-- �ͻ�������
-- mysql -h 127.0.0.1 -P 3306 -u root -p
-- docker ��������
-- docker exec -it 678b6cb65184 /bin/bash

/*
һ��DQL
DQL(data Query Language) ���ݲ�ѯ����
������������õ��� SELECT���飩��� ����Ҫ���������ݿ��е����ݽ��в�ѯ������

����DML
DML��data manipulation language�����ݲ������ԣ�
������������õ��� INSERT��������DELETE��ɾ����UPDATE���ģ�����Ҫ���������ݿ��ر�����ݽ���һЩ��ɾ�Ĳ�����

����DDL
DDL��data definition language�����ݿⶨ�����ԣ�
���������ڴ������ʱ���õ���һЩsql������˵��CREATE��ALTER��DROP�ȡ���Ҫ�����ڶ����ı��Ľṹ���������ͣ���֮������Ӻ�Լ���ȳ�ʼ�������ϡ�
 

�ġ�DCL
DCL��Data Control Language�����ݿ�������ԣ�
���������û�������ݿ��û����ɫȨ�޵���䣬������grant������Ȩ�ޣ�,deny���ܾ�Ȩ�ޣ�,revoke���ջ�Ȩ�ޣ��ȣ���䡣����Ƚ����õ���
*/

/*==================================================================================================*/
-- DDL ���ݿⶨ������

-- SHOW DATABASES�����ʾȨ�޷�Χ�����е����ݿ���
SHOW DATABASES;
-- ��ѯ��ǰ����ʹ�õ����ݿ�����
SELECT DATABASE();

-- �������ݿ�  ����������򴴽�
CREATE DATABASE IF NOT EXISTS TEST2;

-- ɾ�����ݿ� ���������ɾ��
DROP DATABASE IF EXISTS TEST2;

-- �л����ݿ�
USE TEST1;
SELECT DATABASE();

-- ��ѯ��ǰ���ݿ����б�
SHOW TABLES;

-- ��ѯ��ṹ
DESC TEST;

-- ����
CREATE TABLE ZCY_TEST1(
	UUID INT COMMENT '����ID',
	NAME VARCHAR(50) COMMENT '����',
	AGE INT COMMENT '����',
	SEX CHAR COMMENT '�Ա�'
) COMMENT 'ZCY���Ա�1' ;

DESC ZCY_TEST1;

-- ��ѯָ����Ľ������
SHOW CREATE TABLE ZCY_TEST1;

