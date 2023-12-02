-- MySQL Script generated by MySQL Workbench
-- Fri Dec  1 17:48:40 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema techpassdb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema techpassdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `techpassdb` DEFAULT CHARACTER SET utf8mb4 ;
USE `techpassdb` ;

-- -----------------------------------------------------
-- Table `techpassdb`.`loja_recarga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `techpassdb`.`loja_recarga` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL DEFAULT 'Tech Pass',
  `cep` VARCHAR(9) NULL DEFAULT NULL,
  `endereco` VARCHAR(255) NULL,
  `lat` DECIMAL(9,6) NULL,
  `lng` DECIMAL(9,6) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `techpassdb`.`superUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `techpassdb`.`superUser` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(64) NOT NULL,
  `senha` VARCHAR(100) NULL,
  `nome` VARCHAR(100) NOT NULL,
  `nascimento` DATE NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `techpassdb`.`atendente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `techpassdb`.`atendente` (
  `superUser_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `local_de_trabalho_id` INT(11) NOT NULL,
  `turno` VARCHAR(45) NULL,
  `telefone` VARCHAR(13) NULL,
  `endereco` VARCHAR(255) NULL,
  `foto` VARCHAR(200) NULL,
  INDEX `fk_atendente_loja_recarga1_idx` (`local_de_trabalho_id` ASC) ,
  INDEX `fk_atendente_superUser1_idx` (`superUser_id` ASC) ,
  UNIQUE INDEX `superUser_id_UNIQUE` (`superUser_id` ASC) ,
  PRIMARY KEY (`superUser_id`),
  CONSTRAINT `fk_atendente_loja_recarga1`
    FOREIGN KEY (`local_de_trabalho_id`)
    REFERENCES `techpassdb`.`loja_recarga` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_atendente_superUser1`
    FOREIGN KEY (`superUser_id`)
    REFERENCES `techpassdb`.`superUser` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `techpassdb`.`tipos_de_cartao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `techpassdb`.`tipos_de_cartao` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `modalidade` VARCHAR(45) NOT NULL,
  `tarifa` DECIMAL(6,2) NULL,
  `tipos_de_cartaocol` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `techpassdb`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `techpassdb`.`clientes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(64) NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `username` VARCHAR(90) NULL DEFAULT NULL,
  `senha` VARCHAR(200) NULL DEFAULT NULL,
  `nome` VARCHAR(120) NULL DEFAULT NULL,
  `nascimento` DATE NULL DEFAULT NULL,
  `saldo` DECIMAL(6,2) NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) ,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `techpassdb`.`cartoes_do_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `techpassdb`.`cartoes_do_cliente` (
  `codigo_do_cartao` INT(11) NOT NULL,
  `clientes_id` INT(11) NOT NULL,
  `cartao_id` INT(11) NOT NULL,
  PRIMARY KEY (`codigo_do_cartao`),
  INDEX `fk_clientes_has_cartao_passe_clientes` (`clientes_id` ASC) ,
  INDEX `fk_clliente_tem_cartao_cartao1_idx` (`cartao_id` ASC) ,
  CONSTRAINT `fk_clientes_has_cartao_passe_clientes`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `techpassdb`.`clientes` (`id`),
  CONSTRAINT `fk_clliente_tem_cartao_cartao1`
    FOREIGN KEY (`cartao_id`)
    REFERENCES `techpassdb`.`tipos_de_cartao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `techpassdb`.`ADM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `techpassdb`.`ADM` (
  `superUser_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `telefone` VARCHAR(13) NULL,
  `cargo` VARCHAR(45) NULL,
  INDEX `fk_ADM_superUser1_idx` (`superUser_id` ASC) ,
  PRIMARY KEY (`superUser_id`),
  CONSTRAINT `fk_ADM_superUser1`
    FOREIGN KEY (`superUser_id`)
    REFERENCES `techpassdb`.`superUser` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `techpassdb`.`linhas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `techpassdb`.`linhas` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `numero_linha` INT NOT NULL,
  `bairroOrigem` VARCHAR(45) NOT NULL,
  `bairroDestino` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `techpassdb`.`motorista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `techpassdb`.`motorista` (
  `superUser_id` INT UNSIGNED NOT NULL,
  `foto` VARCHAR(200) NULL DEFAULT NULL,
  `cnh` VARCHAR(11) NULL,
  PRIMARY KEY (`superUser_id`),
  CONSTRAINT `fk_motorista_superUser1`
    FOREIGN KEY (`superUser_id`)
    REFERENCES `techpassdb`.`superUser` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `techpassdb`.`onibus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `techpassdb`.`onibus` (
  `id` INT(11) NOT NULL,
  `placa` VARCHAR(15) NOT NULL,
  `quantidade_passageiros` INT NULL,
  `estado_atual` VARCHAR(1) NULL,
  `possui_acessibilidade` VARCHAR(1) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `techpassdb`.`ponto_de_onibus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `techpassdb`.`ponto_de_onibus` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `endereco` VARCHAR(255) NULL,
  `cep` VARCHAR(9) NULL,
  `lat` DECIMAL(9,6) NULL,
  `lng` DECIMAL(9,6) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `techpassdb`.`percurso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `techpassdb`.`percurso` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ordem_do_percurso` INT NULL,
  `linha_id` INT UNSIGNED NOT NULL,
  `pontoOnibus_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_trajeto_paradas_linha1_idx` (`linha_id` ASC) ,
  INDEX `fk_rotas_pontoOnibus1_idx` (`pontoOnibus_id` ASC) ,
  CONSTRAINT `fk_trajeto_paradas_linha1`
    FOREIGN KEY (`linha_id`)
    REFERENCES `techpassdb`.`linhas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rotas_pontoOnibus1`
    FOREIGN KEY (`pontoOnibus_id`)
    REFERENCES `techpassdb`.`ponto_de_onibus` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `techpassdb`.`viagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `techpassdb`.`viagem` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `inicio` DATETIME NULL,
  `duracao` INT NULL DEFAULT NULL,
  `linhas_id` INT UNSIGNED NOT NULL,
  `onibus_id` INT(11) NOT NULL,
  `motorista_SU_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_viagem_linhas1_idx` (`linhas_id` ASC) ,
  INDEX `fk_viagem_onibus1_idx` (`onibus_id` ASC) ,
  INDEX `fk_viagem_motorista1_idx` (`motorista_SU_id` ASC) ,
  CONSTRAINT `fk_viagem_linhas1`
    FOREIGN KEY (`linhas_id`)
    REFERENCES `techpassdb`.`linhas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_viagem_onibus1`
    FOREIGN KEY (`onibus_id`)
    REFERENCES `techpassdb`.`onibus` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_viagem_motorista1`
    FOREIGN KEY (`motorista_SU_id`)
    REFERENCES `techpassdb`.`motorista` (`superUser_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `techpassdb`.`embarque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `techpassdb`.`embarque` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `viagem_id` INT(11) NOT NULL,
  `clliente_tem_cartao_id` INT(11) NOT NULL,
  `historico_tarifa` DECIMAL(6,2) NULL,
  `data` DATETIME NULL DEFAULT now(),
  PRIMARY KEY (`id`),
  INDEX `fk_viagem_has_cliente_has_cartao_passe_viagem1` (`viagem_id` ASC) ,
  INDEX `fk_embarque_clliente_tem_cartao1_idx` (`clliente_tem_cartao_id` ASC) ,
  CONSTRAINT `fk_viagem_has_cliente_has_cartao_passe_viagem1`
    FOREIGN KEY (`viagem_id`)
    REFERENCES `techpassdb`.`viagem` (`id`),
  CONSTRAINT `fk_embarque_clliente_tem_cartao1`
    FOREIGN KEY (`clliente_tem_cartao_id`)
    REFERENCES `techpassdb`.`cartoes_do_cliente` (`codigo_do_cartao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `techpassdb`.`horario_diario_saida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `techpassdb`.`horario_diario_saida` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `linhas_id` INT UNSIGNED NOT NULL,
  `horario_de_saida` TIME NOT NULL,
  `duracaoEstimada` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_horario_diario_saida_linhas1_idx` (`linhas_id` ASC) ,
  CONSTRAINT `fk_horario_diario_saida_linhas1`
    FOREIGN KEY (`linhas_id`)
    REFERENCES `techpassdb`.`linhas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
