BEGIN;

CREATE TABLE pessoas (
id SERIAL PRIMARY KEY,
nome VARCHAR(100),
nome_mae VARCHAR(100),
nome_pai VARCHAR(100),
nome_responsavel VARCHAR(100),
sexo CHAR(1),
dt_nascimento TIMESTAMP,
rz_social VARCHAR(100),
cep INTEGER,
endereco VARCHAR(100),
numero INTEGER,
complemento VARCHAR(50),
bairro VARCHAR(60),
cidade VARCHAR(60),
estado CHAR(2),
telefone1 VARCHAR(15),
telefone2 VARCHAR(15),
telefone3 VARCHAR(15),
celular VARCHAR(15),
email VARCHAR(80),
tp_cliente BOOLEAN,
tp_pessoa CHAR(1),
rg VARCHAR(15),
ssp CHAR(2),
cpf VARCHAR(11),
cnpj VARCHAR(14),
ie VARCHAR(9),
status BOOLEAN DEFAULT false,
created_at TIMESTAMP,
updated_at TIMESTAMP
 
);

COMMIT;