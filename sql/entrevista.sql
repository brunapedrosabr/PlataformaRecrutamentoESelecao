-- MODALIDADE ENTREVISTA
DROP TABLE IF EXISTS modalidade_entrevista CASCADE;

CREATE TABLE IF NOT EXISTS modalidade_entrevista (
    id SERIAL PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL
);

COMMENT ON TABLE modalidade_entrevista IS 'Tabela responsável por armazenar as modalidades possíveis de entrevista.';
COMMENT ON COLUMN modalidade_entrevista.id IS 'Identificador único da modalidade de entrevista.';
COMMENT ON COLUMN modalidade_entrevista.tipo IS 'Tipo da modalidade de entrevista, como Presencial, Online ou Híbrida.';

INSERT INTO modalidade_entrevista (tipo) VALUES
('Presencial'),
('Online'),
('Híbrida');


-- STATUS ENTREVISTA
DROP TABLE IF EXISTS status_entrevista CASCADE;

CREATE TABLE IF NOT EXISTS status_entrevista (
    id SERIAL PRIMARY KEY,
    status VARCHAR(50) NOT NULL
);

COMMENT ON TABLE status_entrevista IS 'Tabela responsável por armazenar os possíveis status de uma entrevista.';
COMMENT ON COLUMN status_entrevista.id IS 'Identificador único do status da entrevista.';
COMMENT ON COLUMN status_entrevista.status IS 'Descrição do status da entrevista, como Agendada, Realizada ou Cancelada.';

INSERT INTO status_entrevista (status) VALUES
('Agendada'),
('Confirmada'),
('Realizada'),
('Cancelada'),
('Reagendada');


-- RESULTADO ENTREVISTA
DROP TABLE IF EXISTS resultado_entrevista CASCADE;

CREATE TABLE IF NOT EXISTS resultado_entrevista (
    id SERIAL PRIMARY KEY,
    resultado VARCHAR(50) NOT NULL
);

COMMENT ON TABLE resultado_entrevista IS 'Tabela responsável por armazenar os possíveis resultados de uma entrevista.';
COMMENT ON COLUMN resultado_entrevista.id IS 'Identificador único do resultado da entrevista.';
COMMENT ON COLUMN resultado_entrevista.resultado IS 'Descrição do resultado da entrevista, como Aprovado, Reprovado ou Em Análise.';

INSERT INTO resultado_entrevista (resultado) VALUES
('Aprovado'),
('Reprovado'),
('Em Análise'),
('Banco de Talentos'),
('Desistiu');


-- LOCAL ENTREVISTA
DROP TABLE IF EXISTS local_entrevista CASCADE;

CREATE TABLE IF NOT EXISTS local_entrevista (
    id SERIAL PRIMARY KEY,
    tipo_local VARCHAR(50) NOT NULL,
    endereco_fisico VARCHAR(255),
    link VARCHAR(255)
);

COMMENT ON TABLE local_entrevista IS 'Tabela responsável por armazenar o local físico ou virtual da entrevista.';
COMMENT ON COLUMN local_entrevista.id IS 'Identificador único do local da entrevista.';
COMMENT ON COLUMN local_entrevista.tipo_local IS 'Tipo do local da entrevista, como Presencial, Online ou Híbrida.';
COMMENT ON COLUMN local_entrevista.endereco_fisico IS 'Endereço físico onde a entrevista será realizada, quando presencial.';
COMMENT ON COLUMN local_entrevista.link IS 'Link de acesso quando a entrevista for online.';

INSERT INTO local_entrevista (tipo_local, endereco_fisico, link) VALUES
('Presencial', 'Av. Paulista, 1000 - São Paulo/SP', NULL),
('Presencial', 'Rua da Bahia, 500 - Belo Horizonte/MG', NULL),
('Online', NULL, 'https://meet.google.com/abc-defg-hij'),
('Online', NULL, 'https://teams.microsoft.com/l/meetup-join/123'),
('Híbrida', 'Av. Faria Lima, 1500 - São Paulo/SP', 'https://zoom.us/j/123456789');


-- ENTREVISTA
DROP TABLE IF EXISTS entrevista CASCADE;

CREATE TABLE IF NOT EXISTS entrevista (
    id SERIAL PRIMARY KEY,
    cpf CHAR(11) NOT NULL,
    data_entrevista TIMESTAMP NOT NULL,
    id_modalidade INT NOT NULL,
    duracao_min INT NOT NULL,
    id_status_entrevista INT NOT NULL,
    id_resultado INT,
    nota_candidato NUMERIC(4,2),
    feedback VARCHAR(500),
    id_etapa INT NOT NULL,
    id_local_entrevista INT,
    id_entrevistador INT NOT NULL
);

