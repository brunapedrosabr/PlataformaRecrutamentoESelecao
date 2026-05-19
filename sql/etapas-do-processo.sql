CREATE TABLE funcionario (
    id INT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL
)

CREATE TABLE tipo_etapa (
    id INT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL
)

CREATE TABLE etapas_do_processo (
    id INT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    ordem_etapa INT NOT NULL,
    data_etapa DATE NOT NULL,

    id_func_responsavel INT NOT NULL,
    id_tipo_etapa INT NOT NULL,
    id_vaga INT NOT NULL,

    FOREIGN KEY (id_func_responsavel)
        REFERENCES funcionario(id),

    FOREIGN KEY (id_tipo_etapa)
        REFERENCES tipo_etapa(id),

    -- Depende da tabela vaga já ter sido criada
    -- FOREIGN KEY (id_VAGA)
    --     REFERENCES vaga(id)
)