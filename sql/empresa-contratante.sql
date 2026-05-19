CREATE TABLE CEP_Empresa (
    End_CEP CHAR(8) NOT NULL,
    End_Bairro VARCHAR(100),
    End_Cidade VARCHAR(100),
    CONSTRAINT PK_CEP_Empresa PRIMARY KEY (End_CEP)
);

CREATE TABLE Empresa (
    CNPJ CHAR(14) NOT NULL,
    Nome_Fantasia VARCHAR(150) NOT NULL,
    Porte VARCHAR(50),
    Setor VARCHAR(100),
    Contato_Nome VARCHAR(100),
    Contato_Cargo VARCHAR(100),
    End_Logradouro VARCHAR(150),
    End_Numero VARCHAR(20),
    End_CEP CHAR(8),

    CONSTRAINT PK_Empresa PRIMARY KEY (CNPJ),

    CONSTRAINT FK_Empresa_CEP 
        FOREIGN KEY (End_CEP)
        REFERENCES CEP_Empresa (End_CEP)
);

CREATE TABLE Telefone_Empresa (
    CNPJ_Empresa CHAR(14) NOT NULL,
    Telefone VARCHAR(20) NOT NULL,

    CONSTRAINT PK_Telefone_Empresa 
        PRIMARY KEY (CNPJ_Empresa, Telefone),

    CONSTRAINT FK_Telefone_Empresa 
        FOREIGN KEY (CNPJ_Empresa)
        REFERENCES Empresa (CNPJ)
        ON DELETE CASCADE
);

CREATE TABLE Email_Empresa (
    CNPJ_Empresa CHAR(14) NOT NULL,
    Email VARCHAR(150) NOT NULL,

    CONSTRAINT PK_Email_Empresa 
        PRIMARY KEY (CNPJ_Empresa, Email),

    CONSTRAINT FK_Email_Empresa 
        FOREIGN KEY (CNPJ_Empresa)
        REFERENCES Empresa (CNPJ)
        ON DELETE CASCADE
);