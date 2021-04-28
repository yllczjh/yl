update 病案管理_项目字段对照 set 是否默认值='False';

alter table 病案管理_项目字段对照 add 是否默认值 varchar2(50);
alter table 病案管理_项目字段对照 add 默认值 varchar2(100);


ALTER TABLE 临时表_病案首页新 RENAME TO 临时表_病案首页西医_季报;

ALTER TABLE 临时表_病案首页医保 RENAME TO 临时表_病案首页西医_医保中心;

update 病案管理_项目信息 set 存储过程名='PR_病案首页西医_季报' where 项目编码='1';
update 病案管理_项目信息 set 存储过程名='PR_病案首页西医_医保中心' where 项目编码='2';
