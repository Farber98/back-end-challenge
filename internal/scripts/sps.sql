CREATE PROCEDURE `am_products_insert`(pIn json)
SALIR: BEGIN
  
    DECLARE pError CONDITION FOR SQLSTATE '45000';
    DECLARE pIdProduct SMALLINT DEFAULT pIn ->> '$.id_product'; 
    DECLARE pProduct VARCHAR(60) DEFAULT pIn ->> '$.product'; 
    DECLARE pOut JSON;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
      SET @full_error = CONCAT("ERROR ", COALESCE(@errno, ''), " (", COALESCE(@sqlstate, ''), "): ", COALESCE(@text, ''));
      ROLLBACK;
      INSERT INTO log_sp VALUES(0, NOW(), 'am_products_insert', @full_error, pIn);
      RESIGNAL;
    END;

    SET SESSION GROUP_CONCAT_MAX_LEN = 1024 * 1024 * 1024;
    SET tmp_table_size = 1024 * 1024 * 1024 * 64; 
    SET max_heap_table_size = 1024 * 1024 * 1024 * 64;
  
    IF EXISTS (SELECT id_product FROM products WHERE id_product = pIdProduct) THEN
        SIGNAL pError SET MESSAGE_TEXT = 'id_product already exists.';
        LEAVE SALIR;
    END IF;
    
    IF EXISTS (SELECT id_product FROM products WHERE product = pProduct) THEN
        SIGNAL pError SET MESSAGE_TEXT = 'product name already exists.';
        LEAVE SALIR;
    END IF;
    
	INSERT INTO products VALUES (pIdProduct, pProduct);
    
    SELECT  JSON_OBJECT(
        'id_product', id_product,
        'product', product
        ) pOut 
	FROM      products
	WHERE     id_product = pIdProduct;
END

-- 
--
--
--
--

CREATE PROCEDURE `am_product_tags_insert`(pIn json)
SALIR: BEGIN
  
    DECLARE pError CONDITION FOR SQLSTATE '45000';
    DECLARE pIdProduct SMALLINT DEFAULT pIn ->> '$.id_product'; 
    DECLARE pTags JSON DEFAULT pIn ->> '$.tags';
    DECLARE pIndice TINYINT;
    DECLARE pTableIdTag TINYINT;
    DECLARE pTag VARCHAR(30);
    DECLARE pOut JSON;


    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
      SET @full_error = CONCAT("ERROR ", COALESCE(@errno, ''), " (", COALESCE(@sqlstate, ''), "): ", COALESCE(@text, ''));
      ROLLBACK;
      INSERT INTO log_sp VALUES(0, NOW(), 'am_product_tags_insert', @full_error, pIn);
      RESIGNAL;
    END;

    SET SESSION GROUP_CONCAT_MAX_LEN = 1024 * 1024 * 1024;
    SET tmp_table_size = 1024 * 1024 * 1024 * 64; 
    SET max_heap_table_size = 1024 * 1024 * 1024 * 64;
		
	IF NOT EXISTS (SELECT id_product FROM products WHERE id_product = pIdProduct) THEN
        SIGNAL pError SET MESSAGE_TEXT = 'id_product does not exists.';
        LEAVE SALIR;
    END IF;
    
    START TRANSACTION;
        SET pIndice = 0;
        
tagsLoop: 	
		WHILE pIndice < JSON_LENGTH(pTags) DO 

            SET pTag = JSON_UNQUOTE(JSON_EXTRACT(pTags,CONCAT('$[', pIndice, ']')));
			
            SET pTableIdTag = (SELECT id_tag FROM tags WHERE tag = pTag);
            
            IF pTableIdTag IS NULL THEN
				INSERT INTO tags VALUES (0, pTag);
                SET pTableIdTag = LAST_INSERT_ID();
            END IF;

            IF EXISTS (SELECT id_product FROM product_tags WHERE id_product = pIdProduct AND id_tag = pTableIdTag) THEN
                SET pIndice = pIndice + 1;
                ITERATE tagsLoop;
            END IF;

            INSERT INTO product_tags VALUES (pIdProduct, pTableIdTag);
				SET pIndice = pIndice + 1;
        END WHILE;
    COMMIT;
    
    SELECT  COALESCE(JSON_ARRAYAGG(JSON_OBJECT(
        'id_product', pt.id_product,
        'product', p.product,
        'id_tag', pt.id_tag,
        'tag', t.tag
        )), JSON_ARRAY()) pOut 
	FROM    product_tags pt
    JOIN	products p ON pt.id_product = p.id_product
    JOIN	tags t ON pt.id_tag = t.id_tag
	WHERE   pt.id_product = pIdProduct;
END