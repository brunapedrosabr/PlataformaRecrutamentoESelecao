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

-- (3) Consultas
-- Q1
-- Q2
-- Q3
-- Q4
-- Q5
-- Q6
-- Q7
-- Q8
-- Q9
-- Q10