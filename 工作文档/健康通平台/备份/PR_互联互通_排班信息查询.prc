CREATE OR REPLACE PROCEDURE PR_互联互通_排班信息查询(STR_请求参数 IN VARCHAR2,
                                           LOB_响应参数 OUT CLOB,
                                           INT_返回值   OUT INTEGER,
                                           STR_返回信息 OUT VARCHAR2) IS

  STR_SQL VARCHAR2(1000);
  --【请求参数】
  STR_机构编码     VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
  STR_科室编码     VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'DEPT_ID');
  STR_人员编码     VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'DOCTOR_ID');
  STR_排班开始日期 VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'START_DATE');
  STR_排班结束日期 VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'END_DATE');

  str_临时医生ID   varchar2(50) := '';
  str_临时出诊日期 varchar2(50) := '';
  str_排班ID       varchar2(50) := '';

  CURSOR CUR_排班信息 IS
    SELECT T.机构编码,
           T.科室编码,
           T.人员编码,
           (SELECT A.人员姓名
              FROM 基础项目_人员资料 A
             WHERE A.机构编码 = T.机构编码
               AND A.人员编码 = T.人员编码) AS 医生名称,
           (SELECT A.职称
              FROM 基础项目_人员资料 A
             WHERE A.机构编码 = T.机构编码
               AND A.人员编码 = T.人员编码) AS 医生职称,
           T1.排班日期,
           T1.星期,
           T2.日班次标识,
           T2.时段编码,
           T2.限号数,
           T2.已挂号数,
           T3.挂号费,
           T3.诊查费
      FROM 基础项目_人员科室列表 T,
           门诊管理_当天排班记录 T1,
           门诊管理_日排班时段表 T2,
           基础项目_挂号类型     T3
     WHERE T.机构编码 = T1.机构编码
       AND T1.机构编码 = T2.机构编码
       AND T2.机构编码 = T3.机构编码
       AND T.科室编码 = T1.科室编码
       and (t.人员编码 = t1.医生编码 or t1.医生编码 is null)
       AND T1.记录ID = T2.记录ID
       AND T1.排班序号 = T2.排班序号
       AND T1.挂号类型编码 = T3.类型编码
       AND T.机构编码 = STR_机构编码
       AND T.删除标志 = '0'
       AND T3.有效状态 = '有效'
       AND T.科室编码 = STR_科室编码
       AND (T.人员编码 = STR_人员编码 OR T.人员编码 = '-1')
       AND T1.排班日期 BETWEEN TO_DATE(STR_排班开始日期, 'yyyy-MM-dd') AND
           TO_DATE(STR_排班结束日期, 'yyyy-MM-dd')
     order by T.科室编码, T.人员编码, T1.排班日期, T2.时段编码;

  ROW_排班信息 CUR_排班信息%ROWTYPE;

BEGIN

  BEGIN
  
    FOR ROW_排班信息 IN CUR_排班信息 LOOP
      EXIT WHEN CUR_排班信息%NOTFOUND;
    
      if ROW_排班信息.人员编码 <> str_临时出诊日期 then
        LOB_响应参数 := LOB_响应参数 || '<REG_DOCTOR_LIST>';
        LOB_响应参数 := LOB_响应参数 || '<DOCTOR_ID>' || ROW_排班信息.人员编码 ||
                    '</DOCTOR_ID>';
        LOB_响应参数 := LOB_响应参数 || '<NAME>' || ROW_排班信息.医生名称 || '</NAME>';
        LOB_响应参数 := LOB_响应参数 || '<JOB_TITLE>' || ROW_排班信息.医生职称 ||
                    '</JOB_TITLE>';
      else
        if ROW_排班信息.排班日期 <> str_临时医生ID then
          LOB_响应参数 := LOB_响应参数 || '<REG_LIST>';
          LOB_响应参数 := LOB_响应参数 || '<REG_DATE>' || ROW_排班信息.排班日期 ||
                      '</REG_DATE>';
          LOB_响应参数 := LOB_响应参数 || '<REG_WEEKDAY>' || ROW_排班信息.星期 ||
                      '</REG_WEEKDAY>';
        
          if ROW_排班信息.日班次标识 <> str_排班ID then
            LOB_响应参数 := LOB_响应参数 || '<REG_TIME_LIST>';
            LOB_响应参数 := LOB_响应参数 || '<REG_ID>' || ROW_排班信息.日班次标识 ||
                        '</REG_ID>';
            LOB_响应参数 := LOB_响应参数 || '<TIME_FLAG>4</TIME_FLAG>';
            LOB_响应参数 := LOB_响应参数 || '<REG_STATUS>1</REG_STATUS>';
            LOB_响应参数 := LOB_响应参数 || '<TOTAL>' || ROW_排班信息.限号数 || '</TOTAL>';
            LOB_响应参数 := LOB_响应参数 || '<OVER_COUNT>' || ROW_排班信息.限号数 -
                        ROW_排班信息.已挂号数 || '</OVER_COUNT>';
            LOB_响应参数 := LOB_响应参数 || '<REG_LEVEL>1</REG_LEVEL>';
            LOB_响应参数 := LOB_响应参数 || '<REG_FEE>' || ROW_排班信息.挂号费 ||
                        '</REG_FEE>';
            LOB_响应参数 := LOB_响应参数 || '<TREAT_FEE>' || ROW_排班信息.诊查费 ||
                        '</TREAT_FEE>';
            LOB_响应参数 := LOB_响应参数 || '<ISTIME>0</ISTIME>';
            LOB_响应参数 := LOB_响应参数 || '</REG_TIME_LIST>';
          end if;
          LOB_响应参数 := LOB_响应参数 || '</REG_LIST>';
        end if;
      end if;
    
    END LOOP;
  
  END;

END PR_互联互通_排班信息查询;
/
