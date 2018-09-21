-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema estoque
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema estoque
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `estoque` DEFAULT CHARACTER SET utf8 ;
USE `estoque` ;

-- -----------------------------------------------------
-- Table `estoque`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estoque`.`usuario` (
  `cd_usuario` INT NOT NULL,
  `nm_usuario` VARCHAR(200) NOT NULL,
  `nm_senha` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`cd_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `estoque`.`tipo_embalagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estoque`.`tipo_embalagem` (
  `nm_tipo_embalagem` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`nm_tipo_embalagem`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `estoque`.`estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estoque`.`estoque` (
  `cd_produto` VARCHAR(10) NOT NULL,
  `cd_ncm` INT NOT NULL,
  `ds_produto` VARCHAR(200) NOT NULL,
  `qt_produto` INT NOT NULL,
  `vl_unitario` DECIMAL(10,2) NOT NULL,
  `vl_total` DECIMAL(10,2) NOT NULL,
  `tipo_embalagem_nm_tipo_embalagem` VARCHAR(100) NOT NULL,
  INDEX `fk_Estoque_Tipo_Embalagem_idx` (`tipo_embalagem_nm_tipo_embalagem` ASC),
  PRIMARY KEY (`cd_produto`),
  CONSTRAINT `fk_Estoque_Tipo_Embalagem`
    FOREIGN KEY (`tipo_embalagem_nm_tipo_embalagem`)
    REFERENCES `estoque`.`tipo_embalagem` (`nm_tipo_embalagem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `estoque`.`lucro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estoque`.`lucro` (
  `cd_lucro` INT NOT NULL,
  PRIMARY KEY (`cd_lucro`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `estoque`.`fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estoque`.`fornecedor` (
  `cd_fornecedor` INT NOT NULL AUTO_INCREMENT,
  `nm_razao` VARCHAR(255) NOT NULL,
  `nm_fantasia` VARCHAR(255) NOT NULL,
  `cd_cnpj` VARCHAR(18) NOT NULL,
  `cd_ie` VARCHAR(25) NOT NULL,
  `cd_cep` VARCHAR(10) NULL,
  `ds_endereco` VARCHAR(150) NULL,
  `cd_numero` VARCHAR(6) NULL,
  `nm_bairro` VARCHAR(50) NULL,
  `nm_cidade` VARCHAR(50) NULL,
  `nm_estado` VARCHAR(2) NULL,
  `cd_tel1` VARCHAR(15) NULL,
  `cd_tel2` VARCHAR(15) NULL,
  `nm_email` VARCHAR(100) NULL,
  `nm_site` VARCHAR(100) NULL,
  `nm_vendedor` VARCHAR(100) NULL,
  `cd_telvendedor` VARCHAR(15) NULL,
  PRIMARY KEY (`cd_fornecedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `estoque`.`notafiscal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estoque`.`notafiscal` (
  `cd_nfe` VARCHAR(100) NOT NULL,
  `dt_emissao` DATETIME NOT NULL,
  `dt_criacao` DATETIME NOT NULL,
  `Fornecedor_cd_fornecedor` INT NOT NULL,
  PRIMARY KEY (`cd_nfe`),
  INDEX `fk_NotaFiscal_Fornecedor1_idx` (`Fornecedor_cd_fornecedor` ASC),
  CONSTRAINT `fk_NotaFiscal_Fornecedor1`
    FOREIGN KEY (`Fornecedor_cd_fornecedor`)
    REFERENCES `estoque`.`fornecedor` (`cd_fornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `estoque`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estoque`.`produto` (
  `cd_produto` VARCHAR(10) NOT NULL,
  `cd_ncm` INT NOT NULL,
  `ds_produto` VARCHAR(200) NOT NULL,
  `qt_produto` INT NOT NULL,
  `vl_unitario` DECIMAL(10,2) NOT NULL,
  `vl_total` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`cd_produto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `estoque`.`saida_produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estoque`.`saida_produto` (
  `cd_produto_saida` VARCHAR(10) NOT NULL,
  `ds_produto` VARCHAR(200) NOT NULL,
  `qt_produto` INT NOT NULL,
  `vl_unitario` DECIMAL(10,2) NOT NULL,
  `dt_saida` DATETIME NOT NULL,
  `produto_cd_produto` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`cd_produto_saida`),
  INDEX `fk_Saida_Produto_Produto1_idx` (`produto_cd_produto` ASC),
  CONSTRAINT `fk_Saida_Produto_Produto1`
    FOREIGN KEY (`produto_cd_produto`)
    REFERENCES `estoque`.`produto` (`cd_produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `estoque`.`entrada_produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estoque`.`entrada_produto` (
  `cd_produto_entrada` VARCHAR(10) NOT NULL,
  `cd_ncm` INT NOT NULL,
  `ds_produto` VARCHAR(200) NOT NULL,
  `qt_produto` INT NOT NULL,
  `vl_unitario` DECIMAL(10,2) NOT NULL,
  `dt_entrada` DATETIME NULL,
  `produto_cd_produto` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`cd_produto_entrada`),
  INDEX `fk_Entrada_Produto_Produto1_idx` (`produto_cd_produto` ASC),
  CONSTRAINT `fk_Entrada_Produto_Produto1`
    FOREIGN KEY (`produto_cd_produto`)
    REFERENCES `estoque`.`produto` (`cd_produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
