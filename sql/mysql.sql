CREATE TABLE IF NOT EXISTS `sessions` (
    id           CHAR(72) PRIMARY KEY,
    session_data TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `user_data` (
  `user_id` INT NOT NULL,
  `user_name` VARCHAR(50) NOT NULL,
  `user_name_suffix_type` TINYINT NOT NULL,
  `password`  VARCHAR(50) NOT NULL,
  `created_at` INT NOT NULL,
  `status` TINYINT NOT NULL,
  PRIMARY KEY (`user_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `user_relation` (
  `study_user_id` INT NOT NULL,
  `admin_user_id` INT NOT NULL,
  `status` TINYINT NOT NULL,
  PRIMARY KEY (`study_user_id`,`admin_user_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `user_study_log` (
  `user_id` INT NOT NULL,
  `study_time` SMALLINT NOT NULL,
  `studied_at` INT NOT NULL,
  PRIMARY KEY (`user_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `user_contents_study_log` (
  `user_id` INT NOT NULL,
  `contents_id` INT NOT NULL,
  `study_start_time` INT NOT NULL,
  `study_end_time` INT NOT NULL,
  `study_status` TINYINT NOT NULL,
  PRIMARY KEY (`user_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `user_contents_item_study_log` (
  `user_id` INT NOT NULL,
  `contents_item_id` INT NOT NULL,
  `study_end_time` INT NOT NULL,
  KEY (`user_id`,`contents_item_id`),
  UNIQUE  (`user_id`,`study_end_time`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `user_review_contents_item` (
  `user_id` INT NOT NULL,
  `contents_item_id` INT NOT NULL,
  `review_count` TINYINT NOT NULL,
  `review_at` INT NOT NULL,
  PRIMARY KEY (`user_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `contents` (
  `contents_id` INT NOT NULL,
  `contents_name` VARCHAR(255) NOT NULL,
  `grade_id` INT NOT NULL,
  `subject_id` INT NOT NULL,
  `contents_owner_id` INT NOT NULL,
  `status` TINYINT NOT NULL,
  PRIMARY KEY (`contents_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT IGNORE INTO `contents` VALUES (1, 'なんばんめ', 1, 1, 1, 1);
INSERT IGNORE INTO `contents` VALUES (2, '足し算', 1, 1, 1, 1);
CREATE TABLE IF NOT EXISTS `contents_item` (
  `contents_item_id` INT NOT NULL,
  `contents_id` INT NOT NULL,
  `contents_name` VARCHAR(255) NOT NULL,
  `contents_body` TEXT NOT NULL,
  `contents_type` TINYINT NOT NULL,
  `status` TINYINT NOT NULL,
  PRIMARY KEY (`contents_item_id`,`contents_id`,`contents_type`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT IGNORE INTO `contents_item` VALUES (1, 1, '前後・上下', '{[{"order":1,"content":{"type":1,"name":"左右で考える","q":"ねぎは、ひだりから、なんばんめですか？","choices":{"1":"1ばんめ","2":"2ばんめ","3":"3ばんめ","4":"4ばんめ"},"a":"4"},"source":{"img_path":"/static/contents/1676.jpg"}},{"order":2,"content":{"type":1,"name":"左右で考える","q":"とまとは、みぎから、なんばんめですか？","choices":{"1":"2ばんめ","2":"3ばんめ","3":"4ばんめ","4":"5ばんめ"},"a":"2"},"source":{"img_path":"/static/contents/1676.jpg"}},{"order":3,"content":{"type":1,"name":"左右で考える","q":"ひだりから、３なんばんめは、なんですか？","choices":{"1":"にんじん","2":"たまねぎ","3":"ねぎ","4":"とまと"},"a":"2"},"source":{"img_path":"/static/contents/1676.jpg"}}]}', 1, 1);
CREATE TABLE IF NOT EXISTS `contents_owner` (
  `contents_owner_id` INT NOT NULL,
  `contents_owner_name` VARCHAR(255) NOT NULL,
  `status` TINYINT NOT NULL,
  PRIMARY KEY (`contents_owner_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `grade` (
  `grade_id` INT NOT NULL,
  `grade_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`grade_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT IGNORE INTO `grade` VALUES (11, '小学校１年生');
INSERT IGNORE INTO `grade` VALUES (12, '小学校２年生');
CREATE TABLE IF NOT EXISTS `subject` (
  `subject_id` INT NOT NULL,
  `subject_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`subject_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT IGNORE INTO `subject` VALUES (1, '算数');
INSERT IGNORE INTO `subject` VALUES (2, '国語');
CREATE TABLE IF NOT EXISTS `sticker` (
  `sticker_id` INT NOT NULL,
  `sticker_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`sticker_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `user_sticker` (
  `user_id` INT NOT NULL,
  `sticker_id` INT NOT NULL,
  `get_time` INT NOT NULL,
  `use_place` INT NOT NULL,
  `use_time` INT NOT NULL,
  `use_status` TINYINT NOT NULL,
  KEY (`user_id`, `sticker_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `user_schedule` (
  `user_id` INT NOT NULL,
  `next_time` INT NOT NULL,
  `created_at` INT NOT NULL,
  KEY (`user_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
