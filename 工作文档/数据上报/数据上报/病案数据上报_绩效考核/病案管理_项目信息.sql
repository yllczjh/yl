prompt Importing table 病案管理_项目信息...
set feedback off
set define off
insert into 病案管理_项目信息 (机构编码, 项目编码, 项目名称, 导出文件类型, 存储过程名, 拼音码, 五笔码, 有效状态, 删除标志, 更新时间, 更新人员)
values ('522633020000001', '4', '西医病案上报_绩效考核', 'csv', 'PR_病案首页西医_绩效考核', 'xybasb_jxkh', 'sauphr_xufs', '1', '0', to_date('11-07-2020 13:10:43', 'dd-mm-yyyy hh24:mi:ss'), '522633020000001');

prompt Done.
