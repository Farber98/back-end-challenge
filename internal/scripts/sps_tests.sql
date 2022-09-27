--
-- am_products_insert
--

-- OK
CALL `amaro`.`am_products_insert`(JSON_OBJECT('id_product', 32, 'product', 'prod1'));

-- Repeated ID
CALL `amaro`.`am_products_insert`(JSON_OBJECT('id_product', 32, 'product', 'no prod1'));

-- Repeated product name
CALL `amaro`.`am_products_insert`(JSON_OBJECT('id_product', 63, 'product', 'prod1'));

-- Check products
SELECT * FROM products;

-- Check LOGSP
SELECT * FROM log_sp ORDER BY 1 DESC;


/************************************************************************************************/

--
-- am_product_tags_insert
--

-- OK
CALL `amaro`.`am_product_tags_insert`(JSON_OBJECT('id_product', 32, 'tags', JSON_ARRAY('tag1', 'tag2', 'tag3')));

-- Idempotence
CALL `amaro`.`am_product_tags_insert`(JSON_OBJECT('id_product', 32, 'tags', JSON_ARRAY('tag1', 'tag2', 'tag3')));

-- Same tags on another product.
CALL `amaro`.`am_products_insert`(JSON_OBJECT('id_product', 33, 'product', 'prod2'));
CALL `amaro`.`am_product_tags_insert`(JSON_OBJECT('id_product', 33, 'tags', JSON_ARRAY('tag1', 'tag2', 'tag3')));

-- Product does not exists
CALL `amaro`.`am_product_tags_insert`(JSON_OBJECT('id_product', 92, 'tags', JSON_ARRAY('tag1', 'tag2', 'tag3')));

-- Check tables
SELECT * FROM product_tags;
SELECT * FROM tags;

-- Check log_sp
SELECT * FROM log_sp ORDER BY 1 DESC;