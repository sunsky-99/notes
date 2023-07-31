-- �ͻ�������
-- mysql -h 127.0.0.1 -P 3306 -u root -p
-- docker ��������
-- docker exec -it 678b6cb65184 /bin/bash


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
 


