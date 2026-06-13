SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE TABLE IF NOT EXISTS `categorias_servico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `descricao` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(150) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `tipo` enum('EMPREITEIRA','PRESTADOR') NOT NULL,
  `data_cadastro` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `empreiteiras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `cnpj` varchar(18) NOT NULL,
  `nome_fantasia` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cnpj` (`cnpj`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `empreiteiras_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `oportunidades_servico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empreiteira_id` int(11) NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `valor_estimado` decimal(10,2) NOT NULL,
  `status` enum('ABERTA','EM_ANDAMENTO','CONCLUIDA','CANCELADA') DEFAULT 'ABERTA',
  PRIMARY KEY (`id`),
  KEY `empreiteira_id` (`empreiteira_id`),
  CONSTRAINT `oportunidades_servico_ibfk_1` FOREIGN KEY (`empreiteira_id`) REFERENCES `empreiteiras` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `prestadores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `categoria_id` int(11) NOT NULL,
  `cpf` varchar(14) NOT NULL,
  `nome_completo` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cpf` (`cpf`),
  KEY `usuario_id` (`usuario_id`),
  KEY `categoria_id` (`categoria_id`),
  CONSTRAINT `prestadores_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `prestadores_ibfk_2` FOREIGN KEY (`categoria_id`) REFERENCES `categorias_servico` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `logs_auditoria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tabela_afetada` varchar(50) NOT NULL,
  `acao` varchar(255) NOT NULL,
  `data_hora` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `oportunidades_arquivadas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `oportunidade_id` int(11) NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT IGNORE INTO `categorias_servico` (`id`, `nome`, `descricao`) VALUES
(1, 'Alvenaria', 'Serviços de construção de paredes e estruturas.'),
(2, 'Elétrica', 'Instalações e manutenções elétricas.'),
(3, 'Hidráulica', 'Instalação de encanamentos e água.'),
(4, 'Pintura', 'Pintura interna e externa.'),
(5, 'Gesso', 'Instalação de forros e paredes de drywall.'),
(6, 'Serralheria', 'Fabricação de estruturas metálicas.'),
(7, 'Marcenaria', 'Móveis planejados e reparos em madeira.'),
(8, 'Jardinagem', 'Manutenção de áreas verdes nas obras.'),
(9, 'Limpeza Pós-Obra', 'Higienização após o término da construção.'),
(10, 'Impermeabilização', 'Tratamento contra infiltrações.');

INSERT IGNORE INTO `usuarios` (`id`, `email`, `senha`, `tipo`) VALUES
(1, 'contato@construtora-a.com', 'novaSenhaSegura456', 'EMPREITEIRA'),
(2, 'rh@engenhariab.com.br', 'novaSenhaSegura456', 'EMPREITEIRA'),
(3, 'projetos@edifica.com', 'hash123', 'EMPREITEIRA'),
(4, 'compras@obracerta.com', 'hash123', 'EMPREITEIRA'),
(5, 'admin@baseforte.com', 'hash123', 'EMPREITEIRA'),
(6, 'joao.silva@email.com', 'hash123', 'PRESTADOR'),
(7, 'maria.eletricista@email.com', 'hash123', 'PRESTADOR'),
(8, 'carlos.encanador@email.com', 'hash123', 'PRESTADOR'),
(9, 'pedro.pintor@email.com', 'hash123', 'PRESTADOR'),
(10, 'lucas.gesso@email.com', 'hash123', 'PRESTADOR'),
(11, 'suporte@serviconnect.com', 'padrao123', 'PRESTADOR');

INSERT IGNORE INTO `empreiteiras` (`id`, `usuario_id`, `cnpj`, `nome_fantasia`) VALUES
(1, 1, '11.111.111/0001-11', 'Construtora A - Matriz'),
(2, 1, '11.111.111/0002-22', 'Construtora A - Filial SP'),
(3, 2, '22.222.222/0001-22', 'Engenharia B'),
(4, 3, '33.333.333/0001-33', 'Edifica Projetos e Soluções'),
(5, 4, '44.444.444/0001-44', 'Obra Certa LTDA'),
(6, 5, '55.555.555/0001-55', 'Base Forte Engenharia'),
(7, 2, '22.222.222/0002-33', 'Engenharia B - RJ'),
(8, 3, '33.333.333/0002-44', 'Edifica Projetos - Galpões'),
(9, 4, '44.444.444/0002-55', 'Obra Certa - Residenciais'),
(10, 5, '55.555.555/0002-66', 'Base Forte - Infraestrutura');

