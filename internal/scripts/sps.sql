SET collation_connection = utf8mb4_unicode_ci;
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
USE amaro;

DELIMITER $$
CREATE DEFINER=`juan`@`localhost` PROCEDURE `am_products_insert`(pIn json)
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
    
	INSERT INTO products VALUES (pIdProduct, LOWER(pProduct));
    
    SELECT  JSON_OBJECT(
        'id_product', id_product,
        'product', UPPER(product)
        ) pOut 
	FROM      products
	WHERE     id_product = pIdProduct;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`juan`@`localhost` PROCEDURE `am_products_search`(pIn json)
BEGIN

  -- Declare variables
  DECLARE pIdProduct SMALLINT DEFAULT pIn ->> '$.id_product';
  DECLARE pProduct VARCHAR(60) DEFAULT pIn ->> '$.product';
  DECLARE pTag VARCHAR(30) DEFAULT pIn ->> '$.tag';
  DECLARE pPageSize INT UNSIGNED DEFAULT 1000;
  DECLARE pPageNumber INT UNSIGNED DEFAULT 1;
  DECLARE pOffset INT UNSIGNED DEFAULT (pPageNumber - 1) * pPageSize;
  DECLARE pOut JSON;
  
  SET SESSION group_concat_max_len = 100000;
  SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  WITH
    temp_base AS ( 
      SELECT  p.id_product
      FROM    products p
      JOIN    product_tags pt ON p.id_product = pt.id_product
      JOIN    tags t ON pt.id_tag = t.id_tag
      WHERE   (p.id_product = pIdProduct OR pIdProduct IS NULL)
        AND   (p.product = pProduct OR pProduct IS NULL)
        AND   (t.tag = pTag OR pTag IS NULL)
        GROUP BY p.id_product
    ), 
    temp_paged    AS (
      SELECT      id_product
      FROM        temp_base
      INNER JOIN  products USING(id_product)
      ORDER BY    product ASC
      LIMIT       pOffset, pPageSize
    )
 
  SELECT  JSON_OBJECT(
    'row_count', (SELECT COUNT(*) FROM temp_base),
    'page_size', pPageSize,
    'page_number', pPageNumber,
    'query_result',
    (
      SELECT      CAST(
                    CONCAT(
                      '[',
                      COALESCE(
                        GROUP_CONCAT(
                          JSON_OBJECT(
                            'id_product', id_product,
                            'product', UPPER(product)
                          ) ORDER BY product ASC
                        ),
                        ''
                      ),
                      ']'
                    ) AS JSON
                  )
      FROM  temp_paged
      JOIN  products USING(id_product)
    )
  ) pOut;

  SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`juan`@`localhost` PROCEDURE `am_product_tags_insert`(pIn json)
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
				INSERT INTO tags VALUES (0, LOWER(pTag));
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
        'product', UPPER(p.product),
        'id_tag', pt.id_tag,
        'tag', UPPER(t.tag)
        )), JSON_ARRAY()) pOut 
	FROM    product_tags pt
    JOIN	products p ON pt.id_product = p.id_product
    JOIN	tags t ON pt.id_tag = t.id_tag
	WHERE   pt.id_product = pIdProduct;
END$$
DELIMITER ;
