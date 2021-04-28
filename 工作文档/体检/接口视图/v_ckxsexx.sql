create or replace view v_ckxsexx as
select

t.住院病历号 as hiscardid, --就诊卡号  String  因his系统不同，如果新生儿在出生时没有记录则填妈妈的His就诊卡号 必填
t.病人id as hispatientid,  --His标识 String  因his系统不同，如果新生儿在出生时没有记录则填妈妈的His标识    必填
b.姓名 as name,  --姓名  String  新生儿的姓名
decode(b.性别,'1','男','2','女','未知') as gender,  --性别  String  新生儿的性别 必填
b.出生日期 as birthday  --出生年月  Date  新生儿的出生日期 必填

    from 住院管理_在院病人信息 t,基础项目_病人信息 b
where t.机构编码=b.机构编码 and t.病人id=b.病人id and t.机构编码='222403100001' and t.母亲病历号 is not null
;
