BEGIN;

CREATE TABLE contatos (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(100),
	email VARCHAR(80),
	telefone VARCHAR(15),
	celular VARCHAR(15),
	status BOOLEAN DEFAULT FALSE,
	cliente_id INTEGER,
	created_at TIMESTAMP,
	updated_at TIMESTAMP,

	FOREIGN KEY (cliente_id) REFERENCES pessoas(id)
);

COMMIT;