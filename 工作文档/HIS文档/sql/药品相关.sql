--1.入库单、退货单、盘点单等
select 单据号,单据类型名称,来源编码,来源名称,目的编码,目的名称,结账状态,结账人姓名,结账时间,小类名称,剂型名称,项目编码,项目名称,规格,厂家名称,单位名称,数量1 as 数量,购进价,购进总额,批号,有效期,序号
from 药房药库_单据明细 t
where to_char(结账时间,'yyyymmdd') between '20191001' and '20191031'
order by 单据号,序号

--2.发药单
select '门诊' as 部门,t.门诊病历号,nvl((select 科室名称 from 基础项目_科室资料 where 机构编码=t.机构编码 and 科室编码=t.开方科室编码),'') as 开方科室,
nvl((select 人员姓名 from 基础项目_人员资料 where 机构编码=t.机构编码 and 人员编码=t.开方医生编码),'') as 开方医生,收费时间,t.剂型名称,t.项目编码,t.项目名称,t.规格,t.厂家名称,t.单位名称,t.批号,t.单价,t.数量,t.总金额,t.进价 as 购进价格,t.数量*(t.单价-t.进价) as 毛利,1 as 处理小数
from 药房药库_门诊发药 t
where to_char(t.收费时间,'yyyymmdd') between '20191001' and '20191031'
union all
select '住院' as 部门,t.住院病历号,nvl((select 科室名称 from 基础项目_科室资料 where 机构编码=t.机构编码 and 科室编码=t.开方科室编码),'') as 开方科室,
nvl((select 人员姓名 from 基础项目_人员资料 where 机构编码=t.机构编码 and 人员编码=t.开方医生编码),'') as 开方医生,t.记账时间,t.剂型名称,t.项目编码,t.项目名称,t.规格,t.厂家名称,t.单位名称,t.批号,t.单价,t.数量,t.总金额,t.进价 as 购进价格,t.数量*(t.单价-t.进价) as 毛利,1 as 处理小数
from 药房药库_住院发药 t
where to_char(t.记账时间,'yyyymmdd') between '20191001' and '20191031'


--3.库存明细
select nvl((select 科室名称 from 基础项目_科室资料 where 科室编码=t.科室编码 and 机构编码=t.机构编码),'') as 科室,p.小类名称,p.剂型名称,p.归类名称,p.药品编码,p.药品名称,p.规格,p.小单位名称,p.生产厂家,
p.批准文号,
nvl((select 名称 from 基础项目_字典明细 t where t.分类编码='GB_KSF9090' and 编码=基药分类 and nvl(删除标志,'0')='0' and 有效状态='有效'),'') as 抗生素属性,
nvl((select 名称 from 基础项目_字典明细 t where t.分类编码='GB_009050' and 编码=基药分类 and nvl(删除标志,'0')='0' and 有效状态='有效'),'') as 基药分类,
t.批号,t.有效期,t.数量 as 库存数量,t.进价,t.数量*t.进价 as 库存金额,1 as 处理小数,
nvl((select 来源名称 from 药房药库_单据明细 m where 批次号=t.批次号 and 单据类型编码='1' and 结账状态='已结账' and not exists(select 1 from 药房药库_单据明细 n where 批次号=t.批次号 and 单据类型编码='1' and 结账状态='已结账' and n.结账时间>m.结账时间)),'') as 供货商
from 药房药库_库存数量 t,基础项目_药品字典 p
where t.项目编码=p.药品编码 and t.机构编码=p.机构编码 and t.数量<>0
and p.拼音码 like '%'||'amxl'||'%'


--4.查询20191001至20191020之间的进销存情况
select 小类名称,药品编码,药品名称,规格,生产厂家,批准文号,剂型名称,归类名称,拼音码,小单位名称,有效状态,

nvl((select sum(处理小数量*处理基数) from 药房药库_库存日志 t where 项目编码=p.药品编码 and 处理时间<to_date('20191001','yyyymmdd')),0.00) as 期初数量,

nvl((select sum(处理小数量*处理基数) from 药房药库_库存日志 t where 项目编码=p.药品编码 and to_date(to_char(处理时间,'yyyymmdd'),'yyyymmdd') between to_date('20191001','yyyymmdd') and to_date('20191020','yyyymmdd') and 库存操作类型 in('1')),0.00) as 购进数量,

-nvl((select sum(处理小数量*处理基数) from 药房药库_库存日志 t where 项目编码=p.药品编码 and to_date(to_char(处理时间,'yyyymmdd'),'yyyymmdd') between to_date('20191001','yyyymmdd') and to_date('20191020','yyyymmdd') and 库存操作类型 not in('1')),0.00) as 销售数量,

nvl((select sum(处理小数量*处理基数) from 药房药库_库存日志 t where 项目编码=p.药品编码 and to_date(to_char(处理时间,'yyyymmdd'),'yyyymmdd')<=to_date('20191020','yyyymmdd')),0.00) as 期末数量,


nvl((select sum(购进总额*处理基数) from 药房药库_库存日志 t where 项目编码=p.药品编码 and 处理时间<to_date('20191001','yyyymmdd')),0) as 期初金额,

nvl((select sum(购进总额*处理基数) from 药房药库_库存日志 t where 项目编码=p.药品编码 and to_date(to_char(处理时间,'yyyymmdd'),'yyyymmdd') between to_date('20191001','yyyymmdd') and to_date('20191020','yyyymmdd') and 库存操作类型 in('1')),0.00) as 购进金额,
-nvl((select sum(购进总额*处理基数) from 药房药库_库存日志 t where 项目编码=p.药品编码 and to_date(to_char(处理时间,'yyyymmdd'),'yyyymmdd') between to_date('20191001','yyyymmdd') and to_date('20191020','yyyymmdd') and 库存操作类型 not in('1')),0.00) as 销售成本,

nvl((select sum(购进总额*处理基数) from 药房药库_库存日志 t where 项目编码=p.药品编码 and to_date(to_char(处理时间,'yyyymmdd'),'yyyymmdd')<=to_date('20191020','yyyymmdd')),0.00) as 期末金额,1 as 处理小数,
nvl((select sum(门诊总额) from 药房药库_库存日志 t where 项目编码=p.药品编码 and to_date(to_char(处理时间,'yyyymmdd'),'yyyymmdd') between to_date('20191001','yyyymmdd') and to_date('20191020','yyyymmdd') and 库存操作类型 not in('1')),0.00) as 销售金额,
nvl((select sum(门诊总额-购进总额) from 药房药库_库存日志 t where 项目编码=p.药品编码 and to_date(to_char(处理时间,'yyyymmdd'),'yyyymmdd') between to_date('20191001','yyyymmdd') and to_date('20191020','yyyymmdd') and 库存操作类型 not in('1')),0.00) as 销售毛利,
nvl((select max(购进总额/处理小数量) from 药房药库_库存日志 t where 项目编码=p.药品编码 and to_date(to_char(处理时间,'yyyymmdd'),'yyyymmdd') between to_date('20191001','yyyymmdd') and to_date('20191020','yyyymmdd') and 单据类型编码='1' and 库存操作类型 in('1') and 处理小数量<>0),0.00) as 最高进价,
nvl((select min(购进总额/处理小数量) from 药房药库_库存日志 t where 项目编码=p.药品编码 and to_date(to_char(处理时间,'yyyymmdd'),'yyyymmdd') between to_date('20191001','yyyymmdd') and to_date('20191020','yyyymmdd') and 单据类型编码='1' and 库存操作类型 in('1') and 处理小数量<>0),0.00) as 最低进价
from 基础项目_药品字典 p

