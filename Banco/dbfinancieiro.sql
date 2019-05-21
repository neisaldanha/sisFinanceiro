-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 30-Jan-2017 às 22:17
-- Versão do servidor: 10.1.19-MariaDB
-- PHP Version: 5.6.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbsistemalaravel`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `categoria`
--

CREATE TABLE `categoria` (
  `idcategoria` int(11) NOT NULL,
  `nome` varchar(256) NOT NULL,
  `descricao` varchar(256) DEFAULT NULL,
  `condicao` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `categoria`
--

INSERT INTO `categoria` (`idcategoria`, `nome`, `descricao`, `condicao`) VALUES
(1, 'Eletrônicos', 'Produtos Eletrônicos', 1),
(2, 'Informática', 'Produtos de Informática', 1),
(3, 'Brinquedos', 'Categoria de Brinquedos', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `detalhe_entrada`
--

CREATE TABLE `detalhe_entrada` (
  `iddetalhe_entrada` int(11) NOT NULL,
  `identrada` int(11) NOT NULL,
  `idproduto` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `preco_compra` decimal(9,2) DEFAULT NULL,
  `preco_venda` decimal(9,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `detalhe_entrada`
--

INSERT INTO `detalhe_entrada` (`iddetalhe_entrada`, `identrada`, `idproduto`, `quantidade`, `preco_compra`, `preco_venda`) VALUES
(1, 1, 1, 15, '50.00', '75.00'),
(2, 7, 1, 44, '44.00', '4.00'),
(3, 8, 3, 10, '15.00', '30.00'),
(4, 8, 5, 10, '16.00', '30.00'),
(5, 9, 1, 5, '10.00', '15.00'),
(6, 10, 1, 4, '44.00', '50.00'),
(7, 10, 4, 2, '33.00', '50.00');

--
-- Acionadores `detalhe_entrada`
--
DELIMITER $$
CREATE TRIGGER `tr_updEstoqueEntrada` AFTER INSERT ON `detalhe_entrada` FOR EACH ROW BEGIN
UPDATE produto SET estoque = estoque + NEW.quantidade
WHERE produto.idproduto = NEW.idproduto;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `detalhe_venda`
--

CREATE TABLE `detalhe_venda` (
  `iddetalhe_venda` int(11) NOT NULL,
  `idvenda` int(11) NOT NULL,
  `idproduto` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `preco_venda` decimal(9,2) DEFAULT NULL,
  `desconto` decimal(9,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `detalhe_venda`
--

INSERT INTO `detalhe_venda` (`iddetalhe_venda`, `idvenda`, `idproduto`, `quantidade`, `preco_venda`, `desconto`) VALUES
(1, 1, 5, 5, '30.00', '0.00'),
(2, 2, 4, 1, '50.00', '0.00'),
(3, 3, 3, 1, '30.00', '0.00'),
(4, 4, 3, 1, '30.00', '0.00'),
(5, 5, 1, 5, '36.00', '0.00'),
(6, 6, 1, 2, '36.00', '0.00'),
(7, 6, 3, 3, '30.00', '0.00');

--
-- Acionadores `detalhe_venda`
--
DELIMITER $$
CREATE TRIGGER `tr_updEstoqueVenda` AFTER INSERT ON `detalhe_venda` FOR EACH ROW BEGIN
UPDATE produto SET estoque = estoque - NEW.quantidade
WHERE produto.idproduto = NEW.idproduto;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `entrada`
--

CREATE TABLE `entrada` (
  `identrada` int(11) NOT NULL,
  `idfornecedor` int(11) NOT NULL,
  `tipo_comprovante` varchar(45) DEFAULT NULL,
  `serie_comprovante` varchar(45) DEFAULT NULL,
  `num_comprovante` varchar(45) DEFAULT NULL,
  `data_hora` datetime NOT NULL,
  `taxa` decimal(4,2) DEFAULT NULL,
  `estado` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `entrada`
--

INSERT INTO `entrada` (`identrada`, `idfornecedor`, `tipo_comprovante`, `serie_comprovante`, `num_comprovante`, `data_hora`, `taxa`, `estado`) VALUES
(1, 1, 'Boleto', '0128', '12034822', '2017-01-26 00:00:00', '0.00', 'A'),
(4, 4, 'RG', '444', '44', '2017-01-27 14:11:54', '0.00', 'A'),
(5, 4, 'RG', '44', '44', '2017-01-26 00:00:00', '0.00', 'A'),
(6, 4, 'RG', '555', '555', '2017-01-27 14:16:54', '0.00', 'A'),
(7, 4, 'RG', '444', '444', '2017-01-27 14:33:16', '0.00', 'C'),
(8, 4, 'CPF', '123', '123', '2017-01-27 14:35:15', '0.00', 'C'),
(9, 4, 'Dinheiro', '100', '000', '2017-01-27 15:00:58', '0.00', 'C'),
(10, 4, 'Dinheiro', '44', '444', '2017-01-27 16:23:10', '0.00', 'A');

-- --------------------------------------------------------

--
-- Estrutura da tabela `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `password_resets`
--

