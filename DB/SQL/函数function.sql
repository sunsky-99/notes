 
-- 函数 字符串函数
-- CONCAT 拼接字符串 ; -- TRIM 删除字符串两侧空格 ； REPLACE 字符串替换
select CONCAT("A","B"),CONCAT("A","B","c"),TRIM("  a  a  "),replace("abc","b","王1");
-- LENGTH 返回字符串的字节长度 ; CHAR_LENGTH 返回字符串的字符长度 ;
select length("abc"),length("张守静"),CHAR_LENGTH("abc"),CHAR_LENGTH("张守静");
-- LOWER 字符串小写 ; UPPER 字符串大写 ; REVERSE 字符串反转 ;
select lower("AA"),upper("aa"),REVERSE("abc") ; 
-- SUBSTRING 截取字符串  LEFT(str,len)函数返回字符串 str 左侧的 len 个字符，RIGHT(str,len)函数返回字符串 str 右侧的 len 个字符
select SUBSTRING("ABCDE",1,2),SUBSTRING("ABCDE",2,2),left("ABCDE",2),right("12345",2);
-- LPAD()/RPAD() 左右填充字符串
select lpad("ABC",6,"DE"),rpad("ABC",6,"DE")  ;

-- 函数 数值函数
-- rand()	返回 0 到 1 内的随机值  
select rand(),
-- truncate(num,n)	返回数字 num 截断为 n 位小数的结果 ;round(num,n)	返回 num 的四舍五入的 n 位小数的值
select truncate(2.333,2),round(2.333333,2);
-- ceil(num) 返回大于 num 的最小整数值  ; floor  返回小于 num 的最大整数值  ;
select ceil(2.1),ceil(-2.8),floor(2.1),floor(-2.8);
-- abs(num)	返回 num 的绝对值 ;sqrt(num)	返回 num 的平方根
select abs(2),abs(-2) , sqrt(4);
-- mod(num1,num2)	返回 num1 对 num2 进行模运算结果
select mod(5,3);

-- 函数 日期函数 
-- now() 当前年月日时分秒;current_DATE()当前年月日;current_time() 当前时分秒
select now(),  current_DATE(),curdate()  ,current_time(),curtime() ;
-- 年year();月month();日day()
select   year(now()),month(now()),day(now()) ;
-- DATE_ADD 日期时间增加减少
select DATE_ADD(now(),interval  1 day),DATE_ADD(now(),interval  -1 day);
-- DATEDIFF()函数：计算两个日期差 
select  DATEDIFF(DATE_ADD(now(),interval  1 day),DATE_ADD(now(),interval  -1 day))
-- TIMEDIFF()函数：计算两个时间差
select  TIMEDIFF(DATE_ADD(now(),interval  1 day),DATE_ADD(now(),interval  -1 day))
-- 当前日期时间
select CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP, LOCALTIME(), LOCALTIME, LOCALTIMESTAMP(), LOCALTIMESTAMP, NOW(), SYSDATE() 

-- 函数 流程函数
select if(false,1,2),ifnull(null,2),
case when 2>1 then "后1" 
	 when 5>6 then "后2" 
else "第一" end;

select case 1 when 1 then "第一" else "后排" end;


-- 约束
-- 非空约束 not null ; 唯一约束 unque; 主键约束 primary key; 默认值 default; 检查约束 check; 外键约束 foreign key;自增约束 auto_increment

-- 添加外键
alter table test1.zcy_test2 add constraint fk_test1_id foreign key (test1_id) references test1.zcy_test1(uuid);
-- 删除外键
alter table test1.zcy_test2  drop foreign key fk_test1_id ;
-- 外键的删除和更新行为 (删除或更新时的规则)
/*删除时属性，取值如图为：默认（RESTRICT），RESTRICT，NO ACTION，CASCADE，SET NULL属性。
更新时属性，取值如图为：默认（RESTRICT），RESTRICT，NO ACTION，CASCADE，SET NULL属性。
取值为 SET NULL 时，则当在父表（即外键的来源表）中删除对应记录时，首先检查该记录是否有对应外键，如果有则设置子表中该外键值为null（不过这就要求该外键允许取null）。
当取值为 CASCADE 时，则当在父表（即外键的来源表）中删除对应记录时，首先检查该记录是否有对应外键，如果有则也删除外键在子表（即包含外键的表）中的记录。
当取值为 NO ACTION 或者RESTRICT时，则当在父表（即外键的来源表）中删除对应记录时，首先检查该记录是否有对应外键，如果有则不允许删除。
**/
alter table test1.zcy_test2 add constraint fk_test1_id foreign key (test1_id) references test1.zcy_test1(uuid) on update cascade on delete cascade ;





