-- ENDEREÇO
DROP TABLE IF EXISTS endereco CASCADE;  

CREATE TABLE IF NOT EXISTS endereco (
    id INT PRIMARY KEY AUTO_INCREMENT,
    logradouro VARCHAR(150) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    complemento VARCHAR(20),
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL,
    cep CHAR(8) NOT NULL
);

COMMENT ON TABLE endereco IS 'Tabela responsável por armazenar o endereço de um determinado candidato';

COMMENT ON COLUMN endereco.id IS 'Idendificador único de um endereço';
COMMENT ON COLUMN endereco.logradouro IS 'Armazena o nome da rua no qual a residência está localizada';
COMMENT ON COLUMN endereco.numero IS 'Armazena o número da residência';
COMMENT ON COLUMN endereco.complemento IS 'Campo opcional caso haja algum complemento referente a residência';
COMMENT ON COLUMN endereco.bairro IS 'Armazena o bairro no qual a residência está localizada';
COMMENT ON COLUMN endereco.cidade IS 'Armazena a cidade da residência';
COMMENT ON COLUMN endereco.estado IS 'Armazena o estado da residência';
COMMENT ON COLUMN endereco.cep IS 'Armazena o cep para localizar a região na qual a residência se encontra';

INSERT INTO endereco (logradouro, numero, complemento, bairro, cidade, estado, cep) VALUES
('Rua das Flores', '120', 'Apto 101', 'Centro', 'Belo Horizonte', 'MG', '30110000'),
('Avenida Brasil', '450', NULL, 'Funcionários', 'Belo Horizonte', 'MG', '30140071'),
('Rua São José', '78', 'Casa', 'Savassi', 'Belo Horizonte', 'MG', '30112020'),
('Rua Tiradentes', '890', NULL, 'Centro', 'Contagem', 'MG', '32010010'),
('Avenida Amazonas', '1500', 'Sala 305', 'Centro', 'Betim', 'MG', '32600000'),
('Rua dos Ipês', '55', NULL, 'Jardim América', 'Belo Horizonte', 'MG', '30421000'),
('Avenida Afonso Pena', '2300', 'Bloco B', 'Funcionários', 'Belo Horizonte', 'MG', '30130007'),
('Rua da Bahia', '640', NULL, 'Lourdes', 'Belo Horizonte', 'MG', '30160011'),
('Rua Padre Eustáquio', '312', 'Fundos', 'Padre Eustáquio', 'Belo Horizonte', 'MG', '30720000'),
('Avenida João César de Oliveira', '400', NULL, 'Eldorado', 'Contagem', 'MG', '32310000');