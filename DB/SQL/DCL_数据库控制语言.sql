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

 