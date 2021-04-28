--创建测试表  存入excel中的字段信息
create table 病案测试表
(
  字段名 VARCHAR2(100),
  类型  VARCHAR2(100),
  描述  VARCHAR2(100)
);


--新建临时表
create global temporary table 临时表_病案首页西医_绩效考核
(

  住院病历号     VARCHAR2(100)
)
on commit preserve rows;






declare

STR_SQL varchar2(1000);
cursor cur_病案首页 is
  select t.字段名, t.类型, t.描述
   from 病案测试表 t;
begin
  


for r in cur_病案首页 loop

   STR_SQL := ' alter table 临时表_病案首页西医_绩效考核 add ' || r.字段名 || ' ' ||
         r.类型;

  execute immediate STR_SQL;
  
  STR_SQL := 'comment on column 临时表_病案首页西医_绩效考核.'|| r.字段名 ||' is '''|| r.描述 ||'''';
  execute immediate STR_SQL;
  
  commit;
end loop;

alter table 临时表_病案首页西医_绩效考核 drop column 住院病历号;
commit;
end;