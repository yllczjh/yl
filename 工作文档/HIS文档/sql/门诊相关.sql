--1.按时间段查询医嘱明细
select 
a.门诊病历号,r.姓名,decode(r.性别,'1','男','2','女','未知') as 性别,

nvl((select 类型名称 from 基础项目_挂号类型 where 机构编码=g.机构编码 and 类型编码=g.挂号类型编码),'') as 挂号类型,
nvl((select 人员姓名 from 基础项目_人员资料 where 机构编码=g.机构编码 and 人员编码=g.操作员编码),'') as 挂号操作员,

a.医嘱号,a.操作员姓名 as 开方医生,a.录入时间,a.医嘱状态,a.收费状态,
nvl((select 名称 from 基础项目_字典明细 where 分类编码='GB_009003' and 编码=a.大类编码),'') as 大类名称,
nvl((select 小类名称 from 基础项目_小类字典 where 机构编码=b.机构编码 and 大类编码=b.大类编码 and 小类编码=b.小类编码),'') as 小类名称,

case a.大类编码 when '6' then a.项目编码 else '' end as 套餐编码,
case a.大类编码 when '6' then a.项目名称 else '' end as 套餐名称,

b.项目编码,b.项目名称,b.规格,b.单位名称,b.总量,b.单价,b.总金额,
nvl((select 科室名称 from 基础项目_科室资料 where 机构编码=b.机构编码 and 科室编码=b.执行科室编码),'') as 执行科室
    
from 门诊管理_挂号登记 g,门诊管理_门诊医嘱 a,门诊管理_门诊医嘱项目 b,基础项目_病人信息 r
where g.机构编码=a.机构编码 and g.挂号序号=a.挂号序号 and a.机构编码=b.机构编码 and a.门诊病历号=b.门诊病历号 and a.医嘱号=b.医嘱号 and a.项目id=b.项目id and a.机构编码=r.机构编码 and a.病人id=r.病人id
and to_char(录入时间,'yyyymmdd') between '20191001' and '20191031';

http://localhost:18080/smartbi/vision/openresource.jsp?resid=I4028d847016f554c554cd455016f556395c200af&user=admin&password=1111

--2.按时间段查询收费明细
select 
a.门诊病历号,r.姓名,decode(r.性别,'1','男','2','女','未知') as 性别,

nvl((select 类型名称 from 基础项目_挂号类型 where 机构编码=g.机构编码 and 类型编码=g.挂号类型编码),'') as 挂号类型,
nvl((select 人员姓名 from 基础项目_人员资料 where 机构编码=g.机构编码 and 人员编码=g.操作员编码),'') as 挂号操作员,

a.医嘱号,a.操作员姓名 as 开方医生,a.录入时间,a.医嘱状态,a.收费状态,
nvl((select 名称 from 基础项目_字典明细 where 分类编码='GB_009003' and 编码=c.大类编码),'') as 大类名称,
nvl((select 小类名称 from 基础项目_小类字典 where 机构编码=c.机构编码 and 大类编码=c.大类编码 and 小类编码=c.小类编码),'') as 小类名称,

case a.大类编码 when '6' then a.项目编码 else '' end as 套餐编码,
case a.大类编码 when '6' then a.项目名称 else '' end as 套餐名称,

c.项目编码,c.项目名称,c.规格,c.单位名称,c.数量,c.单价,c.总金额,
nvl((select 科室名称 from 基础项目_科室资料 where 机构编码=c.机构编码 and 科室编码=c.执行科室编码),'') as 执行科室,

nvl((select case when x.名称 not in('挂号费','检查费','治疗费','卫生材料费','中成药费','药事服务费','其它费','诊查费','化验费','手术费','西药费','中草药费','一般诊疗费','输血费') then '其它费' else x.名称 end as 名称
from 基础项目_费用归类 g,基础项目_字典明细 x
where g.机构编码=c.机构编码 and g.删除标志='0' and g.类别 = '门诊发票项目归类' and x.分类编码 = 'GB_009001' and g.费用编码=c.归类编码 and g.隶属编码=x.编码),'') as 费用名称,

