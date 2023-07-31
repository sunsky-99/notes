 
-- ���� �ַ�������
-- CONCAT ƴ���ַ��� ; -- TRIM ɾ���ַ�������ո� �� REPLACE �ַ����滻
select CONCAT("A","B"),CONCAT("A","B","c"),TRIM("  a  a  "),replace("abc","b","��1");
-- LENGTH �����ַ������ֽڳ��� ; CHAR_LENGTH �����ַ������ַ����� ;
select length("abc"),length("���ؾ�"),CHAR_LENGTH("abc"),CHAR_LENGTH("���ؾ�");
-- LOWER �ַ���Сд ; UPPER �ַ�����д ; REVERSE �ַ�����ת ;
select lower("AA"),upper("aa"),REVERSE("abc") ; 
-- SUBSTRING ��ȡ�ַ���  LEFT(str,len)���������ַ��� str ���� len ���ַ���RIGHT(str,len)���������ַ��� str �Ҳ�� len ���ַ�
select SUBSTRING("ABCDE",1,2),SUBSTRING("ABCDE",2,2),left("ABCDE",2),right("12345",2);
-- LPAD()/RPAD() ��������ַ���
select lpad("ABC",6,"DE"),rpad("ABC",6,"DE")  ;

-- ���� ��ֵ����
-- rand()	���� 0 �� 1 �ڵ����ֵ  
select rand(),
-- truncate(num,n)	�������� num �ض�Ϊ n λС���Ľ�� ;round(num,n)	���� num ����������� n λС����ֵ
select truncate(2.333,2),round(2.333333,2);
-- ceil(num) ���ش��� num ����С����ֵ  ; floor  ����С�� num ���������ֵ  ;
select ceil(2.1),ceil(-2.8),floor(2.1),floor(-2.8);
-- abs(num)	���� num �ľ���ֵ ;sqrt(num)	���� num ��ƽ����
select abs(2),abs(-2) , sqrt(4);
-- mod(num1,num2)	���� num1 �� num2 ����ģ������
select mod(5,3);

-- ���� ���ں��� 
-- now() ��ǰ������ʱ����;current_DATE()��ǰ������;current_time() ��ǰʱ����
select now(),  current_DATE(),curdate()  ,current_time(),curtime() ;
-- ��year();��month();��day()
select   year(now()),month(now()),day(now()) ;
-- DATE_ADD ����ʱ�����Ӽ���
select DATE_ADD(now(),interval  1 day),DATE_ADD(now(),interval  -1 day);
-- DATEDIFF()�����������������ڲ� 
select  DATEDIFF(DATE_ADD(now(),interval  1 day),DATE_ADD(now(),interval  -1 day))
-- TIMEDIFF()��������������ʱ���
select  TIMEDIFF(DATE_ADD(now(),interval  1 day),DATE_ADD(now(),interval  -1 day))
-- ��ǰ����ʱ��
select CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP, LOCALTIME(), LOCALTIME, LOCALTIMESTAMP(), LOCALTIMESTAMP, NOW(), SYSDATE() 

-- ���� ���̺���
select if(false,1,2),ifnull(null,2),
case when 2>1 then "��1" 
	 when 5>6 then "��2" 
else "��һ" end;

select case 1 when 1 then "��һ" else "����" end;


-- Լ��
-- �ǿ�Լ�� not null ; ΨһԼ�� unque; ����Լ�� primary key; Ĭ��ֵ default; ���Լ�� check; ���Լ�� foreign key;����Լ�� auto_increment

-- ������
alter table test1.zcy_test2 add constraint fk_test1_id foreign key (test1_id) references test1.zcy_test1(uuid);
-- ɾ�����
alter table test1.zcy_test2  drop foreign key fk_test1_id ;
-- �����ɾ���͸�����Ϊ (ɾ�������ʱ�Ĺ���)
/*ɾ��ʱ���ԣ�ȡֵ��ͼΪ��Ĭ�ϣ�RESTRICT����RESTRICT��NO ACTION��CASCADE��SET NULL���ԡ�
����ʱ���ԣ�ȡֵ��ͼΪ��Ĭ�ϣ�RESTRICT����RESTRICT��NO ACTION��CASCADE��SET NULL���ԡ�
ȡֵΪ SET NULL ʱ�����ڸ������������Դ����ɾ����Ӧ��¼ʱ�����ȼ��ü�¼�Ƿ��ж�Ӧ�����������������ӱ��и����ֵΪnull���������Ҫ����������ȡnull����
��ȡֵΪ CASCADE ʱ�����ڸ������������Դ����ɾ����Ӧ��¼ʱ�����ȼ��ü�¼�Ƿ��ж�Ӧ������������Ҳɾ��������ӱ�����������ı��еļ�¼��
��ȡֵΪ NO ACTION ����RESTRICTʱ�����ڸ������������Դ����ɾ����Ӧ��¼ʱ�����ȼ��ü�¼�Ƿ��ж�Ӧ����������������ɾ����
**/
alter table test1.zcy_test2 add constraint fk_test1_id foreign key (test1_id) references test1.zcy_test1(uuid) on update cascade on delete cascade ;





