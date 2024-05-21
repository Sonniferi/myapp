/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80031 (8.0.31)
 Source Host           : localhost:3306
 Source Schema         : hkvideo

 Target Server Type    : MySQL
 Target Server Version : 80031 (8.0.31)
 File Encoding         : 65001

 Date: 21/05/2024 20:07:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '账号',
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '密码',
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `status` int NULL DEFAULT 1 COMMENT '状态：0-正常  1-禁用',
  `salt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '盐值,加密用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '管理员/审核员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '频道分类名',
  `summary` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '频道分类介绍',
  `img` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '封面图地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '频道分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `content` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '评论内容',
  `commtime` datetime NULL DEFAULT NULL COMMENT '评论时间',
  `uid` int NULL DEFAULT NULL COMMENT '用户id',
  `vid` int NULL DEFAULT NULL COMMENT '视频id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_comment_user_1`(`uid` ASC) USING BTREE,
  INDEX `fk_comment_video_1`(`vid` ASC) USING BTREE,
  CONSTRAINT `fk_comment_user_1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_comment_video_1` FOREIGN KEY (`vid`) REFERENCES `video` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for favorite
-- ----------------------------
DROP TABLE IF EXISTS `favorite`;
CREATE TABLE `favorite`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '收藏id',
  `uid` int NULL DEFAULT NULL COMMENT '用户id',
  `vid` int NULL DEFAULT NULL COMMENT '视频id',
  `favtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '收藏时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_favorite_user_1`(`uid` ASC) USING BTREE,
  INDEX `fk_favorite_video_1`(`vid` ASC) USING BTREE,
  CONSTRAINT `fk_favorite_user_1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_favorite_video_1` FOREIGN KEY (`vid`) REFERENCES `video` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '收藏表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '标识列(PK)，自动生成，且唯一',
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '密码',
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '手机号 唯一',
  `regtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间 精确到时分秒  yyyy-MM-dd HH:mm:ss',
  `img` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '头像图片存储地址(oss技术)',
  `birth` date NULL DEFAULT NULL COMMENT '生日格式yyyy-MM-dd',
  `status` int NULL DEFAULT 0 COMMENT '账号状态 0-正常    1-禁用',
  `salt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '盐值，加密用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '用户表\r\n' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for video
-- ----------------------------
DROP TABLE IF EXISTS `video`;
CREATE TABLE `video`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '标题',
  `summary` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '详情',
  `coverimg` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '封面图片地址',
  `url` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '视频文件地址',
  `releasetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  `viewcount` int NULL DEFAULT NULL COMMENT '观看数',
  `lovecount` int NULL DEFAULT NULL COMMENT '点赞数',
  `favcount` int NULL DEFAULT NULL COMMENT '收藏数',
  `forward` int NULL DEFAULT NULL COMMENT '转发数',
  `status` int NULL DEFAULT NULL COMMENT '视频状态：0-审核中  1-禁用   2-正常  ',
  `uid` int NULL DEFAULT NULL COMMENT '创作者',
  `aid` int NULL DEFAULT NULL COMMENT '审核员',
  `tags` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '标签',
  `cid` int NULL DEFAULT NULL COMMENT '频道分类',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_video_user_1`(`uid` ASC) USING BTREE,
  INDEX `fk_video_admin_1`(`aid` ASC) USING BTREE,
  INDEX `fk_video_category_1`(`cid` ASC) USING BTREE,
  CONSTRAINT `fk_video_admin_1` FOREIGN KEY (`aid`) REFERENCES `admin` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_video_category_1` FOREIGN KEY (`cid`) REFERENCES `category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_video_user_1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '视频表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
