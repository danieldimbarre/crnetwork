DROP TABLE IF EXISTS `accounts`;
CREATE TABLE IF NOT EXISTS `accounts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `whitelist` tinyint(1) NOT NULL DEFAULT 0,
  `chars` int(10) NOT NULL DEFAULT 1,
  `gems` int(20) NOT NULL DEFAULT 0,
  `rolepass` int(20) NOT NULL DEFAULT 0,
  `premium` int(20) NOT NULL DEFAULT 0,
  `login` varchar(25) NOT NULL DEFAULT '00/00/0000',
  `discord` varchar(50) NOT NULL DEFAULT '0',
  `license` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `license` (`license`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `banneds`;
CREATE TABLE IF NOT EXISTS `banneds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `license` varchar(50) NOT NULL,
  `time` int(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `characters`;
CREATE TABLE IF NOT EXISTS `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `license` varchar(50) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `name` varchar(50) DEFAULT 'Individuo',
  `name2` varchar(50) DEFAULT 'Indigente',
  `sex` varchar(1) NOT NULL DEFAULT 'M',
  `bank` int(20) NOT NULL DEFAULT 3000,
  `blood` int(1) NOT NULL DEFAULT 1,
  `fines` int(20) NOT NULL DEFAULT 0,
  `prison` int(11) NOT NULL DEFAULT 0,
  `fugitive` int(1) NOT NULL DEFAULT 0,
  `tracking` int(30) NOT NULL DEFAULT 0,
  `spending` int(20) NOT NULL DEFAULT 0,
  `cardlimit` int(20) NOT NULL DEFAULT 10000,
  `deleted` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `license` (`license`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `chests`;
CREATE TABLE IF NOT EXISTS `chests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `weight` int(10) NOT NULL DEFAULT 0,
  `perm` varchar(50) NOT NULL,
  `logs` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

INSERT INTO `chests` (`id`, `name`, `weight`, `perm`, `logs`) VALUES
(1, 'Police', 50000, 'Police', 1),
(2, 'Police-2', 50000, 'Police', 1),
(3, 'Police-3', 50000, 'Police', 1),
(4, 'Police-4', 50000, 'Police', 1),
(5, 'Police-5', 50000, 'Police', 1),
(6, 'Police-6', 50000, 'Police', 1),
(7, 'Paramedic', 10000, 'Paramedic', 1),
(8, 'Paramedic-2', 10000, 'Paramedic', 1),
(9, 'Paramedic-3', 10000, 'Paramedic', 1),
(10, 'BurgerShot', 500, 'BurgerShot', 1),
(11, 'PizzaThis', 500, 'PizzaThis', 1),
(12, 'UwuCoffee', 500, 'UwuCoffee', 1),
(13, 'BeanMachine', 500, 'BeanMachine', 1),
(14, 'Ballas', 500, 'Ballas', 1),
(15, 'Ballas-2', 250, 'Ballas-2', 1),
(16, 'Families', 500, 'Families', 1),
(17, 'Families-2', 250, 'Families-2', 1),
(18, 'Vagos', 500, 'Vagos', 1),
(19, 'Vagos-2', 250, 'Vagos-2', 1),
(20, 'Aztecas', 500, 'Aztecas', 1),
(21, 'Aztecas-2', 250, 'Aztecas-2', 1),
(22, 'Bloods', 500, 'Bloods', 1),
(23, 'Bloods-2', 250, 'Bloods-2', 1),
(24, 'Triads', 500, 'Triads', 1),
(25, 'Triads-2', 250, 'Triads-2', 1),
(26, 'Razors', 500, 'Razors', 1),
(27, 'Razors-2', 250, 'Razors-2', 1),
(28, 'Mechanic', 500, 'Mechanic', 1),
(29, 'Mechanic-2', 250, 'Mechanic-2', 1),
(30, 'Tribo', 500, 'Tribo', 1),
(31, 'Tribo-2', 250, 'Tribo-2', 1),
(32, 'Lost', 500, 'Lost', 1),
(33, 'Lost-2', 250, 'Lost-2', 1),
(34, 'Marabunta', 500, 'Marabunta', 1),
(35, 'Marabunta-2', 250, 'Marabunta-2', 1);

DROP TABLE IF EXISTS `entitydata`;
CREATE TABLE IF NOT EXISTS `entitydata` (
  `dkey` varchar(100) NOT NULL,
  `dvalue` longtext DEFAULT NULL,
  PRIMARY KEY (`dkey`),
  KEY `dkey` (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `entitydata` (`dkey`, `dvalue`) VALUES ('Permissions:Admin', '{\"1\":1}');

DROP TABLE IF EXISTS `fidentity`;
CREATE TABLE IF NOT EXISTS `fidentity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `name2` varchar(50) NOT NULL DEFAULT '',
  `port` int(1) NOT NULL DEFAULT 1,
  `blood` int(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `playerdata`;
CREATE TABLE IF NOT EXISTS `playerdata` (
  `Passport` int(11) NOT NULL,
  `dkey` varchar(100) NOT NULL,
  `dvalue` longtext DEFAULT NULL,
  PRIMARY KEY (`Passport`,`dkey`),
  KEY `Passport` (`Passport`),
  KEY `dkey` (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `propertys`;
CREATE TABLE IF NOT EXISTS `propertys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) NOT NULL DEFAULT 'Homes0001',
  `Interior` varchar(20) NOT NULL DEFAULT 'Middle',
  `Keys` int(3) NOT NULL DEFAULT 3,
  `Tax` int(20) NOT NULL DEFAULT 0,
  `Passport` int(6) NOT NULL DEFAULT 0,
  `Serial` varchar(10) NOT NULL,
  `Vault` int(6) NOT NULL DEFAULT 1,
  `Fridge` int(6) NOT NULL DEFAULT 1,
  `Garage` longtext NOT NULL DEFAULT '{}',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `Passport` (`Passport`),
  KEY `Name` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `races`;
CREATE TABLE IF NOT EXISTS `races` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Race` int(3) NOT NULL DEFAULT 0,
  `Passport` int(5) NOT NULL DEFAULT 0,
  `Name` varchar(100) NOT NULL DEFAULT 'Individuo Indigente',
  `Vehicle` varchar(50) NOT NULL DEFAULT 'Sultan RS',
  `Points` int(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `Passport` (`Passport`),
  KEY `Race` (`Race`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE IF NOT EXISTS `vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Passport` int(11) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `tax` int(20) NOT NULL DEFAULT 0,
  `plate` varchar(10) DEFAULT NULL,
  `rental` int(20) NOT NULL DEFAULT 0,
  `arrest` int(20) NOT NULL DEFAULT 0,
  `engine` int(4) NOT NULL DEFAULT 1000,
  `body` int(4) NOT NULL DEFAULT 1000,
  `health` int(4) NOT NULL DEFAULT 1000,
  `fuel` int(3) NOT NULL DEFAULT 100,
  `nitro` int(5) NOT NULL DEFAULT 0,
  `work` varchar(5) NOT NULL DEFAULT 'false',
  `doors` longtext NOT NULL,
  `windows` longtext NOT NULL,
  `tyres` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Passport` (`Passport`),
  KEY `vehicle` (`vehicle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `warehouse`;
CREATE TABLE IF NOT EXISTS `warehouse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `weight` int(10) NOT NULL DEFAULT 200,
  `password` varchar(50) NOT NULL,
  `Passport` int(10) NOT NULL DEFAULT 0,
  `tax` int(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `Passport` (`Passport`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;