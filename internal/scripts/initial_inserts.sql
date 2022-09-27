--
-- PRODUCTS
--
INSERT INTO `amaro`.`products` (`id_product`, `product`) VALUES ('8371', LOWER('VESTIDO BABADO TURTLENECK'));
INSERT INTO `amaro`.`products` (`id_product`, `product`) VALUES ('8367', LOWER('VESTIDO BABADOS HORIZONTAIS'));
INSERT INTO `amaro`.`products` (`id_product`, `product`) VALUES ('8363', LOWER('VESTIDO BABADOS KNIT'));
INSERT INTO `amaro`.`products` (`id_product`, `product`) VALUES ('8360', LOWER('VESTIDO CAMISETA FANCY'));
INSERT INTO `amaro`.`products` (`id_product`, `product`) VALUES ('8358', LOWER('VESTIDO COTTON DOUBLE'));
INSERT INTO `amaro`.`products` (`id_product`, `product`) VALUES ('8314', LOWER('VESTIDO CURTO MANGA LONGA LUREX'));
INSERT INTO `amaro`.`products` (`id_product`, `product`) VALUES ('8311', LOWER('VESTIDO CURTO PONTO ROMA MANGA'));
INSERT INTO `amaro`.`products` (`id_product`, `product`) VALUES ('8310', LOWER('VESTIDO CURTO RENDA VISCOSE'));
INSERT INTO `amaro`.`products` (`id_product`, `product`) VALUES ('8309', LOWER('VESTIDO CURTO VELUDO CRISTAL'));
INSERT INTO `amaro`.`products` (`id_product`, `product`) VALUES ('8301', LOWER('VESTIDO CURTO VELUDO RECORTE GOLA'));
INSERT INTO `amaro`.`products` (`id_product`, `product`) VALUES ('8300', LOWER('VESTIDO CUT OUT TRICOT'));
INSERT INTO `amaro`.`products` (`id_product`, `product`) VALUES ('8293', LOWER('VESTIDO FEMININO CANELADO'));
INSERT INTO `amaro`.`products` (`id_product`, `product`) VALUES ('8291', LOWER('VESTIDO LONGO BABADO'));
INSERT INTO `amaro`.`products` (`id_product`, `product`) VALUES ('8264', LOWER('VESTIDO LONGO CREPE MANGA COMPRIDA'));
INSERT INTO `amaro`.`products` (`id_product`, `product`) VALUES ('8119', LOWER('VESTIDO LONGO ESTAMPADO'));
INSERT INTO `amaro`.`products` (`id_product`, `product`) VALUES ('8110', LOWER('VESTIDO MALHA COM FENDA'));
INSERT INTO `amaro`.`products` (`id_product`, `product`) VALUES ('8109', LOWER('VESTIDO MANGA COMPRIDA COSTAS'));
INSERT INTO `amaro`.`products` (`id_product`, `product`) VALUES ('8104', LOWER('VESTIDO MIDI VELUDO DECOTADO'));
INSERT INTO `amaro`.`products` (`id_product`, `product`) VALUES ('8091', LOWER('VESTIDO MOLETOM COM CAPUZ'));
INSERT INTO `amaro`.`products` (`id_product`, `product`) VALUES ('8083', LOWER('VESTIDO MOLETOM COM CAPUZ MESCLA'));
INSERT INTO `amaro`.`products` (`id_product`, `product`) VALUES ('8080', LOWER('VESTIDO PLISSADO ACINTURADO'));
INSERT INTO `amaro`.`products` (`id_product`, `product`) VALUES ('7613', LOWER('VESTIDO REGATA FEMININO COM GOLA'));
INSERT INTO `amaro`.`products` (`id_product`, `product`) VALUES ('7533', LOWER('VESTIDO SLIPDRESS CETIM'));
INSERT INTO `amaro`.`products` (`id_product`, `product`) VALUES ('7518', LOWER('VESTIDO TRICOT CHEVRON'));
INSERT INTO `amaro`.`products` (`id_product`, `product`) VALUES ('7516', LOWER('VESTIDO WRAP FLEUR'));