INSERT IGNORE INTO `prestadores` (`id`, `usuario_id`, `categoria_id`, `cpf`, `nome_completo`) VALUES
(1, 6, 1, '111.111.111-11', 'João da Silva Santos'),
(2, 7, 2, '222.222.222-22', 'Maria Oliveira Elétrica'),
(3, 8, 3, '333.333.333-33', 'Carlos Souza Encanador'),
(4, 9, 4, '444.444.444-44', 'Pedro Costa Pinturas ME'),
(5, 10, 5, '555.555.555-55', 'Lucas Almeida Gesso'),
(6, 6, 6, '666.666.666-66', 'Roberto Silva Serralheiro'),
(7, 7, 7, '777.777.777-77', 'Ana Paula Marcenaria'),
(8, 8, 8, '888.888.888-88', 'Fernando Jardim'),
(9, 9, 9, '999.999.999-99', 'Equipe Limpeza Rápida'),
(10, 10, 10, '000.000.000-00', 'Marcos Impermeabilizante');

INSERT IGNORE INTO `oportunidades_servico` (`id`, `empreiteira_id`, `titulo`, `valor_estimado`, `status`) VALUES
(1, 1, 'Construção de muro de arrimo', 5000.00, 'CONCLUIDA'),
(2, 2, 'Reforma de Fachada', 12000.00, 'ABERTA'),
(3, 3, 'Revisão hidráulica de condomínio', 3500.00, 'CONCLUIDA'),
(4, 4, 'Pintura externa de prédio 10 andares', 27500.00, 'ABERTA'),
(5, 5, 'Troca de fiação elétrica', 4500.00, 'CANCELADA'),
(6, 1, 'Instalação de portões automáticos', 8800.00, 'ABERTA'),
(7, 2, 'Limpeza de Terreno', 1500.00, 'CONCLUIDA'),
(8, 3, 'Paisagismo praça central', 4500.00, 'CONCLUIDA'),
(9, 4, 'Instalação de Drywall', 3200.00, 'EM_ANDAMENTO'),
(10, 5, 'Aplicação de manta asfáltica', 6000.00, 'EM_ANDAMENTO'),
(11, 1, 'Reparo Emergencial Elétrico', 1650.00, 'ABERTA'),
(12, 3, 'Consultoria Hidráulica', 2200.00, 'ABERTA');

INSERT INTO oportunidades_arquivadas (oportunidade_id, titulo, valor)
SELECT id, titulo, valor_estimado FROM oportunidades_servico WHERE status = 'CONCLUIDA' AND valor_estimado > 4000;

INSERT INTO oportunidades_arquivadas (oportunidade_id, titulo, valor)
SELECT id, titulo, valor_estimado FROM oportunidades_servico WHERE status = 'CANCELADA';

INSERT INTO categorias_servico (nome, descricao)
SELECT 'Alvenaria Estrutural', descricao FROM categorias_servico WHERE nome = 'Alvenaria';

INSERT INTO logs_auditoria (tabela_afetada, acao)
SELECT 'usuarios', CONCAT('Carga do email: ', email) FROM usuarios WHERE tipo = 'EMPREITEIRA';

INSERT INTO oportunidades_arquivadas (oportunidade_id, titulo, valor)
SELECT id, titulo, valor_estimado FROM oportunidades_servico WHERE status = 'CONCLUIDA' AND valor_estimado < 2000;

UPDATE oportunidades_servico SET valor_estimado = valor_estimado * 1.10 WHERE status = 'ABERTA';
UPDATE categorias_servico SET descricao = 'Instalações elétricas gerais e manutenção' WHERE id = 2;
UPDATE usuarios SET senha = 'NovaSenhaCriptografada' WHERE tipo = 'PRESTADOR' AND id < 8;
UPDATE oportunidades_servico SET status = 'CANCELADA' WHERE titulo LIKE '%Emergencial%';
UPDATE prestadores SET nome_completo = UPPER(nome_completo) WHERE categoria_id = 1;

DELETE FROM oportunidades_arquivadas WHERE valor < 1000;
DELETE FROM oportunidades_servico WHERE status = 'CANCELADA';
DELETE FROM categorias_servico WHERE nome = 'Alvenaria Estrutural';
DELETE FROM logs_auditoria WHERE id > 10;
DELETE FROM prestadores WHERE nome_completo = 'Marcos Impermeabilizante';

SELECT p.nome_completo, c.nome AS categoria FROM prestadores p INNER JOIN categorias_servico c ON p.categoria_id = c.id;

SELECT e.nome_fantasia, u.email FROM empreiteiras e INNER JOIN usuarios u ON e.usuario_id = u.id;

SELECT o.titulo, o.valor_estimado, e.nome_fantasia FROM oportunidades_servico o INNER JOIN empreiteiras e ON o.empreiteira_id = e.id;

SELECT p.cpf, p.nome_completo, u.email, u.data_cadastro FROM prestadores p INNER JOIN usuarios u ON p.usuario_id = u.id;

SELECT e.cnpj, e.nome_fantasia, o.titulo FROM empreiteiras e INNER JOIN oportunidades_servico o ON e.id = o.empreiteira_id WHERE o.status = 'EM_ANDAMENTO';

