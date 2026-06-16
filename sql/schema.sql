-- (1) DDL (DROP, ALTER, )
-- Comandos DROP
DROP TABLE IF EXISTS candidato CASCADE;
DROP TABLE IF EXISTS cargo CASCADE;
DROP TABLE IF EXISTS contato_candidato CASCADE;
DROP TABLE IF EXISTS endereco CASCADE;
DROP TABLE IF EXISTS etapa_do_processo CASCADE;
DROP TABLE IF EXISTS funcionario CASCADE;
DROP TABLE IF EXISTS tipo_etapa CASCADE;

DROP TABLE IF EXISTS Requisito CASCADE;
DROP TABLE IF EXISTS Vaga CASCADE;
DROP TABLE IF EXISTS Cargo CASCADE;
DROP TABLE IF EXISTS Empresa CASCADE;

DROP TABLE IF EXISTS modalidade_entrevista CASCADE;
DROP TABLE IF EXISTS status_entrevista CASCADE;
DROP TABLE IF EXISTS resultado_entrevista CASCADE;
DROP TABLE IF EXISTS local_entrevista CASCADE;
DROP TABLE IF EXISTS entrevista CASCADE;

-- Comandos CREATE
CREATE TABLE IF NOT EXISTS candidato (
    cpf CHAR(11) PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    data_nascimento DATE NOT NULL,
    curriculo VARCHAR(255),

    id_endereco INT NOT NULL
);

CREATE TABLE IF NOT EXISTS cargo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    nivel VARCHAR(255) NOT NULL,
    area VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS contato_candidato (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_contato VARCHAR(50) NOT NULL,
    valor VARCHAR(150) NOT NULL,

    cpf CHAR(11) NOT NULL
);

CREATE TABLE IF NOT EXISTS endereco (
    id INT PRIMARY KEY AUTO_INCREMENT,
    logradouro VARCHAR(150) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    complemento VARCHAR(20),
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL,
    cep CHAR(8) NOT NULL
);

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

CREATE TABLE IF NOT EXISTS funcionario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,

    id_cargo INT NOT NULL
);

CREATE TABLE IF NOT EXISTS tipo_etapa (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL
);

CREATE TABLE Empresa (
    CNPJ         CHAR(14)     PRIMARY KEY,
    RazaoSocial  VARCHAR(150) NOT NULL UNIQUE,
    Endereco     VARCHAR(200) NOT NULL,
    CONSTRAINT chk_empresa_cnpj_formato CHECK (CNPJ ~ '^[0-9]{14}$')
);

CREATE TABLE Cargo (
    IdCargo  INT          PRIMARY KEY,
    Nome     VARCHAR(100) NOT NULL,
    Nivel    VARCHAR(50)  NOT NULL,
    Area     VARCHAR(100) NOT NULL,
    CONSTRAINT chk_cargo_nivel CHECK (Nivel IN ('Estágio', 'Júnior', 'Pleno', 'Sênior', 'Especialista')),
    CONSTRAINT uq_cargo_nome_nivel_area UNIQUE (Nome, Nivel, Area)
);

CREATE TABLE Vaga (
    IdVaga          INT          PRIMARY KEY,
    Descricao       VARCHAR(255) NOT NULL,
    DataPublicacao  DATE         NOT NULL DEFAULT CURRENT_DATE,
    Quantidade      INT          NOT NULL DEFAULT 1,
    Salario         FLOAT        NOT NULL,
    IdCargo         INT          NOT NULL,
    Status          BOOLEAN      NOT NULL DEFAULT TRUE,
    CNPJ            CHAR(14)     NOT NULL,
    CONSTRAINT fk_vaga_cargo    FOREIGN KEY (IdCargo) REFERENCES Cargo(IdCargo),
    CONSTRAINT fk_vaga_empresa  FOREIGN KEY (CNPJ)    REFERENCES Empresa(CNPJ),
    CONSTRAINT chk_vaga_quantidade CHECK (Quantidade > 0),
    CONSTRAINT chk_vaga_salario    CHECK (Salario >= 0)
);

CREATE TABLE Requisito (
    IdRequisito  INT          PRIMARY KEY,
    IdVaga       INT          NOT NULL,
    Descricao    VARCHAR(255) NOT NULL,
    CONSTRAINT fk_requisito_vaga FOREIGN KEY (IdVaga) REFERENCES Vaga(IdVaga),
    CONSTRAINT uq_requisito_vaga_descricao UNIQUE (IdVaga, Descricao)
);

