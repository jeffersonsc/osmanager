-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.


BEGIN;

CREATE TABLE logradouros (
id serial PRIMARY KEY NOT NULL,
endereco varchar(60),
bairro varchar(50),
cidade varchar(50),
uf char(2),
status boolean DEFAULT false
);

CREATE TABLE tipos_cliente (
id serial PRIMARY KEY NOT NULL,
nome varchar(15)
);

CREATE TABLE clientes (
id serial PRIMARY KEY NOT NULL,
nome varchar(50),
endereco_id integer,
endereco_n integer,
telefone1 varchar(20),
telefone2 varchar(20),
telefone3 varchar(20),
celular varchar(20),
tp_cliente_id integer,
rg varchar(20),
status boolean DEFAULT true,
dt_cadastro timestamp,
ultima_alteracao timestamp,
 FOREIGN KEY (endereco_id) REFERENCES logradouros(id),
 FOREIGN KEY (tp_cliente_id) REFERENCES tipos_cliente (id)
);

CREATE TABLE servicos (
id serial PRIMARY KEY NOT NULL,
nome varchar(60),
custo decimal(10,2),
status boolean DEFAULT true
);

CREATE TABLE cargos (
id serial PRIMARY KEY NOT NULL,
nome varchar(40),
dt_cadastro timestamp
);

CREATE TABLE funcionarios (
id serial PRIMARY KEY NOT NULL,
nome varchar(60),
endereco_id integer,
endereco_n integer,
rg varchar(20),
status boolean DEFAULT true,
dt_cadastro timestamp,
ultima_alteracao timestamp,
telefone1 varchar(20),
telefone2 varchar(20),
cargo_id integer,
 FOREIGN KEY (endereco_id) REFERENCES logradouros(id),
 FOREIGN KEY (cargo_id) REFERENCES cargos(id)
);

CREATE TABLE tipos_pagamento (
id serial PRIMARY KEY NOT NULL,
nome varchar(60)
);

CREATE TABLE status_ordem_servicos (
id serial PRIMARY KEY NOT NULL,
nome varchar(30)
);

CREATE TABLE status_vendas (
id serial PRIMARY KEY NOT NULL,
nome varchar(30)
);


CREATE TABLE produtos (
id serial PRIMARY KEY NOT NULL,
nome varchar(60),
preco decimal(10,2),
status boolean DEFAULT true,
quant integer,
dt_cadastro timestamp
);



CREATE TABLE ordem_servicos (
id serial PRIMARY KEY NOT NULL,
cliente_id integer,
funcionario_id integer,
servico_id integer,
tipo_servico varchar(15),
tranporte decimal(10,2),
dt_inicial timestamp,
dt_final timestamp,
status_id integer DEFAULT 3,
total decimal(10,2),
tp_pagamento_id integer,
dt_geracao timestamp,
 FOREIGN KEY (cliente_id) REFERENCES clientes (id),
 FOREIGN KEY (funcionario_id) REFERENCES funcionarios (id),
 FOREIGN KEY (servico_id) REFERENCES servicos (id),
 FOREIGN KEY (tp_pagamento_id) REFERENCES tipos_pagamento (id),
 FOREIGN KEY (status_id) REFERENCES status_ordem_servicos (id)
);

CREATE TABLE venda_prod_pai (
id serial PRIMARY KEY NOT NULL,
cliente_id integer,
funcionario_id integer,
dt_venda timestamp,
tp_pagamento_id integer,
total_venda decimal(10,2),
status_id integer DEFAULT 3,
 FOREIGN KEY (funcionario_id) REFERENCES funcionarios (id),
 FOREIGN KEY (cliente_id) REFERENCES clientes (id),
 FOREIGN KEY (tp_pagamento_id) REFERENCES tipos_pagamento(id),
 FOREIGN KEY (status_id) REFERENCES status_vendas (id)
);

