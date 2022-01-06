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
-- Table `mydb`.`Insurance_Coverage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Insurance_Coverage` (
  `Id_Emp_Ins` INT NOT NULL,
  `SSN` INT NOT NULL,
  `DOB` DATE NULL,
  `Name` VARCHAR(45) NULL,
  `Relationship_Emp` VARCHAR(45) NULL,
  `Employee_Table_Id_emp` INT NOT NULL,
  PRIMARY KEY (`Id_Emp_Ins`, `SSN`),
  INDEX `fk_Insurance_Coverage_Employee_Table1_idx` (`Employee_Table_Id_emp` ASC) VISIBLE,
  CONSTRAINT `fk_Insurance_Coverage_Employee_Table1`
    FOREIGN KEY (`Employee_Table_Id_emp`)
    REFERENCES `mydb`.`Employee_Table` (`Id_Emp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Info_Insurance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Info_Insurance` (
  `Id_Emp` INT NOT NULL,
  `Policy_No` INT NOT NULL,
  `Group_No` INT NULL,
  `Dt_End_Ins` DATE NULL,
  `Id_Emp_Ins` VARCHAR(45) NULL,
  `Dt_Begin_Ins` DATE NULL,
  `Group_Cost` INT NULL,
  `Company_Department_Id_Emp` INT NOT NULL,
  `Insurance_Coverage_Id_Emp_Ins` INT NOT NULL,
  `Insurance_Coverage_SSN` INT NOT NULL,
  PRIMARY KEY (`Id_Emp`, `Policy_No`),
  INDEX `fk_Info_Insurance_Insurance_Coverage1_idx` (`Insurance_Coverage_Id_Emp_Ins` ASC, `Insurance_Coverage_SSN` ASC) VISIBLE,
  CONSTRAINT `fk_Info_Insurance_Insurance_Coverage1`
    FOREIGN KEY (`Insurance_Coverage_Id_Emp_Ins` , `Insurance_Coverage_SSN`)
    REFERENCES `mydb`.`Insurance_Coverage` (`Id_Emp_Ins` , `SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Employee_Table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Employee_Table` (
  `Id_Emp` INT NOT NULL,
  `Name_Employee` VARCHAR(45) NULL,
  `DOB` DATE NULL,
  `SSN` INT NOT NULL,
  `Address` VARCHAR(45) NULL,
  `City` VARCHAR(45) NULL,
  `ZIP` INT NULL,
  `Insurance_Coverage_Id_Emp_Ins` INT NOT NULL,
  `Insurance_Coverage_SSN` INT NOT NULL,
  `Insurance_Coverage_Id_Emp_Ins1` INT NOT NULL,
  `Insurance_Coverage_SSN1` INT NOT NULL,
  `Info_Insurance_Id_Emp` INT NOT NULL,
  `Info_Insurance_Policy_No` INT NOT NULL,
  PRIMARY KEY (`Id_Emp`, `SSN`),
  INDEX `fk_Employee_Table_Info_Insurance1_idx` (`Info_Insurance_Id_Emp` ASC, `Info_Insurance_Policy_No` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_Table_Info_Insurance1`
    FOREIGN KEY (`Info_Insurance_Id_Emp` , `Info_Insurance_Policy_No`)
    REFERENCES `mydb`.`Info_Insurance` (`Id_Emp` , `Policy_No`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Comp_Category_Table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Comp_Category_Table` (
  `Id_Category` INT NULL,
  `Rate_Per_Hour` INT NULL,
  `Ext_Per_Hour` INT NULL,
  `Employee_Table_Id_Emp` INT NOT NULL,
  PRIMARY KEY (`Id_Category`),
  INDEX `fk_Comp_Category_Table_Employee_Table1_idx` (`Employee_Table_Id_Emp` ASC) VISIBLE,
  CONSTRAINT `fk_Comp_Category_Table_Employee_Table1`
    FOREIGN KEY (`Employee_Table_Id_Emp`)
    REFERENCES `mydb`.`Employee_Table` (`Id_Emp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Employee_Comp_Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Employee_Comp_Category` (
  `Id_Emp` INT NOT NULL,
  `Id_Category` INT NOT NULL,
  `Dt_Begin_Emp` DATE NULL,
  `Dt_End_Emp` DATE NULL,
  `Employee Comp Categorycol` VARCHAR(45) NULL,
  `Employee_Table_Id_Emp` INT NOT NULL,
  PRIMARY KEY (`Id_Category`, `Id_Emp`),
  INDEX `fk_Employee Comp Category_Employee_Table1_idx` (`Employee_Table_Id_Emp` ASC) VISIBLE,
  CONSTRAINT `fk_Employee Comp Category_Employee_Table1`
    FOREIGN KEY (`Employee_Table_Id_Emp`)
    REFERENCES `mydb`.`Employee_Table` (`Id_Emp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Emp_Payroll`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Emp_Payroll` (
  `Id_Emp` INT NOT NULL,
  `Month_Week` DATE NOT NULL,
  `Hours_Per_Week` INT NULL,
  `Ext_Per_Week` INT NULL,
  `Employee_Table_Id_Emp` INT NOT NULL,
  `Employee_Table_SSN` INT NOT NULL,
  PRIMARY KEY (`Id_Emp`, `Month_Week`),
  INDEX `fk_Emp_Payroll_Employee_Table1_idx` (`Employee_Table_Id_Emp` ASC, `Employee_Table_SSN` ASC) VISIBLE,
  CONSTRAINT `fk_Emp_Payroll_Employee_Table1`
    FOREIGN KEY (`Employee_Table_Id_Emp` , `Employee_Table_SSN`)
    REFERENCES `mydb`.`Employee_Table` (`Id_Emp` , `SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Company_Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Company_Department` (
  `Id_Emp` INT NOT NULL,
  `Num_Of_Employees` INT NULL,
  `Name_Of_Department` VARCHAR(45) NULL,
  `Company_Hours` VARCHAR(45) NULL,
  `Company_Ph_No` INT NULL,
  PRIMARY KEY (`Id_Emp`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Time_Sheet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Time_Sheet` (
  `Id_Emp` INT NOT NULL,
  `Clock_In_Time` DATETIME NULL,
  `Clock_Out_Time` DATETIME NULL,
  `Emp_Name` VARCHAR(45) NULL,
  `Employee_Table_Id_Emp` INT NOT NULL,
  PRIMARY KEY (`Id_Emp`),
  INDEX `fk_Time_Sheet_Employee_Table1_idx` (`Employee_Table_Id_Emp` ASC) VISIBLE,
  CONSTRAINT `fk_Time_Sheet_Employee_Table1`
    FOREIGN KEY (`Employee_Table_Id_Emp`)
    REFERENCES `mydb`.`Employee_Table` (`Id_Emp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment_Plan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment_Plan` (
  `Id_Emp` INT NOT NULL,
  `Monthly_Payment` INT NULL,
  `Annual_Payment` VARCHAR(45) NULL,
  `Bank_Id` VARCHAR(45) NULL,
  `Employee_Table_Id_Emp` INT NOT NULL,
  `Employee_Table_SSN` INT NOT NULL,
  `Emp_Payroll_Id_Emp` INT NOT NULL,
  `Emp_Payroll_Month_Week` DATE NOT NULL,
  PRIMARY KEY (`Id_Emp`),
  INDEX `fk_Payment_Plan_Employee_Table1_idx` (`Employee_Table_Id_Emp` ASC, `Employee_Table_SSN` ASC) VISIBLE,
  INDEX `fk_Payment_Plan_Emp_Payroll1_idx` (`Emp_Payroll_Id_Emp` ASC, `Emp_Payroll_Month_Week` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_Plan_Employee_Table1`
    FOREIGN KEY (`Employee_Table_Id_Emp` , `Employee_Table_SSN`)
    REFERENCES `mydb`.`Employee_Table` (`Id_Emp` , `SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Payment_Plan_Emp_Payroll1`
    FOREIGN KEY (`Emp_Payroll_Id_Emp` , `Emp_Payroll_Month_Week`)
    REFERENCES `mydb`.`Emp_Payroll` (`Id_Emp` , `Month_Week`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Company_Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Company_Address` (
  `Id_Emp` INT NOT NULL,
  `Company_Phone_Number` VARCHAR(45) NULL,
  `Zip_Code` VARCHAR(45) NULL,
  `Street_No` VARCHAR(45) NULL,
  `City_Name` VARCHAR(45) NULL,
  `Street_Name` VARCHAR(45) NULL,
  `Company_Department_Id_Emp` INT NOT NULL,
  PRIMARY KEY (`Id_Emp`),
  INDEX `fk_Company_Address_Company_Department1_idx` (`Company_Department_Id_Emp` ASC) VISIBLE,
  CONSTRAINT `fk_Company_Address_Company_Department1`
    FOREIGN KEY (`Company_Department_Id_Emp`)
    REFERENCES `mydb`.`Company_Department` (`Id_Emp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
