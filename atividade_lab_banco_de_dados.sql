

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
-- Banco de dados: `atividade_lab_banco_de_dados`

-- Estrutura para tabela `categorias_servico`


CREATE TABLE `categorias_servico` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `categorias_servico`
--

INSERT INTO `categorias_servico` (`id`, `nome`, `descricao`) VALUES
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

-- --------------------------------------------------------

--
-- Estrutura para tabela `empreiteiras`
--

CREATE TABLE `empreiteiras` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `cnpj` varchar(18) NOT NULL,
  `nome_fantasia` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `empreiteiras`
--

INSERT INTO `empreiteiras` (`id`, `usuario_id`, `cnpj`, `nome_fantasia`) VALUES
(1, 1, '11.111.111/0001-11', 'Construtora A - Matriz'),
(3, 2, '22.222.222/0001-22', 'Engenharia B'),
(4, 3, '33.333.333/0001-33', 'Edifica Projetos e Soluções'),
(5, 4, '44.444.444/0001-44', 'Obra Certa LTDA'),
(6, 5, '55.555.555/0001-55', 'Base Forte Engenharia'),
(7, 2, '22.222.222/0002-33', 'Engenharia B - RJ'),
(8, 3, '33.333.333/0002-44', 'Edifica Projetos - Galpões'),
(9, 4, '44.444.444/0002-55', 'Obra Certa - Residenciais'),
(10, 5, '55.555.555/0002-66', 'Base Forte - Infraestrutura');

-- --------------------------------------------------------

--
-- Estrutura para tabela `oportunidades_servico`
--

