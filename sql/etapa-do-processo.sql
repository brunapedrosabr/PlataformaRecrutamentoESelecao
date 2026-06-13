-- TIPO ETAPA
DROP TABLE IF EXISTS tipo_etapa CASCADE;

CREATE TABLE IF NOT EXISTS tipo_etapa (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL
);

COMMENT ON TABLE tipo_etapa
    IS 'Tabela responsável por armazenar o nome do tipo da etapa do processo.';

COMMENT ON COLUMN tipo_etapa.id IS 'Identificador único do tipo de etapa.';
COMMENT ON COLUMN tipo_etapa.nome IS 'Nome ou classificação do tipo de etapa (ex: Entrevista RH, Teste Técnico, Dinâmica de Grupo).';

INSERT INTO tipo_etapa (nome) VALUES
('Análise Curricular'),
('Entrevista RH'),
('Entrevista Técnica'),
('Prova Lógica'),
('Desafio Técnico'),
('Entrevista Gestores');

-- ETAPA DO PROCESSO
DROP TABLE IF EXISTS etapa_do_processo CASCADE;

CREATE TABLE IF NOT EXISTS etapa_do_processo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    descricao VARCHAR(255),
    ordem_etapa INT NOT NULL,
    data_etapa DATE NOT NULL,

    id_func_responsavel INT NOT NULL,
    id_tipo_etapa INT NOT NULL,
    id_vaga INT NOT NULL
);

COMMENT ON TABLE etapa_do_processo
    IS 'Tabela responsável por armazenar o histórico e o detalhamento das etapas de um determinado processo.';

COMMENT ON COLUMN etapa_do_processo.id IS 'Identificador único do registro da etapa do processo.';
COMMENT ON COLUMN etapa_do_processo.nome IS 'Nome específico dado a esta etapa dentro do processo.';
COMMENT ON COLUMN etapa_do_processo.descricao IS 'Campo opcional para inserção de informações extras sobre a etapa.';
COMMENT ON COLUMN etapa_do_processo.ordem_etapa IS 'Ordem em que a etapa ocorre dentro do processo seletivo.';
COMMENT ON COLUMN etapa_do_processo.data_etapa IS 'Data agendada para o acontecimento da etapa.';
COMMENT ON COLUMN etapa_do_processo.id_func_responsavel IS 'Chave estrangeira que referencia o funcionário responsável por conduzir ou avaliar esta etapa.';
COMMENT ON COLUMN etapa_do_processo.id_tipo_etapa IS 'Chave estrangeira que referencia a categoria ou tipo desta etapa.';
COMMENT ON COLUMN etapa_do_processo.id_vaga IS 'Chave estrangeira que referencia a vaga de emprego à qual esta etapa de processo pertence.';

ALTER TABLE etapa_do_processo
    ADD CONSTRAINT fk_etapas_func
    FOREIGN KEY (id_func_responsavel) REFERENCES funcionario(id);

ALTER TABLE etapa_do_processo
    ADD CONSTRAINT fk_etapas_tipo
    FOREIGN KEY (id_tipo_etapa) REFERENCES tipo_etapa(id);

ALTER TABLE etapa_do_processo
    ADD CONSTRAINT fk_etapas_vaga
    FOREIGN KEY (id_VAGA) REFERENCES vaga(id);

INSERT INTO etapa_do_processo (nome, descricao, ordem_etapa, data_etapa, id_func_responsavel, id_tipo_etapa, id_vaga) VALUES
    ('Triagem Inicial', 'Leitura e filtro inicial de currículos recebidos', 1, '2026-03-01', 2, 1, 1),
    ('Alinhamento Cultural', 'Bate-papo para entender momento de carreira', 2, '2026-03-05', 4, 2, 1),
    ('Teste de Lógica Online', NULL, 3, '2026-03-10', 1, 4, 1),
    ('Filtro de Portfólio', 'Avaliação de projetos anteriores', 1, '2026-03-15', 3, 1, 2),
    ('Entrevista Técnica Sênior', 'Aprofundamento em arquitetura de software', 2, '2026-03-20', 8, 3, 2),
    ('Live Coding', 'Desafio prático acompanhado pelos devs', 3, '2026-03-25', 8, 5, 2),
    ('Conversa com a Diretoria', 'Avaliação final com os gestores da área', 4, '2026-03-30', 10, 6, 2),
    ('Análise de CV - Estágio', 'Verificação de requisitos acadêmicos', 1, '2026-04-02', 5, 1, 5),
    ('Dinâmica de Grupo', 'Atividade em equipe para avaliar soft skills', 2, '2026-04-10', 4, 2, 5),
    ( 'Apresentação de Case', 'Resolução de um problema fictício', 3, '2026-04-18', 6, 5, 5),
    ( 'Triagem de Candidatos', NULL, 1, '2026-05-01', 7, 1, 8),
    ( 'Prova de Conhecimentos Específicos', 'Teste de múltipla escolha via portal', 2, '2026-05-05', 2, 4, 8),
    ( 'Painel Técnico', 'Entrevista com 3 especialistas da equipe', 3, '2026-05-12', 9, 3, 8),
    ( 'Entrevista Fit Cultural', 'Bate-papo focado em valores da empresa', 1, '2026-06-01', 1, 2, 10),
    ( 'Bate-papo com CEO', 'Reunião de fechamento para cargos de liderança', 2, '2026-06-10', 10, 6, 10);