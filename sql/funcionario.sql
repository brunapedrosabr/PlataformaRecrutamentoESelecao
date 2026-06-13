-- CARGO
DROP TABLE IF EXISTS cargo CASCADE;

CREATE TABLE IF NOT EXISTS cargo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    nivel VARCHAR(255) NOT NULL,
    area VARCHAR(255) NOT NULL
);

COMMENT ON TABLE cargo 
    IS 'Tabela responsável por armazenar os diferentes cargos e papéis dentro da empresa.';

COMMENT ON COLUMN cargo.id IS 'Identificador único do cargo.';
COMMENT ON COLUMN cargo.nome IS 'Nome do cargo (ex: Desenvolvedor Front-end, Product Manager).';
COMMENT ON COLUMN cargo.nivel IS 'Nível hierárquico ou de senioridade do cargo (ex: Júnior, Pleno, Sênior).';
COMMENT ON COLUMN cargo.area IS 'Área de atuação ou departamento ao qual o cargo pertence.';

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

-- FUNCIONARIO
DROP TABLE IF EXISTS funcionario CASCADE;

CREATE TABLE IF NOT EXISTS funcionario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,

    id_cargo INT NOT NULL
);

COMMENT ON TABLE funcionario
    IS 'Tabela responsável por armazenar os detalhes dos colaboradores da empresa.';

COMMENT ON COLUMN funcionario.id IS 'Identificador único do funcionário no sistema.';
COMMENT ON COLUMN funcionario.nome IS 'Nome completo do funcionário.';
COMMENT ON COLUMN funcionario.id_cargo IS 'Chave estrangeira que referencia o cargo que o funcionário ocupa.';

ALTER TABLE funcionario
    ADD CONSTRAINT fk_funcionario_cargo
    FOREIGN KEY (id_cargo) REFERENCES cargo(id);

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