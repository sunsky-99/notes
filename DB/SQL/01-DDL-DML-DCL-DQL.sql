-- 客户端连接
-- mysql -h 127.0.0.1 -P 3306 -u root -p
-- docker 进入容器
-- docker exec -it 678b6cb65184 /bin/bash

/*
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
*/

/*==================================================================================================*/
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

/*==================================================================================================*/
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


/*==================================================================================================*/
-- DCL数据库控制语言
-- 创建用户  User@HOST 确认一个用户  host主机名可以使用%通配
use mysql;
-- 创建只能本地访问的用户userZcy 密码Zcy123456
create user 'userZcy'@'localhost' IDENTIFIED by 'Zcy123456!';

-- 修改用户密码
alter user 'userZcy'@'localhost' IDENTIFIED with mysql_native_password by 'Zcy123456!';

-- 删除用户
drop user 'userZcy'@'localhost' ;

-- 测试用户权限
create user 'userZcy'@'%' IDENTIFIED by 'Zcy123123!';
-- 权限控制
-- 查询用户权限
show Grants for 'userZcy'@'%';
show Grants for 'root'@'%';

-- 授予权限
-- 给用户 'userZcy'@'%' 授予 test1数据库的所有操作权限
grant all on test1.* to 'userZcy'@'%';

-- 撤销权限
revoke all on test1.* from 'userZcy'@'%';

select * from user;


/*==================================================================================================*/
-- DQL 数据库查询语言

select * from zcy_test1 ;
-- AS(可以省略)别名
select UUID as "id" ,name as "名称",age "年龄" from zcy_test1 zt ;

-- 去重 distinct
select distinct uuid ,name  from zcy_test1 zt ;

-- 正则表达式 _长度即为字符长度
select uuid ,name  from zcy_test1 zt
where name like '_' ;

select uuid ,name  from zcy_test1 zt
where name like '%2' ;


-- 聚合函数 count avg sum  max min
-- null值不参与所有聚合函数的运算
-- where 分组前的数据过滤
-- having 分组后的数据过滤
-- Group by 分组 分组后的查询字段一般为聚合函数和分组字段
-- order by 排序 默认升序 ASC  降序DESC    (升序时null排最上方)
-- limit起始索引,每页记录数 分页 0,2 从第一页开始展示2条数据
select count(uuid),avg(age),sum(AGE),max(AGE),min(AGE) ,SEX  ,STUDY
from zcy_test1 zt
where AGE > 0
group by SEX ,STUDY
having avg(age) > 1
order by  SEX ASC ,STUDY desc
limit 0,2
/*DQL编写顺序
 * select 字段
 * from 表名
 * where 条件
 * GROUP by 分组字段
 * having 分组后的条件
 * order by 排序字段
 * limit 分页参数
 * */
/*DQL 查询顺序
 * from 表名 where 条件 GROUP by 分组字段 having 分组后的条件 select 字段 order by 排序字段 limit 分页参数
 * */


-- 多表查询 内连接 自连接 外连接 子查询
select * from zcy_test1,zcy_test2

-- 隐式内连接
select * from zcy_test1 zt ,zcy_test2 zt2 where zt.UUID = zt2.test1_id ;
-- 显示内连接
select * from zcy_test1 zt inner join zcy_test2 zt2 on zt.UUID = zt2.test1_id ;
select * from zcy_test1 zt join zcy_test2 zt2 on zt.UUID = zt2.test1_id ;

-- 左外连接
select * from zcy_test1 zt left join zcy_test2 zt2 on zt.UUID = zt2.test1_id ;
-- 右外连接
select * from zcy_test1 zt right join zcy_test2 zt2 on zt.UUID = zt2.test1_id ;

-- 自连接
-- 联合查询 union
/*1，union和union all都是对于两个或多个select语句的结果集
2，使用union或union all要注意两个表必须有相同的数量的列，同时列也必须有相同或相似的数据类型
3，每条select语句中的列的顺序也是必须相同的
4，union得到的是没有重复的记录，union all得到的是记录条数是两张表中记录的条数之和*/
select * from zcy_test1
union
select * from zcy_test1;

select * from zcy_test1
union all
select * from zcy_test1;

-- 子查询
select * from zcy_test1 where uuid = (select uuid from zcy_test1 z where NAME = '张三')


