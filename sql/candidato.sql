-- CANDIDATO
DROP TABLE IF EXISTS candidato CASCADE;

CREATE TABLE IF NOT EXISTS candidato (
    cpf CHAR(11) PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    data_nascimento DATE NOT NULL,
    curriculo VARCHAR(255),

    id_endereco INT NOT NULL
);

COMMENT ON TABLE candidato IS 'Tabela responsável por armazenar os dados de um candidato';

COMMENT ON COLUMN candidato.cpf IS 'Cadastro de Pessoa Física que serve como identificador único de um determinado candidato';
COMMENT ON COLUMN candidato.nome IS 'Nome que foi registrado em cartório de um determinado candidato';
COMMENT ON COLUMN candidato.data_nascimento IS 'Registro da data de nascimento de um determinado candidato';
COMMENT ON COLUMN candidato.curriculo IS 'Campo que permite armazenar as informações curriculares do candidato';
COMMENT ON COLUMN candidato.id_endereco IS 'Chave estrangeira que referencia o endereço completo do candidato';

ALTER TABLE candidato
    ADD CONSTRAINT fk_candidato_endereco
    FOREIGN KEY (id_endereco) REFERENCES endereco(id);

INSERT INTO candidato (cpf, nome, data_nascimento, curriculo, id_endereco) VALUES
('12345678901', 'João Silva', '1998-05-12', 'curriculos/joao_silva.pdf', 1),
('23456789012', 'Maria Oliveira', '1995-08-23', 'curriculos/maria_oliveira.pdf', 2),
('34567890123', 'Pedro Santos', '2000-01-15', 'curriculos/pedro_santos.pdf', 3),
('45678901234', 'Ana Costa', '1997-11-30', 'curriculos/ana_costa.pdf', 4),
('56789012345', 'Lucas Ferreira', '1999-04-18', 'curriculos/lucas_ferreira.pdf', 5),
('67890123456', 'Juliana Souza', '1996-09-07', 'curriculos/juliana_souza.pdf', 6),
('78901234567', 'Gabriel Almeida', '2001-02-21', 'curriculos/gabriel_almeida.pdf', 7),
('89012345678', 'Fernanda Rocha', '1998-12-03', 'curriculos/fernanda_rocha.pdf', 8),
('90123456789', 'Rafael Martins', '1994-07-14', 'curriculos/rafael_martins.pdf', 9),
('01234567890', 'Camila Pereira', '2002-06-25', 'curriculos/camila_pereira.pdf', 10);

-- CONTATO DO CANDIDATO
DROP TABLE IF EXISTS contato_candidato CASCADE;

CREATE TABLE IF NOT EXISTS contato_candidato (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_contato VARCHAR(50) NOT NULL,
    valor VARCHAR(150) NOT NULL,

    cpf CHAR(11) NOT NULL
);

COMMENT ON TABLE contato_candidato IS 'Tabela responsável por armazenar o contato de um determinado candidato';

COMMENT ON COLUMN contato_candidato.id IS 'Identificador único do contato';
COMMENT ON COLUMN contato_candidato.tipo_contato IS 'Nome do tipo do contato que será armazenado (ex: Telefone fixo, Email, Celular, Linkedin)';
COMMENT ON COLUMN contato_candidato.valor IS 'Armazena o contato de acordo com o tipo de contato que foi escolhido';
COMMENT ON COLUMN contato_candidato.cpf IS 'Chave estrangeira que referencia a qual candidato pertence o contato';

ALTER TABLE contato_candidato
    ADD CONSTRAINT fk_contato_cpf
    FOREIGN KEY (cpf) REFERENCES canditato(cpf)
    ON DELETE CASCADE;

INSERT INTO contato_candidato (tipo_contato, valor, cpf) VALUES
('Email', 'joao.silva@email.com', '12345678901'),
('Telefone', '31991234567', '23456789012'),
('Email', 'pedro.santos@email.com', '34567890123'),
('Telefone', '31992345678', '45678901234'),
('LinkedIn', 'linkedin.com/in/lucasferreira', '56789012345'),
('Email', 'juliana.souza@email.com', '67890123456'),
('Telefone', '31993456789', '78901234567'),
('Email', 'fernanda.rocha@email.com', '89012345678'),
('LinkedIn', 'linkedin.com/in/rafaelmartins', '90123456789'),
('Telefone', '31994567890', '01234567890');