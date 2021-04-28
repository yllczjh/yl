CREATE OR REPLACE PROCEDURE PR_互联互通_排班信息查询(STR_请求参数 IN VARCHAR2,
                                           STR_平台标识 IN VARCHAR2,
                                           STR_功能编码 IN VARCHAR2,
                                           LOB_响应参数 OUT CLOB,
                                           INT_返回值   OUT INTEGER,
                                           STR_返回信息 OUT VARCHAR2) IS

  --STR_SQL  VARCHAR2(2000);
  STR_SQL1 VARCHAR2(2000);

  --【请求参数】
  STR_医院ID       VARCHAR2(50);
  STR_科室ID       VARCHAR2(50);
  STR_医生ID       VARCHAR2(50);
  STR_排班开始日期 VARCHAR2(50);
  STR_排班结束日期 VARCHAR2(50);

  NUM_换算比例 NUMBER(10, 3);
  STR_机构编码 VARCHAR2(50);

  STR_临时医生ID   VARCHAR2(50) := '-999';
  STR_临时出诊日期 DATE := TO_DATE('1990-01-01', 'yyyy-MM-dd');

  CURSOR CUR_排班信息 IS
    SELECT T.机构编码,
           T.记录ID,
           T.科室编码,
           T.医生编码,
           (SELECT A.人员姓名
              FROM 基础项目_人员资料 A
             WHERE A.机构编码 = T.机构编码
               AND A.人员编码 = T.医生编码) AS 医生名称,
           (SELECT A.职称
              FROM 基础项目_人员资料 A
             WHERE A.机构编码 = T.机构编码
               AND A.人员编码 = T.医生编码) AS 医生职称,
           T.排班日期,
           T.星期
      FROM 门诊管理_当天排班记录 T
     WHERE T.机构编码 = STR_机构编码
       AND T.科室编码 = STR_科室ID
       AND T.医生编码 IS NOT NULL
       AND (T.医生编码 = STR_医生ID OR STR_医生ID = '-1')
       AND T.排班日期 BETWEEN TO_DATE(STR_排班开始日期, 'yyyy-MM-dd') AND
           TO_DATE(STR_排班结束日期, 'yyyy-MM-dd')
     ORDER BY T.科室编码, T.医生编码, T.排班日期;

  ROW_排班信息 CUR_排班信息%ROWTYPE;

