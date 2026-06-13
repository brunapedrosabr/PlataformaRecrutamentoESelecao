CREATE TABLE modalidade_entrevista (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(100) NOT NULL
);

CREATE TABLE status_entrevista (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(100) NOT NULL
);

CREATE TABLE resultado_entrevista (
    id INT PRIMARY KEY AUTO_INCREMENT,
    resultado VARCHAR(100) NOT NULL
);

CREATE TABLE local_entrevista (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_local VARCHAR(100) NOT NULL,
    local_fisico VARCHAR(255),
    link VARCHAR(255)
);

CREATE TABLE entrevista (
    id_entrevista INT PRIMARY KEY AUTO_INCREMENT,
    data_entrevista DATETIME NOT NULL,
    duracao_min INT NOT NULL,
    nota_candidato FLOAT,
    feedback VARCHAR(255),

    cpf CHAR(11) NOT NULL,

    id_modalidade INT NOT NULL,

    id_status INT NOT NULL,

    id_resultado INT NOT NULL,

    id_etapa INT NOT NULL,

    id_local INT NOT NULL,

    id_entrevistador INT NOT NULL,
);

ALTER TABLE entrevista
    ADD CONSTRAINT fk_entrevista_cpf
    FOREIGN KEY (cpf) REFERENCES canditato(cpf);

ALTER TABLE entrevista
    ADD CONSTRAINT fk_entrevista_modalidade
    FOREIGN KEY (id_modalidade) REFERENCES modelidade_estrevista(id);

ALTER TABLE entrevista
    ADD CONSTRAINT fk_entrevista_status
    FOREIGN KEY (id_status) REFERENCES status_estrevista(id);

ALTER TABLE entrevista
    ADD CONSTRAINT fk_entrevista_resultado
    FOREIGN KEY (id_resultado) REFERENCES resultado_estrevista(id);

ALTER TABLE entrevista
    ADD CONSTRAINT fk_entrevista_etapa
    FOREIGN KEY (id_etapa) REFERENCES etapa_do_processo(id);

ALTER TABLE entrevista
    ADD CONSTRAINT fk_entrevista_local
    FOREIGN KEY (id_local) REFERENCES local_entrevista(id);

ALTER TABLE entrevista
    ADD CONSTRAINT fk_entrevista_entrevistador
    FOREIGN KEY (id_entrevistador) REFERENCES funcionario(id);