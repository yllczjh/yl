create or replace view v_mzbrxx as
select
t.病人id as hispatientid,  --His标识	String	儿童在His中的标识，必填
t.门诊病历号 as hiscardid,  --His卡号	String	儿童的在His中的卡号或条码号，必填
b.姓名 as name,    --姓名	String	必填
decode(b.性别,'1','男','2','女','未知') as gender,   --性别	String	必填
b.出生日期 as birthday    --出生年月	Date	必填

from 门诊管理_挂号登记 t,基础项目_病人信息 b
where t.机构编码=b.机构编码 and t.病人ID=b.病人ID and t.机构编码='222403100001'
;
