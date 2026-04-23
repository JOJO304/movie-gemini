/*
 Navicat Premium Data Transfer

 Source Server         : localmysql
 Source Server Type    : MySQL
 Source Server Version : 80031
 Source Host           : localhost:3306
 Source Schema         : movie

 Target Server Type    : MySQL
 Target Server Version : 80031
 File Encoding         : 65001

 Date: 22/03/2024 21:12:46
*/
DROP DATABASE IF EXISTS movie ;
CREATE DATABASE movie CHARACTER SET utf8;
use movie ;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_bill
-- ----------------------------
DROP TABLE IF EXISTS `sys_bill`;
CREATE TABLE `sys_bill`  (
  `bill_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '订单编号',
  `pay_state` tinyint NOT NULL DEFAULT 0 COMMENT '支付状态，0未支付，1已支付',
  `cancel_state` tinyint NOT NULL DEFAULT 0 COMMENT '取消状态，0未取消，1取消',
  `user_id` bigint UNSIGNED NOT NULL COMMENT '用户编号',
  `session_id` bigint UNSIGNED NOT NULL COMMENT '场次编号',
  `seats` json NOT NULL COMMENT '购买的座位号',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `deadline` datetime(0) NULL DEFAULT NULL COMMENT '失效时间',
  `cancel_time` datetime(0) NULL DEFAULT NULL COMMENT '取消时间',
  PRIMARY KEY (`bill_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 111 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_bill
-- ----------------------------
INSERT INTO `sys_bill` VALUES (112, 1, 0, 30, 75, '[\"1排8座\"]', '2024-03-22 21:07:49', '2024-03-22 21:22:41', NULL);
INSERT INTO `sys_bill` VALUES (113, 1, 0, 30, 76, '[\"3排7座\", \"3排8座\"]', '2024-03-22 21:08:55', '2024-03-22 21:23:51', NULL);

-- ----------------------------
-- Table structure for sys_cinema
-- ----------------------------
DROP TABLE IF EXISTS `sys_cinema`;
CREATE TABLE `sys_cinema`  (
  `cinema_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '影院编号',
  `cinema_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '影院名称',
  `hall_category_list` json NULL COMMENT '拥有影厅类别',
  `cinema_picture` json NULL COMMENT '影院图片',
  `cinema_phone` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '影院电话',
  `cinema_address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '影院地址',
  `work_start_time` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '开始营业时间',
  `work_end_time` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '结束营业时间',
  PRIMARY KEY (`cinema_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_cinema
-- ----------------------------
INSERT INTO `sys_cinema` VALUES (1, '机电影城', '[\"激光厅\", \"IMAX厅\", \"4DX厅\", \"DTS:X 临镜音厅\", \"儿童厅\", \"4K厅\", \"60帧厅\", \"巨幕厅\", \"MX4D厅\", \"私人定制\", \"5D\"]', '[\"/images/cinema/2024/03/09/039c3745985643a7a22406cd2d6581b9.jpg\"]', '088-80888848', '湖南机电旁', '00:00', '23:59');

-- ----------------------------
-- Table structure for sys_hall
-- ----------------------------
DROP TABLE IF EXISTS `sys_hall`;
CREATE TABLE `sys_hall`  (
  `hall_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '影厅编号',
  `cinema_id` bigint UNSIGNED NOT NULL DEFAULT 1 COMMENT '影院编号',
  `hall_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '影厅名称',
  `hall_category` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '影厅类别',
  `row_start` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '1' COMMENT '排开始编号',
  `row_nums` smallint UNSIGNED NOT NULL DEFAULT 10 COMMENT '总排数',
  `seat_nums_row` smallint UNSIGNED NOT NULL DEFAULT 18 COMMENT '每排的座位数',
  `seat_nums` smallint UNSIGNED NOT NULL DEFAULT 180 COMMENT '总可用座位数',
  `seat_state` json NOT NULL COMMENT '座位的状态',
  `del_state` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`hall_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_hall
-- ----------------------------
INSERT INTO `sys_hall` VALUES (1, 1, '1号激光厅', '激光厅', '1', 10, 10, 100, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 0);
INSERT INTO `sys_hall` VALUES (2, 1, '2号厅', 'IMAX厅', '1', 10, 11, 110, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 0);
INSERT INTO `sys_hall` VALUES (3, 1, '3号厅', '杜比全景声厅', '1', 7, 7, 49, '{\"1\": [0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0]}', 0);
INSERT INTO `sys_hall` VALUES (4, 1, '4号厅', 'RealD 6FLag厅', '1', 15, 15, 225, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"11\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"12\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"13\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"14\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"15\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 0);
INSERT INTO `sys_hall` VALUES (5, 1, '5号厅', 'DTS:X 临镜音厅', '1', 10, 10, 92, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [1, 0, 0, 0, 0, 0, 0, 0, 0, 1], \"8\": [1, 0, 0, 0, 0, 0, 0, 0, 0, 1], \"9\": [1, 0, 0, 0, 0, 0, 0, 0, 0, 1], \"10\": [1, 0, 0, 0, 0, 0, 0, 0, 0, 1]}', 0);
INSERT INTO `sys_hall` VALUES (6, 1, '6号厅', '巨幕厅', '1', 18, 18, 324, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"11\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"12\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"13\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"14\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"15\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"16\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"17\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"18\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 0);
INSERT INTO `sys_hall` VALUES (7, 1, '7号IMAX4D厅', 'MX4D厅', '1', 15, 18, 246, '{\"1\": [1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1], \"2\": [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1], \"3\": [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"11\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"12\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"13\": [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1], \"14\": [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1], \"15\": [1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1]}', 0);
INSERT INTO `sys_hall` VALUES (8, 1, '8号厅', '激光厅', '1', 10, 15, 100, '{\"1\": [0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1], \"2\": [0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1], \"3\": [0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1], \"4\": [0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1], \"5\": [0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1], \"6\": [0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1], \"7\": [0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1], \"8\": [0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1], \"9\": [0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1], \"10\": [0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1]}', 0);
INSERT INTO `sys_hall` VALUES (9, 1, '9号IMAX厅', 'IMAX厅', '1', 18, 18, 324, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"11\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"12\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"13\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"14\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"15\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"16\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"17\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"18\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 0);
INSERT INTO `sys_hall` VALUES (10, 1, '10号激光厅', '激光厅', '1', 10, 15, 150, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 0);
INSERT INTO `sys_hall` VALUES (42, 1, '私人定制', '4DX厅', '3', 10, 10, 100, '{\"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"11\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"12\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 0);

-- ----------------------------
-- Table structure for sys_movie
-- ----------------------------
DROP TABLE IF EXISTS `sys_movie`;
CREATE TABLE `sys_movie`  (
  `movie_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '电影编号',
  `movie_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '电影名称',
  `movie_length` int NULL DEFAULT NULL COMMENT '电影时长',
  `movie_poster` varchar(10000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电影海报',
  `movie_area` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电影区域',
  `release_date` datetime(0) NULL DEFAULT NULL COMMENT '上映时间',
  `movie_box_office` decimal(20, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '电影总票房',
  `movie_introduction` varchar(10000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电影简介',
  `movie_pictures` json NULL COMMENT '电影图集',
  `del_state` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`movie_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_movie
-- ----------------------------
INSERT INTO `sys_movie` VALUES (1, '长津湖', 176, '[\"/images/movie/2024/03/09/472a712daf074850ad12c5a7e60c6d9f.jpg\"]', '中国大陆', '2024-03-10 09:30:00', 1000269.00, '电影《长津湖》以抗美援朝战争第二次战役中的长津湖战役为背景，讲述了一段波澜壮阔的历史：71年前，中国人民志愿军赴朝作战，在极寒严酷环境下，东线作战部队凭着钢铁意志和英勇无畏的战斗精神一路追击，奋勇杀敌，扭转了战场态势，打出了军威国威。', '[\"/images/movie/2024/03/09/14ec328423b24574b4215a0db87fe874.jpg\"]', 0);
INSERT INTO `sys_movie` VALUES (2, '狙击手', 96, '[\"/images/movie/2024/03/09/ff438c494d2043f7ba943d41dcc65a92.jpg\"]', '中国大陆', '2024-03-08 08:00:00', 100335.00, '影片根据抗美援朝战争“冷枪冷炮”运动中神枪手群体事迹改编。1952年冬至1953年初，中国人民志愿军与联合国军在朝鲜战场形成僵持，双方发起了低强度的密集狙击战，史称“冷枪冷炮运动”。在连长（张译 饰）带领下的狙击五班战士枪法过人，成为敌军的心头大患，班长刘文武（章宇 饰）更成为重点狙击对象。为重创狙击五班，敌方调配精英狙击小队，配以最先进的武器装备，更迫使狙击五班战士大永（陈永胜 饰）等人为救同伴进入其设好的险境之地。但正当敌军打响自己如意算盘之时，他们未料到，被他们当作诱饵的侦察兵亮亮（刘奕铁 饰）身上其实隐藏着更大的秘密......', '[]', 0);
INSERT INTO `sys_movie` VALUES (3, '长津湖之水门桥', 149, '[\"/images/movie/2024/03/09/bb330b1c87c244adb53fc67a45360ab8.png\"]', '中国大陆', '2024-02-01 08:00:00', 9999999.00, '电影《长津湖之水门桥》以抗美援朝战争第二次战役中的长津湖战役为背景，讲述了在结束了新兴里和下碣隅里的战斗之后，七连战士们又接到了更艰巨的任务.....', '[\"/images/movie/2024/03/09/16a1afa442b746dfa558293d0759bd45.jpg\", \"/images/movie/2024/03/09/a68eaea237314497ad612471a5ff88bd.jpg\", \"/images/movie/2024/03/09/5afd6cf4e05a46379a47db2c14969f90.jpg\", \"/images/movie/2024/03/09/1e708013824e4ce58aeb2d30205c1c0a.jpg\"]', 0);
INSERT INTO `sys_movie` VALUES (4, '奇迹·笨小孩', 106, '[\"/images/movie/2024/03/09/b2184aa3ceff4a4e885e37939600002a.jpg\"]', '中国大陆', '2024-03-06 08:00:00', 889344.00, '二十岁的景浩（易烊千玺 饰）独自带着年幼的妹妹来到深圳生活，兄妹俩生活温馨却拮据。机缘巧合之下，景浩得到一个机会，本以为美好生活即将来临，却不料遭遇重创。在时间和金钱的双重压力下，毫无退路的景浩决定孤注一掷，而他陷入困境的平凡人生，又能否燃起希望的火花？电影《奇迹·笨小孩》是中宣部国家电影局 2021 年重点电影项目，也是 2021 年重点建党百年献礼片，描述十八大以后新时代年轻人在深圳创业的影片。', '[\"/images/movie/2024/03/09/51c7a41449ba4663b1d82e5e1bfdc510.jpg\"]', 0);
INSERT INTO `sys_movie` VALUES (5, ' 断·桥', 148, '[\"/images/movie/2024/03/09/f6b8dc9065614874957083002da63b2f.jpg\"]', '中国大陆', '2024-06-02 00:00:00', 0.00, '黄雀市大桥突然垮塌，桥墩中一副被活埋多年的人骨赫然惊现。死者女儿闻晓雨（马思纯 饰）为追查父亲死因，得到一个自称孟超（王俊凯 饰）的男孩协助，并携手走上探寻真相与复仇之路。渐渐地，他们发现，闻晓雨的养父朱方正（范伟 饰）很可能就是杀人凶手，而他背后似乎隐藏着惊天的秘密…', '[\"/images/movie/2024/03/09/0efbcde195184fa1b25fa3a828cd1a47.jpg\"]', 0);
INSERT INTO `sys_movie` VALUES (6, '维和防暴队', 120, '[\"/images/movie/2024/03/09/8318b3cc8f254e9096f4b90d93975221.jpg\"]', '中国大陆', '2024-05-05 00:00:00', 0.00, '影片聚焦中国维和警察，讲述中国维和警察防暴队在海外执行任务的故事。他们头戴蓝盔，全副武装，在危险中前行，枕着枪声入眠，只为维护世界的安全与和平。这一次，维和防暴队的成员们将如何应对全新的严峻挑战……', '[]', 0);
INSERT INTO `sys_movie` VALUES (7, '神秘海域', 169, '[\"/images/movie/2024/03/09/e779ab034a6a453887bce7b1034bf174.jpg\"]', '美国', '2024-03-14 09:00:00', 0.00, '足智多谋的内森·德雷克（汤姆·赫兰德 饰）和经验丰富的寻宝者维克多·苏利文（马克·沃尔伯格 饰）组成搭档，追寻费迪南·麦哲伦500年前遗失的宝藏。一开始，这似乎只是个简单的寻宝工作，但很快演变成了一场惊险刺激、横跨全球的竞赛。他们必须赶在冷酷无情的蒙卡达（安东尼奥·班德拉斯 饰）之前寻得宝藏。蒙卡达坚信他和他的家族才是宝藏的正当继承人。若内森和苏利文能破译线索，解开这世界上最古老的谜团，他们便能找到价值50亿美元的宝藏，甚至还可能找到内森失踪已久的哥哥…但首先，他们必须学会通力合作。', '[\"/images/movie/2024/03/09/193302ea8eaa407b9e463d271ff18c11.jpg\"]', 0);
INSERT INTO `sys_movie` VALUES (8, '外太空的莫扎特', 120, '[\"/images/movie/2024/03/09/a54b5d0a76f2405995beb5ca0af4edfb.jpg\"]', '中国大陆', '2024-04-01 00:00:00', 0.00, '任大望（黄渤 饰）一心想把喜好天文的儿子任小天（荣梓杉 饰）培养成钢琴演奏家，为此父子争吵不断。一天，神秘外星人莫扎特意外出现，从此，莫扎特帮助任小天开启了和爸爸“斗智斗勇”的生活。令任小天没有想到的是，莫扎特来到地球竟另有任务……', '[]', 0);
INSERT INTO `sys_movie` VALUES (9, '明日战记', 136, '[\"/images/movie/2024/03/09/98e5ef3869b94e6aa120ceab3abd9dd9.jpg\"]', '中国香港', '2024-05-05 00:00:00', 0.00, '《明日战记》的故事设定在2055年，那时候的地球深受污染和全球变暖问题的困扰，一颗陨石击中地球，带来一种快速生长的触须类外星生物，它在净化地球的同时，也在杀死一切生命。拯救地球的任务落在了一支精英部队身上。在与外星生物作战的同时，他们也发现了一个惊天阴谋……', '[]', 0);
INSERT INTO `sys_movie` VALUES (10, '龙马精神', 142, '[\"/images/movie/2024/03/09/029b9834fd5c42b289a5ea94612cd80d.jpg\"]', '中国大陆', '2024-12-31 00:00:00', 0.00, '曾经风光一时，如今落魄的龙虎武师老罗（成龙 饰）与爱马赤兔相依为命。因赤兔卷入了一起债务纠纷，面临着“父子分离”的危机。情急之下，老罗向存在多年误会的女儿小宝（刘浩存 饰）和其男友乃华（郭麒麟 饰）求救。在三人一马的自救之路中，闹出不少笑话，也渐渐靠近彼此……', '[\"/images/movie/2024/03/09/bcf4783fac944b2aa02c8523af081862.jpg\"]', 0);
INSERT INTO `sys_movie` VALUES (11, '我和我的祖国', 155, '[\"/images/movie/2024/03/09/f85926f452864b01a8f54347c1a5b7d7.jpg\"]', '中国大陆', '2021-10-01 00:00:00', 1000000088.00, '七位导演分别取材新中国成立70周年以来，祖国经历的无数个历史性经典瞬间。讲述普通人与国家之间息息相关密不可分的动人故事。聚焦大时代大事件下，小人物和国家之间，看似遥远实则密切的关联，唤醒全球华人共同回忆。', '[]', 0);
INSERT INTO `sys_movie` VALUES (12, '速度与激情9', 142, '[\"/images/movie/2024/03/09/f6ffc5ecedd942249aab0076c34c18f9.jpg\"]', '美国', '2021-05-21 00:00:00', 156487.00, '范·迪塞尔饰演的唐老大多姆·托莱多，与莱蒂和他的儿子小布莱恩，过上了远离纷扰的平静生活。然而他们也知道，安宁之下总潜藏着危机。这一次，为了保护他所爱的人，唐老大不得不直面过去。他和伙伴们面临的是一场足以引起世界动荡的阴谋，以及一个前所未遇的一流杀手和高能车手。而这个名叫雅各布（约翰·塞纳饰）的人，恰巧是多姆遗落在外的亲弟弟。', '[]', 0);
INSERT INTO `sys_movie` VALUES (13, ' 指环王：双塔奇兵', 182, '[\"/images/movie/2024/03/09/c8e3942d78f84a6ba0136df334f02639.jpg\"]', '美国', '2012-03-09 14:42:54', 260.00, '护戒联盟中的哈比人梅里与皮平被奥克斯掳走，护戒使者们不得不分头行事。弗拉多与好友山姆继续向索隆领地莫都进发，途中他们制服了也在疯狂寻找魔戒的怪物 古鲁姆，魔戒曾经为他带来了长寿与隐身之道直到弗拉多的前辈毕尔博拿走了这枚戒指。', '[]', 0);
INSERT INTO `sys_movie` VALUES (14, '复仇者联盟4：终局之战', 180, '[\"/images/movie/2024/03/09/6f10d729472549bf9f4cf2fb48436174.jpg\"]', '美国', '2019-04-24 00:00:00', 865492.00, '来自泰坦星的 灭霸为了解决宇宙资源匮乏、人口暴增的问题，集齐了所有 无限宝石，一个响指成功地使全宇宙生命随机减半。宇宙由于灭霸的行动而变得满目疮痍，但是五年之后，被困在量子领域的 蚁人意外回到现实世界，他的出现为幸存的复仇者点燃了希望。无备捆拔论前方将遭遇怎样的后果，幸存的复仇者都必须在剩余盟友的帮助下再一次集结，以逆转灭霸的所作所为，彻底恢复宇宙的秩序。', '[\"/images/movie/2024/03/09/06ab257ccdb547a38383f20d2670c1aa.jpg\"]', 0);
INSERT INTO `sys_movie` VALUES (15, ' 这个杀手不太冷静', 109, '[\"/images/movie/2024/03/09/1765f51dc9264a639d75d284aad201ec.jpg\"]', '中国大陆', '2024-03-08 00:00:00', 420.00, '马丽魏翔上演2024开年第一喜剧，平台高分好评如潮！《夏洛特烦恼》《西虹市首富》导演闫非、彭大魔监制，邢文雄执导，马丽、魏翔等喜剧人主演，携手打造爆笑“杀手奇遇”！小人物龙套演员魏成功（魏翔 饰）得到当红女星米兰（马丽 饰）“赏识”，被邀请出演男一号神秘杀手，却没想到这一切竟是一场危机四伏的“戏中戏”、“局中局”。被蒙在鼓里的魏成功数次凭借自己的演技和好运化险为夷，而这场阴谋却逐渐失控，残酷的真相也离他越来越近……', '[\"/images/movie/2024/03/09/85b0fd94ba49451d89cdb82b56cc9660.jpg\"]', 0);
INSERT INTO `sys_movie` VALUES (16, '我们的冬奥', 90, '[\"/images/movie/2024/03/09/81d6e01f0b094708920f42eaa45dd264.jpg\"]', '中国大陆', '2024-03-08 00:00:00', 132.00, '冰墩墩雪容融领衔主演，冬奥会唯一授权动画电影，打造年后最好看的动画电影! 小光头强与小熊大熊二帮冰墩墩雪容融从暴风雪中脱险成功参加奥运村的开村典礼；九月偶然“捡到”冰墩墩，将其送回的同时收获完美假期；小虎妞在玩具的鼓励下勇敢面对挑战；大圣借“冰器”时遇到图图一起参加天宫冰雪大会。从孙悟空到非人哉，片中集合30多位知名IP动画角色热血集结，唤醒五代人的童年回忆。', '[\"/images/movie/2024/03/09/426c0e98c9304ab5a480e92f0a2ab47e.jpg\"]', 0);
INSERT INTO `sys_movie` VALUES (46, '1', 1111, '[]', '中国大陆', '2024-03-31 00:00:00', 0.00, '11', '[]', 1);

-- ----------------------------
-- Table structure for sys_movie_category
-- ----------------------------
DROP TABLE IF EXISTS `sys_movie_category`;
CREATE TABLE `sys_movie_category`  (
  `movie_category_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '电影类别编号',
  `movie_category_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '电影类别名称',
  PRIMARY KEY (`movie_category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_movie_category
-- ----------------------------
INSERT INTO `sys_movie_category` VALUES (1, '爱情');
INSERT INTO `sys_movie_category` VALUES (2, '喜剧');
INSERT INTO `sys_movie_category` VALUES (3, '动画');
INSERT INTO `sys_movie_category` VALUES (4, '剧情');
INSERT INTO `sys_movie_category` VALUES (5, '恐怖');
INSERT INTO `sys_movie_category` VALUES (6, '动作');
INSERT INTO `sys_movie_category` VALUES (7, '科幻');
INSERT INTO `sys_movie_category` VALUES (8, '悬疑');
INSERT INTO `sys_movie_category` VALUES (9, '惊悚');
INSERT INTO `sys_movie_category` VALUES (10, '犯罪');
INSERT INTO `sys_movie_category` VALUES (11, '冒险');
INSERT INTO `sys_movie_category` VALUES (12, '战争');
INSERT INTO `sys_movie_category` VALUES (13, '奇幻');
INSERT INTO `sys_movie_category` VALUES (14, '运动');
INSERT INTO `sys_movie_category` VALUES (15, '励志');
INSERT INTO `sys_movie_category` VALUES (16, '古装');
INSERT INTO `sys_movie_category` VALUES (17, '武侠');
INSERT INTO `sys_movie_category` VALUES (19, '历史');

-- ----------------------------
-- Table structure for sys_movie_to_category
-- ----------------------------
DROP TABLE IF EXISTS `sys_movie_to_category`;
CREATE TABLE `sys_movie_to_category`  (
  `movie_id` bigint UNSIGNED NOT NULL COMMENT '电影编号',
  `movie_category_id` bigint UNSIGNED NOT NULL COMMENT '电影类别编号',
  PRIMARY KEY (`movie_id`, `movie_category_id`) USING BTREE,
  INDEX `movie_category_id`(`movie_category_id`) USING BTREE,
  CONSTRAINT `sys_movie_to_category_ibfk_1` FOREIGN KEY (`movie_category_id`) REFERENCES `sys_movie_category` (`movie_category_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_movie_to_category
-- ----------------------------
INSERT INTO `sys_movie_to_category` VALUES (10, 2);
INSERT INTO `sys_movie_to_category` VALUES (15, 2);
INSERT INTO `sys_movie_to_category` VALUES (16, 3);
INSERT INTO `sys_movie_to_category` VALUES (2, 4);
INSERT INTO `sys_movie_to_category` VALUES (4, 4);
INSERT INTO `sys_movie_to_category` VALUES (8, 4);
INSERT INTO `sys_movie_to_category` VALUES (11, 4);
INSERT INTO `sys_movie_to_category` VALUES (16, 4);
INSERT INTO `sys_movie_to_category` VALUES (7, 6);
INSERT INTO `sys_movie_to_category` VALUES (13, 6);
INSERT INTO `sys_movie_to_category` VALUES (14, 6);
INSERT INTO `sys_movie_to_category` VALUES (12, 10);
INSERT INTO `sys_movie_to_category` VALUES (7, 11);
INSERT INTO `sys_movie_to_category` VALUES (12, 11);
INSERT INTO `sys_movie_to_category` VALUES (13, 11);
INSERT INTO `sys_movie_to_category` VALUES (1, 12);
INSERT INTO `sys_movie_to_category` VALUES (2, 12);
INSERT INTO `sys_movie_to_category` VALUES (3, 12);
INSERT INTO `sys_movie_to_category` VALUES (8, 13);
INSERT INTO `sys_movie_to_category` VALUES (9, 13);
INSERT INTO `sys_movie_to_category` VALUES (14, 13);
INSERT INTO `sys_movie_to_category` VALUES (4, 15);
INSERT INTO `sys_movie_to_category` VALUES (1, 19);
INSERT INTO `sys_movie_to_category` VALUES (2, 19);
INSERT INTO `sys_movie_to_category` VALUES (3, 19);

-- ----------------------------
-- Table structure for sys_resource
-- ----------------------------
DROP TABLE IF EXISTS `sys_resource`;
CREATE TABLE `sys_resource`  (
  `resource_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '资源编号',
  `resource_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '菜单名称',
  `path` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '菜单路径，用于保存页面地址',
  `level` int UNSIGNED NOT NULL DEFAULT 1 COMMENT '资源权限等级,1表示该资源为最高级权限',
  `parent_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '当前菜单父菜单编号',
  PRIMARY KEY (`resource_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 623 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_resource
-- ----------------------------
INSERT INTO `sys_resource` VALUES (1, '影院管理', '', 1, 0);
INSERT INTO `sys_resource` VALUES (2, '电影管理', '', 1, 0);
INSERT INTO `sys_resource` VALUES (3, '影厅管理', '', 1, 0);
INSERT INTO `sys_resource` VALUES (4, '订单管理', '', 1, 0);
INSERT INTO `sys_resource` VALUES (5, '用户管理', '', 1, 0);
INSERT INTO `sys_resource` VALUES (6, '权限管理', '', 1, 0);
INSERT INTO `sys_resource` VALUES (11, '影院信息管理', 'cinema', 2, 1);
INSERT INTO `sys_resource` VALUES (21, '电影信息管理', 'movie', 2, 2);
INSERT INTO `sys_resource` VALUES (22, '电影类别管理', 'movieCategory', 2, 2);
INSERT INTO `sys_resource` VALUES (31, '影厅信息管理', 'hall', 2, 3);
INSERT INTO `sys_resource` VALUES (32, '场次信息管理', 'session', 2, 3);
INSERT INTO `sys_resource` VALUES (41, '订单信息管理', 'bill', 2, 4);
INSERT INTO `sys_resource` VALUES (51, '用户信息管理', 'user', 2, 5);
INSERT INTO `sys_resource` VALUES (61, '角色信息管理', 'role', 2, 6);
INSERT INTO `sys_resource` VALUES (62, '资源信息管理', 'resource', 2, 6);
INSERT INTO `sys_resource` VALUES (111, '查询影院信息权限', '', 3, 11);
INSERT INTO `sys_resource` VALUES (112, '修改影院信息权限', '', 3, 11);
INSERT INTO `sys_resource` VALUES (211, '查询电影信息权限', '', 3, 21);
INSERT INTO `sys_resource` VALUES (212, '修改电影信息权限', '', 3, 21);
INSERT INTO `sys_resource` VALUES (221, '查询电影类别权限', '', 3, 22);
INSERT INTO `sys_resource` VALUES (222, '修改电影类别权限', '', 3, 22);
INSERT INTO `sys_resource` VALUES (311, '查询影厅信息权限', '', 3, 31);
INSERT INTO `sys_resource` VALUES (312, '修改影厅信息权限', '', 3, 31);
INSERT INTO `sys_resource` VALUES (321, '查询场次信息权限', '', 3, 32);
INSERT INTO `sys_resource` VALUES (322, '修改场次信息权限', '', 3, 32);
INSERT INTO `sys_resource` VALUES (411, '查询订单信息权限', '', 3, 41);
INSERT INTO `sys_resource` VALUES (412, '修改订单信息权限', '', 3, 41);
INSERT INTO `sys_resource` VALUES (511, '查询用户信息权限', '', 3, 51);
INSERT INTO `sys_resource` VALUES (512, '修改用户信息权限', '', 3, 51);
INSERT INTO `sys_resource` VALUES (611, '查询角色信息权限', '', 3, 61);
INSERT INTO `sys_resource` VALUES (612, '修改角色信息权限', '', 3, 61);
INSERT INTO `sys_resource` VALUES (621, '查询资源信息权限', '', 3, 62);
INSERT INTO `sys_resource` VALUES (622, '修改资源信息权限', '', 3, 62);

-- ----------------------------
-- Table structure for sys_resource_copy
-- ----------------------------
DROP TABLE IF EXISTS `sys_resource_copy`;
CREATE TABLE `sys_resource_copy`  (
  `resource_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '资源编号',
  `resource_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '菜单名称',
  `path` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '菜单路径，用于保存页面地址',
  `level` int UNSIGNED NOT NULL DEFAULT 1 COMMENT '资源权限等级,1表示该资源为最高级权限',
  `parent_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '当前菜单父菜单编号',
  PRIMARY KEY (`resource_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 623 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_resource_copy
-- ----------------------------
INSERT INTO `sys_resource_copy` VALUES (1, '影院管理', '', 1, 0);
INSERT INTO `sys_resource_copy` VALUES (2, '电影管理', '', 1, 0);
INSERT INTO `sys_resource_copy` VALUES (3, '影厅管理', '', 1, 0);
INSERT INTO `sys_resource_copy` VALUES (4, '订单管理', '', 1, 0);
INSERT INTO `sys_resource_copy` VALUES (5, '用户管理', '', 1, 0);
INSERT INTO `sys_resource_copy` VALUES (6, '权限管理', '', 1, 0);
INSERT INTO `sys_resource_copy` VALUES (11, '影院信息管理', 'cinema', 2, 1);
INSERT INTO `sys_resource_copy` VALUES (21, '电影信息管理', 'movie', 2, 2);
INSERT INTO `sys_resource_copy` VALUES (22, '电影类别管理', 'movieCategory', 2, 2);
INSERT INTO `sys_resource_copy` VALUES (31, '影厅信息管理', 'hall', 2, 3);
INSERT INTO `sys_resource_copy` VALUES (32, '场次信息管理', 'session', 2, 3);
INSERT INTO `sys_resource_copy` VALUES (41, '订单信息管理', 'bill', 2, 4);
INSERT INTO `sys_resource_copy` VALUES (51, '用户信息管理', 'user', 2, 5);
INSERT INTO `sys_resource_copy` VALUES (61, '角色信息管理', 'role', 2, 6);
INSERT INTO `sys_resource_copy` VALUES (62, '资源信息管理', 'resource', 2, 6);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '角色编号',
  `role_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '角色名称',
  `role_desc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '角色描述',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '系统管理员', '管理整个影院在线售票系统');
INSERT INTO `sys_role` VALUES (2, '影院管理员', '管理其所属的影院的相关信息');
INSERT INTO `sys_role` VALUES (3, '用户', '用户，仅能使用前台浏览相关信息、下单、修改个人信息等功能');

-- ----------------------------
-- Table structure for sys_role_resource
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_resource`;
CREATE TABLE `sys_role_resource`  (
  `role_id` bigint UNSIGNED NOT NULL COMMENT '角色编号',
  `resource_id` bigint UNSIGNED NOT NULL COMMENT '资源编号，只以3级权限作为权限判断的依据',
  PRIMARY KEY (`role_id`, `resource_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_resource
-- ----------------------------
INSERT INTO `sys_role_resource` VALUES (1, 111);
INSERT INTO `sys_role_resource` VALUES (1, 112);
INSERT INTO `sys_role_resource` VALUES (1, 211);
INSERT INTO `sys_role_resource` VALUES (1, 212);
INSERT INTO `sys_role_resource` VALUES (1, 221);
INSERT INTO `sys_role_resource` VALUES (1, 222);
INSERT INTO `sys_role_resource` VALUES (1, 311);
INSERT INTO `sys_role_resource` VALUES (1, 312);
INSERT INTO `sys_role_resource` VALUES (1, 321);
INSERT INTO `sys_role_resource` VALUES (1, 322);
INSERT INTO `sys_role_resource` VALUES (1, 411);
INSERT INTO `sys_role_resource` VALUES (1, 412);
INSERT INTO `sys_role_resource` VALUES (1, 511);
INSERT INTO `sys_role_resource` VALUES (1, 512);
INSERT INTO `sys_role_resource` VALUES (1, 611);
INSERT INTO `sys_role_resource` VALUES (1, 612);
INSERT INTO `sys_role_resource` VALUES (1, 621);
INSERT INTO `sys_role_resource` VALUES (1, 622);
INSERT INTO `sys_role_resource` VALUES (2, 211);
INSERT INTO `sys_role_resource` VALUES (2, 221);
INSERT INTO `sys_role_resource` VALUES (2, 231);
INSERT INTO `sys_role_resource` VALUES (2, 241);
INSERT INTO `sys_role_resource` VALUES (2, 251);
INSERT INTO `sys_role_resource` VALUES (2, 261);
INSERT INTO `sys_role_resource` VALUES (2, 311);
INSERT INTO `sys_role_resource` VALUES (2, 312);
INSERT INTO `sys_role_resource` VALUES (2, 321);
INSERT INTO `sys_role_resource` VALUES (2, 411);
INSERT INTO `sys_role_resource` VALUES (2, 412);
INSERT INTO `sys_role_resource` VALUES (2, 511);
INSERT INTO `sys_role_resource` VALUES (2, 621);
INSERT INTO `sys_role_resource` VALUES (10, 621);
INSERT INTO `sys_role_resource` VALUES (10, 622);

-- ----------------------------
-- Table structure for sys_role_resource_copy
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_resource_copy`;
CREATE TABLE `sys_role_resource_copy`  (
  `role_id` bigint UNSIGNED NOT NULL COMMENT '角色编号',
  `resource_id` bigint UNSIGNED NOT NULL COMMENT '资源编号，只以3级权限作为权限判断的依据',
  PRIMARY KEY (`role_id`, `resource_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_resource_copy
-- ----------------------------
INSERT INTO `sys_role_resource_copy` VALUES (1, 11);
INSERT INTO `sys_role_resource_copy` VALUES (1, 21);
INSERT INTO `sys_role_resource_copy` VALUES (1, 22);
INSERT INTO `sys_role_resource_copy` VALUES (1, 31);
INSERT INTO `sys_role_resource_copy` VALUES (1, 32);
INSERT INTO `sys_role_resource_copy` VALUES (1, 41);
INSERT INTO `sys_role_resource_copy` VALUES (1, 51);
INSERT INTO `sys_role_resource_copy` VALUES (1, 61);
INSERT INTO `sys_role_resource_copy` VALUES (1, 62);
INSERT INTO `sys_role_resource_copy` VALUES (2, 21);
INSERT INTO `sys_role_resource_copy` VALUES (2, 22);
INSERT INTO `sys_role_resource_copy` VALUES (2, 23);
INSERT INTO `sys_role_resource_copy` VALUES (2, 24);
INSERT INTO `sys_role_resource_copy` VALUES (2, 25);
INSERT INTO `sys_role_resource_copy` VALUES (2, 26);
INSERT INTO `sys_role_resource_copy` VALUES (2, 31);
INSERT INTO `sys_role_resource_copy` VALUES (2, 32);
INSERT INTO `sys_role_resource_copy` VALUES (2, 41);
INSERT INTO `sys_role_resource_copy` VALUES (2, 51);
INSERT INTO `sys_role_resource_copy` VALUES (2, 62);
INSERT INTO `sys_role_resource_copy` VALUES (10, 62);

-- ----------------------------
-- Table structure for sys_session
-- ----------------------------
DROP TABLE IF EXISTS `sys_session`;
CREATE TABLE `sys_session`  (
  `session_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '场次编号',
  `hall_id` bigint UNSIGNED NOT NULL COMMENT '影厅编号',
  `language_version` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '语言版本',
  `movie_id` bigint UNSIGNED NOT NULL COMMENT '电影编号',
  `play_time` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '播放时间',
  `end_time` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '散场时间',
  `deadline` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '检测到的截止时间，没过这个时间不能删电影、影厅信息',
  `session_date` date NOT NULL COMMENT '场次日期',
  `session_price` decimal(10, 2) NOT NULL COMMENT '票价',
  `session_tips` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '影厅提示(如是否需要戴口罩，有什么福利，显示在选座购票位置的影厅后边，格式类似：6号Barco厅-（戴口罩勿饮食）凭票领券免费停车3小时)',
  `session_seats` json NOT NULL COMMENT '座位信息，采用{key: [], key: []}存储每一个座位的状态，其中key表示排，数组(下标+1)表示几号座，存储的值为0表示可选，1表示空(无座位)，值为2表示已选择，值为3表示已售出，',
  `seat_nums` smallint UNSIGNED NULL DEFAULT 0 COMMENT '总座位数',
  `sall_nums` smallint NOT NULL DEFAULT 0 COMMENT '售出座位数',
  `del_state` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记，0未删除，1删除，默认0',
  PRIMARY KEY (`session_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 72 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_session
-- ----------------------------
INSERT INTO `sys_session` VALUES (75, 1, '国语', 1, '21:07', '00:03', '2024-03-24 00:23:00', '2024-03-23', 55.00, NULL, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 3, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 100, 1, 0);
INSERT INTO `sys_session` VALUES (76, 2, '国语', 11, '21:08', '23:43', '2024-03-25 00:03:00', '2024-03-24', 45.00, NULL, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 3, 3, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 110, 2, 0);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `user_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户名称(用于登录，添加时验证唯一性)',
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户密码(密文存储)',
  `salt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '盐',
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户邮箱，记录个人信息和发送通知',
  `phone_number` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户电话号码，用于注册和发送通知',
  `sex` tinyint UNSIGNED NOT NULL COMMENT '用户性别，1为男性0为女性',
  `user_picture` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `role_id` bigint UNSIGNED NOT NULL DEFAULT 3 COMMENT '角色编号',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `autograph` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '个性签名',
  `del_state` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记，0未删除，1删除，默认0',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '2f6b5c3044b271f5c07545aa862cf35c', '0v#C4w&i', '17777744455@qq.com', '13111212312', 1, '[]', 1, '1999-10-15', '爱拼才会赢123', 0);
INSERT INTO `sys_user` VALUES (30, 'xbb', '334e6ffab40ca31d37fe3cce6270b2cb', 'B6)S%QMt', 'qq@163.com', '13656232356', 0, '[\"/images/user/2024/03/09/d03dcbd64c5c478c8ce794ef5e261220.jpg\"]', 3, '2024-03-09', '你好呀呀呀呀呀', 0);
INSERT INTO `sys_user` VALUES (32, 'bear', 'd1c99c791e1a6b37c37c1f3171ac226a', 'p23BT1lw', 'bear@163.com', '18181311131', 1, '[\"/images/user/2024/03/09/065f400ce90b494f819b685f7bed5fd2.jpg\"]', 3, NULL, NULL, 0);
INSERT INTO `sys_user` VALUES (33, 'Doraemon', '1b09db1fc32878be1034cabd3c298dcc', 'Wm@%(NF&', 'Doraemon@qq.com', '15123565613', 1, '[\"/images/user/2024/03/09/0911a73fcc56476294d4aa2fa65b84b2.jpg\"]', 3, NULL, NULL, 0);
INSERT INTO `sys_user` VALUES (34, 'tom', 'd283f120acc897bb027b43d2cce21c21', 'cgZDTZP^', 'tom@163.com', '13156312113', 0, '[\"/images/user/2024/03/09/74dd87f9c6714be3afb98ac65a153155.gif\"]', 3, '2024-03-10', NULL, 0);
INSERT INTO `sys_user` VALUES (35, 'jack', '58a349e5dc6e5a3cf12ccc0ccb024c41', 'pT!34hRd', 'jack@qq.com', '17643265686', 1, '[\"/images/user/2024/03/09/215c7e2ec8de4600b9fda8aef6a6b099.gif\"]', 3, '2024-03-11', '你好呀呀呀呀呀', 0);

SET FOREIGN_KEY_CHECKS = 1;
