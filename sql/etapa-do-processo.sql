CREATE TABLE tipo_etapa (
    id INT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL
);

CREATE TABLE etapa_do_processo (
    id INT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    ordem_etapa INT NOT NULL,
    data_etapa DATE NOT NULL,

    id_func_responsavel INT NOT NULL,
    id_tipo_etapa INT NOT NULL,
    id_vaga INT NOT NULL,

    COMMENT ON TABLE etapas_do_processo
    IS 'Tabela responsável por armazenar o histórico e o detalhamento das etapas de um determinado processo.';
);

ALTER TABLE etapas_do_processo
    ADD CONSTRAINT fk_etapas_func
    FOREIGN KEY (id_func_responsavel) REFERENCES funcionario(id);

ALTER TABLE etapas_do_processo
    ADD CONSTRAINT fk_etapas_tipo
    FOREIGN KEY (id_tipo_etapa) REFERENCES tipo_etapa(id);

ALTER TABLE etapas_do_processo
    ADD CONSTRAINT fk_etapas_vaga
    FOREIGN KEY (id_VAGA) REFERENCES vaga(id);