CREATE TABLE ModalidadeEntrevista (
    IdModalidade INT PRIMARY KEY AUTO_INCREMENT,
    Tipo VARCHAR(100)
);

CREATE TABLE StatusEntrevista (
    IdStatus INT PRIMARY KEY AUTO_INCREMENT,
    Status VARCHAR(100)
);

CREATE TABLE ResultadoEntrevista (
    IdResultado INT PRIMARY KEY AUTO_INCREMENT,
    Resultado VARCHAR(100)
);

CREATE TABLE LocalEntrevista (
    IdLocal INT PRIMARY KEY AUTO_INCREMENT,
    TipoLocal VARCHAR(100),
    LocalFisico VARCHAR(255),
    Link VARCHAR(255)
);

CREATE TABLE Entrevista (
    IdEntrevista INT PRIMARY KEY AUTO_INCREMENT,

    CPF CHAR(11),

    Data_Entrevista DATETIME,
    Duracao_Min INT,

    IdModalidade INT,
    IdStatusEntrevista INT,
    Resultado INT,

    Nota_Candidato FLOAT,
    Feedback VARCHAR(255),

    IdEtapa INT,
    IdLocalEntrevista INT,
    IdEntrevistador INT,

    CONSTRAINT FK_Entrevista_Candidato
        FOREIGN KEY (CPF)
        REFERENCES Candidato(CPF),

    CONSTRAINT FK_Entrevista_Modalidade
        FOREIGN KEY (IdModalidade)
        REFERENCES ModalidadeEntrevista(IdModalidade),

    CONSTRAINT FK_Entrevista_Status
        FOREIGN KEY (IdStatusEntrevista)
        REFERENCES StatusEntrevista(IdStatus),

    CONSTRAINT FK_Entrevista_Resultado
        FOREIGN KEY (Resultado)
        REFERENCES ResultadoEntrevista(IdResultado),

    CONSTRAINT FK_Entrevista_Etapa
        FOREIGN KEY (IdEtapa)
        REFERENCES EtapasDoProcesso(IdEtapa),

    CONSTRAINT FK_Entrevista_Local
        FOREIGN KEY (IdLocalEntrevista)
        REFERENCES LocalEntrevista(IdLocal),

    CONSTRAINT FK_Entrevista_Entrevistador
        FOREIGN KEY (IdEntrevistador)
        REFERENCES Funcionario(IdFuncionario)
);