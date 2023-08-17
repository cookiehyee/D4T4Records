/*	SQL QUERY TO CREATE AND USE DATABASE	*/
CREATE DATABASE D4T4Records;
USE D4T4Records;

/*	SQL QUERY TO CREATE TABLES	*/

/*	CREATE CUSTOMER TABLE	*/
CREATE TABLE `D4T4Records`.`Customer` (
  `CustomerID` INT NOT NULL,
  `FName` VARCHAR(30) NOT NULL,
  `LName` VARCHAR(30) NOT NULL,
  `Street` VARCHAR(30) NOT NULL,
  `City` VARCHAR(30) NOT NULL,
  `State` VARCHAR(30) NOT NULL,
  `Zip` VARCHAR(30) NOT NULL,
  `Phone` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`CustomerID`));

/*	CREATE TECHNICIAN TABLE	*/
CREATE TABLE `D4T4Records`.`Technician` (
  `TechID` int(11) NOT NULL,
  `FName` VARCHAR(30) NOT NULL,
  `LName` VARCHAR(30) NOT NULL,
  `Street` VARCHAR(30) NOT NULL,
  `City` VARCHAR(30) NOT NULL,
  `State` VARCHAR(30) NOT NULL,
  `Zip` VARCHAR(30) NOT NULL,
  `Phone` VARCHAR(15) NOT NULL,
  `License` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`TechID`));

/*	CREATE ARTIST TABLE	*/
CREATE TABLE `D4T4Records`.`Artist` (
  `ArtistID` INT NOT NULL,
  `FName` VARCHAR(30) NOT NULL,
  `LName` VARCHAR(30) NOT NULL,
  `Label` VARCHAR(30) NOT NULL,
  `StageName` VARCHAR(30) NULL,
  PRIMARY KEY (`ArtistID`));

/*	CREATE PRODUCER TABLE	*/
CREATE TABLE `D4T4Records`.`Producer` (
  `ProducerID` INT NOT NULL,
  `FName` VARCHAR(30) NOT NULL,
  `LName` VARCHAR(30) NOT NULL,
  `Company` VARCHAR(30) NULL,
  PRIMARY KEY (`ProducerID`));

/*	CREATE RECORD TABLE	*/
CREATE TABLE `D4T4Records`.`Record` (
  `RecordID` INT NOT NULL,
  `Name` VARCHAR(30) NOT NULL,
  `Price` DECIMAL(30) NOT NULL,
  `ManufactDate` DATE NOT NULL,
  `SalesDate` DATE NULL,
  `RecordType` VARCHAR(30) NOT NULL,
  `CustomerID` INT DEFAULT NULL,
  PRIMARY KEY (`RecordID`),
  INDEX `CustomerID_idx` (`CustomerID` ASC),
  CONSTRAINT `CustomerID` 
	FOREIGN KEY (`CustomerID`) 
    REFERENCES `D4T4Records`.`Customer` (`CustomerID`) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION);

/*	CREATE VINYL TABLE	*/
CREATE TABLE `D4T4Records`.`Vinyl` (
  `VinylID` INT NOT NULL,
  `Capacity` DECIMAL(30) NOT NULL,
  `Diameter` DECIMAL(30) NOT NULL,
  PRIMARY KEY (`VinylID`));

/*	CREATE CD TABLE	*/
CREATE TABLE `D4T4Records`.`CD` (
  `CDID` INT NOT NULL,
  `Capacity` DECIMAL(30) NOT NULL,
  `CDType` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`CDID`));

/*	CREATE INSTRUMENT TABLE	*/
CREATE TABLE `D4T4Records`.`Instrument` (
  `InstrumentID` INT NOT NULL,
  `ModelBrand` VARCHAR(30) NOT NULL,
  `Insurance` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`InstrumentID`));

/*	CREATE MUSIC TABLE	*/
CREATE TABLE `D4T4Records`.`Music` (
  `MusicID` INT NOT NULL,
  PRIMARY KEY (`MusicID`));

/*	CREATE MOVIE TABLE	*/
CREATE TABLE `D4T4Records`.`Movie` (
  `MovieID` INT NOT NULL,
  `ProducerID` INT NOT NULL,
  PRIMARY KEY (`MovieID`),
  INDEX `ProducerID_idx` (`ProducerID` ASC),
  CONSTRAINT `ProducerID` 
	FOREIGN KEY (`ProducerID`) 
	REFERENCES `D4T4Records`.`Producer` (`ProducerID`) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION);

/*	CREATE CUSTOMERPAYMENT TABLE	*/
CREATE TABLE `D4T4Records`.`CustomerPayment` (
  `PaymentMethod` VARCHAR(30) NOT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`PaymentMethod`,`CustomerID`),
  INDEX `CustomerMultivalue_idx` (`CustomerID` ASC),
  CONSTRAINT `CustomerMultivalue` 
	FOREIGN KEY (`CustomerID`) 
	REFERENCES `D4T4Records`.`Customer` (`CustomerID`) 
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION);

/*	CREATE MUSICGENRE TABLE	*/
CREATE TABLE `D4T4Records`.`MusicGenre` (
  `GenreStyle` VARCHAR(30) NOT NULL,
  `MusicID` INT NOT NULL,
  PRIMARY KEY (`GenreStyle`,`MusicID`),
  INDEX `MusicMultivalue_idx` (`MusicID`),
  CONSTRAINT `MusicMultivalue` 
	FOREIGN KEY (`MusicID`) 
	REFERENCES `D4T4Records`.`Music` (`MusicID`) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION);

/*	CREATE MOVIEGENRE TABLE	*/
CREATE TABLE `D4T4Records`.`MovieGenre` (
  `GenreTheme` VARCHAR(30) NOT NULL,
  `MovieID` INT NOT NULL,
  PRIMARY KEY (`GenreTheme`,`MovieID`),
  INDEX `MovieMultivalue_idx` (`MovieID` ASC),
  CONSTRAINT `MovieMultivalue` 
	FOREIGN KEY (`MovieID`) 
	REFERENCES `D4T4Records`.`Movie` (`MovieID`) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION);

/*	CREATE REPAIR TABLE	*/
CREATE TABLE `D4T4Records`.`Repair` (
  `TechID` INT NOT NULL,
  `InstrumentID` INT NOT NULL,
  `StartDate` DATE NOT NULL,
  `EndDate` DATE NOT NULL,
  `RepairFee` DECIMAL(30) NOT NULL,
  PRIMARY KEY (`TechID`, `InstrumentID`),
  INDEX `InstrumentID_idx` (`InstrumentID` ASC),
  CONSTRAINT `TechID`
    FOREIGN KEY (`TechID`)
    REFERENCES `D4T4Records`.`Technician` (`TechID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `InstrumentID`
    FOREIGN KEY (`InstrumentID`)
    REFERENCES `D4T4Records`.`Instrument` (`InstrumentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

/*	CREATE COLLAB TABLE	*/
CREATE TABLE `D4T4Records`.`Collaboration` (
  `ArtistID` INT NOT NULL,
  `MusicID` INT NOT NULL,
  `CollabDate` DATE NOT NULL,
  PRIMARY KEY (`ArtistID`,`MusicID`),
  INDEX `MusicID_idx` (`MusicID` ASC),
  CONSTRAINT `ArtistID`
	FOREIGN KEY (`ArtistID`) 
	REFERENCES `D4T4Records`.`Artist` (`ArtistID`) 
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION,
  CONSTRAINT `MusicID` 
	FOREIGN KEY (`MusicID`) 
	REFERENCES `D4T4Records`.`Music` (`MusicID`) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION);