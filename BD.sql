-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           8.0.31 - MySQL Community Server - GPL
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para teste
CREATE DATABASE IF NOT EXISTS `teste` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `teste`;

-- Copiando estrutura para tabela teste.cliente
CREATE TABLE IF NOT EXISTS `cliente` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(60) NOT NULL,
  `cidade` varchar(45) NOT NULL,
  `uf` char(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `idx_CLIENTE_id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela teste.cliente: ~0 rows (aproximadamente)
INSERT INTO `cliente` (`id`, `nome`, `cidade`, `uf`) VALUES
	(1, 'MARIA', 'JOAO PESSOA', 'PB'),
	(2, 'JOAO', 'MANAIRA', 'PB'),
	(3, 'MARCOS', 'SANTO ALEXO', 'PB'),
	(4, 'PRISCILA', 'RECIFE', 'PE'),
	(5, 'EMANUELLA', 'CARUARU', 'PE'),
	(6, 'GIOVANA', 'FORTALEZA', 'CE'),
	(7, 'PEDRO', 'ARACATI', 'CE'),
	(8, 'GRAÇA', 'PATOS', 'MG'),
	(9, 'EDUARDA', 'UNAI', 'MG'),
	(10, 'AMANDA', 'BRASILIA', 'DF'),
	(11, 'JULIANA', 'BRASILIA', 'DF'),
	(12, 'MARGARIDA', 'BRASILIA', 'DF'),
	(13, 'JUVENAL', 'BRASILIA', 'DF'),
	(14, 'JULIA', 'BRASILIA', 'DF'),
	(15, 'LEONARDO', 'GOIANIA', 'GO'),
	(16, 'WILSON', 'CERES', 'GO'),
	(17, 'PAULO', 'GOIANESIA', 'GO'),
	(18, 'NAYARA', 'GUARULHOS', 'SP'),
	(19, 'ANA JULIA', 'CAMPINAS', 'SP'),
	(20, 'ANA ALICE', 'SANTOS', 'SP');

-- Copiando estrutura para tabela teste.produto
CREATE TABLE IF NOT EXISTS `produto` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `valor` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `idx_PRODUTO_id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela teste.produto: ~0 rows (aproximadamente)
INSERT INTO `produto` (`id`, `descricao`, `valor`) VALUES
	(1, 'ARROZ TIPO 1', 27.99),
	(2, 'FEIJAO DA MAM', 5.5),
	(3, 'MACARRAO', 2.33),
	(4, 'ABOBORA', 0.99),
	(5, 'BETERRABA', 1.99),
	(6, 'GOIABA', 6.98),
	(7, 'TOMATE', 7),
	(8, 'SABAO EM PO', 5.3),
	(9, 'SABAO BARRA', 8.85),
	(10, 'DETERGENTE', 2.99),
	(11, 'CARNE MOIDA', 35.4),
	(12, 'ACEM', 34.25),
	(13, 'RAÇAO CACHORRO', 12.55),
	(14, 'REFRIGERANTE B', 8.99),
	(15, 'SUCO DE UVA', 4.99),
	(16, 'SUCO DE PESSEGO', 3.69),
	(17, 'BALDE LENOVO', 7.89),
	(18, 'FONTE ALIMENTACAO 12V', 99.89),
	(19, 'PANELA PRESSAO', 33),
	(20, 'OVOS TIPO 1', 12);

-- Copiando estrutura para tabela teste.venda
CREATE TABLE IF NOT EXISTS `venda` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dtemissao` date NOT NULL,
  `idcliente` int NOT NULL,
  `vlrtotal` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela teste.venda: ~0 rows (aproximadamente)
INSERT INTO `venda` (`id`, `dtemissao`, `idcliente`, `vlrtotal`) VALUES
	(1, '2022-11-03', 1, 89.99);

-- Copiando estrutura para tabela teste.vendaitem
CREATE TABLE IF NOT EXISTS `vendaitem` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idpedido` int NOT NULL,
  `idproduto` int NOT NULL,
  `qtde` float NOT NULL,
  `vlrunitario` float NOT NULL,
  `vlrtotal` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela teste.vendaitem: ~0 rows (aproximadamente)
INSERT INTO `vendaitem` (`id`, `idpedido`, `idproduto`, `qtde`, `vlrunitario`, `vlrtotal`) VALUES
	(1, 1, 2, 1, 5.5, 5.5),
	(2, 1, 1, 1, 27.99, 27.99),
	(3, 1, 3, 2, 3, 6),
	(4, 1, 2, 1, 5.5, 5.5),
	(5, 1, 20, 1, 12, 12),
	(6, 1, 19, 1, 33, 33);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
