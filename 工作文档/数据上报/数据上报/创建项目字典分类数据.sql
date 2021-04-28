select t.*, t.rowid from 病案管理_项目字典分类 t where t.项目编码='3' 

insert into 病案管理_项目字典分类 a
select t.机构编码,'4',t.字典分类编码,t.字典分类名称,t.拼音码,t.五笔码,t.有效状态,t.删除标志,t.更新时间,t.更新人员 from 病案管理_项目字典分类 t where t.项目编码='4';



select t.*, t.rowid from 病案管理_项目字典分类 t  where t.项目编码='4' 