CREATE TABLE venda_prod_filho (
id serial PRIMARY KEY NOT NULL ,
vd_id integer  NOT NULL,
produto_id integer,
 FOREIGN KEY (vd_id) REFERENCES venda_prod_pai (id),
 FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

CREATE TABLE login (
id serial PRIMARY KEY NOT NULL,
funcionario_id integer,
usuario varchar(20), 
senha varchar(10) DEFAULT '12345678',
criado_em timestamp,
alterado_em timestamp,
	FOREIGN KEY (funcionario_id) REFERENCES funcionarios(id)
);

COMMIT;

INSERT INTO tipos_pagamento (nome) VALUES ('Cartão Débito');
INSERT INTO tipos_pagamento (nome) VALUES ('Cartão Crédito');
INSERT INTO tipos_pagamento (nome) VALUES ('Dinheiro');
INSERT INTO tipos_pagamento (nome) VALUES ('Boleto');

INSERT INTO status_vendas (nome) VALUES ('Pago');
INSERT INTO status_vendas (nome) VALUES ('Pendente');
INSERT INTO status_vendas (nome) VALUES ('Não Pago');

INSERT INTO status_ordem_servicos (nome) VALUES ('Aberto');
INSERT INTO status_ordem_servicos (nome) VALUES ('Fechado');
INSERT INTO status_ordem_servicos (nome) VALUES ('Pendente');

INSERT INTO logradouros (endereco, bairro, cidade , uf) VALUES ('rua joão gomes', 'jardins', 'são paulo', 'SP');
INSERT INTO logradouros (endereco, bairro, cidade , uf) VALUES ('av paula ferreira', 'pirituba', 'são paulo', 'SP');

INSERT INTO produtos (nome , preco , quant) VALUES ('Impressora HP', 600.00  , 10 );
INSERT INTO produtos (nome , preco , quant) VALUES ('Computado HP deskjet 1200 series', 1200.00 , 5 );

INSERT INTO servicos (nome , custo) VALUES ( 'Visita tecnica fora do rail local', 120.00  );
INSERT INTO servicos (nome , custo) VALUES ( 'Visita tecnica local', 60.00  );
INSERT INTO servicos (nome , custo) VALUES ( 'Troca de peça local', 30.00  );

INSERT INTO funcionarios (nome , endereco_id, endereco_n , rg ) VALUES ('Jefferson SIlva', 1 , 150 , '1025458754');
INSERT INTO funcionarios (nome , endereco_id, endereco_n , rg ) VALUES ('Maria José', 1 , 150 , '20123254');

INSERT INTO tipos_cliente (nome) VALUES ('Física');
INSERT INTO tipos_cliente (nome) VALUES ('Jurídica');
 
INSERT INTO clientes (nome , endereco_id, endereco_n , telefone1 , telefone2 , telefone3, celular , tp_cliente_id , rg , dt_cadastro ) 
VALUES ('Armando Carneiro' , 1 , 220, '01133552222' , '011985856535' ,'33558545', '11965855118', 1 , '3535353', '2014-04-2 13:42:53' );

INSERT INTO clientes (nome , endereco_id, endereco_n , telefone1 , telefone2 , telefone3, celular , tp_cliente_id , rg , dt_cadastro ) 
VALUES ('José muniz' , 2 , 3000, '01133335555' , '01133224455' ,'01185967414', '11985962536', 1 , '3535353', '2014-04-2 13:42:53' );




INSERT INTO ordem_servicos ( cliente_id , funcionario_id , servico_id , tipo_servico , tranporte , situacao, dt_geracao)
VALUES ( 1 , 1 , 1 , 'externo' , 0.00  , 'a' ,	'2014-04-02  10:52:15' );

UPDATE ordem_servicos SET dt_final='2014-04-01 17:49:15' , situacao='f' , total=120.00 WHERE id=1;

CREATE VIEW lista_chamados AS ( 
SELECT
	clientes.nome AS cliente,
	funcionarios.nome AS tecnico,
	servicos.nome AS servico,
	servicos.custo AS custo,
	ordem_servicos.tranporte AS transporte,
	ordem_servicos.dt_inicial AS entrada,
	ordem_servicos.dt_final AS saida,
	ordem_servicos.situacao AS situacao,
	ordem_servicos.total AS total

FROM

	ordem_servicos
	INNER JOIN clientes ON clientes.id = ordem_servicos.cliente_id
	INNER JOIN funcionarios ON funcionarios.id = ordem_servicos.funcionario_id
	INNER JOIN servicos ON servicos.id = ordem_servicos.servico_id );



INSERT INTO venda_prod_pai (cliente_id, funcionario_id, total_venda ) VALUES ( 1 , 1 , 1 , 1800.00 );
INSERT INTO venda_prod_filho ( vd_id , produto_id) VALUES ( 1 , 1 );
INSERT INTO venda_prod_filho (vd_id , produto_id ) VALUES ( 1 , 2 );

CREATE VIEW vendas AS (
SELECT
	
	venda_prod_pai.id,
	venda_prod_pai.cliente_id,
	clientes.nome,
	funcionarios.nome,
	venda_prod_filho.produto_id,
	produtos.nome,
	venda_prod_pai.total

FROM

	venda_prod_pai
	INNER JOIN venda_prod_filho ON venda_prod_filho.vd_id = venda_prod_pai.id
	INNER JOIN clientes ON clientes.id = venda_prod_pai.cliente_id
	INNER JOIN funcionarios ON funcionarios.id = venda_prod_pai.funcionario_id
	INNER JOIN produtos ON produtos.id = venda_prod_filho.produto_id

GROUP BY

	venda_prod_pai.id,
	venda_prod_pai.cliente_id,
	clientes.nome,
	funcionarios.nome,
	venda_prod_filho.produto_id,
	produtos.nome );

CREATE VIEW lista_funcionarios AS (
SELECT 

	funcionarios.nome AS nome,
	logradouros.endereco AS endereco,
	funcionarios.endereco_n AS numero,
	logradouros.bairro AS bairro,
	logradouros.cidade AS cidade,
	logradouros.uf AS estado,
	funcionarios.rg AS rg,
	funcionarios.dt_cadastro AS cadatrado_em

FROM
	funcionarios
	INNER JOIN logradouros ON logradouros.id = funcionarios.endereco_id );

COMMIT;

DROP VIEW lista_chamados , lista_funcionarios;
DROP TABLE clientes, funcionarios , ordem_servicos, servicos, logradouros , venda_prod_pai,
venda_prod_filho , cargos , produtos, tipos_pagamento, tipos_cliente, tipos_pagamento, status_ordem_servicos, status_vendas ;

