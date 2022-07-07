DROP TABLE IF EXISTS `summerz_accounts`;
CREATE TABLE IF NOT EXISTS `summerz_accounts` (
	`id` bigint(20) NOT NULL AUTO_INCREMENT,
	`whitelist` tinyint(1) NOT NULL DEFAULT 0,
	`chars` int(10) NOT NULL DEFAULT 1,
	`gems` int(20) NOT NULL DEFAULT 0,
	`rolepass` int(20) NOT NULL DEFAULT 0,
	`premium` int(20) NOT NULL DEFAULT 0,
	`login` int(20) NOT NULL DEFAULT 0,
	`discord` varchar(50) NOT NULL DEFAULT '0',
	`license` varchar(50) NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`) USING BTREE,
	UNIQUE KEY `license` (`license`),
	KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `summerz_bank`;
CREATE TABLE IF NOT EXISTS `summerz_bank` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`Passport` int(20) NOT NULL DEFAULT 0,
	`dvalue` int(20) NOT NULL DEFAULT 0,
	`mode` varchar(50) DEFAULT 'Private',
	`owner` tinyint(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`),
	KEY `Passport` (`Passport`),
	KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `summerz_banneds`;
CREATE TABLE IF NOT EXISTS `summerz_banneds` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`license` varchar(50) NOT NULL,
	`time` int(20) NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`),
	KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `summerz_business`;
CREATE TABLE IF NOT EXISTS `summerz_business` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`business` int(11) NOT NULL DEFAULT 0,
	`Passport` int(11) NOT NULL DEFAULT 0,
	`products` int(11) NOT NULL DEFAULT 0,
	`balance` int(11) NOT NULL DEFAULT 0,
	`owner` int(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`),
	KEY `Passport` (`Passport`),
	KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `summerz_characters`;
CREATE TABLE IF NOT EXISTS `summerz_characters` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`license` varchar(50) DEFAULT NULL,
	`phone` varchar(10) DEFAULT NULL,
	`name` varchar(50) DEFAULT 'Individuo',
	`name2` varchar(50) DEFAULT 'Indigente',
	`sex` varchar(1) NOT NULL DEFAULT 'M',
	`blood` int(1) NOT NULL DEFAULT 1,
	`fines` int(20) NOT NULL DEFAULT 0,
	`prison` int(11) NOT NULL DEFAULT 0,
	`port` int(1) NOT NULL DEFAULT 0,
	`deleted` int(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`),
	KEY `license` (`license`),
	KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `summerz_chests`;
CREATE TABLE IF NOT EXISTS `summerz_chests` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`name` varchar(50) NOT NULL,
	`weight` int(10) NOT NULL DEFAULT 0,
	`perm` varchar(50) NOT NULL,
	`logs` int(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`),
	KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `summerz_entitydata`;
CREATE TABLE IF NOT EXISTS `summerz_entitydata` (
	`dkey` varchar(100) NOT NULL,
	`dvalue` longtext DEFAULT NULL,
	PRIMARY KEY (`dkey`),
	KEY `dkey` (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `summerz_fidentity`;
CREATE TABLE IF NOT EXISTS `summerz_fidentity` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`name` varchar(50) NOT NULL DEFAULT '',
	`name2` varchar(50) NOT NULL DEFAULT '',
	`port` int(1) NOT NULL DEFAULT 1,
	`blood` int(1) NOT NULL DEFAULT 1,
	PRIMARY KEY (`id`),
	KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `summerz_playerdata`;
CREATE TABLE IF NOT EXISTS `summerz_playerdata` (
	`Passport` int(11) NOT NULL,
	`dkey` varchar(100) NOT NULL,
	`dvalue` longtext DEFAULT NULL,
	PRIMARY KEY (`dkey`),
	KEY `Passport` (`Passport`),
	KEY `dkey` (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `summerz_propertys`;
CREATE TABLE IF NOT EXISTS `summerz_propertys` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`Name` varchar(20) NOT NULL DEFAULT 'Homes0001',
	`Interior` varchar(20) NOT NULL DEFAULT 'Middle',
	`Keys` int(3) NOT NULL DEFAULT 3,
	`Tax` int(20) NOT NULL DEFAULT 0,
	`Passport` int(6) NOT NULL DEFAULT 0,
	`Serial` varchar(10) NOT NULL,
	`Vault` int(6) NOT NULL DEFAULT 1,
	`Fridge` int(6) NOT NULL DEFAULT 1,
	`Garage` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`Garage`)),
	PRIMARY KEY (`id`),
	KEY `id` (`id`),
	KEY `Passport` (`Passport`),
	KEY `Name` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `summerz_races`;
CREATE TABLE IF NOT EXISTS `summerz_races` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`Race` int(3) NOT NULL DEFAULT 0,
	`Passport` int(5) NOT NULL DEFAULT 0,
	`Name` varchar(100) NOT NULL DEFAULT 'Individuo Indigente',
	`Vehicle` varchar(50) NOT NULL DEFAULT 'Sultan RS',
	`Points` int(20) NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`),
	KEY `Passport` (`Passport`),
	KEY `Race` (`Race`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `summerz_vehicles`;
CREATE TABLE IF NOT EXISTS `summerz_vehicles` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`Passport` int(11) NOT NULL,
	`vehicle` varchar(100) NOT NULL,
	`tax` int(20) NOT NULL DEFAULT 0,
	`plate` varchar(20) DEFAULT NULL,
	`rental` int(20) NOT NULL DEFAULT 0,
	`arrest` int(20) NOT NULL DEFAULT 0,
	`engine` int(4) NOT NULL DEFAULT 1000,
	`body` int(4) NOT NULL DEFAULT 1000,
	`fuel` int(3) NOT NULL DEFAULT 100,
	`nitro` int(5) NOT NULL DEFAULT 0,
	`work` varchar(5) NOT NULL DEFAULT 'false',
	`doors` varchar(254) NOT NULL,
	`windows` varchar(254) NOT NULL,
	`tyres` varchar(254) NOT NULL,
	PRIMARY KEY (`id`),
	KEY `Passport` (`Passport`),
	KEY `vehicle` (`vehicle`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `summerz_warehouse`;
CREATE TABLE IF NOT EXISTS `summerz_warehouse` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`name` varchar(50) NOT NULL,
	`weight` int(10) NOT NULL DEFAULT 200,
	`password` varchar(50) NOT NULL,
	`Passport` int(10) NOT NULL DEFAULT 0,
	`tax` int(20) NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`),
	KEY `Passport` (`Passport`),
	KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `summerz_entitydata` (`dkey`, `dvalue`) VALUES ('Permissions', '{\"Admin\":{\"1\":true}}');