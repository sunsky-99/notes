存储过程是事先经过编译并存储在数据库中的一段 SQL 语句的集合，调用存储过程可以简化应用开发人员的很多工作，减少数据在数据库和应用服务器之间的传输，对于提高数据处理的效率是有好处的。
存储过程思想上很简单，就是数据库SQL 语言层面的代码封装与重用

特点
封装，复用；
可以接收参数，也可以返回数据；
减少网络交互，效率提升；

存储过程基本语法
创建 可以传递参数和返回参数
create procedure p1()
begin
select count(*) from testzcy.user100w;
end;
调用
call p1(); 
-- 查询指定数据库的存储过程及状信息
select * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'testzcy'; 
-- 查询某个存储过程的定义
SHOW CREATE PROCEDURE p1;
-- 删除
DROP PROCEDURE IF EXISTS p1;
注意: 在命令行中，执行创建存储过程的SQL时，需要通过关键字 delimiter 指定SQL语句的结束符


变量
系统变量 是MySQL服务器提供，不是用户定义的，属于服务器层面。分为全局变量(GLOBAL)、会话变量(SESSION)
-- 查看所有系统变量
SHOW [ SESSION|GLOBAL] VARIABLES ;
-- 可以通过LIKE模糊匹配方式查找变量
SHOW [SESSION|GLOBAL] VARIABLES LIKE，....; 
-- 查看指定变量的值
SELECT @@[SESSION|GLOBAL] 系统变量名;
设置系统变量
SET [ SESSION|GLOBAL] 系统变量名=值
SET @@[SESSION|GLOBAL]系统变量名 = 值


SHOW  VARIABLES ;

如果没有指定SESSION/GLOBAL，默认是SESSION会话变量。
mysql服务重新启动之后，所设置的全局参数会失效,要想不失效，可以在 /etc/my.cnf 中配置

用户定义变量 
是用户根据需要自己定义的变量，用户变量不用提前声明，在用的时候直接用“@变量名”使用就可以。其作用域为当前连接。

赋值
SET @var_name = expr [, @var_name = expr] ... ;
SET @var_name := expr l @var_name := expr] ... ;
SELECT @var_name := expr [, @var_name := expr] ... ;
SELECT 字段名 INTO @var_name FROM 表名;
使用
SELECT @var_name ;
赋值
set @myName = '张三';
set @myAge := 22;
set @myName = '张三',@myAge = 23;
SELECT @mySex := '1' ;
select count(*) into @myMax from testzcy.user100w;
使用
SELECT @myName,@myAge,@mySex,@myMax ;
用户定义的变量无需对其进行声明或初始化，只不过获取到的值为NULL
SELECT @tes;


局部变量 
是根据需要定义的在局部生效的变量，访问之前，需要DECLARE声明。可用作存储过程内的局部变量和输入参数，局部变量的范围是在其内声明的BEGIN ...END块

声明
DECLARE 变量名 变量类型[DEFAULT ...];
变量类型就是数据库字段类型:INT、BIGINT、CHAR、VARCHAR、DATE、TIME等赋值
SET 变量名=值
SET 变量名 := 值 ;
SELECT 字段名 INTO 变量名 FROM 表名 ...

create procedure p2()
begin
declare user_count int default 0;
select count(*) into user_count from testzcy.user100w;
select user_count;
end;
call p2();

if语法
IF 条件1 then .....
ELSEIF 条件2 then ..... -- 可选
else .... -- 可选
END IF;


存储过程参数
类型
in 		该类参数作为输入，也就是需要调用时传入值   默认
out		该类参数作为输出，也就是该参数可以作为返回值
inout	既可以作为输入参数，也可以作为输出参数 

用法: 
CREATE PROCEDURE 存储过程名称([IN/OUT/INOUT 参数名 参数类型])BEGIN
SQL语句
end;

create PROCEDURE p3(in score int, out res varchar(10)) 
begin
	if score >= 85 then set res := '优秀';
	elseif score >= 60 then set res := '及格';
	else set res := '不及格';
	end if;
end;
call p3(60,@res);
select @res;

create procedure p5(inout score double)begin
	set score := score * 0.5;
end;
set @score = 198;
call p5( @score) ;
select @score; 



case语法
CASE case_value
	WHEN when_value1 THEN statement_list1
	[ WHEN when_value2 THEN statement list2] ...
	[ ELSE statement_list ]
END case;
语法二
CASE
	WHEN search_condition1 THEN statement_list1
	[ WHEN search_condition2 THEN statement_list2] ...
	[ ELSE statement_list]
