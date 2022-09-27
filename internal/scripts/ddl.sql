SET collation_connection = utf8mb4_unicode_ci;
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
-- CREATE DATABASE amaro;
USE amaro;

-- 
-- TABLE: products 
--
DROP TABLE products;
CREATE TABLE products(
    id_product    SMALLINT       NOT NULL,
    product       VARCHAR(60)    NOT NULL,
    PRIMARY KEY (id_product), 
    UNIQUE INDEX ui_product(product)
)ENGINE=INNODB
;


-- 
-- TABLE: tags 
--
DROP TABLE tags;
CREATE TABLE tags(
    id_tag    TINYINT        AUTO_INCREMENT,
    tag       VARCHAR(30)    NOT NULL,
    PRIMARY KEY (id_tag), 
    UNIQUE INDEX ui_tag(tag)
)ENGINE=INNODB
;



-- 
-- TABLE: product_tags 
--
DROP TABLE product_tags;
CREATE TABLE product_tags(
    id_product    SMALLINT    NOT NULL,
    id_tag        TINYINT     NOT NULL,
    PRIMARY KEY (id_product, id_tag), 
    INDEX Ref11(id_product),
    INDEX Ref22(id_tag), 
    CONSTRAINT Refproducts1 FOREIGN KEY (id_product)
    REFERENCES products(id_product),
    CONSTRAINT Reftags2 FOREIGN KEY (id_tag)
    REFERENCES tags(id_tag)
)ENGINE=INNODB
;

--
-- aud_logsp
--
DROP TABLE log_sp;
CREATE TABLE `log_sp` (
  `id_log` bigint NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `sp` varchar(100) NOT NULL,
  `msg` varchar(2000) NOT NULL,
  `params` json DEFAULT NULL,
  PRIMARY KEY (`id_log`)
) ENGINE=InnoDB
