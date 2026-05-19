CREATE TABLE modalidade_entrevista (
    id_modalidade  INT PRIMARY KEY AUTO_INCREMENT,
    tipo           VARCHAR(100) NOT NULL
);

CREATE TABLE status_entrevista (
    id_status      INT PRIMARY KEY AUTO_INCREMENT,
    status         VARCHAR(100) NOT NULL
);

CREATE TABLE resultado_entrevista (
    id_resultado   INT PRIMARY KEY AUTO_INCREMENT,
    resultado      VARCHAR(100) NOT NULL
);

CREATE TABLE local_entrevista (
    id_local       INT PRIMARY KEY AUTO_INCREMENT,
    tipo_local     VARCHAR(100) NOT NULL,
    local_fisico   VARCHAR(255),
    link           VARCHAR(255)
);

CREATE TABLE entrevista (
    id_entrevista        INT PRIMARY KEY AUTO_INCREMENT,
    cpf                  CHAR(11) NOT NULL,
    data_entrevista      DATETIME NOT NULL,
    duracao_min          INT NOT NULL,
    id_modalidade        INT NOT NULL,
    id_status_entrevista INT NOT NULL,
    id_resultado         INT NOT NULL,
    nota_candidato       FLOAT,
    feedback             VARCHAR(255),
    id_etapa             INT NOT NULL,
    id_local_entrevista  INT NOT NULL,
    id_entrevistador     INT NOT NULL,

    FOREIGN KEY (cpf)
        REFERENCES candidato(cpf),

    FOREIGN KEY (id_modalidade)
        REFERENCES modalidade_entrevista(id_modalidade),

    FOREIGN KEY (id_status_entrevista)
        REFERENCES status_entrevista(id_status),

    FOREIGN KEY (id_resultado)
        REFERENCES resultado_entrevista(id_resultado),

    FOREIGN KEY (id_etapa)
        REFERENCES etapas_do_processo(id_etapa),

    FOREIGN KEY (id_local_entrevista)
        REFERENCES local_entrevista(id_local),

    FOREIGN KEY (id_entrevistador)
        REFERENCES funcionario(id_funcionario)
);
