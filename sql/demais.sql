CREATE TABLE Endereco_Candidato (
    IdEnderecoCandidato INT PRIMARY KEY AUTO_INCREMENT,
    Logradouro VARCHAR(150),
    Numero VARCHAR(20),
    Bairro VARCHAR(100),
    Cidade VARCHAR(100),
    Estado CHAR(2),
    CEP CHAR(8)
);

CREATE TABLE Candidato (
    CPF CHAR(11) PRIMARY KEY,
    DataNascimento DATE,
    Nome VARCHAR(150) NOT NULL,
    Curriculo VARCHAR(255),

    IdEndereco INT,

    CONSTRAINT FK_Candidato_Endereco
        FOREIGN KEY (IdEndereco)
        REFERENCES Endereco_Candidato(IdEnderecoCandidato)
);

CREATE TABLE Contato (
    IdContato INT PRIMARY KEY AUTO_INCREMENT,
    CPF CHAR(11) NOT NULL,
    TipoContato VARCHAR(50),
    Valor VARCHAR(150),

    CONSTRAINT FK_Contato_Candidato
        FOREIGN KEY (CPF)
        REFERENCES Candidato(CPF)
        ON DELETE CASCADE
);

CREATE TABLE Endereco_Empresa (
    IdEndereco INT PRIMARY KEY AUTO_INCREMENT,
    End_Logradouro VARCHAR(150),
    End_Numero VARCHAR(20),
    End_Bairro VARCHAR(100),
    End_Cidade VARCHAR(100),
    End_Estado CHAR(2),
    End_CEP CHAR(8)
);

CREATE TABLE Empresa (
    CNPJ CHAR(14) PRIMARY KEY,
    RazaoSocial VARCHAR(150),
    Nome_Fantasia VARCHAR(150),
    Porte VARCHAR(50),
    Setor VARCHAR(100),

    IdEnderecoEmpresa INT,

    CONSTRAINT FK_Empresa_Endereco
        FOREIGN KEY (IdEnderecoEmpresa)
        REFERENCES Endereco_Empresa(IdEndereco)
);

CREATE TABLE Telefone_Empresa (
    CNPJ_Empresa CHAR(14),
    Telefone VARCHAR(20),
    Contato_Nome VARCHAR(100),
    Contato_Cargo VARCHAR(100),

    PRIMARY KEY (CNPJ_Empresa, Telefone),

    CONSTRAINT FK_TelefoneEmpresa
        FOREIGN KEY (CNPJ_Empresa)
        REFERENCES Empresa(CNPJ)
        ON DELETE CASCADE
);

CREATE TABLE Email_Empresa (
    CNPJ_Empresa CHAR(14),
    Email VARCHAR(150),

    PRIMARY KEY (CNPJ_Empresa, Email),

    CONSTRAINT FK_EmailEmpresa
        FOREIGN KEY (CNPJ_Empresa)
        REFERENCES Empresa(CNPJ)
        ON DELETE CASCADE
);

CREATE TABLE Cargo (
    IdCargo INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),
    Nivel VARCHAR(50),
    Area VARCHAR(100)
);

CREATE TABLE Vaga (
    IdVaga INT PRIMARY KEY AUTO_INCREMENT,
    Descricao VARCHAR(255),
    DataPublicacao DATE,
    Quantidade INT,
    Salario FLOAT,
    Status BOOLEAN,

    IdEmpresa CHAR(14),
    IdCargo INT,

    CONSTRAINT FK_Vaga_Empresa
        FOREIGN KEY (IdEmpresa)
        REFERENCES Empresa(CNPJ),

    CONSTRAINT FK_Vaga_Cargo
        FOREIGN KEY (IdCargo)
        REFERENCES Cargo(IdCargo)
);

CREATE TABLE Requisito (
    IdRequisito INT PRIMARY KEY AUTO_INCREMENT,
    IdVaga INT,
    Descricao VARCHAR(255),

    CONSTRAINT FK_Requisito_Vaga
        FOREIGN KEY (IdVaga)
        REFERENCES Vaga(IdVaga)
);

CREATE TABLE Funcionario (
    IdFuncionario INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(150) NOT NULL,
    Cargo VARCHAR(100)
);

CREATE TABLE TipoEtapa (
    IdTipoEtapa INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100)
);

CREATE TABLE EtapasDoProcesso (
    IdEtapa INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(150) NOT NULL,
    Descricao VARCHAR(255),
    Ordem INT,
    Data_Etapa DATE,

    IdFuncionarioResponsavel INT,
    IdTipoEtapa INT,
    IdVaga INT,

    CONSTRAINT FK_Etapa_Funcionario
        FOREIGN KEY (IdFuncionarioResponsavel)
        REFERENCES Funcionario(IdFuncionario),

    CONSTRAINT FK_Etapa_Tipo
        FOREIGN KEY (IdTipoEtapa)
        REFERENCES TipoEtapa(IdTipoEtapa),

    CONSTRAINT FK_Etapa_Vaga
        FOREIGN KEY (IdVaga)
        REFERENCES Vaga(IdVaga)
);