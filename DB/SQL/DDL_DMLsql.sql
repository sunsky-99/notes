-- 客户端连接
-- mysql -h 127.0.0.1 -P 3306 -u root -p
-- docker 进入容器
-- docker exec -it 678b6cb65184 /bin/bash


一、DQL
DQL(data Query Language) 数据查询语言
就是我们最经常用到的 SELECT（查）语句 。主要用来对数据库中的数据进行查询操作。
二、DML
DML（data manipulation language）数据操纵语言：
就是我们最经常用到的 INSERT（增）、DELETE（删）、UPDATE（改）。主要用来对数据库重表的数据进行一些增删改操作。

三、DDL
DDL（data definition language）数据库定义语言：
就是我们在创建表的时候用到的一些sql，比如说：CREATE、ALTER、DROP等。主要是用在定义或改变表的结构，数据类型，表之间的链接和约束等初始化工作上。
 

四、DCL
DCL（Data Control Language）数据库控制语言：
是用来设置或更改数据库用户或角色权限的语句，包括（grant（授予权限）,deny（拒绝权限）,revoke（收回权限）等）语句。这个比较少用到。

-- DDL 数据库定义语言

-- SHOW DATABASES语句显示权限范围内所有的数据库名
SHOW DATABASES;
-- 查询当前正在使用的数据库名称
SELECT DATABASE();

-- 创建数据库  如果不存在则创建
CREATE DATABASE IF NOT EXISTS TEST2;

-- 删除数据库 如果存在则删除
DROP DATABASE IF EXISTS TEST2;

-- 切换数据库
USE TEST1;
SELECT DATABASE();

-- 查询当前数据库所有表
SHOW TABLES;

-- 查询表结构
DESC TEST;

-- 建表
CREATE TABLE ZCY_TEST1(
	UUID INT COMMENT '主键ID',
	NAME VARCHAR(50) COMMENT '姓名',
	AGE INT COMMENT '年龄',
	SEX CHAR COMMENT '性别'
) COMMENT 'ZCY测试表1' ;

DESC ZCY_TEST1;

-- 查询指定表的建表语句
SHOW CREATE TABLE ZCY_TEST1;

CREATE TABLE `ZCY_TEST1` (
  `UUID` INT DEFAULT NULL COMMENT '主键ID',
  `NAME` VARCHAR(50) COLLATE UTF8MB4_GERMAN2_CI DEFAULT NULL COMMENT '姓名',
  `AGE` INT DEFAULT NULL COMMENT '年龄',
  `SEX` CHAR(1) COLLATE UTF8MB4_GERMAN2_CI DEFAULT NULL COMMENT '性别'
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4 COLLATE=UTF8MB4_GERMAN2_CI COMMENT='ZCY测试表1'

-- 数据类型明细

-- 表操作  
-- 添加表字段
ALTER TABLE ZCY_TEST1 ADD ENAME VARCHAR(20) COMMENT '英文名';
ALTER TABLE test1.zcy_test1 ADD STUDY varchar(20) DEFAULT "" NULL COMMENT '学科';

-- 修改表字段数据类型
ALTER TABLE ZCY_TEST1 MODIFY ENAME CHAR(5) COMMENT '英文名'; 

-- 修改表字段名和数据类型
ALTER TABLE ZCY_TEST1 CHANGE ENAME NEW_ENAME VARCHAR(20) COMMENT '新英文名';

-- 删除字段
ALTER TABLE ZCY_TEST1 DROP NEW_ENAME;

-- 修改表名
ALTER TABLE ZCY_TEST1 RENAME TO ZCY_TEST;

-- 删除表
DROP TABLE IF EXISTS ZCY_TEST1;

-- 删除指定表并重新创建该表
TRUNCATE TABLE ZCY_TEST1;


-- DML 数据库操作语言
-- 批量插入数据 
INSERT INTO ZCY_TEST1 VALUES 
(1,1,1,1),
(2,2,2,2),
(4,2,2,2);

INSERT INTO ZCY_TEST1 (UUID,NAME) VALUES 
(5,1),
(6,2);

-- 修改语句
UPDATE ZCY_TEST1 SET NAME = '这是2' ,SEX = '男'
WHERE UUID =  2 ;

-- 删除语句
DELETE FROM ZCY_TEST1 WHERE UUID = 4;  

-- 新增主键
ALTER TABLE ZCY_TEST1 ADD CONSTRAINT PRIMARY KEY(UUID);
 


