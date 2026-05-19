CREATE TABLE endereco (
    id          INT PRIMARY KEY,
    rua         VARCHAR(255) NOT NULL,
    numero      INT NOT NULL,
    cep         CHAR(8) NOT NULL,
    cidade      VARCHAR(150) NOT NULL,
    estado      CHAR(2) NOT NULL
)

CREATE TABLE candidato (
    cpf             VARCHAR(11) PRIMARY KEY,
    nome            VARCHAR(150) NOT NULL,
    data_nascimento DATE NOT NULL,
    curriculo       TEXT,

    id_endereco     INT NOT NULL,

    FOREIGN KEY (id_endereco)
        REFERENCES endereco(id)
)

CREATE TABLE contato (
    id           INT PRIMARY KEY,
    tipo_contato VARCHAR(50) NOT NULL,
    valor        VARCHAR(150) NOT NULL,

    cpf          VARCHAR(11) NOT NULL,

    FOREIGN KEY (cpf)
        REFERENCES candidato(cpf)
)