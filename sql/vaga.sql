CREATE TABLE vaga (
    id INT PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL,
    data_publicacao DATE NOT NULL,
    quantidade INT NOT NULL,
    salario DECIMAL (10,2) NOT NULL,
    ativa BOOLEAN NOT NULL,

    cnpj CHAR(11) NOT NULL,

    id_cargo INT
);

ALTER TABLE vaga
    ADD CONSTRAINT fk_vaga_cnpj
    FOREIGN KEY (cnpj) REFERENCES empresa(cnpj),
    ON DELETE CASCADE;

ALTER TABLE vaga
    ADD CONSTRAINT fk_vaga_cargo
    FOREIGN KEY (id_cargo) REFERENCES cargo(id);

CREATE TABLE requisito (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(255) NOT NULL,

    id_vaga INT,
);

ALTER TABLE requisito
    ADD CONSTRAINT fk_requisito_vaga
    FOREIGN KEY (id_vaga) REFERENCES vaga(id),
    ON DELETE CASCADE;