CREATE OR REPLACE VIEW `vw_empreiteiras_acessos` AS 
SELECT e.nome_fantasia, e.cnpj, u.email FROM empreiteiras e JOIN usuarios u ON e.usuario_id = u.id;

CREATE OR REPLACE VIEW `vw_oportunidades_detalhadas` AS 
SELECT o.titulo, o.valor_estimado, o.status, e.nome_fantasia FROM oportunidades_servico o JOIN empreiteiras e ON o.empreiteira_id = e.id;

CREATE OR REPLACE VIEW `vw_prestadores_acessos` AS 
SELECT p.nome_completo, u.email, u.data_cadastro FROM prestadores p JOIN usuarios u ON p.usuario_id = u.id;

CREATE OR REPLACE VIEW `vw_prestadores_categorias` AS 
SELECT p.nome_completo, p.cpf, c.nome AS categoria FROM prestadores p JOIN categorias_servico c ON p.categoria_id = c.id;

CREATE OR REPLACE VIEW `vw_servicos_completos` AS 
SELECT o.titulo, e.nome_fantasia, u.email AS email_contato, o.status, o.valor_estimado 
FROM oportunidades_servico o JOIN empreiteiras e ON o.empreiteira_id = e.id JOIN usuarios u ON e.usuario_id = u.id;

SELECT status, COUNT(*) as total_projetos, SUM(valor_estimado) as valor_total FROM vw_oportunidades_detalhadas GROUP BY status;

SELECT AVG(valor_estimado) as media_valor, MIN(valor_estimado) as menor_valor, MAX(valor_estimado) as maior_valor 
FROM vw_oportunidades_detalhadas WHERE valor_estimado BETWEEN 1000 AND 20000;

SELECT * FROM vw_prestadores_categorias WHERE categoria IN ('Elétrica', 'Hidráulica', 'Pintura') ORDER BY nome_completo DESC;

SELECT nome_fantasia, COUNT(titulo) as qtd_oportunidades FROM vw_oportunidades_detalhadas GROUP BY nome_fantasia HAVING qtd_oportunidades > 0;

SELECT COUNT(*) as volume_negocios, SUM(valor_estimado) as montante_financeiro FROM vw_servicos_completos WHERE status = 'ABERTA';

SELECT nome_completo FROM prestadores WHERE categoria_id = (SELECT id FROM categorias_servico WHERE nome = 'Alvenaria');

SELECT nome_fantasia, (SELECT SUM(valor_estimado) FROM oportunidades_servico WHERE empreiteira_id = e.id) as valor_total_obras FROM empreiteiras e;

SELECT titulo, valor_estimado FROM oportunidades_servico WHERE empreiteira_id IN (SELECT id FROM empreiteiras WHERE nome_fantasia LIKE '%Construtora%');

SELECT sub.status, AVG(sub.valor_estimado) FROM (SELECT status, valor_estimado FROM oportunidades_servico WHERE valor_estimado > 2000) AS sub GROUP BY sub.status;

SELECT titulo, valor_estimado FROM oportunidades_servico WHERE valor_estimado = (SELECT MAX(valor_estimado) FROM oportunidades_servico);

CREATE INDEX idx_status_oportunidade ON oportunidades_servico(status);
CREATE INDEX idx_valor_estimado ON oportunidades_servico(valor_estimado);
CREATE INDEX idx_nome_fantasia ON empreiteiras(nome_fantasia);
CREATE INDEX idx_nome_completo ON prestadores(nome_completo);
CREATE INDEX idx_email_usuarios ON usuarios(email);

DELIMITER //

CREATE PROCEDURE sp_inserir_categoria(IN p_nome VARCHAR(100), IN p_desc TEXT)
BEGIN
    INSERT INTO categorias_servico (nome, descricao) VALUES (p_nome, p_desc);
END //

CREATE PROCEDURE sp_atualizar_status_oportunidade(IN p_id INT, IN p_status VARCHAR(20))
BEGIN
    UPDATE oportunidades_servico SET status = p_status WHERE id = p_id;
END //

CREATE PROCEDURE sp_deletar_usuario(IN p_id INT)
BEGIN
    DELETE FROM usuarios WHERE id = p_id;
END //

CREATE PROCEDURE sp_aumentar_valores(IN p_percentual DECIMAL(5,2))
BEGIN
    UPDATE oportunidades_servico SET valor_estimado = valor_estimado + (valor_estimado * (p_percentual/100)) WHERE status = 'ABERTA';
END //

CREATE PROCEDURE sp_registrar_log(IN p_tabela VARCHAR(50), IN p_acao VARCHAR(255))
BEGIN
    INSERT INTO logs_auditoria (tabela_afetada, acao) VALUES (p_tabela, p_acao);
