-- MySQL Script generated by MySQL Workbench
-- 06/08/16 22:25:26
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
/*==============================================================*/
/* Base de datos: `ferreteria`                                 */
/*==============================================================*/
CREATE DATABASE IF NOT EXISTS `ferreteriaweb` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `ferreteriaweb`;

-- -----------------------------------------------------
-- Table `ferreteriaweb`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ferreteriaweb`.`Usuario` (
  `runUsuario` VARCHAR(13) NOT NULL COMMENT 'Rol Unico Nacional del Cliente',
  `nombre` VARCHAR(50) NOT NULL,
  `apellido` VARCHAR(50) NOT NULL,
  `sexo` VARCHAR(7) NOT NULL,
  `fechaNacimiento` DATE NOT NULL,
  `telefono` INT NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `suscripcion` BOOLEAN NOT NULL,
  `pass` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`runUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ferreteriaweb`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ferreteriaweb`.`Categoria` (
  `idCategoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NOT NULL,
  `tipoCategoria` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ferreteriaweb`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ferreteriaweb`.`Producto` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `nombreProducto` VARCHAR(30) NOT NULL,
  `categoria` VARCHAR(30) NOT NULL,
  `precioUnitario` INT NOT NULL,
  `descripcionProducto` VARCHAR(1024) NOT NULL,
  `ubicacion` VARCHAR(30) NOT NULL,
  `cantidad` INT NOT NULL,
  `dsto` DOUBLE NULL,
  `fechaTerminoDsto` DATE NULL,
  `Categoria_idCategoria` INT NOT NULL,
  PRIMARY KEY (`idProducto`, `Categoria_idCategoria`),
  INDEX `fk_Producto_Categoria1_idx` (`Categoria_idCategoria` ASC),
  CONSTRAINT `fk_Producto_Categoria1`
    FOREIGN KEY (`Categoria_idCategoria`)
    REFERENCES `ferreteriaweb`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ferreteriaweb`.`carritoCompra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ferreteriaweb`.`carritoCompra` (
  `idcarritoCompra` INT NOT NULL,
  `producto` INT NOT NULL,
  `dscto` INT NOT NULL,
  `total` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `montoPagar` INT NOT NULL,
  `carritoCompracol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcarritoCompra`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ferreteriaweb`.`Boleta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ferreteriaweb`.`Boleta` (
  `numBoleta` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `hora` TIME(0) NOT NULL,
  `medioPago` VARCHAR(30) NOT NULL,
  `nroTarjeta` MEDIUMTEXT NOT NULL,
  `total` INT NOT NULL,
  `tipoTransaccion` VARCHAR(30) NOT NULL,
  `nroOrden` INT NOT NULL,
  `Usuario_runUsuario` VARCHAR(13) NOT NULL,
  `carritoCompra_idcarritoCompra` INT NOT NULL,
  PRIMARY KEY (`numBoleta`, `carritoCompra_idcarritoCompra`),
  INDEX `fk_Boleta_Usuario1_idx` (`Usuario_runUsuario` ASC),
  INDEX `fk_Boleta_carritoCompra1_idx` (`carritoCompra_idcarritoCompra` ASC),
  CONSTRAINT `fk_Boleta_Usuario1`
    FOREIGN KEY (`Usuario_runUsuario`)
    REFERENCES `ferreteriaweb`.`Usuario` (`runUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Boleta_carritoCompra1`
    FOREIGN KEY (`carritoCompra_idcarritoCompra`)
    REFERENCES `ferreteriaweb`.`carritoCompra` (`idcarritoCompra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ferreteriaweb`.`Administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ferreteriaweb`.`Administrador` (
  `runUsuario` VARCHAR(13) NOT NULL COMMENT 'Rol Unico Nacional del Administrador',
  `nombre` VARCHAR(30) NOT NULL,
  `apellido` VARCHAR(30) NOT NULL,
  `sexo` VARCHAR(7) NOT NULL,
  `fechaNacimiento` DATE NOT NULL,
  `email` VARCHAR(30) NOT NULL,
  `userName` VARCHAR(30) NOT NULL,
  `pass` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`runUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ferreteriaweb`.`SubCategoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ferreteriaweb`.`SubCategoria` (
  `idSubCategoria` INT NOT NULL AUTO_INCREMENT,
  `nomCategoria` VARCHAR(30) NOT NULL,
  `Categoria_idCategoria` INT NOT NULL,
  PRIMARY KEY (`idSubCategoria`, `Categoria_idCategoria`),
  INDEX `fk_SubCategoria_Categoria_idx` (`Categoria_idCategoria` ASC),
  CONSTRAINT `fk_SubCategoria_Categoria`
    FOREIGN KEY (`Categoria_idCategoria`)
    REFERENCES `ferreteriaweb`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ferreteriaweb`.`Producto_has_Administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ferreteriaweb`.`Producto_has_Administrador` (
  `Producto_idProducto` INT NOT NULL,
  `Producto_Categoria_idCategoria` INT NOT NULL,
  `Administrador_runUsuario` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Producto_idProducto`, `Producto_Categoria_idCategoria`, `Administrador_runUsuario`),
  INDEX `fk_Producto_has_Administrador_Administrador1_idx` (`Administrador_runUsuario` ASC),
  INDEX `fk_Producto_has_Administrador_Producto1_idx` (`Producto_idProducto` ASC, `Producto_Categoria_idCategoria` ASC),
  CONSTRAINT `fk_Producto_has_Administrador_Producto1`
    FOREIGN KEY (`Producto_idProducto` , `Producto_Categoria_idCategoria`)
    REFERENCES `ferreteriaweb`.`Producto` (`idProducto` , `Categoria_idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_has_Administrador_Administrador1`
    FOREIGN KEY (`Administrador_runUsuario`)
    REFERENCES `ferreteriaweb`.`Administrador` (`runUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

