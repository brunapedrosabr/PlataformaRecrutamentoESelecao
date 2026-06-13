CREATE TABLE empresa (
    cnpj CHAR(14) PRIMARY KEY,
    razao_social VARCHAR(150) NOT NULL,
    nome_fantasia VARCHAR(150) NOT NULL,
    porte VARCHAR(50),
    setor VARCHAR(100),
    contato_nome VARCHAR(100),
    contato_cargo VARCHAR(100),

    id_endereco INT NOT NULL
);

ALTER TABLE empresa
    ADD CONSTRAINT fk_empresa_endereco
    FOREIGN KEY (id_endereco) REFERENCES endereco(id);

CREATE TABLE telefone_empresa (
    cnpj CHAR(14) NOT NULL,
    telefone CHAR(20) NOT NULL,
    
    CONSTRAINT pk_telefone_Empresa 
        PRIMARY KEY (cnpj, telefone)
);

ALTER TABLE telefone_empresa
    ADD CONSTRAINT fk_telefone_empresa_cnpj
    FOREIGN KEY (cnpj) REFERENCES empresa(cnpj),
    ON DELETE CASCADE;

CREATE TABLE email_empresa (
    cnpj CHAR(14) NOT NULL,
    email VARCHAR(150) NOT NULL,

    CONSTRAINT pk_email_Empresa 
        PRIMARY KEY (cnpj, Email)
);

ALTER TABLE email_empresa
    ADD CONSTRAINT fk_email_empresa_cnpj
    FOREIGN KEY (cnpj) REFERENCES empresa(cnpj),
    ON DELETE CASCADE;