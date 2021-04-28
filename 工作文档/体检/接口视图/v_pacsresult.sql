create or replace view v_pacsresult as
select
s.病历号 as hiscardid, --就诊卡号  String
s.病人id as hispatientid,  --His标识 String
t.申请单id as applyNum,  --申请序号  String
'' as barcode, --条码  String
t.报告时间 as testdate,  --报告日期  Date
s.项目名称 as subtype,  --检查类别  String  超声，磁共振，DR等等
s.项目名称 as type, --检查子类  String  腹部B超，胸部DR等等
s.项目编码 as code,  --项目代码  String
s.项目名称 as name,  --项目名称    String
s.医生编码 as doctor,  --申请医生  String
t.文字报告内容 as Findings,  --检查所见  String
t.文字报告内容 as Impression,  --印象  String
t.图片报告文件 as Image --影像  Image

    from 检验检查_结果 t,检验检查_申请 s
    where t.申请单id = s.申请单id and s.结果状态='已报告' and s.类型='检查' and s.机构编码='222403100001'
;