BEGIN

  BEGIN
    --【请求参数】
    STR_医院ID       := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
    STR_科室ID       := FU_互联互通_节点值(STR_请求参数, 'DEPT_ID');
    STR_医生ID       := FU_互联互通_节点值(STR_请求参数, 'DOCTOR_ID');
    STR_排班开始日期 := FU_互联互通_节点值(STR_请求参数, 'START_DATE');
    STR_排班结束日期 := FU_互联互通_节点值(STR_请求参数, 'END_DATE');
  
    --【参数验证】
    IF STR_医院ID IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请传入医院ID';
      GOTO 退出;
    END IF;
    IF STR_科室ID IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请传入科室ID';
      GOTO 退出;
    END IF;
    IF STR_医生ID IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请传入医生ID';
      GOTO 退出;
    END IF;
    IF STR_排班开始日期 IS NULL AND FU_尝试转日期(STR_排班开始日期) IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请传入排班开始日期';
      GOTO 退出;
    END IF;
    IF STR_排班结束日期 IS NULL AND FU_尝试转日期(STR_排班结束日期) IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请传入排班结束日期';
      GOTO 退出;
    END IF;
    STR_机构编码:=FU_互联互通_医院ID转换(STR_平台标识,STR_医院ID,'1');
    IF STR_机构编码 IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '医院ID无效';
      GOTO 退出;
    END IF;
  
    --【验证科室排班信息】
    SELECT COUNT(1)
      INTO INT_返回值
      FROM 门诊管理_当天排班记录
     WHERE 机构编码 = STR_机构编码
       AND 科室编码 = STR_科室ID
       AND 排班日期 BETWEEN TO_DATE(STR_排班开始日期, 'yyyy-MM-dd') AND
           TO_DATE(STR_排班结束日期, 'yyyy-MM-dd');
  
    IF INT_返回值 = 0 THEN
      INT_返回值   := 200301;
      STR_返回信息 := '科室不存在';
      GOTO 退出;
    END IF;
  
    --【验证医生排班信息】
    IF STR_医生ID <> '-1' THEN
      SELECT COUNT(1)
        INTO INT_返回值
        FROM 门诊管理_当天排班记录
       WHERE 机构编码 = STR_机构编码
         AND 医生编码 = STR_医生ID
         AND 排班日期 BETWEEN TO_DATE(STR_排班开始日期, 'yyyy-MM-dd') AND
             TO_DATE(STR_排班结束日期, 'yyyy-MM-dd');
    
      IF INT_返回值 = 0 THEN
        INT_返回值   := 200302;
        STR_返回信息 := '医生不存在';
        GOTO 退出;
      END IF;
    END IF;
  
    BEGIN
      SELECT 换算比例
        INTO NUM_换算比例
        FROM 互联互通_平台参数配置
       WHERE 平台标识 = STR_平台标识
         AND 有效状态 = '1';
    EXCEPTION
      WHEN OTHERS THEN
        NUM_换算比例 := 100;
    END;
  
    FOR ROW_排班信息 IN CUR_排班信息 LOOP
      EXIT WHEN CUR_排班信息%NOTFOUND;
      
      STR_SQL1:='SELECT DECODE((SELECT COUNT(1)
                                FROM 门诊管理_日排班时段表
                               WHERE 机构编码 = T1.机构编码
                                 AND 记录ID = T1.记录ID),
                              1,
                              (SELECT 日班次标识
                                 FROM 门诊管理_日排班时段表
                                WHERE 机构编码 = T1.机构编码
                                  AND 记录ID = T1.记录ID),
                              T1.记录ID) AS REG_ID,
                       ''4'' AS TIME_FLAG,
                       T1.出诊状态 AS REG_STATUS,
                       (SELECT SUM(限号数)
                          FROM 门诊管理_日排班时段表
                         WHERE 机构编码 = T1.机构编码
                           AND 记录ID = T1.记录ID
                           AND 限号数 >= 0) TOTAL,
                       (SELECT SUM(限号数) - SUM(已挂号数)
                          FROM 门诊管理_日排班时段表
                         WHERE 机构编码 = T1.机构编码
                           AND 记录ID = T1.记录ID
                           AND 限号数 >= 0) OVER_COUNT,
                       1 AS REG_LEVEL,
                       T2.挂号费 * 100 AS REG_FEE,
                       T2.诊查费 * 100 AS TREAT_FEE,
                       DECODE((SELECT COUNT(1)
                                FROM 门诊管理_日排班时段表
                               WHERE 机构编码 = T1.机构编码
                                 AND 记录ID = T1.记录ID),
                              1,
                              0,
                              1) AS ISTIME
                  FROM 门诊管理_当天排班记录 T1, 基础项目_挂号类型 T2
                 WHERE T1.机构编码 = T2.机构编码
                   AND T1.挂号类型编码 = T2.类型编码
                   AND T1.机构编码=' || STR_机构编码 ||
                      ' AND T1.记录ID=''' || ROW_排班信息.记录ID || '''';

    
      /*STR_SQL1 := 'SELECT T1.记录ID AS REG_ID,
                         ''4'' AS TIME_FLAG,
                         T1.出诊状态 AS REG_STATUS,      
                         (SELECT SUM(限号数)
                            FROM 门诊管理_日排班时段表
                           WHERE 机构编码 = T1.机构编码
                             AND 记录ID = T1.记录ID
                             AND 限号数 >= 0) TOTAL,
                         (SELECT SUM(限号数) - SUM(已挂号数)
                            FROM 门诊管理_日排班时段表
                           WHERE 机构编码 = T1.机构编码
                             AND 记录ID = T1.记录ID
                             AND 限号数 >= 0) OVER_COUNT,
                         1 AS REG_LEVEL,
                         T2.挂号费 * ' || NUM_换算比例 ||
                  ' AS REG_FEE,
                         T2.诊查费 * ' || NUM_换算比例 ||
                  ' AS TREAT_FEE,
                         1 AS ISTIME
                    FROM 门诊管理_当天排班记录 T1, 基础项目_挂号类型 T2
                   WHERE T1.机构编码 = T2.机构编码
                     AND T1.挂号类型编码 = T2.类型编码
                   AND T1.机构编码=' || STR_机构编码 ||
                  ' AND T1.记录ID=''' || ROW_排班信息.记录ID || '''';*/
    
      IF STR_临时医生ID <> ROW_排班信息.医生编码 THEN
        STR_临时医生ID   := ROW_排班信息.医生编码;
        STR_临时出诊日期 := TO_DATE('1990-01-01', 'yyyy-MM-dd');
        IF DBMS_LOB.GETLENGTH(LOB_响应参数) > 0 THEN
          LOB_响应参数 := LOB_响应参数 || '</REG_LIST>'; --出诊日期节点结束
          LOB_响应参数 := LOB_响应参数 || '</REG_DOCTOR_LIST>'; --排班医生集合节点结束
        END IF;
        LOB_响应参数 := LOB_响应参数 || '<REG_DOCTOR_LIST>'; --排班医生集合节点开始
        LOB_响应参数 := LOB_响应参数 || '<DOCTOR_ID>' || ROW_排班信息.医生编码 ||
                    '</DOCTOR_ID>'; --医生ID
        LOB_响应参数 := LOB_响应参数 || '<NAME>' || ROW_排班信息.医生名称 || '</NAME>'; --医生名称
        LOB_响应参数 := LOB_响应参数 || '<JOB_TITLE>' || ROW_排班信息.医生职称 ||
                    '</JOB_TITLE>'; --医生职称
      
        IF STR_临时出诊日期 <> ROW_排班信息.排班日期 THEN
          STR_临时出诊日期 := ROW_排班信息.排班日期;
          LOB_响应参数     := LOB_响应参数 || '<REG_LIST>'; --出诊日期节点开始
          LOB_响应参数     := LOB_响应参数 || '<REG_DATE>' ||
                          TO_CHAR(ROW_排班信息.排班日期, 'yyyy-MM-dd') ||
                          '</REG_DATE>'; --出诊日期
          LOB_响应参数     := LOB_响应参数 || '<REG_WEEKDAY>' || ROW_排班信息.星期 ||
                          '</REG_WEEKDAY>'; --出诊日期对应星期
        
          LOB_响应参数 := LOB_响应参数 ||
                      FU_互联互通_得到响应参数(STR_SQL1, 'REG_TIME_LIST', '');
        
        END IF;
      ELSE
        IF STR_临时出诊日期 <> ROW_排班信息.排班日期 THEN
          IF DBMS_LOB.GETLENGTH(LOB_响应参数) > 0 THEN
            LOB_响应参数 := LOB_响应参数 || '</REG_LIST>'; --出诊日期节点结束
          END IF;
          STR_临时出诊日期 := ROW_排班信息.排班日期;
          LOB_响应参数     := LOB_响应参数 || '<REG_LIST>'; --出诊日期节点开始
          LOB_响应参数     := LOB_响应参数 || '<REG_DATE>' ||
                          TO_CHAR(ROW_排班信息.排班日期, 'yyyy-MM-dd') ||
                          '</REG_DATE>'; --出诊日期
          LOB_响应参数     := LOB_响应参数 || '<REG_WEEKDAY>' || ROW_排班信息.星期 ||
                          '</REG_WEEKDAY>'; --出诊日期对应星期
        
          LOB_响应参数 := LOB_响应参数 ||
                      FU_互联互通_得到响应参数(STR_SQL1, 'REG_TIME_LIST', '');
        
        ELSE
        
          LOB_响应参数 := LOB_响应参数 ||
                      FU_互联互通_得到响应参数(STR_SQL1, 'REG_TIME_LIST', '');
        END IF;
      END IF;
    
    END LOOP;
    IF DBMS_LOB.GETLENGTH(LOB_响应参数) > 0 THEN
      LOB_响应参数 := LOB_响应参数 || '</REG_LIST>'; --出诊日期节点结束
      LOB_响应参数 := LOB_响应参数 || '</REG_DOCTOR_LIST>'; --排班医生集合节点结束
    
      LOB_响应参数 := '<RES><HOS_ID>' || STR_医院ID || '</HOS_ID><DEPT_ID>' ||
                  STR_科室ID || '</DEPT_ID>' || LOB_响应参数 || '</RES>';
      INT_返回值   := 0;
      STR_返回信息 := '交易成功';
    ELSE
      INT_返回值   := 200303;
      STR_返回信息 := '排班不存在，未查询到排班信息';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := 99;
      STR_返回信息 := '响应请求报错:' || SQLERRM;
      GOTO 退出;
  END;
  <<退出>>

  -- 【保存日志】
  PR_互联互通_操作日志(STR_平台标识 => STR_平台标识,
               STR_医院编码 => STR_机构编码,
               STR_功能编码 => STR_功能编码,
               STR_请求参数 => STR_请求参数,
               DAT_请求时间 => SYSDATE,
               INT_返回值   => INT_返回值,
               STR_返回信息 => STR_返回信息,
               DAT_执行时间 => SYSDATE);

  RETURN;

END PR_互联互通_排班信息查询;
/
