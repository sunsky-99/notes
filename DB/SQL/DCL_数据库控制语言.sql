-- DCL数据库控制语言
-- 创建用户  User@HOST 确认一个用户  host主机名可以使用%通配
use mysql;
-- 创建只能本地访问的用户userZcy 密码Zcy123456
create user 'userZcy'@'localhost' IDENTIFIED by 'Zcy123456!';

-- 修改用户密码
alter user 'userZcy'@'localhost' IDENTIFIED with mysql_native_password by 'Zcy123456!';

-- 删除用户
drop user 'userZcy'@'localhost' ;

-- 测试用户权限
create user 'userZcy'@'%' IDENTIFIED by 'Zcy123123!';
-- 权限控制
-- 查询用户权限
show Grants for 'userZcy'@'%';
show Grants for 'root'@'%';

-- 授予权限
-- 给用户 'userZcy'@'%' 授予 test1数据库的所有操作权限
grant all on test1.* to 'userZcy'@'%';

-- 撤销权限
revoke all on test1.* from 'userZcy'@'%';

select * from user;

 