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