c.操作员姓名 as 收费员,c.收费时间 as 收费时间,

c.发药标志 as 执行,c.发药人姓名 as 执行人,c.退药标志 as 取消执行,nvl((select 姓名 from 基础项目_人员资料 where 机构编码=c.机构编码 and 人员编码=c.退药人编码),'') as 取消执行人,c.退药时间 as 取消执行时间,

to_char(c.收费时间,'yyyy-mm-dd') as 收费日期,
nvl((select 名称 from 基础项目_字典明细 where 分类编码='GB_009000' and 编码=g.病人类型编码),'') as 病人类型,
nvl((select 科室名称 from 基础项目_科室资料 where 机构编码=c.机构编码 and 科室编码=c.开方科室编码),'') as 开方科室,g.挂号来源,
nvl((select 名称 from 基础项目_字典明细 where 分类编码='GB_009000' and 编码=g.病人类型编码),'') as 结算类型,
nvl((select 结果状态 from 检验检查_申请 where 申请单id=a.检验申请ID),'无报告') as 结果状态

from 门诊管理_挂号登记 g,门诊管理_门诊医嘱 a,门诊管理_门诊医嘱项目 b,基础项目_病人信息 r,门诊管理_门诊处方 c
where g.机构编码=a.机构编码 and g.挂号序号=a.挂号序号 and a.机构编码=b.机构编码 and a.门诊病历号=b.门诊病历号 and a.医嘱号=b.医嘱号 and a.项目id=b.项目id and a.机构编码=r.机构编码 and a.病人id=r.病人id
and b.计价id=c.计价id and b.机构编码=c.机构编码
and to_char(c.收费时间,'yyyymmdd') between '20191001' and '20191031';



--3.按时间段查挂号列表
select g.门诊病历号,b.姓名,decode(b.性别,'1','男','2','女','未知') as 性别,b.年龄,
nvl((select x.类型名称 from 基础项目_挂号类型 x where x.机构编码=g.机构编码 and x.类型编码=g.挂号类型编码),'') as 挂号类型,
nvl((select r.人员姓名 from 基础项目_人员资料 r where r.机构编码=g.机构编码 and r.人员编码=g.操作员编码),'') as 收费员,
g.挂号时间,g.是否急诊,g.就诊状态,g.总费用,g.退号标志 as 是否退号,
nvl((select k.科室名称 from 基础项目_科室资料 k where k.机构编码=g.机构编码 and 科室编码=g.就诊科室编码),'') as 就诊科室,
nvl((select r.人员姓名 from 基础项目_人员资料 r where r.机构编码=g.机构编码 and r.人员编码=g.就诊医生编码),'') as 就诊医生,
g.疾病名称,
nvl((select k.科室名称 from 基础项目_科室资料 k where k.机构编码=g.机构编码 and 科室编码=g.挂号科室编码),'') as 挂号科室,
nvl((select r.人员姓名 from 基础项目_人员资料 r where r.机构编码=g.机构编码 and r.人员编码=g.挂号医生编码),'') as 挂号医生,
g.挂号来源,
g.病人id,g.挂号序号,
nvl((select sum(总金额) from 门诊管理_门诊医嘱 where 挂号序号=g.挂号序号),0.00) as 开嘱金额,
nvl((select sum(总金额) from 门诊管理_门诊处方 where 挂号序号=g.挂号序号 and 总金额>0),0.00) as 交款金额,
nvl((select sum(总金额) from 门诊管理_门诊处方 where 挂号序号=g.挂号序号 and 总金额<0),0.00) as 退费金额,
nvl((select sum(总金额) from 门诊管理_门诊医嘱 where 挂号序号=g.挂号序号),0.00)-
nvl((select sum(总金额) from 门诊管理_门诊处方 where 挂号序号=g.挂号序号 and 总金额>0),0.00) as 未交金额,1 as 处理小数
from 门诊管理_挂号登记 g,基础项目_病人信息 b
where g.病人id=b.病人id
and to_char(g.挂号时间,'yyyymmdd') between  '20191001' and '20191031'
