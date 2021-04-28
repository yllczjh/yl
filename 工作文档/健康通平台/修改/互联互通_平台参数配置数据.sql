prompt Importing table 互联互通_平台参数配置...
set feedback off
set define off
insert into 互联互通_平台参数配置 (流水码, 平台标识, 平台名称, 用户ID, 认证密钥, 医院ID, 机构编码, URL地址, 类名, 方法名, 支付方式, 换算比例, 不可预约科室, 有效状态, 创建人, 创建时间, 更新人, 更新时间)
values ('1', '12320', '12320测试', 'ln_12320wx', '2098D32C4D1399EC', '1', '522633020000001', 'http://localhost:8001/APIService.asmx', 'APIService', 'PubService', '网上支付', 100.000, '1020,1018', '1', null, null, null, null);

prompt Done.
