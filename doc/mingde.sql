-- MySQL Script generated by MySQL Workbench
-- 08/08/16 10:45:44
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mingde
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mingde
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mingde` DEFAULT CHARACTER SET utf8 ;
USE `mingde` ;

-- -----------------------------------------------------
-- Table `mingde`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mingde`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `login_name` VARCHAR(20) NOT NULL,
  `login_pwd` VARCHAR(45) NOT NULL,
  `type` ENUM('admin', 'student') NOT NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `nickname` VARCHAR(45) NULL,
  `last_login_time` DATETIME NULL,
  `last_login_ip` VARCHAR(45) NULL,
  `created_on` DATETIME NULL,
  `modified_on` TIMESTAMP NULL DEFAULT  CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mingde`.`professions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mingde`.`professions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL COMMENT '专业名称',
  `created_on` DATETIME NULL,
  `modified_on` TIMESTAMP NULL DEFAULT  CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '专业表';


-- -----------------------------------------------------
-- Table `mingde`.`schools`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mingde`.`schools` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL COMMENT '学校名称',
  `created_on` DATETIME NULL,
  `modified_on` TIMESTAMP NULL DEFAULT  CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '学校表';


-- -----------------------------------------------------
-- Table `mingde`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mingde`.`students` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NULL COMMENT '姓名',
  `sex` ENUM('male','female') NULL COMMENT '性别',
  `cellphone` VARCHAR(20) NULL COMMENT '手机号',
  `qq` VARCHAR(20) NULL,
  `avatar` VARCHAR(255) NULL COMMENT '头像地址',
  `signature` VARCHAR(100) NULL COMMENT '个性签名',
  `user_id` INT NOT NULL,
  `profession_id` INT NULL,
  `school_id` INT NULL,
  `created_on` DATETIME NULL,
  `modified_on` TIMESTAMP NULL DEFAULT  CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_students_users_idx` (`user_id` ASC),
  INDEX `fk_students_professions1_idx` (`profession_id` ASC),
  INDEX `fk_students_schools1_idx` (`school_id` ASC),
  CONSTRAINT `fk_students_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `mingde`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_students_professions1`
    FOREIGN KEY (`profession_id`)
    REFERENCES `mingde`.`professions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_students_schools1`
    FOREIGN KEY (`school_id`)
    REFERENCES `mingde`.`schools` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mingde`.`resources`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mingde`.`resources` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `filename` VARCHAR(45) NULL COMMENT '文件名称',
  `filepath` VARCHAR(255) NOT NULL COMMENT '文件路径',
  `filesize` INT NULL COMMENT '文件大小',
  `mine_type` VARCHAR(200) NULL COMMENT '文件类型',
  `created_on` DATETIME NULL,
  `modified_on` TIMESTAMP NULL DEFAULT  CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mingde`.`posts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mingde`.`posts` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NULL COMMENT '主题',
  `content` TEXT NULL COMMENT '内容',
  `type` VARCHAR(45) NULL COMMENT '类型',
  `view_count` INT NOT NULL DEFAULT 0 COMMENT '浏览量',
  `comment_count` INT NOT NULL DEFAULT 0 COMMENT '评论数',
  `favorite_count` INT NOT NULL DEFAULT 0 COMMENT '点赞数',
  `collected_count` INT NOT NULL DEFAULT 0 COMMENT '转发次数',
  `forward_count` INT NOT NULL DEFAULT 0,
  `longitude` VARCHAR(45) NULL COMMENT '经度',
  `latitude` VARCHAR(45) NULL COMMENT '纬度',
  `place` VARCHAR(45) NULL COMMENT '发帖地址',
  `cover` INT UNSIGNED NULL COMMENT '图片',
  `user_id` INT NOT NULL,
  `created_on` DATETIME NULL,
  `modified_on` TIMESTAMP NULL DEFAULT  CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_posts_users1_idx` (`user_id` ASC),
  INDEX `fk_posts_resources1_idx` (`cover` ASC),
  CONSTRAINT `fk_posts_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mingde`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_posts_resources1`
    FOREIGN KEY (`cover`)
    REFERENCES `mingde`.`resources` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '帖子';


-- -----------------------------------------------------
-- Table `mingde`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mingde`.`comments` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(200) NULL COMMENT '评论内容',
  `post_id` INT UNSIGNED NOT NULL,
  `user_id` INT NOT NULL,
  `created_on` DATETIME NULL,
  `modified_on` TIMESTAMP NULL DEFAULT  CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_comments_users1_idx` (`user_id` ASC),
  INDEX `fk_comments_posts1_idx` (`post_id` ASC),
  CONSTRAINT `fk_comments_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mingde`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_posts1`
    FOREIGN KEY (`post_id`)
    REFERENCES `mingde`.`posts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '评论';


-- -----------------------------------------------------
-- Table `mingde`.`user_focus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mingde`.`user_focus` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL COMMENT '关注者',
  `target_id` INT NOT NULL COMMENT '被关注者',
  `has_new` TINYINT NOT NULL DEFAULT 0 COMMENT '是否有新消息',
  `created_on` DATETIME NULL,
  `modified_on` TIMESTAMP NULL DEFAULT  CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_user_focus_users1_idx` (`user_id` ASC),
  INDEX `fk_user_focus_users2_idx` (`target_id` ASC),
  CONSTRAINT `fk_user_focus_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mingde`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_focus_users2`
    FOREIGN KEY (`target_id`)
    REFERENCES `mingde`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '用户关注';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;