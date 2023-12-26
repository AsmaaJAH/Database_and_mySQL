-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema SAMPLE_Asmaa_CommuDepartment
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema SAMPLE_Asmaa_CommuDepartment
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SAMPLE_Asmaa_CommuDepartment` ;
USE `SAMPLE_Asmaa_CommuDepartment` ;

-- -----------------------------------------------------
-- Table `SAMPLE_Asmaa_CommuDepartment`.`PUBLISHER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE_Asmaa_CommuDepartment`.`PUBLISHER` (
  `PublisherName` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(100) NULL,
  `Phone` VARCHAR(13) NULL,
  PRIMARY KEY (`PublisherName`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAMPLE_Asmaa_CommuDepartment`.`BOOK`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE_Asmaa_CommuDepartment`.`BOOK` (
  `BookID` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(45) NOT NULL,
  `PublisherName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`BookID`),
  INDEX `FKpublisherName_idx` (`PublisherName` ASC) ,
  CONSTRAINT `FKpublisherName`
    FOREIGN KEY (`PublisherName`)
    REFERENCES `SAMPLE_Asmaa_CommuDepartment`.`PUBLISHER` (`PublisherName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAMPLE_Asmaa_CommuDepartment`.`BOOK_AUTHORS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE_Asmaa_CommuDepartment`.`BOOK_AUTHORS` (
  `BookID` INT NOT NULL,
  `AuthorName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`AuthorName`, `BookID`),
  INDEX `fk_BOOK_AUTHORS_BOOK_idx` (`BookID` ASC) ,
  CONSTRAINT `fk_BOOK_AUTHORS_BOOK`
    FOREIGN KEY (`BookID`)
    REFERENCES `SAMPLE_Asmaa_CommuDepartment`.`BOOK` (`BookID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAMPLE_Asmaa_CommuDepartment`.`LIBRARY_BRANCH`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE_Asmaa_CommuDepartment`.`LIBRARY_BRANCH` (
  `BranchID` INT NOT NULL AUTO_INCREMENT,
  `BranchName` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(100) NULL,
  PRIMARY KEY (`BranchID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAMPLE_Asmaa_CommuDepartment`.`BOOK_COPIES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE_Asmaa_CommuDepartment`.`BOOK_COPIES` (
  `BranchID` INT NOT NULL,
  `BookID` INT NOT NULL,
  `No_Of_Copies` INT ZEROFILL NULL,
  PRIMARY KEY (`BranchID`, `BookID`),
  CONSTRAINT `BookID`
    FOREIGN KEY (`BookID`)
    REFERENCES `SAMPLE_Asmaa_CommuDepartment`.`BOOK` (`BookID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `BranchID`
    FOREIGN KEY (`BranchID`)
    REFERENCES `SAMPLE_Asmaa_CommuDepartment`.`LIBRARY_BRANCH` (`BranchID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAMPLE_Asmaa_CommuDepartment`.`BORROWER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE_Asmaa_CommuDepartment`.`BORROWER` (
  `CardNo` INT NOT NULL AUTO_INCREMENT,
  `borrowerName` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(100) NULL,
  `Phone` VARCHAR(13) NULL,
  PRIMARY KEY (`CardNo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAMPLE_Asmaa_CommuDepartment`.`BOOK_LOANS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE_Asmaa_CommuDepartment`.`BOOK_LOANS` (
  `BookID` INT NOT NULL,
  `BranchID` INT NOT NULL,
  `CardNo` INT NOT NULL,
  `DateOut` DATE NOT NULL,
  `DueDate` DATE NOT NULL,
  INDEX `BookID_idx` (`BookID` ASC) ,
  PRIMARY KEY (`BookID`, `BranchID`, `CardNo`),
  INDEX `BranchID_idx` (`BranchID` ASC) ,
  INDEX `CardNo_idx` (`CardNo` ASC) ,
  CONSTRAINT `BookID_BookLOANS`
    FOREIGN KEY (`BookID`)
    REFERENCES `SAMPLE_Asmaa_CommuDepartment`.`BOOK` (`BookID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `BranchID_BookLOANS`
    FOREIGN KEY (`BranchID`)
    REFERENCES `SAMPLE_Asmaa_CommuDepartment`.`LIBRARY_BRANCH` (`BranchID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CardNo_BookLOANS`
    FOREIGN KEY (`CardNo`)
    REFERENCES `SAMPLE_Asmaa_CommuDepartment`.`BORROWER` (`CardNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
