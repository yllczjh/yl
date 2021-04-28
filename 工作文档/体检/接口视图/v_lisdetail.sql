create or replace view v_lisdetail as
select

t.报告单id as  lisid, --检验主记录标识 String  用于连接主记录
t.细项主键 as itemcode,  --检验细项代码  String
t.细项名称 as itemname,  --检验细项名称  String
t.细项值 as result,  --结果  String
t.单位 as unit,  --单位  String
t.参考值上限 as range --范围  String

    from 检验检查_结果_明细 t
   where t.机构编码 = '222403100001'
;
