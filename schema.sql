use mydb;

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`members`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`members` ;

CREATE TABLE IF NOT EXISTS `mydb`.`members` (
  `member_no` INT NOT NULL AUTO_INCREMENT,
  `member_fname` VARCHAR(45) NOT NULL,
  `member_lname` VARCHAR(45) NOT NULL,
  `partner_name` VARCHAR(45) NULL,
  `street_address` VARCHAR(45) NULL,
  `suburb` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `postcode` VARCHAR(45) NULL,
  `home_phone` VARCHAR(45) NULL,
  `mobile_phone` VARCHAR(45) NULL,
  `email` VARCHAR(100) NULL,
  `member_status` VARCHAR(15) NULL,
  PRIMARY KEY (`member_no`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`invoice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`invoice` ;

CREATE TABLE IF NOT EXISTS `mydb`.`invoice` (
  `invoice_no` INT NOT NULL AUTO_INCREMENT,
  `invoice_date` DATETIME NOT NULL,
  `invoice_duedate` DATETIME NOT NULL,
  `invoice_total` DECIMAL(9,2) NOT NULL,
  `member_no` INT NOT NULL,
  `invoice_sent` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`invoice_no`),
  CONSTRAINT `fk_invoice_member`
    FOREIGN KEY (`member_no`)
    REFERENCES `mydb`.`members` (`member_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`item` ;

CREATE TABLE IF NOT EXISTS `mydb`.`item` (
  `item_code` INT NOT NULL,
  `item_description` VARCHAR(45) NOT NULL,
  `item_value` DECIMAL(9,2) NOT NULL,
  PRIMARY KEY (`item_code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`invoice_line`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`invoice_line` ;

CREATE TABLE IF NOT EXISTS `mydb`.`invoice_line` (
  `invoice_no` INT NOT NULL,
  `item_qty` INT NOT NULL,
  `invoice_item_value` DECIMAL(9,2) NOT NULL,
  `item_code` INT NOT NULL,
  PRIMARY KEY (`invoice_no`, `item_code`),
  CONSTRAINT `fk_invoice_line_invoice1`
    FOREIGN KEY (`invoice_no`)
    REFERENCES `mydb`.`invoice` (`invoice_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_invoice_line_item1`
    FOREIGN KEY (`item_code`)
    REFERENCES `mydb`.`item` (`item_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`invoice_receipt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`invoice_receipt` ;

CREATE TABLE IF NOT EXISTS `mydb`.`invoice_receipt` (
  `invoice_receipt_no` INT NOT NULL,
  `invoice_no` INT NOT NULL,
  `cash_amount` DECIMAL(9,2) NOT NULL,
  `transfer_amount` DECIMAL(9,2) NOT NULL,
  `payment_datetime` DATETIME NOT NULL,
  `receipt_sent` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`invoice_receipt_no`),
  UNIQUE INDEX `invoice_no_UNIQUE` (`invoice_no` ASC) VISIBLE,
  CONSTRAINT `fk_receipt_invoice1`
    FOREIGN KEY (`invoice_no`)
    REFERENCES `mydb`.`invoice` (`invoice_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`expense`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`expense` ;

CREATE TABLE IF NOT EXISTS `mydb`.`expense` (
  `expense_id` INT NOT NULL,
  `expense_description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`expense_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`expense_receipt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`expense_receipt` ;

CREATE TABLE IF NOT EXISTS `mydb`.`expense_receipt` (
  `expense_receipt_no` INT NOT NULL,
  `expense_id` INT NOT NULL,
  `cash_amount` DECIMAL(9,2) NOT NULL,
  `transfer_amount` DECIMAL(9,2) NOT NULL,
  `payment_datetime` DATETIME NOT NULL,
  `expense_notes` VARCHAR(200),
  PRIMARY KEY (`expense_receipt_no`),
  CONSTRAINT `fk_expense1`
    FOREIGN KEY (`expense_id`)
    REFERENCES `mydb`.`expense` (`expense_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`income`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`income` ;

CREATE TABLE IF NOT EXISTS `mydb`.`income` (
  `income_id` INT NOT NULL,
  `income_description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`income_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`income_receipt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`income_receipt` ;

CREATE TABLE IF NOT EXISTS `mydb`.`income_receipt` (
  `income_receipt_no` INT NOT NULL,
  `income_id` INT NOT NULL,
  `cash_amount` DECIMAL(9,2) NOT NULL,
  `transfer_amount` DECIMAL(9,2) NOT NULL,
  `payment_datetime` DATETIME NOT NULL,
  `income_notes` VARCHAR(200),
  PRIMARY KEY (`income_receipt_no`),
  CONSTRAINT `fk_income1`
    FOREIGN KEY (`income_id`)
    REFERENCES `mydb`.`income` (`income_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`transfer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`transfer` ;

CREATE TABLE IF NOT EXISTS `mydb`.`transfer` (
  `transfer_no` INT NOT NULL,
  `cash_amount` DECIMAL(9,2) NOT NULL,
  `transfer_amount` DECIMAL(9,2) NOT NULL,
  `payment_datetime` DATETIME NOT NULL,
  PRIMARY KEY (`transfer_no`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`bank_detail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`bank_detail` ;

CREATE TABLE IF NOT EXISTS `mydb`.`bank_detail` (
  `bsb` VARCHAR(15) NOT NULL,
  `account_no` VARCHAR(15) NOT NULL,
  `bank_name` VARCHAR(45) NOT NULL,
  `customer_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`bsb`, `account_no`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `mydb`.`payment_history`;

CREATE TABLE IF NOT EXISTS `mydb`.`payment_history` (
  `cash_balance` DECIMAL(9,2) NOT NULL,
  `bank_balance` DECIMAL(9,2) NOT NULL,
  `payment_datetime` DATETIME NOT NULL,
  PRIMARY KEY (`cash_balance`, `bank_balance`))
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO members (member_no, member_fname, member_lname, partner_name, street_address, suburb, state, postcode, home_phone, mobile_phone, email, member_status) 
VALUES (1, "Admin", "Admin", "Admin", "Admin", "Admin", "Admin", "Admin", "Admin", "Admin", "Admin", "Admin");

INSERT INTO item (item_code, item_description, item_value) VALUES (1,'Annual Membership Renewal Fee', 100);
INSERT INTO item (item_code, item_description, item_value) VALUES (2,'Fine', 10);
INSERT INTO item (item_code, item_description, item_value) VALUES (3,'First Time Membership Fee', 100);
INSERT INTO item (item_code, item_description, item_value) VALUES (4,'Club Apparel', 50);

insert into bank_detail (bank_name, customer_name, bsb, account_no) values ('Westpac Bank', 'Greater Western 4x4 Club', 033120, 283739); 

alter table members auto_increment = 60;

insert into payment_history (cash_balance, bank_balance, payment_datetime) values (0, 0, now());
insert into invoice (invoice_no, invoice_date, invoice_duedate, invoice_total, member_no, invoice_sent) values (10000,str_to_date("01-01-70","%d-%m-%y"), str_to_date("01-01-70","%d-%m-%y"), 0, 1, 'Yes');
insert into invoice_receipt (invoice_receipt_no, invoice_no, cash_amount, transfer_amount, payment_datetime, receipt_sent) values (40000, 10000, 0, 0, now(), "Yes");
insert into expense (expense_id, expense_description) values (1, 'Admin');

insert into income (income_id, income_description) values (1, 'Admin');
insert into income_receipt (income_receipt_no, income_id, cash_amount, transfer_amount, payment_datetime, income_notes) values (30000, 1, 50.45, 2504.48, str_to_date("01-01-70","%d-%m-%y"),'Database initalisation');
insert into expense_receipt (expense_receipt_no, expense_id, cash_amount, transfer_amount, payment_datetime, expense_notes) values (70000, 1, 0, 0, str_to_date("01-01-70","%d-%m-%y"), 'Database initalisation');
insert into transfer (transfer_no, cash_amount, transfer_amount, payment_datetime) values (50000, 0, 0, str_to_date("01-01-70","%d-%m-%y"));




