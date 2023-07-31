-- 储存引擎


/*	
 	mysql的体系架构 
一、网络连接层
客户端连接器（Client Connectors）：提供与MySQL服务器建立的支持。目前几乎支持所有主流
的服务端编程技术，例如常见的 Java、C、Python、.NET等，它们通过各自API技术与MySQL建立连接

--------------------------------------------------------------------------------

二、服务层（MySQL Server）
服务层是MySQL Server的核心，主要包含系统管理和控制工具、连接池、SQL接口、解析器、查询优
化器和缓存六个部分：

连接池（Connection Pool）：负责存储和管理客户端与数据库的连接，一个线程负责管理一个连接
系统管理和控制工具（Management Services & Utilities）：例如备份恢复、安全管理、集群管理等
SQL接口（SQL Interface）：用于接受客户端发送的各种SQL命令，并且返回用户需要查询的结果。比如DML、DDL、存储过程、视图、触发器等
解析器（Parser）：负责将请求的SQL解析生成一个"解析树"。然后根据一些MySQL规则进一步检查解析树是否合法
查询优化器（Optimizer）：当“解析树”通过解析器语法检查后，将交由优化器将其转化成执行计划，然后与存储引擎交互

-----------------------------------------------------------------------------------------

三、存储引擎层（Pluggable Storage Engines）
存储引擎负责MySQL中数据的存储与提取，与底层系统文件进行交互。MySQL存储引擎是插件式的，
服务器中的查询执行引擎通过接口与存储引擎进行通信，接口屏蔽了不同存储引擎之间的差异 。现在有
很多种存储引擎，各有各的特点，最常见的是MyISAM和InnoDB

-----------------------------------------------------------------------------------------

四、系统文件层（File System）
该层负责将数据库的数据和日志存储在文件系统之上，并完成与存储引擎的交互，是文件的物理存储
层。主要包含日志文件，数据文件，配置文件，pid 文件，socket 文件等

日志文件
错误日志（Error log）
默认开启，show variables like ‘%log_error%’

通用查询日志（General query log）
记录一般查询语句，show variables like ‘%general%’;

二进制日志（binary log）
记录了对MySQL数据库执行的更改操作，并且记录了语句的发生时间、执行时长；但是它不
记录select、show等不修改数据库的SQL。主要用于数据库恢复和主从复制。
show variables like ‘%log_bin%’; //是否开启
 
show variables like ‘%binlog%’; //参数查看

show binary logs;//查看日志文件

慢查询日志（Slow query log）
记录所有执行时间超时的查询SQL，默认是10秒。
show variables like ‘%slow_query%’; //是否开启

show variables like ‘%long_query_time%’; //时长

配置文件
用于存放MySQL所有的配置信息文件，比如my.cnf、my.ini等

数据文件
db.opt 文件：记录这个库的默认使用的字符集和校验规则。
frm 文件：存储与表相关的元数据（meta）信息，包括表结构的定义信息等，每一张表都会有一个frm 文件。
MYD 文件：MyISAM 存储引擎专用，存放 MyISAM 表的数据（data)，每一张表都会有一个.MYD 文件。
MYI 文件：MyISAM 存储引擎专用，存放 MyISAM 表的索引相关信息，每一张 MyISAM 表对应一个 .MYI 文件。
ibd文件和 IBDATA 文件：存放 InnoDB 的数据文件（包括索引）。InnoDB 存储引擎有两种表空间方式：独享表空间和共享表空间。独享表空间使用 .ibd 文件来存放数据，且每一张InnoDB 表对应一个 .ibd 文件。共享表空间使用 .ibdata 文件，所有表共同使用一个（或多个，自行配置）.ibdata 文件。
ibdata1 文件：系统表空间数据文件，存储表元数据、Undo日志等 。
ib_logfile0、ib_logfile1 文件：Redo log 日志文件

查看数据文件位置
show variables like '%datadir%'

pid 文件
pid 文件是 mysqld 应用程序在 Unix/Linux 环境下的一个进程文件，和许多其他 Unix/Linux 服务端程序一样，它存放着自己的进程 id

socket 文件
socket 文件也是在 Unix/Linux 环境下才有的，用户在 Unix/Linux 环境下客户端连接可以不通过TCP/IP 网络而直接使用 Unix Socket 来连接 MySQL。
 
 */


-- 查询建表语句   
show create table test1.zcy_test1 ;
-- ENGINE(引擎) 默认InnoDB
CREATE TABLE `zcy_test1` (
  `UUID` int NOT NULL COMMENT '主键ID',
  `NAME` varchar(50) COLLATE utf8mb4_german2_ci DEFAULT NULL COMMENT '姓名',
  `AGE` int DEFAULT NULL COMMENT '年龄',
  `SEX` char(1) COLLATE utf8mb4_german2_ci DEFAULT NULL COMMENT '性别',
  `STUDY` varchar(20) COLLATE utf8mb4_german2_ci DEFAULT '' COMMENT '学科',
  PRIMARY KEY (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_german2_ci COMMENT='ZCY测试表1'

-- 查看当前数据库支持的存储引擎
show ENGINES;

/*
InnoDB 储存引擎  高可靠性和高性能
特点
	DML操作遵循ACID模型，支持事务
	行级锁，提高并发访问性能
	支持外键foreign key约束,保证数据的完整性和正确性
文件
	xxx.ibd: InnoDB储存引擎的每张表都对应一个表空间文件，存储该表的表结构(frm、sdi)、数据和索引
	参数:innodb_file_per_table
*/
-- show variables like 参数查看
show variables like 'innodb_file_per_table';
-- innodb_file_per_table value='ON' 每一张表都有自己的表空间

-- cmd命令行 ibd2sdi zcy_test1.ibd 查看ibd(表空间)文件内容

/*
tablespace(表空间)->segment(段)->extent(区)1M->page(页)16K->row(行)
一个分区64页 
row 包含 
	trx id 最后一次操作事务的id
	poll pointer 指针
	col 字段*/

-------------------------------------------------------
/*

MyISAM 储存引擎
特点
	不支持事务，不支持外键
	支持表锁，不支持行锁
	访问速度快

SDI文件	存储表结构信息
MYD文件	存储数据
MYI文件	存储索引
*/

/*

Memory 储存引擎
	Memory引擎的表数据存储在内存中。由于受到硬件问题或断电问题的影响，只能将这些表作为临时表或缓存使用
特点
	内存存放 访问速度很快
	hash索引(默认)
	
SDI文件	存储表结构信息
*/

/*
 在开发中，我们经常使用的存储引擎 myisam / innodb/ memory
MyISAM存储引擎
  如果表对事务要求不高，同时是以查询和添加为主的，我们考虑使用myisam存储引擎. 比如 bbs 中的 发帖表，回复表。

INNODB存储引擎:
  对事务要求高，保存的数据都是重要数据，我们建议使用INNODB,比如订单表，账号表。

Memory 存储
  我们数据变化频繁，不需要入库，同时又频繁的查询和修改，我们考虑使用memory, 速度极快。

问 MyISAM 和 INNODB的区别(主要)
  1.事务安全 myisam不支持事务而innodb支持。
  2.查询和添加速度 myisam不用支持事务就不用考虑同步锁，查找和添加的速度快。
  3.支持全文索引 myisam支持innodb不支持。
  4.锁机制 myisam支持表锁而innodb支持行锁(事务)。
  5.外键 MyISAM 不支持外键， INNODB支持外键. (通常不设置外键，通常是在程序中保证数据的一致)。 
原文链接：https://blog.csdn.net/faramita_of_mine/article/details/124070613
 
 **/