INSERT INTO `password_resets` (`email`, `token`, `created_at`) VALUES
('hugovasconcelosf@hotmail.com', '26e41d32cbad0674b06da6e77c7251cc33ab483d38e8489502e479cd94587ec7', '2017-01-30 18:16:11');

-- --------------------------------------------------------

--
-- Estrutura da tabela `pessoa`
--

CREATE TABLE `pessoa` (
  `idpessoas` int(11) NOT NULL,
  `tipo_pessoa` varchar(20) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `tipo_documento` varchar(20) DEFAULT NULL,
  `num_doc` varchar(30) DEFAULT NULL,
  `endereco` varchar(70) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `pessoa`
--

INSERT INTO `pessoa` (`idpessoas`, `tipo_pessoa`, `nome`, `tipo_documento`, `num_doc`, `endereco`, `telefone`, `email`) VALUES
(1, 'Cliente', 'Hugo', 'CPF', '090.281.356-00', 'Rua X', '(31)97527-5084', 'hugovasconcelosf@hotmail.com'),
(2, 'Cliente', 'Fábio', 'RG', '555555', 'Rua A', '333333333', 'fabio@hotmail.com'),
(3, 'Cliente', 'Pedro', 'CPF', '1555144', 'Rua teste4', '333334444', '3333333344'),
(4, 'Fornecedor', 'Marcos', 'RG', '4545656', 'aaaaaa', '222', 'aa'),
(5, 'Fornecedor', 'Pedro', 'CPF', '054445', 'Rua A', '333', '3333333'),
(6, 'Inativo', 'Teste', 'CPF', '33333', '333', '00033', '0033');

-- --------------------------------------------------------

--
-- Estrutura da tabela `produto`
--

CREATE TABLE `produto` (
  `idproduto` int(11) NOT NULL,
  `idcategoria` int(11) NOT NULL,
  `codigo` varchar(50) DEFAULT NULL,
  `nome` varchar(100) NOT NULL,
  `estoque` int(11) NOT NULL,
  `descricao` varchar(512) DEFAULT NULL,
  `imagem` varchar(50) DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `produto`
--

INSERT INTO `produto` (`idproduto`, `idcategoria`, `codigo`, `nome`, `estoque`, `descricao`, `imagem`, `estado`) VALUES
(1, 2, '01853', 'Computador', 12, 'PC 3 GB de Ram...', 'pc.jpg', 'Ativo'),
(3, 1, '45545', 'Tablet', 5, 'Table x Polegadas', 'tablet.png', 'Ativo'),
(4, 1, '42278', 'Galaxy J3', 11, 'Brinquedo do Toy', 'celular.jpg', 'Ativo'),
(5, 3, '04622', 'Udi Toy Store', 20, 'Brinquedo do Toy Store', 'brinquedo.jpg', 'Ativo');

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Hugo', 'hugovasconcelosf@hotmail.com', '$2y$10$.mzP5xhqtLfqbW3Vd5oTIuKVE8hVsYgvktpGis2Ijt8bYABCJU89C', 'N7Dt5aVePm63H6JP6S2fTMl96hhYV3FxbzpvD66yZYW4Nro3mrmd23rWiSU8', '2017-01-30 17:30:07', '2017-01-30 19:30:16'),
(3, 'Paula Matos', 'paulam@hotmail.com', '$2y$10$heathM5B/tFTGt5I1GSpNOnFUBesjzq3iR3AyQEO8WKFJEeKEdmmm', NULL, '2017-01-30 19:19:44', '2017-01-30 19:30:09');

-- --------------------------------------------------------

--
-- Estrutura da tabela `venda`
--

CREATE TABLE `venda` (
  `idvenda` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `tipo_comprovante` varchar(45) DEFAULT NULL,
  `serie_comprovante` varchar(45) DEFAULT NULL,
  `num_comprovante` varchar(45) DEFAULT NULL,
  `data_hora` datetime NOT NULL,
  `taxa` decimal(4,2) DEFAULT NULL,
  `total_venda` decimal(9,2) DEFAULT NULL,
  `estado` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `venda`
--

INSERT INTO `venda` (`idvenda`, `idcliente`, `tipo_comprovante`, `serie_comprovante`, `num_comprovante`, `data_hora`, `taxa`, `total_venda`, `estado`) VALUES
(1, 2, 'Boleto', '444', '444', '2017-01-27 00:00:00', '0.00', '50.00', 'A'),
(2, 1, 'Dinheiro', '55', '55', '2017-01-30 14:07:34', '0.00', NULL, 'C'),
(3, 1, 'Dinheiro', '77', '777', '2017-01-30 14:15:12', '0.00', '30.00', 'A'),
(4, 1, 'Dinheiro', '111', '111', '2017-01-30 14:15:35', '0.00', '30.00', 'A'),
(5, 1, 'Dinheiro', '55', '55555', '2017-01-30 14:17:04', '0.00', '180.00', 'A'),
(6, 1, 'Dinheiro', '00', '0012', '2017-01-30 15:00:28', '0.00', '162.00', 'A');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idcategoria`);

--
-- Indexes for table `detalhe_entrada`
--
ALTER TABLE `detalhe_entrada`
  ADD PRIMARY KEY (`iddetalhe_entrada`),
  ADD KEY `fk_detalhe_entrada_idx` (`identrada`),
  ADD KEY `fk_detalhe_produto_idx` (`idproduto`);

--
-- Indexes for table `detalhe_venda`
--
ALTER TABLE `detalhe_venda`
  ADD PRIMARY KEY (`iddetalhe_venda`),
  ADD KEY `fk_detalhe_venda_idx` (`idvenda`),
  ADD KEY `fk_detalhe_produto_idx` (`idproduto`);

--
-- Indexes for table `entrada`
--
ALTER TABLE `entrada`
  ADD PRIMARY KEY (`identrada`),
  ADD KEY `fk_entrada_pessoa_idx` (`idfornecedor`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`),
  ADD KEY `password_resets_token_index` (`token`);

--
-- Indexes for table `pessoa`
--
ALTER TABLE `pessoa`
  ADD PRIMARY KEY (`idpessoas`);

--
-- Indexes for table `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`idproduto`),
  ADD KEY `fk_produto_categoria_idx` (`idcategoria`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `venda`
--
ALTER TABLE `venda`
  ADD PRIMARY KEY (`idvenda`),
  ADD KEY `fk_venda_cliente_idx` (`idcliente`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idcategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `detalhe_entrada`
--
ALTER TABLE `detalhe_entrada`
  MODIFY `iddetalhe_entrada` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `detalhe_venda`
--
ALTER TABLE `detalhe_venda`
  MODIFY `iddetalhe_venda` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `entrada`
--
ALTER TABLE `entrada`
  MODIFY `identrada` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `pessoa`
--
ALTER TABLE `pessoa`
  MODIFY `idpessoas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `produto`
--
ALTER TABLE `produto`
  MODIFY `idproduto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `venda`
--
ALTER TABLE `venda`
  MODIFY `idvenda` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `detalhe_entrada`
--
ALTER TABLE `detalhe_entrada`
  ADD CONSTRAINT `fk_detalhe_entrada` FOREIGN KEY (`identrada`) REFERENCES `entrada` (`identrada`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_detalhe_produto` FOREIGN KEY (`idproduto`) REFERENCES `produto` (`idproduto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `detalhe_venda`
--
ALTER TABLE `detalhe_venda`
  ADD CONSTRAINT `fk_detalhevenda_produto` FOREIGN KEY (`idproduto`) REFERENCES `produto` (`idproduto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_detalhevenda_venda` FOREIGN KEY (`idvenda`) REFERENCES `venda` (`idvenda`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `entrada`
--
ALTER TABLE `entrada`
  ADD CONSTRAINT `fk_entrada_pessoa` FOREIGN KEY (`idfornecedor`) REFERENCES `pessoa` (`idpessoas`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `produto`
--
ALTER TABLE `produto`
  ADD CONSTRAINT `fk_produto_categoria` FOREIGN KEY (`idcategoria`) REFERENCES `categoria` (`idcategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `venda`
--
ALTER TABLE `venda`
  ADD CONSTRAINT `fk_venda_cliente` FOREIGN KEY (`idcliente`) REFERENCES `pessoa` (`idpessoas`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
