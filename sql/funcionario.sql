CREATE TABLE funcionario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,

    id_cargo INT NOT NULL,

    COMMENT ON TABLE funcionario
    IS 'Tabela responsável por armazenar os detalhes de um funcionario da empresa';
);

ALTER TABLE funcionario
    ADD CONSTRAINT fk_funcionario_cargo
    FOREIGN KEY (id_cargo) REFERENCES cargo(id);

CREATE TABLE cargo (
    id INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    nivel VARCHAR(255) NOT NULL,
    area VARCHAR(255) NOT NULL
);