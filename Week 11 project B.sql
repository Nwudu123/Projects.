-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `university` ;

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university` DEFAULT CHARACTER SET utf8 ;
USE `university` ;

-- -----------------------------------------------------
-- Table `university`.`college`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`college` ;

CREATE TABLE IF NOT EXISTS `university`.`college` (
  `college_id` INT NOT NULL,
  `college_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `university`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`department` ;

CREATE TABLE IF NOT EXISTS `university`.`department` (
  `dept_code` VARCHAR(10) NOT NULL,
  `dept_name` VARCHAR(100) NOT NULL,
  `college_id` INT NOT NULL,
  PRIMARY KEY (`dept_code`, `college_id`),
  INDEX `fk_department_college1_idx` (`college_id` ASC) VISIBLE,
  CONSTRAINT `fk_department_college1`
    FOREIGN KEY (`college_id`)
    REFERENCES `university`.`college` (`college_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `university`.`course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`course` ;

CREATE TABLE IF NOT EXISTS `university`.`course` (
  `course_num` INT NOT NULL,
  `course_name` VARCHAR(50) NOT NULL,
  `credit` INT NOT NULL,
  `dept_code` VARCHAR(10) NOT NULL,
  `college_id` INT NOT NULL,
  PRIMARY KEY (`course_num`, `dept_code`, `college_id`),
  INDEX `fk_course_department1_idx` (`dept_code` ASC, `college_id` ASC) VISIBLE,
  CONSTRAINT `fk_course_department1`
    FOREIGN KEY (`dept_code` , `college_id`)
    REFERENCES `university`.`department` (`dept_code` , `college_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `university`.`faculty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`faculty` ;

CREATE TABLE IF NOT EXISTS `university`.`faculty` (
  `faculty_id` INT NOT NULL,
  `fname` VARCHAR(45) NOT NULL,
  `lname` VARCHAR(45) NOT NULL,
  `dept_code` VARCHAR(10) NOT NULL,
  `college_id` INT NOT NULL,
  PRIMARY KEY (`faculty_id`, `dept_code`, `college_id`),
  INDEX `fk_faculty_department1_idx` (`dept_code` ASC, `college_id` ASC) VISIBLE,
  CONSTRAINT `fk_faculty_department1`
    FOREIGN KEY (`dept_code` , `college_id`)
    REFERENCES `university`.`department` (`dept_code` , `college_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `university`.`term`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`term` ;

CREATE TABLE IF NOT EXISTS `university`.`term` (
  `term_id` INT NOT NULL,
  `term_name` VARCHAR(25) NOT NULL,
  `year` INT NOT NULL,
  PRIMARY KEY (`term_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `university`.`section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`section` ;

CREATE TABLE IF NOT EXISTS `university`.`section` (
  `section_id` INT NOT NULL,
  `capacity` INT NULL DEFAULT NULL,
  `term_id` INT NOT NULL,
  `course_num` INT NOT NULL,
  `faculty_id` INT NOT NULL,
  `dept_code` VARCHAR(10) NOT NULL,
  `college_id` INT NOT NULL,
  `sec_number` INT NULL DEFAULT NULL,
  PRIMARY KEY (`section_id`, `term_id`, `course_num`, `faculty_id`, `dept_code`, `college_id`),
  INDEX `fk_section_term1_idx` (`term_id` ASC) VISIBLE,
  INDEX `fk_section_course1_idx` (`course_num` ASC) VISIBLE,
  INDEX `fk_section_faculty1_idx` (`faculty_id` ASC) VISIBLE,
  INDEX `fk_section_department1_idx` (`dept_code` ASC, `college_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_course1`
    FOREIGN KEY (`course_num`)
    REFERENCES `university`.`course` (`course_num`),
  CONSTRAINT `fk_section_department1`
    FOREIGN KEY (`dept_code` , `college_id`)
    REFERENCES `university`.`department` (`dept_code` , `college_id`),
  CONSTRAINT `fk_section_faculty1`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `university`.`faculty` (`faculty_id`),
  CONSTRAINT `fk_section_term1`
    FOREIGN KEY (`term_id`)
    REFERENCES `university`.`term` (`term_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `university`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`student` ;

CREATE TABLE IF NOT EXISTS `university`.`student` (
  `student_id` INT NOT NULL,
  `fname` VARCHAR(25) NOT NULL,
  `lname` VARCHAR(25) NOT NULL,
  `gender` ENUM('M', 'F') NOT NULL,
  `state` VARCHAR(10) NOT NULL,
  `dob` DATE NOT NULL,
  `city` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `university`.`enrollment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`enrollment` ;

CREATE TABLE IF NOT EXISTS `university`.`enrollment` (
  `student_id` INT NOT NULL,
  `section_id` INT NOT NULL,
  PRIMARY KEY (`student_id`, `section_id`),
  INDEX `fk_student_has_section_section1_idx` (`section_id` ASC) VISIBLE,
  INDEX `fk_student_has_section_student_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `fk_student_has_section_section1`
    FOREIGN KEY (`section_id`)
    REFERENCES `university`.`section` (`section_id`),
  CONSTRAINT `fk_student_has_section_student`
    FOREIGN KEY (`student_id`)
    REFERENCES `university`.`student` (`student_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

USE university;

# Insert statement college#
INSERT INTO `college` VALUES
 (1,'College of Physical Science and Engineering'),
 (2,'College of Business and Communication'),
 (3,'College of Language and Letter');
 SELECT * FROM college;
 
 # Insert Statement Course #
 SELECT * FROM course;
 INSERT INTO `course` VALUES 
 (111,'Introduction to Databases',2,'CIT',1),
 (150,'Micro Economics',3,'ECON',2),
 (376,'Classical Heritage',2,'HUM',3),
 (388,'Econometrics',4,'ECON',2);
 SELECT * FROM course;
 
 #Insert statement department #
 SELECT * FROM department;
 INSERT INTO `department` VALUES 
 ('CIT','Computer Information Technology',1),
 ('ECON','Economics',2),
 ('HUM','Humanities and Phylosophy',3);
 SELECT * FROM department;
 
 #Insert Statement enrollment#
 SELECT * FROM enrollment;
 INSERT INTO `enrollment` VALUES 
 (1,1),
 (2,4),
 (3,4),
 (5,4),
 (4,5),
 (5,5),
 (7,6),
 (10,6),
 (6,7),
 (7,8),
 (8,9),
 (9,9),
 (7,10);

SELECT * FROM enrollment;

#Insert Statement faculty#
SELECT * FROM faculty;
INSERT INTO `faculty` VALUES 
(1,'Marty','Morring','CIT',1),
(2,'Nate','Nathan','ECON',2),
(3,'Ben','Barrus','ECON',2),
(4,'John','Jensen','HUM',3),
(5,'Bill','Barney','CIT',1);
SELECT * FROM faculty;

# Insert Statement section #
SELECT * FROM section;
INSERT INTO `section` VALUES  
(1,30,1,111,1,'CIT',1,1),     
(2,50,1,150,2,'ECON',2,1),
(3,50,1,150,2,'ECON',2,2),
(4,35,1,388,3,'ECON',2,1),
(5,30,1,376,4,'HUM',3,1),
(6,30,2,111,1,'CIT',1,2),
(7,35,2,111,5,'CIT',1,3),
(8,50,2,150,2,'ECON',2,1),
(9,50,2,150,2,'ECON',2,2),
(10,30,2,376,4,'HUM',3,1); 
SELECT * FROM section;

# Insert Statement Student #
SELECT * FROM student;
INSERT INTO `student` VALUES 
(1,'Paul','Miller','M','TX','1996-02-22','Dallas'),
(2,'Katie','Smith','F','UT','1995-07-22','Provo'),
(3,'Kelly','Jones','F','UT','1998-06-22','Provo'),
(4,'Devon','Merrill','M','AZ','2000-07-22','Mesa'),
(5,'Mandy','Murdock','F','KS','1996-11-22','Topeka'),
(6,'Alece','Adams','F','ID','1997-05-22','Rigby'),
(7,'Bryce','Carlson','M','MT','1997-11-22','Bozeman'),
(8,'Preston','Larsen','M','TN','1996-09-22','Decatur'),
(9,'Julia','Madsen','F','ID','1998-09-22','Rexburg'),
(10,'Susan','Sorensen','F','AZ','1998-08-09','Mesa');
SELECT * FROM STUDENT;

# Insert term Statement #
SELECT * FROM term;

INSERT INTO `term` VALUES 
(1,'Fall',2019),
(2,'Winter',2018);
SELECT * FROM term;






