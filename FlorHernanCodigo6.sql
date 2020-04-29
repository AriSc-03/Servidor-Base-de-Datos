-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema BDFloreria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BDFloreria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BDFloreria` DEFAULT CHARACTER SET utf8 ;
USE `BDFloreria` ;

-- -----------------------------------------------------
-- Table `BDFloreria`.`CATEGORIAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BDFloreria`.`CATEGORIAS` (
  `ID_Categoria` VARCHAR(5) NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_Categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDFloreria`.`SUBCATEGORIAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BDFloreria`.`SUBCATEGORIAS` (
  `ID_SubCategoria` VARCHAR(5) NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Descripcion` VARCHAR(150) NULL,
  PRIMARY KEY (`ID_SubCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDFloreria`.`ORDENES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BDFloreria`.`ORDENES` (
  `ID_Orden` INT NOT NULL AUTO_INCREMENT,
  `Tipo` VARCHAR(35) NOT NULL,
  PRIMARY KEY (`ID_Orden`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDFloreria`.`CLIENTES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BDFloreria`.`CLIENTES` (
  `User_Name` VARCHAR(30) NOT NULL,
  `Nombre` VARCHAR(20) NOT NULL,
  `Apellidos` VARCHAR(35) NOT NULL,
  `Edad` INT NOT NULL,
  `Correo` VARCHAR(50) NOT NULL,
  `Contraseña` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`User_Name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDFloreria`.`ARTICULOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BDFloreria`.`ARTICULOS` (
  `ID_Articulo` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(40) NOT NULL,
  `ID_Categoria` VARCHAR(5) NOT NULL,
  `ID_SubCategoria` VARCHAR(5) NOT NULL,
  `Descripcion` VARCHAR(200) NULL,
  `PrecioUnit` DECIMAL(7,2) NOT NULL,
  `Estatus` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_Articulo`),
  INDEX `ID_Categoria_idx` (`ID_Categoria` ASC) VISIBLE,
  INDEX `ID_SubCategoria_idx` (`ID_SubCategoria` ASC) VISIBLE,
  CONSTRAINT `ID_Categoria`
    FOREIGN KEY (`ID_Categoria`)
    REFERENCES `BDFloreria`.`CATEGORIAS` (`ID_Categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ID_SubCategoria`
    FOREIGN KEY (`ID_SubCategoria`)
    REFERENCES `BDFloreria`.`SUBCATEGORIAS` (`ID_SubCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDFloreria`.`PEDIDOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BDFloreria`.`PEDIDOS` (
  `ID_Pedido` INT NOT NULL AUTO_INCREMENT,
  `User_Name` VARCHAR(30) NOT NULL,
  `Enviar o Recoge` VARCHAR(35) NOT NULL,
  `Telefono` INT NOT NULL,
  `ID_Articulo` INT NOT NULL,
  `Foto articulo` LONGBLOB NOT NULL,
  `Fecha` DATE NOT NULL,
  `Fecha de entrega` DATE NOT NULL,
  `Hora de entrega` INT NOT NULL,
  `Direccion` VARCHAR(55) NOT NULL,
  `ID_Orden` INT NOT NULL,
  `Estatus` INT NOT NULL,
  `Requisitos` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`ID_Pedido`),
  INDEX `User_Name_idx` (`User_Name` ASC) VISIBLE,
  INDEX `ID_Articulo_idx` (`ID_Articulo` ASC) VISIBLE,
  INDEX `ID_Orden_idx` (`ID_Orden` ASC) VISIBLE,
  CONSTRAINT `User_Name`
    FOREIGN KEY (`User_Name`)
    REFERENCES `BDFloreria`.`CLIENTES` (`User_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ID_Articulo`
    FOREIGN KEY (`ID_Articulo`)
    REFERENCES `BDFloreria`.`ARTICULOS` (`ID_Articulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ID_Orden`
    FOREIGN KEY (`ID_Orden`)
    REFERENCES `BDFloreria`.`ORDENES` (`ID_Orden`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDFloreria`.`TICKETS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BDFloreria`.`TICKETS` (
  `Noº_Ticket` INT NOT NULL AUTO_INCREMENT,
  `ID_Pedido` INT NOT NULL,
  `ID_Articulo` INT NOT NULL,
  `PrecioUnit` DECIMAL(7,2) NOT NULL,
  `Cantidad` INT NOT NULL,
  `Importe` DECIMAL(7,2) NOT NULL,
  `Total` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`Noº_Ticket`),
  INDEX `ID_Articulo_idx` (`ID_Articulo` ASC) VISIBLE,
  INDEX `ID_Pedido_idx` (`ID_Pedido` ASC) VISIBLE,
  CONSTRAINT `ID_Articulo`
    FOREIGN KEY (`ID_Articulo`)
    REFERENCES `BDFloreria`.`ARTICULOS` (`ID_Articulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ID_Pedido`
    FOREIGN KEY (`ID_Pedido`)
    REFERENCES `BDFloreria`.`PEDIDOS` (`ID_Pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDFloreria`.`VENTAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BDFloreria`.`VENTAS` (
  `ID_Venta` INT NOT NULL AUTO_INCREMENT,
  `Noº_Ticket` INT NOT NULL,
  `User_Name` VARCHAR(30) NOT NULL,
  `ID_Pedido` INT NOT NULL,
  `ID_Articulo` INT NOT NULL,
  `Cantidad` INT NOT NULL,
  `PrecioUnit` DECIMAL(7,2) NOT NULL,
  `Importe` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`ID_Venta`),
  INDEX `Noº_Ticket_idx` (`Noº_Ticket` ASC) VISIBLE,
  INDEX `User_Name_idx` (`User_Name` ASC) VISIBLE,
  INDEX `ID_Pedido_idx` (`ID_Pedido` ASC) VISIBLE,
  INDEX `ID_Articulo_idx` (`ID_Articulo` ASC) VISIBLE,
  CONSTRAINT `Noº_Ticket`
    FOREIGN KEY (`Noº_Ticket`)
    REFERENCES `BDFloreria`.`TICKETS` (`Noº_Ticket`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `User_Name`
    FOREIGN KEY (`User_Name`)
    REFERENCES `BDFloreria`.`CLIENTES` (`User_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ID_Pedido`
    FOREIGN KEY (`ID_Pedido`)
    REFERENCES `BDFloreria`.`PEDIDOS` (`ID_Pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ID_Articulo`
    FOREIGN KEY (`ID_Articulo`)
    REFERENCES `BDFloreria`.`ARTICULOS` (`ID_Articulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