CREATE TABLE `ZCY_TEST1` (
  `UUID` INT DEFAULT NULL COMMENT '����ID',
  `NAME` VARCHAR(50) COLLATE UTF8MB4_GERMAN2_CI DEFAULT NULL COMMENT '����',
  `AGE` INT DEFAULT NULL COMMENT '����',
  `SEX` CHAR(1) COLLATE UTF8MB4_GERMAN2_CI DEFAULT NULL COMMENT '�Ա�'
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4 COLLATE=UTF8MB4_GERMAN2_CI COMMENT='ZCY���Ա�1'

-- ����������ϸ

-- �����  
-- ��ӱ��ֶ�
ALTER TABLE ZCY_TEST1 ADD ENAME VARCHAR(20) COMMENT 'Ӣ����';
ALTER TABLE test1.zcy_test1 ADD STUDY varchar(20) DEFAULT "" NULL COMMENT 'ѧ��';

-- �޸ı��ֶ���������
ALTER TABLE ZCY_TEST1 MODIFY ENAME CHAR(5) COMMENT 'Ӣ����'; 

-- �޸ı��ֶ�������������
ALTER TABLE ZCY_TEST1 CHANGE ENAME NEW_ENAME VARCHAR(20) COMMENT '��Ӣ����';

-- ɾ���ֶ�
ALTER TABLE ZCY_TEST1 DROP NEW_ENAME;

-- �޸ı���
ALTER TABLE ZCY_TEST1 RENAME TO ZCY_TEST;

-- ɾ����
DROP TABLE IF EXISTS ZCY_TEST1;

-- ɾ��ָ�������´����ñ�
TRUNCATE TABLE ZCY_TEST1;

/*==================================================================================================*/
-- DML ���ݿ��������
-- ������������ 
INSERT INTO ZCY_TEST1 VALUES 
(1,1,1,1),
(2,2,2,2),
(4,2,2,2);

INSERT INTO ZCY_TEST1 (UUID,NAME) VALUES 
(5,1),
(6,2);

-- �޸����
UPDATE ZCY_TEST1 SET NAME = '����2' ,SEX = '��'
WHERE UUID =  2 ;

-- ɾ�����
DELETE FROM ZCY_TEST1 WHERE UUID = 4;  

-- ��������
ALTER TABLE ZCY_TEST1 ADD CONSTRAINT PRIMARY KEY(UUID);


/*==================================================================================================*/
-- DCL���ݿ��������
-- �����û�  User@HOST ȷ��һ���û�  host����������ʹ��%ͨ��
use mysql;
-- ����ֻ�ܱ��ط��ʵ��û�userZcy ����Zcy123456
create user 'userZcy'@'localhost' IDENTIFIED by 'Zcy123456!';

-- �޸��û�����
alter user 'userZcy'@'localhost' IDENTIFIED with mysql_native_password by 'Zcy123456!';

-- ɾ���û�
drop user 'userZcy'@'localhost' ;

-- �����û�Ȩ��
create user 'userZcy'@'%' IDENTIFIED by 'Zcy123123!';
-- Ȩ�޿���
-- ��ѯ�û�Ȩ��
show Grants for 'userZcy'@'%';
show Grants for 'root'@'%';

-- ����Ȩ��
-- ���û� 'userZcy'@'%' ���� test1���ݿ�����в���Ȩ��
grant all on test1.* to 'userZcy'@'%';

-- ����Ȩ��
revoke all on test1.* from 'userZcy'@'%';

select * from user;


/*==================================================================================================*/
-- DQL ���ݿ��ѯ����

select * from zcy_test1 ;
-- AS(����ʡ��)����
select UUID as "id" ,name as "����",age "����" from zcy_test1 zt ;

-- ȥ�� distinct
select distinct uuid ,name  from zcy_test1 zt ;

-- ������ʽ _���ȼ�Ϊ�ַ�����
select uuid ,name  from zcy_test1 zt
where name like '_' ;

select uuid ,name  from zcy_test1 zt
where name like '%2' ;


-- �ۺϺ��� count avg sum  max min
-- nullֵ���������оۺϺ���������
-- where ����ǰ�����ݹ���
-- having ���������ݹ���
-- Group by ���� �����Ĳ�ѯ�ֶ�һ��Ϊ�ۺϺ����ͷ����ֶ�
-- order by ���� Ĭ������ ASC  ����DESC    (����ʱnull�����Ϸ�)
-- limit��ʼ����,ÿҳ��¼�� ��ҳ 0,2 �ӵ�һҳ��ʼչʾ2������
select count(uuid),avg(age),sum(AGE),max(AGE),min(AGE) ,SEX  ,STUDY
from zcy_test1 zt
where AGE > 0
group by SEX ,STUDY
having avg(age) > 1
order by  SEX ASC ,STUDY desc
limit 0,2
/*DQL��д˳��
 * select �ֶ�
 * from ����
 * where ����
 * GROUP by �����ֶ�
 * having ����������
 * order by �����ֶ�
 * limit ��ҳ����
 * */
/*DQL ��ѯ˳��
 * from ���� where ���� GROUP by �����ֶ� having ���������� select �ֶ� order by �����ֶ� limit ��ҳ����
 * */


-- ����ѯ ������ ������ ������ �Ӳ�ѯ
select * from zcy_test1,zcy_test2

-- ��ʽ������
select * from zcy_test1 zt ,zcy_test2 zt2 where zt.UUID = zt2.test1_id ;
-- ��ʾ������
select * from zcy_test1 zt inner join zcy_test2 zt2 on zt.UUID = zt2.test1_id ;
select * from zcy_test1 zt join zcy_test2 zt2 on zt.UUID = zt2.test1_id ;

-- ��������
select * from zcy_test1 zt left join zcy_test2 zt2 on zt.UUID = zt2.test1_id ;
-- ��������
select * from zcy_test1 zt right join zcy_test2 zt2 on zt.UUID = zt2.test1_id ;

-- ������
-- ���ϲ�ѯ union
/*1��union��union all���Ƕ�����������select���Ľ����
2��ʹ��union��union allҪע���������������ͬ���������У�ͬʱ��Ҳ��������ͬ�����Ƶ���������
3��ÿ��select����е��е�˳��Ҳ�Ǳ�����ͬ��
4��union�õ�����û���ظ��ļ�¼��union all�õ����Ǽ�¼���������ű��м�¼������֮��*/
select * from zcy_test1
union
select * from zcy_test1;

select * from zcy_test1
union all
select * from zcy_test1;

-- �Ӳ�ѯ
select * from zcy_test1 where uuid = (select uuid from zcy_test1 z where NAME = '����')