CREATE TABLE IF NOT EXISTS modalidade_entrevista (
    id SERIAL PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS status_entrevista (
    id SERIAL PRIMARY KEY,
    status VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS resultado_entrevista (
    id SERIAL PRIMARY KEY,
    resultado VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS local_entrevista (
    id SERIAL PRIMARY KEY,
    tipo_local VARCHAR(50) NOT NULL,
    endereco_fisico VARCHAR(255),
    link VARCHAR(255)
);

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

-- Comandos ALTER (criação de constraints)
ALTER TABLE candidato
    ADD CONSTRAINT fk_candidato_endereco
    FOREIGN KEY (id_endereco) REFERENCES endereco(id);

ALTER TABLE contato_candidato
    ADD CONSTRAINT fk_contato_cpf
    FOREIGN KEY (cpf) REFERENCES canditato(cpf)
    ON DELETE CASCADE;

ALTER TABLE etapa_do_processo
    ADD CONSTRAINT fk_etapas_func
    FOREIGN KEY (id_func_responsavel) REFERENCES funcionario(id);

ALTER TABLE etapa_do_processo
    ADD CONSTRAINT fk_etapas_tipo
    FOREIGN KEY (id_tipo_etapa) REFERENCES tipo_etapa(id);

ALTER TABLE etapa_do_processo
    ADD CONSTRAINT fk_etapas_vaga
    FOREIGN KEY (id_VAGA) REFERENCES vaga(id);

ALTER TABLE funcionario
    ADD CONSTRAINT fk_funcionario_cargo
    FOREIGN KEY (id_cargo) REFERENCES cargo(id);

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

-- Comandos COMMENT
COMMENT ON TABLE candidato 
    IS 'Tabela responsável por armazenar os dados de um candidato';
COMMENT ON COLUMN candidato.cpf IS 'Cadastro de Pessoa Física que serve como identificador único de um determinado candidato';
COMMENT ON COLUMN candidato.nome IS 'Nome que foi registrado em cartório de um determinado candidato';
COMMENT ON COLUMN candidato.data_nascimento IS 'Registro da data de nascimento de um determinado candidato';
COMMENT ON COLUMN candidato.curriculo IS 'Campo que permite armazenar as informações curriculares do candidato';
COMMENT ON COLUMN candidato.id_endereco IS 'Chave estrangeira que referencia o endereço completo do candidato';

COMMENT ON TABLE cargo 
    IS 'Tabela responsável por armazenar os diferentes cargos e papéis dentro da empresa.';
COMMENT ON COLUMN cargo.id IS 'Identificador único do cargo.';
COMMENT ON COLUMN cargo.nome IS 'Nome do cargo (ex: Desenvolvedor Front-end, Product Manager).';
COMMENT ON COLUMN cargo.nivel IS 'Nível hierárquico ou de senioridade do cargo (ex: Júnior, Pleno, Sênior).';
COMMENT ON COLUMN cargo.area IS 'Área de atuação ou departamento ao qual o cargo pertence.';

COMMENT ON TABLE contato_candidato 
    IS 'Tabela responsável por armazenar o contato de um determinado candidato';
COMMENT ON COLUMN contato_candidato.id IS 'Identificador único do contato';
COMMENT ON COLUMN contato_candidato.tipo_contato IS 'Nome do tipo do contato que será armazenado (ex: Telefone fixo, Email, Celular, Linkedin)';
COMMENT ON COLUMN contato_candidato.valor IS 'Armazena o contato de acordo com o tipo de contato que foi escolhido';
COMMENT ON COLUMN contato_candidato.cpf IS 'Chave estrangeira que referencia a qual candidato pertence o contato';

COMMENT ON TABLE endereco 
    IS 'Tabela responsável por armazenar o endereço de um determinado candidato';
COMMENT ON COLUMN endereco.id IS 'Idendificador único de um endereço';
COMMENT ON COLUMN endereco.logradouro IS 'Armazena o nome da rua no qual a residência está localizada';
COMMENT ON COLUMN endereco.numero IS 'Armazena o número da residência';
COMMENT ON COLUMN endereco.complemento IS 'Campo opcional caso haja algum complemento referente a residência';
COMMENT ON COLUMN endereco.bairro IS 'Armazena o bairro no qual a residência está localizada';
COMMENT ON COLUMN endereco.cidade IS 'Armazena a cidade da residência';
COMMENT ON COLUMN endereco.estado IS 'Armazena o estado da residência';
COMMENT ON COLUMN endereco.cep IS 'Armazena o cep para localizar a região na qual a residência se encontra';


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

COMMENT ON TABLE funcionario
    IS 'Tabela responsável por armazenar os detalhes dos colaboradores da empresa.';
COMMENT ON COLUMN funcionario.id IS 'Identificador único do funcionário no sistema.';
COMMENT ON COLUMN funcionario.nome IS 'Nome completo do funcionário.';
COMMENT ON COLUMN funcionario.id_cargo IS 'Chave estrangeira que referencia o cargo que o funcionário ocupa.';

COMMENT ON TABLE tipo_etapa
    IS 'Tabela responsável por armazenar o nome do tipo da etapa do processo.';
COMMENT ON COLUMN tipo_etapa.id IS 'Identificador único do tipo de etapa.';
COMMENT ON COLUMN tipo_etapa.nome IS 'Nome ou classificação do tipo de etapa (ex: Entrevista RH, Teste Técnico, Dinâmica de Grupo).';

COMMENT ON TABLE modalidade_entrevista IS 'Tabela responsável por armazenar as modalidades possíveis de entrevista.';
COMMENT ON COLUMN modalidade_entrevista.id IS 'Identificador único da modalidade de entrevista.';
COMMENT ON COLUMN modalidade_entrevista.tipo IS 'Tipo da modalidade de entrevista, como Presencial, Online ou Híbrida.';

COMMENT ON TABLE status_entrevista IS 'Tabela responsável por armazenar os possíveis status de uma entrevista.';
COMMENT ON COLUMN status_entrevista.id IS 'Identificador único do status da entrevista.';
COMMENT ON COLUMN status_entrevista.status IS 'Descrição do status da entrevista, como Agendada, Realizada ou Cancelada.';

COMMENT ON TABLE resultado_entrevista IS 'Tabela responsável por armazenar os possíveis resultados de uma entrevista.';
COMMENT ON COLUMN resultado_entrevista.id IS 'Identificador único do resultado da entrevista.';
COMMENT ON COLUMN resultado_entrevista.resultado IS 'Descrição do resultado da entrevista, como Aprovado, Reprovado ou Em Análise.';

COMMENT ON TABLE local_entrevista IS 'Tabela responsável por armazenar o local físico ou virtual da entrevista.';
COMMENT ON COLUMN local_entrevista.id IS 'Identificador único do local da entrevista.';
COMMENT ON COLUMN local_entrevista.tipo_local IS 'Tipo do local da entrevista, como Presencial, Online ou Híbrida.';
COMMENT ON COLUMN local_entrevista.endereco_fisico IS 'Endereço físico onde a entrevista será realizada, quando presencial.';
COMMENT ON COLUMN local_entrevista.link IS 'Link de acesso quando a entrevista for online.';

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

-- (2) DML
INSERT INTO candidato (cpf, nome, data_nascimento, curriculo, id_endereco) VALUES
    ('12345678901', 'João Silva', '1998-05-12', 'curriculos/joao_silva.pdf', 1),
    ('23456789012', 'Maria Oliveira', '1995-08-23', 'curriculos/maria_oliveira.pdf', 2),
    ('34567890123', 'Pedro Santos', '2000-01-15', 'curriculos/pedro_santos.pdf', 3),
    ('45678901234', 'Ana Costa', '1997-11-30', 'curriculos/ana_costa.pdf', 4),
    ('56789012345', 'Lucas Ferreira', '1999-04-18', 'curriculos/lucas_ferreira.pdf', 5),
    ('67890123456', 'Juliana Souza', '1996-09-07', 'curriculos/juliana_souza.pdf', 6),
    ('78901234567', 'Gabriel Almeida', '2001-02-21', 'curriculos/gabriel_almeida.pdf', 7),
    ('89012345678', 'Fernanda Rocha', '1998-12-03', 'curriculos/fernanda_rocha.pdf', 8),
    ('90123456789', 'Rafael Martins', '1994-07-14', 'curriculos/rafael_martins.pdf', 9),
    ('01234567890', 'Camila Pereira', '2002-06-25', 'curriculos/camila_pereira.pdf', 10);

INSERT INTO cargo (nome, nivel, area) VALUES
    ('Desenvolvedor Front-end', 'Júnior', 'Engenharia de Software'),
    ('Desenvolvedor Front-end', 'Pleno', 'Engenharia de Software'),
    ('Desenvolvedor Back-end', 'Pleno', 'Engenharia de Software'),
    ('Desenvolvedor Back-end', 'Sênior', 'Engenharia de Software'),
    ('Analista de QA (Qualidade)', 'Pleno', 'Qualidade e Testes'),
    ('Engenheiro DevOps', 'Sênior', 'Infraestrutura'),
    ('Product Manager', 'Pleno', 'Produto'),
    ('UX/UI Designer', 'Pleno', 'Design'),
    ('Scrum Master', 'Sênior', 'Agilidade'),
    ('Tech Lead', 'Especialista', 'Engenharia de Software');

INSERT INTO contato_candidato (tipo_contato, valor, cpf) VALUES
    ('Email', 'joao.silva@email.com', '12345678901'),
    ('Telefone', '31991234567', '23456789012'),
    ('Email', 'pedro.santos@email.com', '34567890123'),
    ('Telefone', '31992345678', '45678901234'),
    ('LinkedIn', 'linkedin.com/in/lucasferreira', '56789012345'),
    ('Email', 'juliana.souza@email.com', '67890123456'),
    ('Telefone', '31993456789', '78901234567'),
    ('Email', 'fernanda.rocha@email.com', '89012345678'),
    ('LinkedIn', 'linkedin.com/in/rafaelmartins', '90123456789'),
    ('Telefone', '31994567890', '01234567890');

INSERT INTO endereco (logradouro, numero, complemento, bairro, cidade, estado, cep) VALUES
    ('Rua das Flores', '120', 'Apto 101', 'Centro', 'Belo Horizonte', 'MG', '30110000'),
    ('Avenida Brasil', '450', NULL, 'Funcionários', 'Belo Horizonte', 'MG', '30140071'),
    ('Rua São José', '78', 'Casa', 'Savassi', 'Belo Horizonte', 'MG', '30112020'),
    ('Rua Tiradentes', '890', NULL, 'Centro', 'Contagem', 'MG', '32010010'),
    ('Avenida Amazonas', '1500', 'Sala 305', 'Centro', 'Betim', 'MG', '32600000'),
    ('Rua dos Ipês', '55', NULL, 'Jardim América', 'Belo Horizonte', 'MG', '30421000'),
    ('Avenida Afonso Pena', '2300', 'Bloco B', 'Funcionários', 'Belo Horizonte', 'MG', '30130007'),
    ('Rua da Bahia', '640', NULL, 'Lourdes', 'Belo Horizonte', 'MG', '30160011'),
    ('Rua Padre Eustáquio', '312', 'Fundos', 'Padre Eustáquio', 'Belo Horizonte', 'MG', '30720000'),
    ('Avenida João César de Oliveira', '400', NULL, 'Eldorado', 'Contagem', 'MG', '32310000');

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

INSERT INTO funcionario (nome, id_cargo) VALUES
    ('Ana Silva', 3),        -- Desenvolvedor Back-end Pleno
    ('Carlos Eduardo', 1),   -- Desenvolvedor Front-end Júnior
    ('Beatriz Costa', 7),    -- Product Manager Pleno
    ('Daniel Souza', 6),     -- Engenheiro DevOps Sênior
    ('Eduarda Lima', 2),     -- Desenvolvedor Front-end Pleno
    ('Felipe Santos', 4),    -- Desenvolvedor Back-end Sênior
    ('Gabriela Oliveira', 8),-- UX/UI Designer Pleno
    ('Henrique Martins', 10),-- Tech Lead Especialista
    ('Isabela Rocha', 5),    -- Analista de QA Pleno
    ('João Pedro', 9),       -- Scrum Master Sênior
    ('Karla Mendes', 3),     -- Desenvolvedor Back-end Pleno
    ('Lucas Almeida', 2),    -- Desenvolvedor Front-end Pleno
    ('Mariana Pereira', 1),  -- Desenvolvedor Front-end Júnior
    ('Nicolas Ferreira', 4), -- Desenvolvedor Back-end Sênior
    ('Olivia Ribeiro', 5);   -- Analista de QA Pleno

INSERT INTO tipo_etapa (nome) VALUES
    ('Análise Curricular'),
    ('Entrevista RH'),
    ('Entrevista Técnica'),
    ('Prova Lógica'),
    ('Desafio Técnico'),
    ('Entrevista Gestores');

INSERT INTO modalidade_entrevista (tipo) VALUES
('Presencial'),
('Online'),
('Híbrida');

INSERT INTO status_entrevista (status) VALUES
('Agendada'),
('Confirmada'),
('Realizada'),
('Cancelada'),
('Reagendada');

INSERT INTO resultado_entrevista (resultado) VALUES
('Aprovado'),
('Reprovado'),
('Em Análise'),
('Banco de Talentos'),
('Desistiu');

INSERT INTO local_entrevista (tipo_local, endereco_fisico, link) VALUES
('Presencial', 'Av. Paulista, 1000 - São Paulo/SP', NULL),
('Presencial', 'Rua da Bahia, 500 - Belo Horizonte/MG', NULL),
('Online', NULL, 'https://meet.google.com/abc-defg-hij'),
('Online', NULL, 'https://teams.microsoft.com/l/meetup-join/123'),
('Híbrida', 'Av. Faria Lima, 1500 - São Paulo/SP', 'https://zoom.us/j/123456789');

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

-- (3) Consultas
-- Q1
SELECT ep.nome AS etapa_nome,
    ep.descricao,
    f.nome AS funcionario
FROM etapa_do_processo AS ep
    JOIN funcionario AS f ON f.id = ep.id_func_responsavel
WHERE ep.data_etapa BETWEEN '2026-03-01' AND '2026-03-31'
    
-- Q2
SELECT ep.nome AS etapa_nome,
    ep.descricao,
    f.nome AS funcionario,
    te.nome AS tipo_etapa,
    v.descricao AS vaga,
    v.salario
FROM etapa_do_processo AS ep
    JOIN funcionario AS f ON f.id = ep.id_func_responsavel
    JOIN tipo_etapa AS te ON te.id = ep.id_tipo_etapa
    JOIN vaga AS v ON v.id = ep.id_vaga
WHERE te.nome LIKE '%entrevista%'
    AND v.salario >= 1000

-- Q3
SELECT
f.nome AS funcionario,
c.nome AS cargo,
c.nivel
FROM funcionario f
INNER JOIN cargo c ON f.id_cargo = c.id
    
-- Q4
SELECT
ep.nome AS etapa,
te.nome AS tipo_etapa,
f.nome AS responsavel,
c.nome AS cargo_responsavel
FROM etapa_do_processo ep
INNER JOIN tipo_etapa te ON ep.id_tipo_etapa = te.id
INNER JOIN funcionario f ON ep.id_func_responsavel = f.id
INNER JOIN cargo c ON f.id_cargo = c.id
    
-- Q5
SELECT
c.nome AS candidato,
cc.tipo_contato,
cc.valor
FROM candidato c
LEFT JOIN contato_candidato cc ON c.cpf = cc.cpf
    
-- Q6
SELECT
ca.area,
COUNT(f.id) AS total_funcionarios
FROM funcionario f
INNER JOIN cargo ca ON f.id_cargo = ca.id
GROUP BY ca.area
HAVING COUNT(f.id) >= 2
    
-- Q7
SELECT
nome,
cpf
FROM candidato
WHERE cpf IN (
SELECT cpf
FROM contato_candidato
WHERE tipo_contato = 'Email'
)

-- Q8
SELECT
c.nome,
c.cpf
FROM candidato c
WHERE EXISTS (
SELECT 1
FROM contato_candidato cc
WHERE cc.cpf = c.cpf
AND cc.tipo_contato = 'LinkedIn'
)
    
-- Q9
WITH resumo_entrevistas AS (
SELECT
c.nome AS candidato,
e.data_entrevista,
m.tipo AS modalidade,
s.status AS status_entrevista,
r.resultado,
e.nota_candidato,
f.nome AS entrevistador
FROM entrevista e
INNER JOIN candidato c ON e.cpf = c.cpf
INNER JOIN modalidade_entrevista m ON e.id_modalidade = m.id_modalidade
INNER JOIN status_entrevista s ON e.id_status_entrevista = s.id_status
LEFT OUTER JOIN resultado_entrevista r ON e.id_resultado = r.id_resultado
INNER JOIN funcionario f ON e.id_entrevistador = f.id
)
SELECT *
FROM resumo_entrevistas
WHERE status_entrevista = 'Realizada'
    
-- Q10
SELECT
c.nome AS candidato,
COUNT(e.id_entrevista) AS total_entrevistas,
AVG(e.nota_candidato) AS media_nota,
MAX(e.nota_candidato) AS maior_nota
FROM entrevista e
INNER JOIN candidato c ON e.cpf = c.cpf
INNER JOIN status_entrevista s ON e.id_status_entrevista = s.id_status
WHERE s.status = 'Realizada'
GROUP BY c.nome
HAVING AVG(e.nota_candidato) >= 7
ORDER BY media_nota DESC