END case;

set @SCORE = 'A';
select CASE @SCORE WHEN 'A' THEN '优' 
		    WHEN 'B' THEN '良'
		    WHEN 'C' THEN '中'
ELSE '不及格' end; 

select CASE WHEN @SCORE = 'A' THEN '优'
     WHEN @SCORE = 'B' THEN '良'
     WHEN @SCORE = 'C' THEN '中' 
ELSE '不及格' end;



while 循环是有条件的循环控制语句。满足条件后，再执行循环体中的SQL语句。
具体语法为:#先判定条件，如果条件为true，则执行逻辑，否则，不执行逻辑
WHILE 条件 DO
	SQL逻辑...
END WHILE;

create procedure p7(in n int)begin
	declare total int default 0;
	while n>0 do
		set total := total + n;
		set n := n - 1;
	end while;
	select total;
end;

call p7(33);

LOOP实现简单的循环，如果不在SQL逻辑中增加退出循环的条件，可以用其来实现简单的死循环。LOOP可以配合以下两个语句使用:
LEAVE:配合循环使用，退出循环。
ITERATE:必须用在循环中，作用是跳过当前循环剩下的语句，直接进入下一次循环

[begin_label:] Loop
	SQL逻辑...
END Loop [end_label];
LEAVE label; -- 退出指定标记的循环体
ITERATE label;-- 直接进入下一次循环

create procedure p9(in n int)
begin
	declare total int default 0;
	sumLoop:loop
		if n <= 0 then
			leave sumLoop;
		end if;
		set total := total + n;
		set n := n - 1;
	end loop sumLoop;
	select total;
end;

call p9(20);

---------------------------------------------------------------------------------------------------------------------
-- 游标

游标(CURSOR)是用来存储查询结果集的数据类型，在存储过程和函数中可以使用游标对结果集进行循环的处理。
游标的使用包括游标的声明、OPEN、FETCH 和 CLOSE，其语法分别如下
声明游标 
DECLARE 游标名称 CURSOR FOR 查询语句;
打开游标
OPEN 游标名称;
获取游标记录
FETCH 游标名称 INTO 变量[, 变量 ];
关闭游标
CLOSE 游标名称;

create procedure p11(in minid int)
begin
	declare uname varchar(100);
	declare uename varchar(100);
	declare u_cursor cursor for select first_name,last_name from testzcy.user100w where id <= minid;
	DECLARE exit HANDLER FOR SQLSTATE '02000' close u_cursor;
	-- DECLARE exit HANDLER FOR not found close u_cursor;
	drop table if exists user30;
	create table if not exists user30(
		id int primary key auto_increment,
		name varchar(100),
		ename varchar(100)
	);
	open u_cursor;
-- SQL 错误 [1329] [02000]: No data - zero rows fetched, selected, or processed
	while true do
		fetch u_cursor into uname ,uename;
		insert into user30 values (null, uname, uename) ;
	end while;
	close u_cursor;
end ;
call p11(33);

drop procedure p11;

条件处理程序(Handler)可以用来定义在流程控制结构执行过程中遇到问题时相应的处理步骤。具体语法为:
DECLARE handler_action HANDLER FOR condition_value [,condition_value] ... statement;

handler_action
	CONTINUE: 继续执行当前程序
	EXIT: 终止执行当前程序
	
condition value
	SQLSTATE sglstate_value: 状态码，如02000
	SQLWARNING: 所有以01开头的SQLSTATE代码的简写
	NOT FOUND: 所有以02开头的SQLSTATE代码的简写
	SQLEXCEPTION: 所有没有被SQLWARNING 或 NOT FOUND捕获的SQLSTATE代码的简写

	
---------------------------------------------------------------------------------------------------------------------	
存储函数是有返回值的存储过程，存储函数的参数只能是IN类型的。具体语法如下:
CREATE FUNCTION 存储函数名称([ 参数列表])
RETURNS type[characteristic ...]
BEGIN
	-- SQL语句
	RETURN ...;
END ;

characteristic 说明
DETERMINISTIC: 相同的输入参数总是产生相同的结果
NO SQL: 不包含 SQL 语句。
READS SQL DATA: 包含读取数据的语句，但不包含写入数据的语句。	


create function fun1(n int)
returns int DETERMINISTIC
-- returns int NO sql
begin
	declare total int default 0;
	while n>0 do
		set total := total + n;
		set n := n - 1;
	end while;
	return total;
end;

select fun1(33);

