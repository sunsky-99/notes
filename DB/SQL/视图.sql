
视图(View)是一种虚拟存在的表。视图中的数据并不在数据库中实际存在，行和列数据来自定义视图的查询中使用的表，并且是在使用视图时动态生成的。
通俗的讲，视图只保存了查询的SQL逻辑，不保存查询结果。所以我们在创建视图的时候，主要的工作就落在创建这条S0L查询语句上。
创建视图
CREATE [OR REPLACE] VIEW 视图名称(列名列表] AS SELECT语句 [WITH[CASCADED | LOCAL] CHECK OPTION]
查看创建视图语句: SHOW CREATE VIEW; 
视图名称查看视图数据: SELECT* FROM 视图名称......

修改 
方式-: CREATE [OR REPLACE VIEW 视图名称列名列表)] AS SELECT语句 [WITHCASCADED  LOCALI CHECK option
方式二: ALTER VIEW 视图名称(列名列表)] AS SELECT语句 [WTH[ CASCADED | LOCAL] CHECK OPTION]

删除
DROP VIEW [IF EXISTS] 视图名称 [,视图名称]

CREATE OR REPLACE VIEW view_user_test1 as select id,first_name ,last_name  from testzcy.user100w uw where uw.id < 100;
SHOW CREATE view view_user_test1; 
select * from view_user_test1; 
CREATE OR REPLACE VIEW view_user_test1 as select id,first_name ,last_name  from testzcy.user100w uw where uw.id > 609990;
ALTER VIEW view_user_test1 AS select id,first_name ,last_name  from testzcy.user100w uw where uw.id < 200;

CREATE OR REPLACE VIEW view_user_test2 as select id,first_name ,last_name  from testzcy.user100w uw where uw.id < 100;
SHOW CREATE view view_user_test2; 
DROP VIEW IF exists view_user_test2; 

插入视图
insert into view_user_test1 values(610003,'123','123');

视图的检查选项
当使用WITH CHECK OPTION子句创建视图时，MySQL会通过视图检查正在更改的每个行，例如 插入，更新，删除，以使其符合视图的定义。
MySQL允许基于另一个视图创建视图，它还会检查依赖视图中的规则以保持一致性。
为了确定检查的范围，mysql提供了两个选项:CASCADED和LOCAL，默认值为 cascaded


create view v1 as select id,name from student where id <= 20 with cascaded check option ;
create view v2 as select id , name from v1 where id >= 10 with cascaded check option 
create view v3 as select id . name from v2 where id <= 15
create view v1 as select id,name from student where id <= 15
create view v2 as select id , name from v1 where id >= 10 with local check option ;
create view v3 as select id , name from v2 where id < 20

视图的更新
要使视图可更新，视图中的行与基础表中的行之间必须存在一对一的关系。如果视图包含以下任何一项，则该视图不可更新:
聚合函数或窗口函数(SUM()、MIN()、MAX()、COUNT()等)、
distinct、GROUP by、having、UNION 或者UNION all

视图作用
简单：视图不仅可以简化用户对数据的理解，也可以简化他们的操作。那些被经常使用的查询可以被定义为视图，从而使得用户不必为以后的操作每次指定全部的条件
安全：数据库可以授权，但不能授权到数据库特定行和特定的列上。通过视图用户只能查询和修改他们所能见到的数据
数据独立：视图可帮助用户屏蔽真实表结构变化带来的影响