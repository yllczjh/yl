CREATE OR REPLACE PROCEDURE PR_互联互通_生成门诊待缴费清单(STR_机构编码   IN VARCHAR2,
                                              STR_病人ID     IN VARCHAR2,
                                              STR_门诊病历号 IN VARCHAR2,
                                              INT_返回值     OUT INTEGER,
                                              STR_返回信息   OUT VARCHAR2) IS

  -- 处理参数
  STR_是否接诊才能收费 VARCHAR2(50);
  I_天数               INTEGER;
  STR_收费序号         VARCHAR2(50);
  STR_医嘱号           VARCHAR2(50);
  STR_挂号序号         VARCHAR2(50);
  NUM_应付金额         NUMBER(18, 3);
  STR_订单号           VARCHAR2(50);
  DAT_系统时间         DATE;
  STR_平台标识         VARCHAR2(50);
  STR_状态             VARCHAR2(50);

  TYPE REF_CURSOR_TYPE IS REF CURSOR;
  CUR_待缴费明细 REF_CURSOR_TYPE;
  ROW_待缴费明细 门诊管理_门诊医嘱明细%ROWTYPE;
  STR_SQL        VARCHAR2(1000);
  NUM_换算比例   NUMBER(10, 3);
BEGIN

  -- 【数据初始化】
  SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
  NUM_应付金额 := 0;
  STR_平台标识 := '12320';

  BEGIN
    SELECT 状态
      INTO STR_状态
      FROM 互联互通_平台功能配置
     WHERE 平台标识 = STR_平台标识
       AND 功能编码 = '3003';
  EXCEPTION
    WHEN OTHERS THEN
      STR_状态 := '0';
  END;
  IF STR_状态 = '0' THEN
    INT_返回值 := 0;
    RETURN;
  END IF;

  BEGIN
    SELECT COUNT(1)
      INTO INT_返回值
      FROM 互联互通_订单
     WHERE 平台标识 = STR_平台标识
       AND 病人ID = STR_病人ID
       AND 就诊病历号 = STR_门诊病历号
       AND 订单类型 = '预约挂号';
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值 := 0;
  END;
  IF INT_返回值 = 0 THEN
    RETURN;
  END IF;

  -- 读取系统参数
  BEGIN
    SELECT TO_NUMBER(值)
      INTO I_天数
      FROM 基础项目_机构参数列表
     WHERE 参数编码 = '48'
       AND 机构编码 = STR_机构编码;
  EXCEPTION
    WHEN OTHERS THEN
      I_天数 := 15;
  END;

  BEGIN
    SELECT 值
      INTO STR_是否接诊才能收费
      FROM 基础项目_机构参数列表
     WHERE 参数编码 = '311'
       AND 机构编码 = STR_机构编码;
  EXCEPTION
    WHEN OTHERS THEN
      STR_是否接诊才能收费 := '否';
  END;

  --【构造数据】
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

  BEGIN
    SELECT DISTINCT A.医嘱号, A.挂号序号
      INTO STR_医嘱号, STR_挂号序号
      FROM 门诊管理_门诊医嘱 A, 门诊管理_挂号登记 C
     WHERE A.机构编码 = C.机构编码
       AND A.病人ID = C.病人ID
       AND A.挂号序号 = C.挂号序号
       AND C.就诊状态 = (CASE
             WHEN STR_是否接诊才能收费 = '是' THEN
              '完成接诊'
             ELSE
              C.就诊状态
           END)
       AND (C.就诊状态 <> '完成接诊' OR EXISTS
            (SELECT 1
               FROM 门诊管理_门诊医嘱 P
              WHERE P.机构编码 = A.机构编码
                AND P.挂号序号 = A.挂号序号
                AND P.病人ID = A.病人ID
                AND P.收费状态 = '发送未收费'))
       AND C.退号标志 = '否'
       AND (A.大类编码 = '1' OR A.大类编码 = '2' OR A.大类编码 = '6')
       AND A.机构编码 = STR_机构编码
       AND A.门诊病历号 = STR_门诊病历号
       AND A.病人ID = STR_病人ID
       AND C.挂号时间 > TRUNC(SYSDATE) - I_天数 + 1
       AND A.录入时间 > TRUNC(SYSDATE) - I_天数 + 1
       AND A.收费状态 = '发送未收费'
       AND A.划价方式 <> '退费自动划价'
       AND C.病人类型编码 = '1';
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INT_返回值   := -1;
      STR_返回信息 := '未找到有效的待缴费信息！';
      GOTO 退出;
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '系统异常：' || SQLERRM;
      GOTO 退出;
  END;

  -- 生成医嘱明细
  BEGIN
  
    PR_互联互通_生成医嘱明细(STR_机构编码 => STR_机构编码,
                   STR_挂号序号 => STR_挂号序号,
                   STR_医嘱号   => STR_医嘱号,
                   STR_收费序号 => STR_收费序号,
                   INT_返回值   => INT_返回值,
                   STR_返回信息 => STR_返回信息);
  
    IF INT_返回值 = -1 THEN
      INT_返回值   := -1;
      STR_返回信息 := '生成待缴费信息失败！';
      GOTO 退出;
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '系统异常：' || SQLERRM;
      GOTO 退出;
  END;

  BEGIN
  
    BEGIN
      SELECT 医院订单号
        INTO STR_订单号
        FROM 互联互通_订单
       WHERE 平台标识 = STR_平台标识
         AND 医院编码 = STR_机构编码
         AND 病人ID = STR_病人ID
         AND 就诊病历号 = STR_门诊病历号
         AND 订单状态 = '待支付'
         AND 订单类型 = '门诊缴费'
         AND ROWNUM = 1;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        STR_订单号 := '';
      WHEN OTHERS THEN
        INT_返回值   := -1;
        STR_返回信息 := '查找订单信息失败!';
        GOTO 退出;
    END;
  
    IF STR_订单号 IS NULL THEN
      -- 1)生成订单号
      PR_获取_系统唯一号(PRM_唯一号编码 => '6002',
                  PRM_机构编码   => STR_机构编码,
                  PRM_事物类型   => '1',
                  PRM_返回唯一号 => STR_订单号,
                  PRM_执行结果   => INT_返回值,
                  PRM_错误信息   => STR_返回信息);
      IF INT_返回值 <> 0 THEN
        INT_返回值   := -1;
        STR_返回信息 := '产生订单号失败!';
        GOTO 退出;
      END IF;
    ELSE
      --删除未缴费的订单明细记录
      DELETE FROM 互联互通_订单明细 WHERE 订单号 = STR_订单号;
      --删除未缴费的订单记录
      DELETE FROM 互联互通_订单 WHERE 医院订单号 = STR_订单号;
    END IF;
  
    STR_SQL := 'SELECT *
      FROM 门诊管理_门诊医嘱明细
     WHERE 机构编码 = ''' || STR_机构编码 || '''
       AND 病人ID = ''' || STR_病人ID || '''
       AND 门诊病历号 = ''' || STR_门诊病历号 || '''
       AND 收费序号 = ''' || STR_收费序号 || '''';
    OPEN CUR_待缴费明细 FOR STR_SQL;
    LOOP
      FETCH CUR_待缴费明细
        INTO ROW_待缴费明细;
      EXIT WHEN CUR_待缴费明细%NOTFOUND;
      INSERT INTO 互联互通_订单明细
        (流水码,
         订单号,
         唯一编码,
         大类编码,
         小类编码,
         项目编码,
         项目名称,
         规格,
         批次号,
         数量,
         单位,
         单价,
         总金额,
         归类编码)
      VALUES
        (SEQ_互联互通_订单明细_流水码.NEXTVAL,
         STR_订单号,
         ROW_待缴费明细.计价ID,
         ROW_待缴费明细.大类编码,
         ROW_待缴费明细.小类编码,
         ROW_待缴费明细.项目编码,
         ROW_待缴费明细.项目名称,
         ROW_待缴费明细.规格,
         ROW_待缴费明细.批次号,
         ROW_待缴费明细.数量,
         ROW_待缴费明细.单位名称,
         ROW_待缴费明细.单价,
         ROW_待缴费明细.总金额,
         ROW_待缴费明细.归类编码);
    
      INT_返回值 := SQL%ROWCOUNT;
      IF INT_返回值 = 0 THEN
        INT_返回值   := -1;
        STR_返回信息 := '保存订单明细失败！';
        GOTO 退出;
      END IF;
    
      NUM_应付金额 := NUM_应付金额 + ROW_待缴费明细.总金额;
    
    END LOOP;
  
    INSERT INTO 互联互通_订单
      (流水码,
       平台标识,
       医院编码,
       病人ID,
       就诊病历号,
       关联编码,
       订单类型,
       订单时间,
       医院订单号,
       总金额,
       应付金额,
       实付金额,
       订单状态,
       创建人,
       创建时间,
       更新人,
       更新时间)
    VALUES
      (SEQ_互联互通_订单_流水码.NEXTVAL,
       STR_平台标识,
       STR_机构编码,
       STR_病人ID,
       STR_门诊病历号,
       STR_收费序号,
       '门诊缴费',
       DAT_系统时间,
       STR_订单号,
       NUM_应付金额,
       NUM_应付金额,
       0,
       '待支付',
       STR_平台标识,
       DAT_系统时间,
       STR_平台标识,
       DAT_系统时间);
  
    INT_返回值 := SQL%ROWCOUNT;
    IF INT_返回值 = 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '保存订单失败！';
      GOTO 退出;
    END IF;
    CLOSE CUR_待缴费明细;
  
    INT_返回值 := '0';
  
    COMMIT;
    RETURN;
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '系统异常：' || SQLERRM;
      GOTO 退出;
  END;

  <<退出>>
  IF CUR_待缴费明细%ISOPEN THEN
    CLOSE CUR_待缴费明细;
  END IF;

  INT_返回值 := '-1';

  ROLLBACK;
  RETURN;
END PR_互联互通_生成门诊待缴费清单;
/
