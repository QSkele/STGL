/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80029
 Source Host           : localhost:3306
 Source Schema         : db

 Target Server Type    : MySQL
 Target Server Version : 80029
 File Encoding         : 65001

 Date: 12/04/2023 15:13:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `cno` int NOT NULL AUTO_INCREMENT COMMENT '课程id',
  `cname` varchar(15) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL COMMENT '课程名称',
  PRIMARY KEY (`cno`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_danish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (1, '数据结构');
INSERT INTO `course` VALUES (2, '操作系统');
INSERT INTO `course` VALUES (3, '计算机网络');
INSERT INTO `course` VALUES (4, '计算机组成原理');
INSERT INTO `course` VALUES (5, 'JAVA课程设计');
INSERT INTO `course` VALUES (6, 'C语言程序设计');
INSERT INTO `course` VALUES (7, '数据库原理');
INSERT INTO `course` VALUES (8, '大学英语');
INSERT INTO `course` VALUES (9, '高等数学');
INSERT INTO `course` VALUES (10, '计算机科学导论');
INSERT INTO `course` VALUES (11, '大学体育');
INSERT INTO `course` VALUES (12, '大学语文');
INSERT INTO `course` VALUES (13, '线性代数');

-- ----------------------------
-- Table structure for exam
-- ----------------------------
DROP TABLE IF EXISTS `exam`;
CREATE TABLE `exam`  (
  `eid` int NOT NULL AUTO_INCREMENT COMMENT '试卷id',
  `pname` varchar(20) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL COMMENT '试卷名称',
  `cno` int NOT NULL COMMENT '课程id',
  `userid` int NOT NULL COMMENT '用户id',
  `classid` int NOT NULL COMMENT '班级id',
  `singlenumber` int NOT NULL COMMENT '单选题个数',
  `singlecore` int NOT NULL COMMENT '单选题分数',
  `multiplenumber` int NOT NULL COMMENT '多选题个数',
  `multiplecore` int NOT NULL COMMENT '多选题分数',
  `examdate` date NOT NULL COMMENT '开始时间',
  `examtime` date NOT NULL COMMENT '结束时间',
  `testtime` int NOT NULL COMMENT '考试时长',
  PRIMARY KEY (`eid`) USING BTREE,
  INDEX `fk_relationship_2`(`userid`) USING BTREE,
  INDEX `fk_relationship_3`(`classid`) USING BTREE,
  INDEX `fk_relationship_4`(`cno`) USING BTREE,
  CONSTRAINT `fk_relationship_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_relationship_3` FOREIGN KEY (`classid`) REFERENCES `pjclass` (`classid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_relationship_4` FOREIGN KEY (`cno`) REFERENCES `course` (`cno`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_danish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of exam
-- ----------------------------
INSERT INTO `exam` VALUES (1, '数据结构', 1, 1, 3, 1, 5, 0, 5, '2023-04-10', '2023-04-10', 90);
INSERT INTO `exam` VALUES (2, '操作系统', 2, 3, 3, 1, 5, 0, 5, '2023-04-10', '2023-04-11', 120);
INSERT INTO `exam` VALUES (3, '计算机网络', 3, 1, 3, 1, 5, 0, 5, '2023-04-10', '2023-04-15', 120);
INSERT INTO `exam` VALUES (4, '计算机组成原理', 4, 4, 2, 1, 4, 0, 5, '2023-04-10', '2023-04-16', 180);

-- ----------------------------
-- Table structure for paper
-- ----------------------------
DROP TABLE IF EXISTS `paper`;
CREATE TABLE `paper`  (
  `pid` int NOT NULL AUTO_INCREMENT COMMENT '试卷问题存储id',
  `eid` int NOT NULL COMMENT '试卷id',
  `sid` int NOT NULL COMMENT '题目id',
  `cno` int NOT NULL COMMENT '课程id',
  `stype` int NOT NULL COMMENT '题目类型',
  `scontent` varchar(255) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL COMMENT '题目',
  `sa` varchar(255) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL COMMENT '选项a',
  `sb` varchar(255) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL COMMENT '选项b',
  `sc` varchar(255) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL COMMENT '选项c',
  `sd` varchar(255) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL COMMENT '选项d',
  `skey` varchar(255) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL COMMENT '正确答案',
  PRIMARY KEY (`pid`) USING BTREE,
  INDEX `fk_relationship_13`(`eid`) USING BTREE,
  INDEX `fk_relationship_14`(`sid`) USING BTREE,
  CONSTRAINT `fk_relationship_13` FOREIGN KEY (`eid`) REFERENCES `exam` (`eid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_relationship_14` FOREIGN KEY (`sid`) REFERENCES `subject` (`sid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_danish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of paper
-- ----------------------------
INSERT INTO `paper` VALUES (1, 1, 1, 1, 1, '数据的逻辑结构是强调（ ）之间的逻辑关系', '数据对象', '数据元素', '数据项', '数据类型', 'B.数据元素');
INSERT INTO `paper` VALUES (2, 2, 2, 2, 1, '操作系统为每一个文件开辟一个存储区，在它的里面记录着该文件的有关信息。这就是所谓的（）', '文件控制块', '进程控制块', '设备控制块', '作业控制块', 'A.文件控制块');
INSERT INTO `paper` VALUES (3, 3, 3, 3, 1, '一台主机的IP地址为10.10.100.10/18，则该主机位于的网络的地址为（  ）。', '10.10.10.0', '10.10.4.0', '10.10.64.0', '10.10.32.0', 'C.10.10.64.0');
INSERT INTO `paper` VALUES (4, 4, 4, 4, 1, '在CPU中，跟踪下一条要执行的指令的地址的寄存器是（    ）。', 'IR', 'MAR', 'MDR', 'PC', 'D.PC');

-- ----------------------------
-- Table structure for pjclass
-- ----------------------------
DROP TABLE IF EXISTS `pjclass`;
CREATE TABLE `pjclass`  (
  `classid` int NOT NULL AUTO_INCREMENT COMMENT '班级id',
  `classname` varchar(25) CHARACTER SET utf8 COLLATE utf8_danish_ci NULL DEFAULT NULL COMMENT '班级名称',
  PRIMARY KEY (`classid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_danish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pjclass
-- ----------------------------
INSERT INTO `pjclass` VALUES (1, '19计本1班');
INSERT INTO `pjclass` VALUES (2, '19计本2班');
INSERT INTO `pjclass` VALUES (3, '19计本3班');
INSERT INTO `pjclass` VALUES (4, '19大数据1班');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `roleid` int NOT NULL AUTO_INCREMENT COMMENT '用户类型id',
  `rolename` varchar(20) CHARACTER SET utf8 COLLATE utf8_danish_ci NULL DEFAULT NULL COMMENT '用户类型',
  PRIMARY KEY (`roleid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_danish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '老师');
INSERT INTO `role` VALUES (2, '学生');
INSERT INTO `role` VALUES (3, '管理员');

-- ----------------------------
-- Table structure for studentexam
-- ----------------------------
DROP TABLE IF EXISTS `studentexam`;
CREATE TABLE `studentexam`  (
  `seid` int NOT NULL AUTO_INCREMENT COMMENT '试卷存储id',
  `userid` int NOT NULL COMMENT '用户id',
  `classid` int NOT NULL COMMENT '班级id',
  `eid` int NOT NULL COMMENT '试卷id',
  `pname` varchar(20) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL COMMENT '试卷名称',
  `zscore` int NOT NULL COMMENT '总分数',
  `score` int NOT NULL COMMENT '学生分数',
  `tjtime` datetime NOT NULL COMMENT '考试时间',
  PRIMARY KEY (`seid`) USING BTREE,
  INDEX `fk_relationship_6`(`userid`) USING BTREE,
  INDEX `fk_relationship_7`(`classid`) USING BTREE,
  INDEX `fk_relationship_8`(`eid`) USING BTREE,
  CONSTRAINT `fk_relationship_6` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_relationship_7` FOREIGN KEY (`classid`) REFERENCES `pjclass` (`classid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_relationship_8` FOREIGN KEY (`eid`) REFERENCES `exam` (`eid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_danish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of studentexam
-- ----------------------------
INSERT INTO `studentexam` VALUES (1, 1, 3, 1, '数据结构', 5, 5, '2023-04-10 22:00:00');
INSERT INTO `studentexam` VALUES (2, 2, 1, 2, '操作系统', 5, 5, '2023-04-10 22:00:00');
INSERT INTO `studentexam` VALUES (3, 3, 3, 3, '计算机网络', 5, 5, '2023-04-10 22:00:00');
INSERT INTO `studentexam` VALUES (4, 4, 4, 4, '计算机组成原理', 4, 4, '2023-04-10 22:00:00');

-- ----------------------------
-- Table structure for studentsubject
-- ----------------------------
DROP TABLE IF EXISTS `studentsubject`;
CREATE TABLE `studentsubject`  (
  `ssid` int NOT NULL AUTO_INCREMENT COMMENT '学生答题id',
  `seid` int NOT NULL COMMENT '试卷存储id',
  `userid` int NOT NULL COMMENT '用户id',
  `eid` int NOT NULL COMMENT '试卷id',
  `sid` int NOT NULL COMMENT '题目id',
  `studentkey` varchar(255) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL COMMENT '学生答案',
  PRIMARY KEY (`ssid`) USING BTREE,
  INDEX `fk_relationship_9`(`seid`) USING BTREE,
  INDEX `fk_relationship_10`(`userid`) USING BTREE,
  INDEX `fk_relationship_11`(`eid`) USING BTREE,
  INDEX `fk_relationship_12`(`sid`) USING BTREE,
  CONSTRAINT `fk_relationship_10` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_relationship_11` FOREIGN KEY (`eid`) REFERENCES `exam` (`eid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_relationship_12` FOREIGN KEY (`sid`) REFERENCES `subject` (`sid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_relationship_9` FOREIGN KEY (`seid`) REFERENCES `studentexam` (`seid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_danish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of studentsubject
-- ----------------------------
INSERT INTO `studentsubject` VALUES (1, 1, 1, 1, 1, 'B.数据元素');
INSERT INTO `studentsubject` VALUES (2, 2, 2, 2, 2, 'A.文件控制块');
INSERT INTO `studentsubject` VALUES (3, 3, 3, 3, 3, 'C.10.10.64.0');
INSERT INTO `studentsubject` VALUES (4, 4, 4, 4, 4, 'D.PC');

-- ----------------------------
-- Table structure for subject
-- ----------------------------
DROP TABLE IF EXISTS `subject`;
CREATE TABLE `subject`  (
  `sid` int NOT NULL AUTO_INCREMENT COMMENT '题目id',
  `cno` int NOT NULL COMMENT '课程id',
  `stype` int NOT NULL COMMENT '题目类型',
  `scontent` varchar(255) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL COMMENT '题目',
  `sa` varchar(255) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL COMMENT '选项a',
  `sb` varchar(255) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL COMMENT '选项b',
  `sc` varchar(255) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL COMMENT '选项c',
  `sd` varchar(255) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL COMMENT '选项d',
  `skey` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '答案',
  PRIMARY KEY (`sid`) USING BTREE,
  UNIQUE INDEX `scontent`(`scontent`) USING BTREE,
  INDEX `fk_relationship_5`(`cno`) USING BTREE,
  CONSTRAINT `fk_relationship_5` FOREIGN KEY (`cno`) REFERENCES `course` (`cno`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_danish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of subject
-- ----------------------------
INSERT INTO `subject` VALUES (1, 1, 1, '数据的逻辑结构是强调（ ）之间的逻辑关系', '数据对象', '数据元素', '数据项', '数据类型', 'B.数据元素');
INSERT INTO `subject` VALUES (2, 2, 1, '操作系统为每一个文件开辟一个存储区，在它的里面记录着该文件的有关信息。这就是所谓的（）', '文件控制块', '进程控制块', '设备控制块', '作业控制块', 'A.文件控制块');
INSERT INTO `subject` VALUES (3, 3, 1, '一台主机的IP地址为10.10.100.10/18，则该主机位于的网络的地址为（  ）。', '10.10.10.0', '10.10.4.0', '10.10.64.0', '10.10.32.0', 'C.10.10.64.0');
INSERT INTO `subject` VALUES (4, 4, 1, '在CPU中，跟踪下一条要执行的指令的地址的寄存器是（    ）。', 'IR', 'MAR', 'MDR', 'PC', 'D.PC');
INSERT INTO `subject` VALUES (7, 1, 1, '算法设计的要求包括____。', '正确性', '可读性', '健壮性', '确定性', 'A，B，C');

-- ----------------------------
-- Table structure for type
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type`  (
  `stype` int NOT NULL AUTO_INCREMENT COMMENT '题目类型',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL COMMENT '题目名称',
  PRIMARY KEY (`stype`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_danish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of type
-- ----------------------------
INSERT INTO `type` VALUES (1, '单选题');
INSERT INTO `type` VALUES (2, '多选题');
INSERT INTO `type` VALUES (3, '简答题');
INSERT INTO `type` VALUES (4, '填空题');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `userid` int NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `roleid` int NULL DEFAULT NULL COMMENT '用户类型',
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_danish_ci NULL DEFAULT NULL COMMENT '用户名',
  `userpwd` varchar(20) CHARACTER SET utf8 COLLATE utf8_danish_ci NULL DEFAULT NULL COMMENT '密码',
  `truename` varchar(30) CHARACTER SET utf8 COLLATE utf8_danish_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `classid` int NULL DEFAULT NULL COMMENT '班级id',
  PRIMARY KEY (`userid`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE,
  INDEX `fk_relationship_1`(`roleid`) USING BTREE,
  CONSTRAINT `fk_relationship_1` FOREIGN KEY (`roleid`) REFERENCES `role` (`roleid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_danish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 2, 'QXL', '123456', '邱某亮', 3);
INSERT INTO `users` VALUES (2, 2, 'DCY', '123456', '董某毅', 1);
INSERT INTO `users` VALUES (3, 2, 'HGT', '123456', '黄某橦', 3);
INSERT INTO `users` VALUES (4, 2, 'WXT', '123456', '吴某天', 4);
INSERT INTO `users` VALUES (5, 3, 'admin', '123456', '管理员', 1);
INSERT INTO `users` VALUES (6, 1, 'QXF', '123456', '邱某峰', 3);
INSERT INTO `users` VALUES (7, 1, 'WJP', '123456', '吴某萍', 3);
INSERT INTO `users` VALUES (8, 1, 'CXY', '123456', '程某杨', 3);
INSERT INTO `users` VALUES (9, 1, 'XGQ', '123456', '谢某强', 2);
INSERT INTO `users` VALUES (11, 1, 'WM', '123456', '王某敏', 1);
INSERT INTO `users` VALUES (12, 1, 'YP', '123456', '袁某平', 1);

SET FOREIGN_KEY_CHECKS = 1;
