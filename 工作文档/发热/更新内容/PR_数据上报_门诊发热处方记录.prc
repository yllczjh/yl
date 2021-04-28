create or replace procedure PR_数据上报_门诊发热处方记录(STR_参数          IN VARCHAR2,
                                             CUR_导出_列表信息 OUT SYS_REFCURSOR) IS

  STR_机构编码 VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 1);
  /*DAT_出院时间起始 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 2),
                             'yyyy-MM-dd hh24:mi:ss');
  DAT_出院时间截止 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 3),
                             'yyyy-MM-dd hh24:mi:ss');
  STR_过滤数据     VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 4);*/
  STR_项目编码 VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 5);
  STR_流水码   VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 6);
BEGIN
  BEGIN
    OPEN CUR_导出_列表信息 FOR
      select 1 from dual;
             
  
  end;

end PR_数据上报_门诊发热处方记录;
/
