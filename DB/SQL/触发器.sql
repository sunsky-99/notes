
������������йص����ݿ����ָ�� insert/update/delete ֮ǰ��֮�󣬴�����ִ�д������ж����SQL��伯�ϡ�
���������������Կ���Э��Ӧ�������ݿ��ȷ�����ݵ������ԣ���־��¼������У��Ȳ���ʹ�ñ��� OLD�� NEW �����ô������з����仯�ļ�¼���ݣ��������������ݿ������Ƶġ�
���ڴ�������ֻ֧���м���������֧����ϼ�������

INSERT�ʹ����� 	NEW��ʾ��Ҫ�����Ѿ����������� 
UPDATE�ʹ�����		OLD��ʾ�޸�֮ǰ�����ݣ�NEW ��ʾ��Ҫ���Ѿ��޸ĺ������
DELETE�ʹ�����		OLD ��ʾ��Ҫ�����Ѿ�ɾ��������

����
CREATE TRIGGER trigger_name
BEFORE/AFTER INSERT/UPDATE/DELETE
ON tbl_name FOR EACH ROW -- �м�������
begin
		trigger_stmt ;
END;
�鿴
SHOW TRIGGERS;
ɾ�� -- ���û��ָ�� schema name��Ĭ��Ϊ��ǰ���ݿ�
DROP TRIGGER [schema_name.]trigger_name; 

ͨ����������¼user������ݱ����־���������־���뵽��־��user_logs��,��������,�޸ģ�ɾ��
create table user_logs(
	id int(11) not null auto_increment,
	operation varchar(20) not null comment '��������, insert/update/delete',
	operate_time datetime not null comment '����ʱ��!',
	operate_id int(11) not null comment '������ID',
	operate_params varchar(500) comment '��������',
	primary key(id)
)engine=innodb default charset=utf8;

-- ����������
create trigger testzcy.tb_user_insert_trigger
after insert on testzcy.user100w for each row
begin
	insert into user_logs(id, operation, operate_time, operate_id, operate_params) 
	VALUES(null,'insert',now(),new.id,concat('�������������Ϊ: id=',new.id,',name=',new.first_name,NEW.last_name));
end;

SHOW TRIGGERS;
DROP trigger  testzcy.tb_user_insert_trigger;