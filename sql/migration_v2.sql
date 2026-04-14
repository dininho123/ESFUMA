-- =============================================
-- MIGRAÇÃO v2: treinadores independentes
-- =============================================

-- 1. Criar tabela de junção
CREATE TABLE IF NOT EXISTS escalao_treinador (
    escalao_id   INT NOT NULL,
    treinador_id INT NOT NULL,
    PRIMARY KEY (escalao_id, treinador_id)
);

-- 2. Copiar relações existentes
INSERT IGNORE INTO escalao_treinador (escalao_id, treinador_id)
SELECT escalao_id, id FROM treinadores;

-- 3. Recriar treinadores sem escalao_id
CREATE TABLE treinadores_temp (
    id   INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);
INSERT INTO treinadores_temp (id, nome) SELECT id, nome FROM treinadores;
DROP TABLE treinadores;
RENAME TABLE treinadores_temp TO treinadores;

-- 4. Adicionar foreign keys
ALTER TABLE escalao_treinador
    ADD CONSTRAINT fk_et_escalao   FOREIGN KEY (escalao_id)   REFERENCES escaloes(id)    ON DELETE CASCADE,
    ADD CONSTRAINT fk_et_treinador FOREIGN KEY (treinador_id) REFERENCES treinadores(id) ON DELETE CASCADE;
