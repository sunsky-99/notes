Mysql下载 安装步骤
1. 使用 wget 下载RPM包
wget https://repo.mysql.com//mysql80-community-release-el7-7.noarch.rpm
使用 wget 会默认下载到当前所在目录下
安装指令：yum localinstall RPM全名
yum localinstall mysql80-community-release-el7-7.noarch.rpm
安装完成后在：/etc/yum.repos.d下会出现三个Mysql文件（安装完成）
通过以下命令安装MySQL：
yum install mysql-community-server -y

MySQL初始化
# MySQL表名不区分大小写 需在MySQL初始化前配置
lower_case_table_names = 1 

# 开启慢查询日志
slow_query_log = 1
# 设置慢查询时间
long_query_time = 1




# 启动 MySQL
systemctl start mysqld

# 重启 MySQL
systemctl restart mysqld

# 查看 MySQL 运行状态：
systemctl status mysqld

linux进入mysql
mysql -u root -p




进入mysql库
use mysql;

查看用户表 
SELECT Host,User FROM user;

#修改密码
ALTER USER 'root'@'localhost' IDENTIFIED BY 'Zcy123456!';

更新用户表全局访问 
UPDATE user SET Host= '%' WHERE User= 'root' LIMIT 1;

强制刷新权限
flush privileges;



Linux防火墙状态查看的方法

iptables 防火墙
# 查看防火墙状态
service iptables status
 
# 停止防火墙
service iptables stop
 
# 启动防火墙
service iptables start
 
# 重启防火墙
service iptables restart
 
# 永久关闭防火墙
chkconfig iptables off
 
# 永久关闭后重启
chkconfig iptables on

# 开启80端口
vim /etc/sysconfig/iptables
# 加入如下代码
-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
# 保存退出后重启防火墙
service iptables restart

firewall防火墙
# 查看firewall服务状态
systemctl status firewalld
# 出现Active: active (running)切高亮显示则表示是启动状态。
# 出现 Active: inactive (dead)灰色表示停止，看单词也行。

# 查看firewall的状态
firewall-cmd --state

# 查看防火墙规则
firewall-cmd --list-all

#查询、开放、关闭端口
# 查询端口是否开放
firewall-cmd --query-port=8080/tcp
 
# 开放80端口
firewall-cmd --permanent --add-port=80/tcp
 
# 移除端口
firewall-cmd --permanent --remove-port=8080/tcp
 
#重启防火墙(修改配置后要重启防火墙)
firewall-cmd --reload

# 参数解释
1、firwall-cmd：是Linux提供的操作firewall的一个工具；
2、--permanent：表示设置为持久；
3、--add-port：标识添加的端口；