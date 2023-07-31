
-- mysql事务 默认自动提交 
-- 事务有四个特性：一致性、持久性、原子性、隔离性

-- 查看/设置事务提交方式   1自动提交   0手动提交
select @@autocommit;
set @@autocommit = 0 ;
set @@autocommit = 1 ;

select * from zcy_test1 zt ;
update zcy_test1 set age = 18 where UUID = 7;
update zcy_test1 set age = 18 where UUID = 1;
-- 提交事务
commit;
-- 回滚事务
rollback;

-- 手动开启事务 start transaction 或 begin
start transaction ;


/*1、事务定义 
事务：事务是一个最小的不可在分的工作单元；通常一个事务对应一个完整的业务(例如银行账户转账业务，该业务是一个最小的工作单元)
一个完整的业务需要批量的DML(insert、update、delete)语句共同联合完成。
事务只和DML语句有关，或者说DML语句才有事务。这个和业务逻辑有关，业务逻辑不同，DML语句的个数不同。
2.事务是什么？
多个操作同时进行,那么同时成功，那么同时失败。这就是事务。
事务有四个特性：一致性、持久性、原子性、隔离性。
二、事务的四大性质 ACID
原子性(Atomicity)：事务是一个不可分割的工作单位，要么同时成功，要么同时失败。
　　例：当两个人发起转账业务时，如果A转账发起，而B因为一些原因不能成功接受，事务最终将不会提交，则A和B的请求最终不会成功。
持久性(Consistency)：一旦事务提交，他对数据库的改变就是永久的。
　　注：只要提交了事务，将会对数据库的数据进行永久性刷新。
隔离性(Isolation)：多个事务之间相互隔离的，互不干扰
一致性：事务执行接收之后，数据库完整性不被破坏
注意：只有当前三条性质都满足了，才能保证事务的一致性*/

-- 事务并发问题 脏读  一个事务读到另一个还没有提交的数据
-- 事务并发问题 不可重复读 一个事务先后读取同一条数据，但两次读取的数据不同
-- 事务并发问题 幻读 一个事务按照条件查询数据时，没有对应数据行，但在插入数据时，又发现这行数据已经存在，好像出现了幻影

-- 事务的隔离级别
/*read uncommitted(读取未提交)： 最低的隔离级别，允许读取尚未提交的数据变更，可能会导致脏读、幻读或不可重复读。
read committed(读取已提交)： 允许读取并发事务已经提交的数据，可以阻止脏读，但是幻读或不可重复读仍有可能发生。
repeatable read(可重复读)： 对同一字段的多次读取结果都是一致的，除非数据是被本身事务自己所修改，可以阻止脏读和不可重复读，但幻读仍有可能发生。
serializable(可串行化)： 最高的隔离级别，完全服从ACID的隔离级别。所有的事务依次逐个执行，这样事务之间就完全不可能产生干扰，也就是说，该级别可以防止脏读、不可重复读以及幻
读。*/

-- 查看事务隔离级别 默认repeatable read(可重复读)：
SELECT @@transaction_isolation;
-- 设置事务隔离级别 
-- session 仅对当前会话有效 global所有客户端有效
set session transaction isolation level read committed;
set session transaction isolation level repeatable read;