--
-- TAGS
--
INSERT INTO `amaro`.`tags` (`id_tag`,`tag`) VALUES ( '1', 'balada');
INSERT INTO `amaro`.`tags` (`id_tag`,`tag`) VALUES ( '2', 'basics');
INSERT INTO `amaro`.`tags` (`id_tag`,`tag`) VALUES ( '3', 'boho');
INSERT INTO `amaro`.`tags` (`id_tag`,`tag`) VALUES ( '4', 'casual');
INSERT INTO `amaro`.`tags` (`id_tag`,`tag`) VALUES ( '5', 'colorido');
INSERT INTO `amaro`.`tags` (`id_tag`,`tag`) VALUES ( '6', 'couro');
INSERT INTO `amaro`.`tags` (`id_tag`,`tag`) VALUES ( '7', 'delicado');
INSERT INTO `amaro`.`tags` (`id_tag`,`tag`) VALUES ( '8', 'descolado');
INSERT INTO `amaro`.`tags` (`id_tag`,`tag`) VALUES ( '9', 'elastano');
INSERT INTO `amaro`.`tags` (`id_tag`,`tag`) VALUES ( '10', 'estampado');
INSERT INTO `amaro`.`tags` (`id_tag`,`tag`) VALUES ( '11', 'estampas');
INSERT INTO `amaro`.`tags` (`id_tag`,`tag`) VALUES ( '12', 'festa');
INSERT INTO `amaro`.`tags` (`id_tag`,`tag`) VALUES ( '13', 'inverno');
INSERT INTO `amaro`.`tags` (`id_tag`,`tag`) VALUES ( '14', 'liso');
INSERT INTO `amaro`.`tags` (`id_tag`,`tag`) VALUES ( '15', 'metal');
INSERT INTO `amaro`.`tags` (`id_tag`,`tag`) VALUES ( '16', 'moderno');
INSERT INTO `amaro`.`tags` (`id_tag`,`tag`) VALUES ( '17', 'neutro');
INSERT INTO `amaro`.`tags` (`id_tag`,`tag`) VALUES ( '18', 'passeio');
INSERT INTO `amaro`.`tags` (`id_tag`,`tag`) VALUES ( '19', 'veludo');
INSERT INTO `amaro`.`tags` (`id_tag`,`tag`) VALUES ( '20', 'viagem');
INSERT INTO `amaro`.`tags` (`id_tag`,`tag`) VALUES ( '21', 'workwear');

--
-- PRODUCTS_TAGS
--
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8371', '1');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8371', '17');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8371', '7');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8371', '12');

INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8367', '4');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8367', '15');

INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8363', '5');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8363', '15');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8363', '7');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8363', '11');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8363', '18');

INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8360', '21');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8360', '20');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8360', '8');


INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8358', '16');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8358', '13');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8358', '14');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8358', '2');


INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8314', '4');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8314', '20');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8314', '7');


INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8311', '1');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8311', '15');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8311', '3');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8311', '8');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8311', '18');


INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8310', '4');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8310', '15');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8310', '7');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8310', '8');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8310', '9');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8310', '11');


INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8309', '13');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8309', '14');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8309', '4');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8309', '8');


INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8301', '4');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8301', '15');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8301', '7');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8301', '8');


INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8300', '1');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8300', '15');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8300', '11');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8300', '16');


INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8293', '5');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8293', '20');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8293', '7');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8293', '8');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8293', '13');


INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8291', '13');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8291', '11');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8291', '7');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8291', '8');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8291', '4');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8291', '18');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8291', '2');


INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8264', '4');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8264', '20');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8264', '3');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8264', '17');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8264', '12');


INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8119', '16');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8119', '15');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8119', '8');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8119', '9');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8119', '12');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8119', '5');

INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8110', '4');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8110', '5');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8110', '7');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8110', '8');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8110', '20');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8110', '13');

INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8109', '16');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8109', '3');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8109', '12');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8109', '8');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8109', '5');

INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8104', '4');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8104', '15');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8104', '7');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8104', '17');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8104', '2');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8104', '13');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8104', '20');

INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8091', '6');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8091', '19');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8091', '18');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8091', '20');

INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8083', '6');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8083', '10');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8083', '18');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8083', '20');

INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8080', '17');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8080', '21');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8080', '16');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8080', '8');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8080', '14');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('8080', '9');

INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('7613', '4');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('7613', '14');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('7613', '18');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('7613', '5');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('7613', '3');

INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('7533', '1');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('7533', '14');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('7533', '16');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('7533', '8');

INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('7518', '4');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('7518', '14');

INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('7516', '17');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('7516', '14');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('7516', '2');
INSERT INTO `amaro`.`product_tags` (`id_product`, `id_tag`) VALUES ('7516', '20');