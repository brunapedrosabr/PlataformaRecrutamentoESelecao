CREATE TABLE Empresa (
    CNPJ CHAR(14) PRIMARY KEY,
    RazaoSocial VARCHAR(150),
    Endereco VARCHAR(200)
);

CREATE TABLE Cargo (
    IdCargo INT PRIMARY KEY,
    Nome VARCHAR(100),
    Nivel VARCHAR(50),
    Area VARCHAR(100)
);

CREATE TABLE Vaga (
    IdVaga INT PRIMARY KEY,
    Descricao VARCHAR(255),
    DataPublicacao DATE,
    Quantidade INT,
    Salario FLOAT,
    IdCargo INT NOT NULL,
    Status BOOLEAN,
    CNPJ CHAR(14) NOT NULL,
    FOREIGN KEY (IdCargo) REFERENCES Cargo(IdCargo),
    FOREIGN KEY (CNPJ) REFERENCES Empresa(CNPJ)
);

CREATE TABLE Requisito (
    IdRequisito INT PRIMARY KEY,
    IdVaga INT NOT NULL,
    Descricao VARCHAR(255),
    FOREIGN KEY (IdVaga) REFERENCES Vaga(IdVaga)
);
