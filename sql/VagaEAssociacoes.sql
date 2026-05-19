CREATE TABLE empresa (
    cnpj INT PRIMARY KEY,
    razao_social VARCHAR(255),
    endereco VARCHAR(255)
);

CREATE TABLE cargo (
    id_cargo INT PRIMARY KEY,
    nome VARCHAR(255),
    nivel VARCHAR(255),
    area VARCHAR(255)
);

CREATE TABLE vaga (
    id_vaga INT PRIMARY KEY,
    descricao VARCHAR(255),
    data_publicacao DATE,
    quantidade INT,
    salario FLOAT,
    status BOOLEAN,
    id_cargo INT,
    cnpj INT,
    FOREIGN KEY (id_cargo) REFERENCES cargo(id_cargo),
    FOREIGN KEY (cnpj) REFERENCES empresa(cnpj)
);

CREATE TABLE requisito (
    id_requisito INT PRIMARY KEY,
    id_vaga INT,
    descricao VARCHAR(255),
    FOREIGN KEY (id_vaga) REFERENCES vaga(id_vaga)
);