Mysql���� ��װ����
1. ʹ�� wget ����RPM��
wget https://repo.mysql.com//mysql80-community-release-el7-7.noarch.rpm
ʹ�� wget ��Ĭ�����ص���ǰ����Ŀ¼��
��װָ�yum localinstall RPMȫ��
yum localinstall mysql80-community-release-el7-7.noarch.rpm
��װ��ɺ��ڣ�/etc/yum.repos.d�»��������Mysql�ļ�����װ��ɣ�
ͨ���������װMySQL��
yum install mysql-community-server -y

MySQL��ʼ��
# MySQL���������ִ�Сд ����MySQL��ʼ��ǰ����
lower_case_table_names = 1 

# ��������ѯ��־
slow_query_log = 1
# ��������ѯʱ��
long_query_time = 1




# ���� MySQL
systemctl start mysqld

# ���� MySQL
systemctl restart mysqld

# �鿴 MySQL ����״̬��
systemctl status mysqld

linux����mysql
mysql -u root -p




����mysql��
use mysql;

�鿴�û��� 
SELECT Host,User FROM user;

#�޸�����
ALTER USER 'root'@'localhost' IDENTIFIED BY 'Zcy123456!';

�����û���ȫ�ַ��� 
UPDATE user SET Host= '%' WHERE User= 'root' LIMIT 1;

ǿ��ˢ��Ȩ��
flush privileges;



Linux����ǽ״̬�鿴�ķ���

iptables ����ǽ
# �鿴����ǽ״̬
service iptables status
 
# ֹͣ����ǽ
service iptables stop
 
# ��������ǽ
service iptables start
 
# ��������ǽ
service iptables restart
 
# ���ùرշ���ǽ
chkconfig iptables off
 
# ���ùرպ�����
chkconfig iptables on

# ����80�˿�
vim /etc/sysconfig/iptables
# �������´���
-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
# �����˳�����������ǽ
service iptables restart

firewall����ǽ
# �鿴firewall����״̬
systemctl status firewalld
# ����Active: active (running)�и�����ʾ���ʾ������״̬��
# ���� Active: inactive (dead)��ɫ��ʾֹͣ��������Ҳ�С�

# �鿴firewall��״̬
firewall-cmd --state

# �鿴����ǽ����
firewall-cmd --list-all

#��ѯ�����š��رն˿�
# ��ѯ�˿��Ƿ񿪷�
firewall-cmd --query-port=8080/tcp
 
# ����80�˿�
firewall-cmd --permanent --add-port=80/tcp
 
# �Ƴ��˿�
firewall-cmd --permanent --remove-port=8080/tcp
 
#��������ǽ(�޸����ú�Ҫ��������ǽ)
firewall-cmd --reload

# ��������
1��firwall-cmd����Linux�ṩ�Ĳ���firewall��һ�����ߣ�
2��--permanent����ʾ����Ϊ�־ã�
3��--add-port����ʶ��ӵĶ˿ڣ