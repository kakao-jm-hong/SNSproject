-- MySQL Script generated by MySQL Workbench
-- Fri Jul 31 19:14:26 2020
-- Model: New Model    Version: 1.0
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
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `email` VARCHAR(255) NOT NULL,
  `nickname` VARCHAR(45) NOT NULL,
  `pwd` VARCHAR(32) NOT NULL,
  `name` VARCHAR(16) NOT NULL,
  `joindate` DATE NULL DEFAULT now(),
  `age` INT NULL,
  `gender` VARCHAR(10) NULL,
  `major` VARCHAR(45) NULL,
  `description` VARCHAR(1024) NULL,
  `address` VARCHAR(45) NULL,
  `src` VARCHAR(45) NULL,
  PRIMARY KEY (`email`),
  UNIQUE INDEX `nickname_UNIQUE` (`nickname` ASC));
-- -----------------------------------------------------
-- Table `mydb`.`feed`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`feed` (
  `no` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `nickname` VARCHAR(45) NOT NULL,
  `description` VARCHAR(1024) NOT NULL,
  `writedate` DATETIME NULL DEFAULT now(),
  `views` INT NULL DEFAULT 0,
  `tag` VARCHAR(255) NULL,
  `src` VARCHAR(512) NULL COMMENT 'feed represent file path\n',
  `category` VARCHAR(45) NULL,
  PRIMARY KEY (`no`, `email`),
  INDEX `fk_feed_user_idx` (`email` ASC),
  CONSTRAINT `fk_feed_user`
    FOREIGN KEY (`email`)
    REFERENCES `mydb`.`user` (`email`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`feedtag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`feedtag` (
  `no` INT NOT NULL,
  `tag` VARCHAR(45) NOT NULL,
  CONSTRAINT `fk_feedtag_feed`
    FOREIGN KEY (`no`)
    REFERENCES `mydb`.`feed` (`no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`feedimage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`feedimage` (
  `no` INT NOT NULL,
  `src` VARCHAR(512) NOT NULL,
  CONSTRAINT `fk_feedimage_feed`
    FOREIGN KEY (`no`)
    REFERENCES `mydb`.`feed` (`no`)
     ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`reply`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`reply` (
  `no` INT NOT NULL,
  `email` VARCHAR(255) NULL,
  `writedate` DATETIME NULL DEFAULT now(),
  `nickname` VARCHAR(45) NULL,
  `reply` VARCHAR(45) NULL,
  INDEX `no_idx` (`no` ASC),
  CONSTRAINT `fk_reply_feed`
    FOREIGN KEY (`no`)
    REFERENCES `mydb`.`feed` (`no`)
     ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`likefeed`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`likefeed` (
  `no` INT NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`no`, `email`),
  CONSTRAINT `fk_likefeed_feed`
    FOREIGN KEY (`no`)
    REFERENCES `mydb`.`feed` (`no`)
     ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`scrap`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`scrap` (
  `no` INT NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`no`, `email`),
  CONSTRAINT `fk_scrap_feed`
    FOREIGN KEY (`no` , `email`)
    REFERENCES `mydb`.`feed` (`no` , `email`)
     ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`follow`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`follow` (
  `email` VARCHAR(255) NOT NULL,
  `following` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`email`, `following`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`contest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`contest` (
  `de` INT NOT NULL,
  PRIMARY KEY (`de`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`contents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`contents` (
  `no` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `nickname` VARCHAR(45) NULL COMMENT '공모전 등록(admin)\n프로젝트 등록한 사람',
  `title` VARCHAR(45) NOT NULL,
  `category` INT NOT NULL,
  `description` VARCHAR(1024) NULL,
  `start` DATE NULL COMMENT '공모전 시작',
  `end` DATE NULL,
  `reward` VARCHAR(45) NULL,
  `host` VARCHAR(45) NULL COMMENT '주최기관',
  `imagesrc` VARCHAR(1024) NULL,
  `url` VARCHAR(1024) NULL COMMENT '공모전 사이트',
  `views` INT NULL DEFAULT 0 COMMENT '조회수',
  PRIMARY KEY (`no`, `email`),
  INDEX `nickname_idx` (`email` ASC),
  CONSTRAINT `fk_contents_user`
    FOREIGN KEY (`email`)
    REFERENCES `mydb`.`user` (`email`)
     ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'project와 contest 관리';
-- -----------------------------------------------------
-- Table `mydb`.`contentstag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`contentstag` (
  `no` INT NOT NULL,
  `tag` VARCHAR(45) NOT NULL,
  CONSTRAINT `fk_contentstag_contents`
    FOREIGN KEY (`no`)
    REFERENCES `mydb`.`contents` (`no`)
     ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`team`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`team` (
  `no` INT NOT NULL,
  `leaderemail` VARCHAR(255) NOT NULL,
  `title` VARCHAR(45) NULL,
  `local` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL COMMENT '팀 설명',
  INDEX `fk_team_user_idx` (`leaderemail` ASC),
  PRIMARY KEY (`no`, `leaderemail`),
  CONSTRAINT `fk_team_contents`
    FOREIGN KEY (`no`)
    REFERENCES `mydb`.`contents` (`no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_team_user`
    FOREIGN KEY (`leaderemail`)
    REFERENCES `mydb`.`user` (`email`)
     ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'team 등록';
-- -----------------------------------------------------
-- Table `mydb`.`teaminfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`teaminfo` (
  `no` INT NOT NULL,
  `leaderemail` VARCHAR(255) NOT NULL COMMENT '팀장',
  `part` VARCHAR(45) NULL COMMENT '분야\n백엔드, 프론트 엔드',
  `task` VARCHAR(2000) NULL COMMENT '업무',
  `ability` VARCHAR(2000) NULL COMMENT '필수역량',
  `advantage` VARCHAR(2000) NULL COMMENT '우대사항',
  `headcount` INT NULL COMMENT '필요한 인원 수',
  INDEX `fk_teaminfo_team1_idx` (`no` ASC, `leaderemail` ASC),
  CONSTRAINT `fk_teaminfo_team1`
    FOREIGN KEY (`no` , `leaderemail`)
    REFERENCES `mydb`.`team` (`no` , `leaderemail`)
     ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`member` (
  `no` INT NOT NULL,
  `leaderemail` VARCHAR(255) NOT NULL COMMENT '팀장 이름',
  `memberemail` VARCHAR(255) NOT NULL COMMENT '팀원의 nickname',
  `part` VARCHAR(45) NULL,
  PRIMARY KEY (`no`, `leaderemail`, `memberemail`),
  CONSTRAINT `fk_member_team1`
    FOREIGN KEY (`no` , `leaderemail`)
    REFERENCES `mydb`.`team` (`no` , `leaderemail`)
     ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `mydb`.`applymember`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`applymember` (
  `no` INT NOT NULL COMMENT '지원한 팀의 콘텐츠 번호',
  `leaderemail` VARCHAR(255) NOT NULL COMMENT '지원한 팀의 리더',
  `teamemail` VARCHAR(255) NOT NULL,
  `part` VARCHAR(45) NULL COMMENT '지원 분야',
  PRIMARY KEY (`no`, `leaderemail`, `teamemail`),
  CONSTRAINT `fk_applymember_team1`
    FOREIGN KEY (`no` , `leaderemail`)
    REFERENCES `mydb`.`team` (`no` , `leaderemail`)
     ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
USE `mydb`;
DELIMITER $$
USE `mydb`$$
$$
DELIMITER ;
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;