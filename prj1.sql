-- prj1.sql
-- Dylan Neese
-- CS415 Final Project - Greenwood Road Runners
-- Creates database and tables using IF NOT EXISTS

CREATE DATABASE IF NOT EXISTS neese;
USE neese;

-- -----------------------------------------------------
-- Table `Members`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Members` (
  `member_id`   INT NOT NULL AUTO_INCREMENT,
  `first_name`  VARCHAR(50) NOT NULL,
  `last_name`   VARCHAR(50) NOT NULL,
  `gender`      ENUM('M','F','X') NOT NULL,
  `birth_date`  DATE NOT NULL,
  `join_date`   DATE NOT NULL,
  `email`       VARCHAR(100) DEFAULT NULL,
  PRIMARY KEY (`member_id`),
  KEY `idx_member_name` (`last_name`,`first_name`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1;

-- -----------------------------------------------------
-- Table `Races`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Races` (
  `race_id`     INT NOT NULL AUTO_INCREMENT,
  `race_name`   VARCHAR(100) NOT NULL,
  `race_date`   DATE NOT NULL,
  `location`    VARCHAR(80) NOT NULL,
  `distance_km` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`race_id`),
  KEY `idx_race_date` (`race_date`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

-- -----------------------------------------------------
-- Table `RaceResults`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RaceResults` (
  `result_id`       INT NOT NULL AUTO_INCREMENT,
  `member_id`       INT NOT NULL,
  `race_id`         INT NOT NULL,
  `finish_time`     TIME NOT NULL,
  `overall_place`   INT DEFAULT NULL,
  `age_group_place` INT DEFAULT NULL,
  PRIMARY KEY (`result_id`),
  KEY `member_id` (`member_id`),
  KEY `race_id` (`race_id`),
  CONSTRAINT `fk_result_member` FOREIGN KEY (`member_id`) REFERENCES `Members`(`member_id`),
  CONSTRAINT `fk_result_race`   FOREIGN KEY (`race_id`)   REFERENCES `Races`(`race_id`)
) ENGINE=InnoDB AUTO_INCREMENT=345 DEFAULT CHARSET=latin1;