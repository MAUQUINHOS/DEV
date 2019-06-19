-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema nfc
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema nfc
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `nfc` DEFAULT CHARACTER SET utf8 ;
USE `nfc` ;

-- -----------------------------------------------------
-- Table `nfc`.`profile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nfc`.`profile` (
  `ra_user` INT(20) NOT NULL,
  `status_profile` VARCHAR(45) NULL,
  `img_profile` VARCHAR(100) NULL,
  `curso_profile` VARCHAR(100) NULL,
  PRIMARY KEY (`ra_user`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nfc`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nfc`.`users` (
  `id_users` INT(10) NOT NULL AUTO_INCREMENT,
  `cpf_users` INT(12) NOT NULL,
  `profile_ra_user` INT(20) NOT NULL,
  `nome_users` VARCHAR(45) NOT NULL,
  `lastname_users` VARCHAR(100) NOT NULL,
  `add_users` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_users`, `cpf_users`, `profile_ra_user`),
  UNIQUE INDEX `cpf_users_UNIQUE` (`cpf_users` ASC),
  INDEX `fk_users_profile1_idx` (`profile_ra_user` ASC),
  CONSTRAINT `fk_users_profile1`
    FOREIGN KEY (`profile_ra_user`)
    REFERENCES `nfc`.`profile` (`ra_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `nfc`.`cards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nfc`.`cards` (
  `id_cards` INT(10) NOT NULL,
  `users_id_users` INT(10) NOT NULL,
  `users_cpf_users` VARCHAR(20) NOT NULL,
  `nfc_users` INT(15) NOT NULL,
  `passwd_users` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_cards`, `users_id_users`, `users_cpf_users`),
  INDEX `fk_cards_users1_idx` (`users_id_users` ASC, `users_cpf_users` ASC),
  UNIQUE INDEX `nfc_users_UNIQUE` (`nfc_users` ASC),
  CONSTRAINT `fk_cards_users1`
    FOREIGN KEY (`users_id_users` , `users_cpf_users`)
    REFERENCES `nfc`.`users` (`id_users` , `cpf_users`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nfc`.`logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nfc`.`logs` (
  `users_id_users` INT(10) NOT NULL,
  `users_cpf_users` INT(11) NOT NULL,
  `users_logs` VARCHAR(45) NULL,
  `funcao_logs` VARCHAR(45) NULL,
  PRIMARY KEY (`users_id_users`, `users_cpf_users`),
  CONSTRAINT `fk_logs_users1`
    FOREIGN KEY (`users_id_users` , `users_cpf_users`)
    REFERENCES `nfc`.`users` (`id_users` , `cpf_users`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
