create or replace view v_lisresult as
select

t.唯一id as lisid, --检验主记录标识 String
s.病历号 as hiscardid, --就诊卡号  String
s.病人id as hispatientid,  --His标识 String
'' as barcode, --条码  String
s.申请时间 as testdate,  --检验日期  Date
s.项目编码 as examcode,  --检验项目代码  String
s.项目名称 as examname,  --检验项目名称    String
'' as samplyid,  --样本标识  String
'' as sampltype --样本类型  String

    from 检验检查_结果 t,检验检查_申请 s
   where t.申请单id = s.申请单id and t.机构编码 = '222403100001' and s.结果状态='已报告' and s.类型='检验'
;
