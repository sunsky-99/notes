
��ͼ(View)��һ��������ڵı���ͼ�е����ݲ��������ݿ���ʵ�ʴ��ڣ��к����������Զ�����ͼ�Ĳ�ѯ��ʹ�õı���������ʹ����ͼʱ��̬���ɵġ�
ͨ�׵Ľ�����ͼֻ�����˲�ѯ��SQL�߼����������ѯ��������������ڴ�����ͼ��ʱ����Ҫ�Ĺ��������ڴ�������S0L��ѯ����ϡ�
������ͼ
CREATE [OR REPLACE] VIEW ��ͼ����(�����б�] AS SELECT��� [WITH[CASCADED | LOCAL] CHECK OPTION]
�鿴������ͼ���: SHOW CREATE VIEW; 
��ͼ���Ʋ鿴��ͼ����: SELECT* FROM ��ͼ����......

�޸� 
��ʽ-: CREATE [OR REPLACE VIEW ��ͼ���������б�)] AS SELECT��� [WITHCASCADED  LOCALI CHECK option
��ʽ��: ALTER VIEW ��ͼ����(�����б�)] AS SELECT��� [WTH[ CASCADED | LOCAL] CHECK OPTION]

ɾ��
DROP VIEW [IF EXISTS] ��ͼ���� [,��ͼ����]

CREATE OR REPLACE VIEW view_user_test1 as select id,first_name ,last_name  from testzcy.user100w uw where uw.id < 100;
SHOW CREATE view view_user_test1; 
select * from view_user_test1; 
CREATE OR REPLACE VIEW view_user_test1 as select id,first_name ,last_name  from testzcy.user100w uw where uw.id > 609990;
ALTER VIEW view_user_test1 AS select id,first_name ,last_name  from testzcy.user100w uw where uw.id < 200;

CREATE OR REPLACE VIEW view_user_test2 as select id,first_name ,last_name  from testzcy.user100w uw where uw.id < 100;
SHOW CREATE view view_user_test2; 
DROP VIEW IF exists view_user_test2; 

������ͼ
insert into view_user_test1 values(610003,'123','123');

��ͼ�ļ��ѡ��
��ʹ��WITH CHECK OPTION�Ӿ䴴����ͼʱ��MySQL��ͨ����ͼ������ڸ��ĵ�ÿ���У����� ���룬���£�ɾ������ʹ�������ͼ�Ķ��塣
MySQL���������һ����ͼ������ͼ����������������ͼ�еĹ����Ա���һ���ԡ�
Ϊ��ȷ�����ķ�Χ��mysql�ṩ������ѡ��:CASCADED��LOCAL��Ĭ��ֵΪ cascaded


create view v1 as select id,name from student where id <= 20 with cascaded check option ;
create view v2 as select id , name from v1 where id >= 10 with cascaded check option 
create view v3 as select id . name from v2 where id <= 15
create view v1 as select id,name from student where id <= 15
create view v2 as select id , name from v1 where id >= 10 with local check option ;
create view v3 as select id , name from v2 where id < 20

��ͼ�ĸ���
Ҫʹ��ͼ�ɸ��£���ͼ�е�����������е���֮��������һ��һ�Ĺ�ϵ�������ͼ���������κ�һ������ͼ���ɸ���:
�ۺϺ����򴰿ں���(SUM()��MIN()��MAX()��COUNT()��)��
distinct��GROUP by��having��UNION ����UNION all

��ͼ����
�򵥣���ͼ�������Լ��û������ݵ���⣬Ҳ���Լ����ǵĲ�������Щ������ʹ�õĲ�ѯ���Ա�����Ϊ��ͼ���Ӷ�ʹ���û�����Ϊ�Ժ�Ĳ���ÿ��ָ��ȫ��������
��ȫ�����ݿ������Ȩ����������Ȩ�����ݿ��ض��к��ض������ϡ�ͨ����ͼ�û�ֻ�ܲ�ѯ���޸��������ܼ���������
���ݶ�������ͼ�ɰ����û�������ʵ��ṹ�仯������Ӱ��