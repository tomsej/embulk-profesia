SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+02:00";

CREATE DATABASE IF NOT EXISTS `profesia`;

USE `profesia`;

CREATE TABLE IF NOT EXISTS `jmena` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=2;

INSERT INTO `jmena` (`id`, `name`) VALUES
(1, 'Honza');
INSERT INTO `jmena` (`id`, `name`) VALUES
(2, 'Jirka');