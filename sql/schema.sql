-- =============================================
-- ESFUMA — Base de Dados
-- =============================================

CREATE DATABASE IF NOT EXISTS esfuma
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE esfuma;

-- ---------------------------------------------
-- ESCALÕES
-- ---------------------------------------------
CREATE TABLE IF NOT EXISTS escaloes (
    id        INT AUTO_INCREMENT PRIMARY KEY,
    nome      VARCHAR(50)  NOT NULL,
    idade_max INT          NOT NULL,
    ativo     TINYINT(1)   NOT NULL DEFAULT 1
);

-- ---------------------------------------------
-- TREINADORES
-- ---------------------------------------------
CREATE TABLE IF NOT EXISTS treinadores (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    escalao_id INT          NOT NULL,
    nome       VARCHAR(100) NOT NULL,
    FOREIGN KEY (escalao_id) REFERENCES escaloes(id) ON DELETE CASCADE
);

-- ---------------------------------------------
-- TREINOS (horários)
-- ---------------------------------------------
CREATE TABLE IF NOT EXISTS treinos (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    escalao_id INT          NOT NULL,
    dia        VARCHAR(20)  NOT NULL,
    hora       VARCHAR(25)  NOT NULL,
    local      VARCHAR(100) NOT NULL,
    FOREIGN KEY (escalao_id) REFERENCES escaloes(id) ON DELETE CASCADE
);

-- =============================================
-- DADOS INICIAIS
-- =============================================

INSERT INTO escaloes (nome, idade_max) VALUES
    ('Sub-6',     6),
    ('Sub-7',     7),
    ('Sub-8',     8),
    ('Sub-9',     9),
    ('Sub-10',   10),
    ('Sub-11',   11),
    ('Sub-12',   12),
    ('Sub-13',   13),
    ('Iniciados',15),
    ('Juvenis',  17),
    ('Juniores', 19);

-- Sub-6 (id=1)
INSERT INTO treinadores (escalao_id, nome) VALUES
    (1, 'Afonso Azevedo'),
    (1, 'Francisco Sombreireiro');
INSERT INTO treinos (escalao_id, dia, hora, local) VALUES
    (1, 'Segunda', '19h00 - 20h00', 'Campo ESFUMA'),
    (1, 'Quarta',  '19h00 - 20h00', 'Campo ESFUMA');

-- Sub-7 (id=2)
INSERT INTO treinadores (escalao_id, nome) VALUES
    (2, 'Treinador A'),
    (2, 'Treinador B');
INSERT INTO treinos (escalao_id, dia, hora, local) VALUES
    (2, 'Terça',  '19h00 - 20h00', 'Campo ESFUMA'),
    (2, 'Sábado', '19h00 - 20h00', 'Campo ESFUMA');

-- Sub-8 (id=3)
INSERT INTO treinadores (escalao_id, nome) VALUES
    (3, 'Treinador C'),
    (3, 'Treinador D');
INSERT INTO treinos (escalao_id, dia, hora, local) VALUES
    (3, 'Quarta',  '19h00 - 20h00', 'Campo ESFUMA'),
    (3, 'Sábado',  '19h00 - 20h00', 'Campo ESFUMA');

-- Sub-9 (id=4)
INSERT INTO treinadores (escalao_id, nome) VALUES
    (4, 'Treinador E'),
    (4, 'Treinador F');
INSERT INTO treinos (escalao_id, dia, hora, local) VALUES
    (4, 'Terça',  '19h00 - 20h00', 'Campo ESFUMA'),
    (4, 'Sábado', '19h00 - 20h00', 'Campo ESFUMA');

-- Sub-10 (id=5)
INSERT INTO treinadores (escalao_id, nome) VALUES
    (5, 'Treinador G'),
    (5, 'Treinador H');
INSERT INTO treinos (escalao_id, dia, hora, local) VALUES
    (5, 'Segunda', '19h00 - 20h00', 'Campo ESFUMA'),
    (5, 'Quinta',  '19h00 - 20h00', 'Campo ESFUMA');

-- Sub-11 (id=6)
INSERT INTO treinadores (escalao_id, nome) VALUES
    (6, 'João Pedro Ramos');
INSERT INTO treinos (escalao_id, dia, hora, local) VALUES
    (6, 'Segunda', '19h00 - 20h15', 'Liceu Jaime Moniz'),
    (6, 'Quinta',  '18h40 - 19h50', 'Escola da Ajuda');

-- Sub-12 (id=7)
INSERT INTO treinadores (escalao_id, nome) VALUES
    (7, 'Treinador K'),
    (7, 'Treinador L');
INSERT INTO treinos (escalao_id, dia, hora, local) VALUES
    (7, 'Terça',  '19h00 - 20h00', 'Campo ESFUMA'),
    (7, 'Quarta', '19h00 - 20h00', 'Campo ESFUMA'),
    (7, 'Quinta', '19h00 - 20h00', 'Campo ESFUMA');

-- Sub-13 (id=8)
INSERT INTO treinadores (escalao_id, nome) VALUES
    (8, 'Treinador M'),
    (8, 'Treinador N');
INSERT INTO treinos (escalao_id, dia, hora, local) VALUES
    (8, 'Terça',  '19h00 - 20h00', 'Campo ESFUMA'),
    (8, 'Quarta', '19h00 - 20h00', 'Campo ESFUMA'),
    (8, 'Quinta', '19h00 - 20h00', 'Campo ESFUMA');

-- Iniciados (id=9)
INSERT INTO treinadores (escalao_id, nome) VALUES
    (9, 'Treinador O'),
    (9, 'Treinador P');
INSERT INTO treinos (escalao_id, dia, hora, local) VALUES
    (9, 'Terça',  '19h00 - 20h00', 'Campo ESFUMA'),
    (9, 'Quarta', '19h00 - 20h00', 'Campo ESFUMA'),
    (9, 'Sexta',  '19h00 - 20h00', 'Campo ESFUMA');

-- Juvenis (id=10)
INSERT INTO treinadores (escalao_id, nome) VALUES
    (10, 'Treinador Q'),
    (10, 'Treinador R');
INSERT INTO treinos (escalao_id, dia, hora, local) VALUES
    (10, 'Segunda', '19h00 - 20h00', 'Campo ESFUMA'),
    (10, 'Quarta',  '19h00 - 20h00', 'Campo ESFUMA'),
    (10, 'Sexta',   '19h00 - 20h00', 'Campo ESFUMA');

-- Juniores (id=11)
INSERT INTO treinadores (escalao_id, nome) VALUES
    (11, 'Treinador S'),
    (11, 'Treinador T');
INSERT INTO treinos (escalao_id, dia, hora, local) VALUES
    (11, 'Segunda', '19h00 - 20h00', 'Campo ESFUMA'),
    (11, 'Quarta',  '19h00 - 20h00', 'Campo ESFUMA'),
    (11, 'Sexta',   '19h00 - 20h00', 'Campo ESFUMA');