COMMENT ON TABLE entrevista IS 'Tabela responsável por armazenar as entrevistas de candidatos durante o processo seletivo.';
COMMENT ON COLUMN entrevista.id IS 'Identificador único da entrevista.';
COMMENT ON COLUMN entrevista.cpf IS 'Chave estrangeira que referencia o candidato entrevistado.';
COMMENT ON COLUMN entrevista.data_entrevista IS 'Data e horário da entrevista.';
COMMENT ON COLUMN entrevista.id_modalidade IS 'Chave estrangeira que referencia a modalidade da entrevista.';
COMMENT ON COLUMN entrevista.duracao_min IS 'Duração da entrevista em minutos.';
COMMENT ON COLUMN entrevista.id_status_entrevista IS 'Chave estrangeira que referencia o status da entrevista.';
COMMENT ON COLUMN entrevista.id_resultado IS 'Chave estrangeira que referencia o resultado da entrevista.';
COMMENT ON COLUMN entrevista.nota_candidato IS 'Nota atribuída ao candidato na entrevista.';
COMMENT ON COLUMN entrevista.feedback IS 'Feedback textual sobre o desempenho do candidato.';
COMMENT ON COLUMN entrevista.id_etapa IS 'Chave estrangeira que referencia a etapa do processo seletivo.';
COMMENT ON COLUMN entrevista.id_local_entrevista IS 'Chave estrangeira que referencia o local físico ou virtual da entrevista.';
COMMENT ON COLUMN entrevista.id_entrevistador IS 'Chave estrangeira que referencia o funcionário responsável pela entrevista.';

ALTER TABLE entrevista
    ADD CONSTRAINT fk_entrevista_candidato
    FOREIGN KEY (cpf) REFERENCES candidato(cpf);

ALTER TABLE entrevista
    ADD CONSTRAINT fk_entrevista_modalidade
    FOREIGN KEY (id_modalidade) REFERENCES modalidade_entrevista(id);

ALTER TABLE entrevista
    ADD CONSTRAINT fk_entrevista_status
    FOREIGN KEY (id_status_entrevista) REFERENCES status_entrevista(id);

ALTER TABLE entrevista
    ADD CONSTRAINT fk_entrevista_resultado
    FOREIGN KEY (id_resultado) REFERENCES resultado_entrevista(id);

ALTER TABLE entrevista
    ADD CONSTRAINT fk_entrevista_etapa
    FOREIGN KEY (id_etapa) REFERENCES etapa_do_processo(id);

ALTER TABLE entrevista
    ADD CONSTRAINT fk_entrevista_local
    FOREIGN KEY (id_local_entrevista) REFERENCES local_entrevista(id);

ALTER TABLE entrevista
    ADD CONSTRAINT fk_entrevista_entrevistador
    FOREIGN KEY (id_entrevistador) REFERENCES funcionario(id);

INSERT INTO entrevista (
    cpf,
    data_entrevista,
    id_modalidade,
    duracao_min,
    id_status_entrevista,
    id_resultado,
    nota_candidato,
    feedback,
    id_etapa,
    id_local_entrevista,
    id_entrevistador
) VALUES
('12345678901', '2026-03-05 09:00:00', 2, 30, 3, 1, 8.50, 'Boa comunicação e perfil aderente.', 1, 3, 2),
('23456789012', '2026-03-08 10:00:00', 2, 30, 3, 1, 8.70, 'Ótima comunicação.', 2, 3, 1),
('34567890123', '2026-03-12 15:00:00', 1, 45, 3, 2, 5.80, 'Conhecimento técnico abaixo do esperado.', 3, 1, 8),
('45678901234', '2026-03-18 09:00:00', 2, 60, 3, 1, 9.40, 'Excelente desempenho técnico.', 5, 4, 10),
('56789012345', '2026-04-02 14:00:00', 2, 30, 1, NULL, NULL, NULL, 8, 3, 4),
('67890123456', '2026-04-15 11:00:00', 3, 50, 3, 4, 7.20, 'Mantido em banco de talentos.', 10, 5, 6),
('78901234567', '2026-05-10 09:30:00', 1, 40, 3, 1, 8.90, 'Perfil aderente à cultura da empresa.', 13, 2, 9),
('89012345678', '2026-05-20 16:00:00', 2, 45, 4, NULL, NULL, 'Candidato não compareceu.', 11, 4, 7),
('90123456789', '2026-06-01 13:30:00', 1, 60, 3, 3, 7.50, 'Aguardando decisão final.', 14, 1, 1),
('01234567890', '2026-06-10 10:00:00', 3, 50, 5, NULL, NULL, 'Entrevista será remarcada.', 15, 5, 10);
