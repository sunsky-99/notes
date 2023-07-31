
触发器是与表有关的数据库对象，指在 insert/update/delete 之前或之后，触发并执行触发器中定义的SQL语句集合。
触发器的这种特性可以协助应用在数据库端确保数据的完整性，日志记录，数据校验等操作使用别名 OLD和 NEW 来引用触发器中发生变化的记录内容，这与其他的数据库是相似的。
现在触发器还只支持行级触发，不支持语合级触发。

INSERT型触发器 	NEW表示将要或者已经新增的数据 
UPDATE型触发器		OLD表示修改之前的数据，NEW 表示将要或已经修改后的数据
DELETE型触发器		OLD 表示将要或者已经删除的数据

创建
CREATE TRIGGER trigger_name
BEFORE/AFTER INSERT/UPDATE/DELETE
ON tbl_name FOR EACH ROW -- 行级触发器
begin
		trigger_stmt ;
END;
查看
SHOW TRIGGERS;
删除 -- 如果没有指定 schema name，默认为当前数据库
DROP TRIGGER [schema_name.]trigger_name; 

通过触发器记录user表的数据变更日志，将变更日志插入到日志表user_logs中,包含增加,修改，删除
create table user_logs(
	id int(11) not null auto_increment,
	operation varchar(20) not null comment '操作类型, insert/update/delete',
	operate_time datetime not null comment '操作时间!',
	operate_id int(11) not null comment '操作的ID',
	operate_params varchar(500) comment '操作参数',
	primary key(id)
)engine=innodb default charset=utf8;

-- 创建触发器
create trigger testzcy.tb_user_insert_trigger
after insert on testzcy.user100w for each row
begin
	insert into user_logs(id, operation, operate_time, operate_id, operate_params) 
	VALUES(null,'insert',now(),new.id,concat('插入的数据内容为: id=',new.id,',name=',new.first_name,NEW.last_name));
end;

SHOW TRIGGERS;
DROP trigger  testzcy.tb_user_insert_trigger;