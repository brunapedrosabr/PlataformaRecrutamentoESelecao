CREATE TABLE candidato (
    cpf CHAR(11) PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    data_nascimento DATE NOT NULL,
    curriculo VARCHAR(255),

    id_endereco INT NOT NULL
);

ALTER TABLE candidato
    ADD CONSTRAINT fk_candidato_endereco
    FOREIGN KEY (id_endereco) REFERENCES endereco(id),

CREATE TABLE contato_candidato (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_contato VARCHAR(50) NOT NULL,
    valor VARCHAR(150) NOT NULL,

    cpf CHAR(11) NOT NULL
);

ALTER TABLE contato_candidato
    ADD CONSTRAINT fk_contato_cpf
    FOREIGN KEY (cpf) REFERENCES canditato(cpf),
    ON DELETE CASCADE;