CREATE TABLE `oportunidades_servico` (
  `id` int(11) NOT NULL,
  `empreiteira_id` int(11) NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `valor_estimado` decimal(10,2) NOT NULL,
  `status` enum('ABERTA','EM_ANDAMENTO','CONCLUIDA','CANCELADA') DEFAULT 'ABERTA'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `oportunidades_servico`
--

INSERT INTO `oportunidades_servico` (`id`, `empreiteira_id`, `titulo`, `valor_estimado`, `status`) VALUES
(1, 1, 'Construção de muro de arrimo', 5000.00, 'CONCLUIDA'),
(3, 3, 'Revisão hidráulica de condomínio', 3500.00, 'CONCLUIDA'),
(4, 4, 'Pintura externa de prédio 10 andares', 27500.00, 'ABERTA'),
(6, 1, 'Instalação de portões automáticos', 8800.00, 'ABERTA'),
(8, 3, 'Paisagismo praça central', 4500.00, 'CONCLUIDA'),
(10, 5, 'Aplicação de manta asfáltica', 6000.00, 'EM_ANDAMENTO'),
(11, 1, 'Reparo Emergencial Elétrico', 1650.00, 'ABERTA'),
(12, 3, 'Consultoria Hidráulica', 2200.00, 'ABERTA');

-- --------------------------------------------------------

--
-- Estrutura para tabela `prestadores`
--

CREATE TABLE `prestadores` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `categoria_id` int(11) NOT NULL,
  `cpf` varchar(14) NOT NULL,
  `nome_completo` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `prestadores`
--

INSERT INTO `prestadores` (`id`, `usuario_id`, `categoria_id`, `cpf`, `nome_completo`) VALUES
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

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `email` varchar(150) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `tipo` enum('EMPREITEIRA','PRESTADOR') NOT NULL,
  `data_cadastro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `email`, `senha`, `tipo`, `data_cadastro`) VALUES
(1, 'contato@construtora-a.com', 'novaSenhaSegura456', 'EMPREITEIRA', '2026-04-16 23:45:49'),
(2, 'rh@engenhariab.com.br', 'novaSenhaSegura456', 'EMPREITEIRA', '2026-04-16 23:45:49'),
(3, 'projetos@edifica.com', 'hash123', 'EMPREITEIRA', '2026-04-16 23:45:49'),
(4, 'compras@obracerta.com', 'hash123', 'EMPREITEIRA', '2026-04-16 23:45:49'),
(5, 'admin@baseforte.com', 'hash123', 'EMPREITEIRA', '2026-04-16 23:45:49'),
(6, 'joao.silva@email.com', 'hash123', 'PRESTADOR', '2026-04-16 23:45:49'),
(7, 'maria.eletricista@email.com', 'hash123', 'PRESTADOR', '2026-04-16 23:45:49'),
(8, 'carlos.encanador@email.com', 'hash123', 'PRESTADOR', '2026-04-16 23:45:49'),
(9, 'pedro.pintor@email.com', 'hash123', 'PRESTADOR', '2026-04-16 23:45:49'),
(10, 'lucas.gesso@email.com', 'hash123', 'PRESTADOR', '2026-04-16 23:45:49'),
(11, 'suporte@serviconnect.com', 'padrao123', 'PRESTADOR', '2026-04-16 23:45:49');

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vw_empreiteiras_acessos`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `vw_empreiteiras_acessos` (
`nome_fantasia` varchar(150)
,`cnpj` varchar(18)
,`email` varchar(150)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vw_oportunidades_detalhadas`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `vw_oportunidades_detalhadas` (
`titulo` varchar(200)
,`valor_estimado` decimal(10,2)
,`status` enum('ABERTA','EM_ANDAMENTO','CONCLUIDA','CANCELADA')
,`nome_fantasia` varchar(150)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vw_prestadores_acessos`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `vw_prestadores_acessos` (
`nome_completo` varchar(150)
,`email` varchar(150)
,`data_cadastro` datetime
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vw_prestadores_categorias`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `vw_prestadores_categorias` (
`nome_completo` varchar(150)
,`cpf` varchar(14)
,`categoria` varchar(100)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vw_servicos_completos`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `vw_servicos_completos` (
`titulo` varchar(200)
,`nome_fantasia` varchar(150)
,`email_contato` varchar(150)
,`status` enum('ABERTA','EM_ANDAMENTO','CONCLUIDA','CANCELADA')
,`valor_estimado` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Estrutura para view `vw_empreiteiras_acessos`
--
DROP TABLE IF EXISTS `vw_empreiteiras_acessos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_empreiteiras_acessos`  AS SELECT `e`.`nome_fantasia` AS `nome_fantasia`, `e`.`cnpj` AS `cnpj`, `u`.`email` AS `email` FROM (`empreiteiras` `e` join `usuarios` `u` on(`e`.`usuario_id` = `u`.`id`)) ;

-- --------------------------------------------------------

--
-- Estrutura para view `vw_oportunidades_detalhadas`
--
DROP TABLE IF EXISTS `vw_oportunidades_detalhadas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_oportunidades_detalhadas`  AS SELECT `o`.`titulo` AS `titulo`, `o`.`valor_estimado` AS `valor_estimado`, `o`.`status` AS `status`, `e`.`nome_fantasia` AS `nome_fantasia` FROM (`oportunidades_servico` `o` join `empreiteiras` `e` on(`o`.`empreiteira_id` = `e`.`id`)) ;

-- --------------------------------------------------------

--
-- Estrutura para view `vw_prestadores_acessos`
--
DROP TABLE IF EXISTS `vw_prestadores_acessos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_prestadores_acessos`  AS SELECT `p`.`nome_completo` AS `nome_completo`, `u`.`email` AS `email`, `u`.`data_cadastro` AS `data_cadastro` FROM (`prestadores` `p` join `usuarios` `u` on(`p`.`usuario_id` = `u`.`id`)) ;

-- --------------------------------------------------------

--
-- Estrutura para view `vw_prestadores_categorias`
--
DROP TABLE IF EXISTS `vw_prestadores_categorias`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_prestadores_categorias`  AS SELECT `p`.`nome_completo` AS `nome_completo`, `p`.`cpf` AS `cpf`, `c`.`nome` AS `categoria` FROM (`prestadores` `p` join `categorias_servico` `c` on(`p`.`categoria_id` = `c`.`id`)) ;

-- --------------------------------------------------------

--
-- Estrutura para view `vw_servicos_completos`
--
DROP TABLE IF EXISTS `vw_servicos_completos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_servicos_completos`  AS SELECT `o`.`titulo` AS `titulo`, `e`.`nome_fantasia` AS `nome_fantasia`, `u`.`email` AS `email_contato`, `o`.`status` AS `status`, `o`.`valor_estimado` AS `valor_estimado` FROM ((`oportunidades_servico` `o` join `empreiteiras` `e` on(`o`.`empreiteira_id` = `e`.`id`)) join `usuarios` `u` on(`e`.`usuario_id` = `u`.`id`)) ;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `categorias_servico`
--
ALTER TABLE `categorias_servico`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome` (`nome`);

--
-- Índices de tabela `empreiteiras`
--
ALTER TABLE `empreiteiras`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cnpj` (`cnpj`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Índices de tabela `oportunidades_servico`
--
ALTER TABLE `oportunidades_servico`
  ADD PRIMARY KEY (`id`),
  ADD KEY `empreiteira_id` (`empreiteira_id`);

--
-- Índices de tabela `prestadores`
--
ALTER TABLE `prestadores`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cpf` (`cpf`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `categoria_id` (`categoria_id`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `categorias_servico`
--
ALTER TABLE `categorias_servico`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de tabela `empreiteiras`
--
ALTER TABLE `empreiteiras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `oportunidades_servico`
--
ALTER TABLE `oportunidades_servico`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `prestadores`
--
ALTER TABLE `prestadores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `empreiteiras`
--
ALTER TABLE `empreiteiras`
  ADD CONSTRAINT `empreiteiras_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `oportunidades_servico`
--
ALTER TABLE `oportunidades_servico`
  ADD CONSTRAINT `oportunidades_servico_ibfk_1` FOREIGN KEY (`empreiteira_id`) REFERENCES `empreiteiras` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `prestadores`
--
ALTER TABLE `prestadores`
  ADD CONSTRAINT `prestadores_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `prestadores_ibfk_2` FOREIGN KEY (`categoria_id`) REFERENCES `categorias_servico` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
