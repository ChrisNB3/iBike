-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ibike
-- -----------------------------------------------------
-- Schema used with the iBike application
DROP SCHEMA IF EXISTS `ibike` ;

-- -----------------------------------------------------
-- Schema ibike
--
-- Schema used with the iBike application
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ibike` ;
USE `ibike` ;

-- -----------------------------------------------------
-- Table `ibike`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibike`.`customer` ;

CREATE TABLE IF NOT EXISTS `ibike`.`customer` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `department` VARCHAR(2) NOT NULL,
  `cc_number` VARCHAR(19) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibike`.`customer_order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibike`.`customer_order` ;

CREATE TABLE IF NOT EXISTS `ibike`.`customer_order` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(6,2) NOT NULL,
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `confirmation_number` INT UNSIGNED NOT NULL,
  `customer_id` INT UNSIGNED NOT NULL,
  `delivery` TINYINT(1) NOT NULL,
  `discount` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_customer_order_customer1_idx` (`customer_id` ASC),
  CONSTRAINT `fk_customer_order_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `ibike`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibike`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibike`.`category` ;

CREATE TABLE IF NOT EXISTS `ibike`.`category` (
  `id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibike`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibike`.`product` ;

CREATE TABLE IF NOT EXISTS `ibike`.`product` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `price` DECIMAL(5,2) NOT NULL,
  `description` TINYTEXT NULL,
  `last_update` VARCHAR(45) NOT NULL DEFAULT 'CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP',
  `category_id` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_product_category_idx` (`category_id` ASC),
  CONSTRAINT `fk_product_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `ibike`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibike`.`ordered_product_size`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibike`.`ordered_product_size` ;

CREATE TABLE IF NOT EXISTS `ibike`.`ordered_product_size` (
  `id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibike`.`ordered_product_color`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibike`.`ordered_product_color` ;

CREATE TABLE IF NOT EXISTS `ibike`.`ordered_product_color` (
  `id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibike`.`ordered_product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibike`.`ordered_product` ;

CREATE TABLE IF NOT EXISTS `ibike`.`ordered_product` (
  `customer_order_id` INT UNSIGNED NOT NULL,
  `product_id` INT UNSIGNED NOT NULL,
  `quantity` INT UNSIGNED NOT NULL,
  `ordered_product_color_id` TINYINT UNSIGNED NOT NULL,
  `ordered_product_size_id` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`customer_order_id`, `product_id`, `ordered_product_color_id`, `ordered_product_size_id`),
  INDEX `fk_customer_order_has_product_product1_idx` (`product_id` ASC),
  INDEX `fk_customer_order_has_product_customer_order1_idx` (`customer_order_id` ASC),
  INDEX `fk_ordered_product_color1_idx` (`ordered_product_color_id` ASC),
  INDEX `fk_ordered_product_size1_idx` (`ordered_product_size_id` ASC),
  CONSTRAINT `fk_ordered_product_customer_order`
    FOREIGN KEY (`customer_order_id`)
    REFERENCES `ibike`.`customer_order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ordered_product_product`
    FOREIGN KEY (`product_id`)
    REFERENCES `ibike`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ordered_product_color1`
    FOREIGN KEY (`ordered_product_color_id`)
    REFERENCES `ibike`.`ordered_product_color` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ordered_product_size1`
    FOREIGN KEY (`ordered_product_size_id`)
    REFERENCES `ibike`.`ordered_product_size` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
