�洢���������Ⱦ������벢�洢�����ݿ��е�һ�� SQL ���ļ��ϣ����ô洢���̿��Լ�Ӧ�ÿ�����Ա�ĺܶ๤�����������������ݿ��Ӧ�÷�����֮��Ĵ��䣬����������ݴ����Ч�����кô��ġ�
�洢����˼���Ϻܼ򵥣��������ݿ�SQL ���Բ���Ĵ����װ������

�ص�
��װ�����ã�
���Խ��ղ�����Ҳ���Է������ݣ�
�������罻����Ч��������

�洢���̻����﷨
���� ���Դ��ݲ����ͷ��ز���
create procedure p1()
begin
select count(*) from testzcy.user100w;
end;
����
call p1(); 
-- ��ѯָ�����ݿ�Ĵ洢���̼�״��Ϣ
select * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'testzcy'; 
-- ��ѯĳ���洢���̵Ķ���
SHOW CREATE PROCEDURE p1;
-- ɾ��
DROP PROCEDURE IF EXISTS p1;
ע��: ���������У�ִ�д����洢���̵�SQLʱ����Ҫͨ���ؼ��� delimiter ָ��SQL���Ľ�����


����
ϵͳ���� ��MySQL�������ṩ�������û�����ģ����ڷ��������档��Ϊȫ�ֱ���(GLOBAL)���Ự����(SESSION)
-- �鿴����ϵͳ����
SHOW [ SESSION|GLOBAL] VARIABLES ;
-- ����ͨ��LIKEģ��ƥ�䷽ʽ���ұ���
SHOW [SESSION|GLOBAL] VARIABLES LIKE��....; 
-- �鿴ָ��������ֵ
SELECT @@[SESSION|GLOBAL] ϵͳ������;
����ϵͳ����
SET [ SESSION|GLOBAL] ϵͳ������=ֵ
SET @@[SESSION|GLOBAL]ϵͳ������ = ֵ


SHOW  VARIABLES ;

���û��ָ��SESSION/GLOBAL��Ĭ����SESSION�Ự������
mysql������������֮�������õ�ȫ�ֲ�����ʧЧ,Ҫ�벻ʧЧ�������� /etc/my.cnf ������

�û�������� 
���û�������Ҫ�Լ�����ı������û�����������ǰ���������õ�ʱ��ֱ���á�@��������ʹ�þͿ��ԡ���������Ϊ��ǰ���ӡ�

��ֵ
SET @var_name = expr [, @var_name = expr] ... ;
SET @var_name := expr l @var_name := expr] ... ;
SELECT @var_name := expr [, @var_name := expr] ... ;
SELECT �ֶ��� INTO @var_name FROM ����;
ʹ��
SELECT @var_name ;
��ֵ
set @myName = '����';
set @myAge := 22;
set @myName = '����',@myAge = 23;
SELECT @mySex := '1' ;
select count(*) into @myMax from testzcy.user100w;
ʹ��
SELECT @myName,@myAge,@mySex,@myMax ;
�û�����ı��������������������ʼ����ֻ������ȡ����ֵΪNULL
SELECT @tes;


�ֲ����� 
�Ǹ�����Ҫ������ھֲ���Ч�ı���������֮ǰ����ҪDECLARE�������������洢�����ڵľֲ�����������������ֲ������ķ�Χ��������������BEGIN ...END��

����
DECLARE ������ ��������[DEFAULT ...];
�������;������ݿ��ֶ�����:INT��BIGINT��CHAR��VARCHAR��DATE��TIME�ȸ�ֵ
SET ������=ֵ
SET ������ := ֵ ;
SELECT �ֶ��� INTO ������ FROM ���� ...

create procedure p2()
begin
declare user_count int default 0;
select count(*) into user_count from testzcy.user100w;
select user_count;
end;
call p2();

if�﷨
IF ����1 then .....
ELSEIF ����2 then ..... -- ��ѡ
else .... -- ��ѡ
END IF;


�洢���̲���
����
in 		���������Ϊ���룬Ҳ������Ҫ����ʱ����ֵ   Ĭ��
out		���������Ϊ�����Ҳ���Ǹò���������Ϊ����ֵ
inout	�ȿ�����Ϊ���������Ҳ������Ϊ������� 