END //

CREATE FUNCTION fn_contar_obras_abertas() RETURNS INT DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM oportunidades_servico WHERE status = 'ABERTA';
    RETURN total;
END //

CREATE FUNCTION fn_obter_nome_categoria(p_id INT) RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
    DECLARE v_nome VARCHAR(100);
    SELECT nome INTO v_nome FROM categorias_servico WHERE id = p_id;
    RETURN v_nome;
END //

CREATE FUNCTION fn_calcula_imposto_servico(p_valor DECIMAL(10,2)) RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    RETURN p_valor * 0.05;
END //

CREATE FUNCTION fn_verifica_status_obra(p_id INT) RETURNS VARCHAR(20) DETERMINISTIC
BEGIN
    DECLARE v_status VARCHAR(20);
    SELECT status INTO v_status FROM oportunidades_servico WHERE id = p_id;
    RETURN v_status;
END //

CREATE FUNCTION fn_total_gasto_empreiteira(p_empreiteira_id INT) RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10,2);
    SELECT IFNULL(SUM(valor_estimado), 0) INTO v_total FROM oportunidades_servico WHERE empreiteira_id = p_empreiteira_id;
    RETURN v_total;
END //

CREATE TRIGGER trg_before_insert_categoria
BEFORE INSERT ON categorias_servico FOR EACH ROW
BEGIN
    SET NEW.nome = UPPER(NEW.nome);
END //

CREATE TRIGGER trg_before_update_oportunidade
BEFORE UPDATE ON oportunidades_servico FOR EACH ROW
BEGIN
    IF NEW.valor_estimado < 0 THEN
        SET NEW.valor_estimado = 0;
    END IF;
END //

CREATE TRIGGER trg_before_insert_usuario
BEFORE INSERT ON usuarios FOR EACH ROW
BEGIN
    SET NEW.email = LOWER(NEW.email);
END //

CREATE TRIGGER trg_after_delete_arquivada
AFTER DELETE ON oportunidades_arquivadas FOR EACH ROW
BEGIN
    INSERT INTO logs_auditoria (tabela_afetada, acao) VALUES ('oportunidades_arquivadas', 'Registro apagado fisicamente');
END //

CREATE TRIGGER trg_before_insert_prestador
BEFORE INSERT ON prestadores FOR EACH ROW
BEGIN
    SET NEW.cpf = TRIM(NEW.cpf);
END //

CREATE TRIGGER trg_after_insert_oportunidade
AFTER INSERT ON oportunidades_servico FOR EACH ROW
BEGIN
    CALL sp_registrar_log('oportunidades_servico', CONCAT('Nova oportunidade inserida. ID: ', NEW.id));
END //

CREATE TRIGGER trg_after_update_empreiteira
AFTER UPDATE ON empreiteiras FOR EACH ROW
BEGIN
    CALL sp_registrar_log('empreiteiras', CONCAT('Empreiteira atualizada. CNPJ: ', NEW.cnpj));
END //

CREATE TRIGGER trg_after_delete_oportunidade
AFTER DELETE ON oportunidades_servico FOR EACH ROW
BEGIN
    CALL sp_registrar_log('oportunidades_servico', CONCAT('Oportunidade deletada. Título: ', OLD.titulo));
END //

CREATE TRIGGER trg_before_update_prestador
BEFORE UPDATE ON prestadores FOR EACH ROW
BEGIN
    DECLARE cat_antiga VARCHAR(100);
    SET cat_antiga = fn_obter_nome_categoria(OLD.categoria_id);
    CALL sp_registrar_log('prestadores', CONCAT('Prestador alterado. Categoria antiga era: ', cat_antiga));
END //

CREATE TRIGGER trg_after_insert_categoria
AFTER INSERT ON categorias_servico FOR EACH ROW
BEGIN
    CALL sp_registrar_log('categorias_servico', CONCAT('Categoria Inserida: ', NEW.nome));
END //

DELIMITER ;

START TRANSACTION;
INSERT INTO categorias_servico (nome, descricao) VALUES ('Demolição', 'Serviço de demolição segura.');
UPDATE oportunidades_servico SET valor_estimado = 9000 WHERE id = 1;
COMMIT;

START TRANSACTION;
DELETE FROM usuarios WHERE id = 1;
ROLLBACK;

START TRANSACTION;
UPDATE oportunidades_servico SET status = 'EM_ANDAMENTO' WHERE status = 'ABERTA' AND valor_estimado > 10000;
COMMIT;

START TRANSACTION;
INSERT INTO prestadores (usuario_id, categoria_id, cpf, nome_completo) VALUES (11, 2, '999.888.777-66', 'José Teste');
ROLLBACK;

START TRANSACTION;
CALL sp_atualizar_status_oportunidade(3, 'ABERTA');
COMMIT;

COMMIT;
