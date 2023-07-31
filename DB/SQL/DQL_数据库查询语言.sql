-- DQL 数据库查询语言

select * from zcy_test1 ;
-- AS(可以省略)别名 
select UUID as "id" ,name as "名称",age "年龄" from zcy_test1 zt ;

-- 去重 distinct
select distinct uuid ,name  from zcy_test1 zt ;

-- 正则表达式 _长度即为字符长度
select uuid ,name  from zcy_test1 zt 
where name like '_' ;

select uuid ,name  from zcy_test1 zt 
where name like '%2' ;


-- 聚合函数 count avg sum  max min
-- null值不参与所有聚合函数的运算 
-- where 分组前的数据过滤
-- having 分组后的数据过滤
-- Group by 分组 分组后的查询字段一般为聚合函数和分组字段
-- order by 排序 默认升序 ASC  降序DESC    (升序时null排最上方)
-- limit起始索引,每页记录数 分页 0,2 从第一页开始展示2条数据
select count(uuid),avg(age),sum(AGE),max(AGE),min(AGE) ,SEX  ,STUDY 
from zcy_test1 zt 
where AGE > 0 
group by SEX ,STUDY 
having avg(age) > 1
order by  SEX ASC ,STUDY desc 
limit 0,2
/*DQL编写顺序
 * select 字段
 * from 表名
 * where 条件
 * GROUP by 分组字段
 * having 分组后的条件
 * order by 排序字段
 * limit 分页参数
 * */
/*DQL 查询顺序
 * from 表名 where 条件 GROUP by 分组字段 having 分组后的条件 select 字段 order by 排序字段 limit 分页参数
 * */


-- 多表查询 内连接 自连接 外连接 子查询 
select * from zcy_test1,zcy_test2  
 
-- 隐式内连接 
select * from zcy_test1 zt ,zcy_test2 zt2 where zt.UUID = zt2.test1_id ;
-- 显示内连接 
select * from zcy_test1 zt inner join zcy_test2 zt2 on zt.UUID = zt2.test1_id ;
select * from zcy_test1 zt join zcy_test2 zt2 on zt.UUID = zt2.test1_id ;

-- 左外连接
select * from zcy_test1 zt left join zcy_test2 zt2 on zt.UUID = zt2.test1_id ;
-- 右外连接
select * from zcy_test1 zt right join zcy_test2 zt2 on zt.UUID = zt2.test1_id ;

-- 自连接
-- 联合查询 union 
/*1，union和union all都是对于两个或多个select语句的结果集
2，使用union或union all要注意两个表必须有相同的数量的列，同时列也必须有相同或相似的数据类型
3，每条select语句中的列的顺序也是必须相同的
4，union得到的是没有重复的记录，union all得到的是记录条数是两张表中记录的条数之和*/
select * from zcy_test1
union
select * from zcy_test1;

select * from zcy_test1
union all
select * from zcy_test1;

-- 子查询
select * from zcy_test1 where uuid = (select uuid from zcy_test1 z where NAME = '张三')