�÷�: 
CREATE PROCEDURE �洢��������([IN/OUT/INOUT ������ ��������])BEGIN
SQL���
end;

create PROCEDURE p3(in score int, out res varchar(10)) 
begin
	if score >= 85 then set res := '����';
	elseif score >= 60 then set res := '����';
	else set res := '������';
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



case�﷨
CASE case_value
	WHEN when_value1 THEN statement_list1
	[ WHEN when_value2 THEN statement list2] ...
	[ ELSE statement_list ]
END case;
�﷨��
CASE
	WHEN search_condition1 THEN statement_list1
	[ WHEN search_condition2 THEN statement_list2] ...
	[ ELSE statement_list]
END case;

set @SCORE = 'A';
select CASE @SCORE WHEN 'A' THEN '��' 
		    WHEN 'B' THEN '��'
		    WHEN 'C' THEN '��'
ELSE '������' end; 

select CASE WHEN @SCORE = 'A' THEN '��'
     WHEN @SCORE = 'B' THEN '��'
     WHEN @SCORE = 'C' THEN '��' 
ELSE '������' end;



while ѭ������������ѭ��������䡣������������ִ��ѭ�����е�SQL��䡣
�����﷨Ϊ:#���ж��������������Ϊtrue����ִ���߼������򣬲�ִ���߼�
WHILE ���� DO
	SQL�߼�...
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

LOOPʵ�ּ򵥵�ѭ�����������SQL�߼��������˳�ѭ��������������������ʵ�ּ򵥵���ѭ����LOOP������������������ʹ��:
LEAVE:���ѭ��ʹ�ã��˳�ѭ����
ITERATE:��������ѭ���У�������������ǰѭ��ʣ�µ���䣬ֱ�ӽ�����һ��ѭ��

[begin_label:] Loop
	SQL�߼�...
END Loop [end_label];
LEAVE label; -- �˳�ָ����ǵ�ѭ����
ITERATE label;-- ֱ�ӽ�����һ��ѭ��

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
-- �α�

�α�(CURSOR)�������洢��ѯ��������������ͣ��ڴ洢���̺ͺ����п���ʹ���α�Խ��������ѭ���Ĵ���
�α��ʹ�ð����α��������OPEN��FETCH �� CLOSE�����﷨�ֱ�����
�����α� 
DECLARE �α����� CURSOR FOR ��ѯ���;
���α�
OPEN �α�����;
��ȡ�α��¼
FETCH �α����� INTO ����[, ���� ];
�ر��α�
CLOSE �α�����;

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
-- SQL ���� [1329] [02000]: No data - zero rows fetched, selected, or processed
	while true do
		fetch u_cursor into uname ,uename;
		insert into user30 values (null, uname, uename) ;
	end while;
	close u_cursor;
end ;
call p11(33);

drop procedure p11;

�����������(Handler)�����������������̿��ƽṹִ�й�������������ʱ��Ӧ�Ĵ����衣�����﷨Ϊ:
DECLARE handler_action HANDLER FOR condition_value [,condition_value] ... statement;

handler_action
	CONTINUE: ����ִ�е�ǰ����
	EXIT: ��ִֹ�е�ǰ����
	
condition value
	SQLSTATE sglstate_value: ״̬�룬��02000
	SQLWARNING: ������01��ͷ��SQLSTATE����ļ�д
	NOT FOUND: ������02��ͷ��SQLSTATE����ļ�д
	SQLEXCEPTION: ����û�б�SQLWARNING �� NOT FOUND�����SQLSTATE����ļ�д

	
---------------------------------------------------------------------------------------------------------------------	
�洢�������з���ֵ�Ĵ洢���̣��洢�����Ĳ���ֻ����IN���͵ġ������﷨����:
CREATE FUNCTION �洢��������([ �����б�])
RETURNS type[characteristic ...]
BEGIN
	-- SQL���
	RETURN ...;
END ;

characteristic ˵��
DETERMINISTIC: ��ͬ������������ǲ�����ͬ�Ľ��
NO SQL: ������ SQL ��䡣
READS SQL DATA: ������ȡ���ݵ���䣬��������д�����ݵ���䡣	


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

