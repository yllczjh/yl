CREATE OR REPLACE PROCEDURE PR_互联互通_预约挂号取号(STR_请求参数 IN VARCHAR2,
                                           STR_平台标识 IN VARCHAR2,
                                           STR_功能编码 IN VARCHAR2, --2011
                                           STR_调用标识 IN VARCHAR2, --0平台  1医院
                                           LOB_响应参数 OUT CLOB,
                                           INT_返回值   OUT INTEGER,
                                           STR_返回信息 OUT VARCHAR2) IS

  --【请求参数】
  STR_医院ID     VARCHAR2(50);
  STR_平台订单号 VARCHAR2(50);

  --【业务参数】
  STR_SQL      VARCHAR2(1000);
  DAT_系统时间 DATE;
  STR_预约单号 VARCHAR2(50);

  STR_病人ID       VARCHAR2(50);
  STR_排班ID       VARCHAR2(50);
  STR_挂号序号     VARCHAR2(50);
  STR_挂号单号     VARCHAR2(50);
  STR_门诊病历号   VARCHAR2(50);
  NUM_挂号费       NUMBER(10, 4);
  NUM_诊查费       NUMBER(10, 4);
  NUM_总费用       NUMBER(10, 4);
  STR_费用归类编码 VARCHAR2(50);

  STR_挂号科室编码 VARCHAR2(50);
  STR_挂号科室位置 VARCHAR2(50);
  STR_挂号医生编码 VARCHAR2(50);
  STR_挂号类型编码 VARCHAR2(50);

  STR_病人类型编码 VARCHAR2(50);
  STR_病人类型名称 VARCHAR2(50);
  STR_就诊状态     VARCHAR2(50);
  STR_挂号来源     VARCHAR2(50);
  STR_付款方式     VARCHAR2(50);

  DAT_预约开始时间 DATE;
  DAT_预约结束时间 DATE;
  STR_日班次标识   VARCHAR2(50);

  STR_医院候诊号 VARCHAR2(50);
  STR_机构编码   VARCHAR2(50);
  STR_平台名称   VARCHAR2(50);

BEGIN
  BEGIN
  
    --【请求参数解析】
    STR_医院ID := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
    IF STR_调用标识 = '1' THEN
      --医院
      STR_医院ID := FU_互联互通_医院ID转换(STR_平台标识, STR_医院ID, '2');
    END IF;
  
    STR_平台订单号 := FU_互联互通_节点值(STR_请求参数, 'ORDER_ID');
  
    STR_病人类型编码 := '1';
    STR_病人类型名称 := '现金';
    STR_就诊状态     := '等待接诊';
    STR_挂号来源     := '预约';
  
    -- 【变量初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
  
    BEGIN
      SELECT 平台名称, 支付方式
        INTO STR_平台名称, STR_付款方式
        FROM 互联互通_平台参数配置
       WHERE 平台标识 = STR_平台标识
         AND ROWNUM = 1;
    EXCEPTION
      WHEN OTHERS THEN
        STR_付款方式 := '网上支付';
        STR_平台名称 := STR_平台标识;
    END;
  
    IF STR_医院ID IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请传入医院ID';
      GOTO 退出;
    END IF;
    IF STR_平台订单号 IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请传入平台订单号';
      GOTO 退出;
    END IF;
    STR_机构编码 := FU_互联互通_医院ID转换(STR_平台标识, STR_医院ID, '1');
    IF STR_机构编码 IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '医院ID无效';
      GOTO 退出;
    END IF;
  
    -- 【获取预约单号】
    BEGIN
      SELECT 关联编码
        INTO STR_预约单号
        FROM 互联互通_订单
       WHERE 医院编码 = STR_机构编码
         AND 平台标识 = STR_平台标识
         AND 平台订单号 = STR_平台订单号
         AND 订单状态 = '已支付';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        INT_返回值   := 201101;
        STR_返回信息 := '挂号订单不存在';
        GOTO 退出;
      WHEN OTHERS THEN
        INT_返回值   := 99;
        STR_返回信息 := '系统错误' || SQLERRM;
        GOTO 退出;
    END;
  
    -- 读取预约挂号数据
    BEGIN
      SELECT 挂号科室编码,
             挂号科室位置,
             挂号医生编码,
             挂号类型编码,
             病人ID,
             排班ID,
             挂号费,
             诊查费,
             挂号费 + 诊查费,
             归类编码,
             预约时段开始,
             预约时段结束,
             日班次标识
        INTO STR_挂号科室编码,
             STR_挂号科室位置,
             STR_挂号医生编码,
             STR_挂号类型编码,
             STR_病人ID,
             STR_排班ID,
             NUM_挂号费,
             NUM_诊查费,
             NUM_总费用,
             STR_费用归类编码,
             DAT_预约开始时间,
             DAT_预约结束时间,
             STR_日班次标识
        FROM 门诊管理_预约挂号 G
       WHERE G.机构编码 = STR_机构编码
         AND G.主键ID = STR_预约单号
         AND G.去向标志 = '预约'
         AND G.支付标志 = '是'
         AND TO_CHAR(G.预约时间, 'yyyymmdd') = TO_CHAR(SYSDATE, 'yyyymmdd');
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        INT_返回值   := 201101;
        STR_返回信息 := '挂号订单不存在';
        GOTO 退出;
      WHEN OTHERS THEN
        INT_返回值   := 99;
        STR_返回信息 := '系统异常：' || SQLERRM;
        GOTO 退出;
    END;
  
    -- 产生【门诊病历号】
    PR_公用_取得业务病历号(STR_机构编码   => STR_机构编码,
                  STR_病历号类型 => '门诊病历号',
                  STR_返回病历号 => STR_门诊病历号,
                  INT_返回值     => INT_返回值,
                  STR_返回信息   => STR_返回信息);
    IF INT_返回值 <> 1 THEN
      INT_返回值   := 99;
      STR_返回信息 := '产生门诊病历号失败,原因:' + STR_返回信息;
      GOTO 退出;
    END IF;
  
    -- 产生【挂号序号】
    PR_获取_系统唯一号(PRM_唯一号编码 => '26',
                PRM_机构编码   => STR_机构编码,
                PRM_事物类型   => '1',
                PRM_返回唯一号 => STR_挂号序号,
                PRM_执行结果   => INT_返回值,
                PRM_错误信息   => STR_返回信息);
    IF INT_返回值 <> 0 THEN
      INT_返回值   := 99;
      STR_返回信息 := '产生挂号序号失败!';
      GOTO 退出;
    END IF;
  
    -- 产生【挂号单号】
    SELECT FU_公用_获取当前票据号(STR_机构编码, STR_平台标识, '4')
      INTO STR_挂号单号
      FROM DUAL;
  
    IF STR_挂号单号 = '请到财务先领用票据' THEN
      INT_返回值   := 99;
      STR_返回信息 := '该操作员无挂号单号,请通知财务先领用票据!';
      GOTO 退出;
    END IF;
  
    -- 生成挂号记录 
    BEGIN
      INSERT INTO 门诊管理_挂号登记
        (机构编码,
         病人ID,
         门诊病历号,
         挂号序号,
         挂号单号,
         挂号科室编码,
         挂号科室位置,
         挂号医生编码,
         挂号类型编码,
         操作员编码,
         挂号时间,
         退号标志,
         归类编码,
         挂号费,
         工本费,
         诊查费,
         病历本,
         总费用,
         是否急诊,
         序号,
         就诊状态,
         病人类型编码,
         挂号来源,
         就诊科室编码,
         就诊医生编码,
         补偿金额,
         自付金额,
         挂号类别编码,
         卡支付金额,
         预约开始时间,
         预约结束时间,
         日班次标识,
         排班ID)
      VALUES
        (STR_机构编码,
         STR_病人ID,
         STR_门诊病历号,
         STR_挂号序号,
         STR_挂号单号,
         STR_挂号科室编码,
         STR_挂号科室位置,
         STR_挂号医生编码,
         STR_挂号类型编码,
         STR_平台标识,
         DAT_系统时间,
         '否',
         STR_费用归类编码,
         NUM_挂号费,
         0,
         NUM_诊查费,
         0,
         NUM_总费用,
         '否',
         '0',
         STR_就诊状态,
         STR_病人类型编码,
         STR_挂号来源,
         STR_挂号科室编码,
         STR_挂号医生编码,
         0,
         NUM_总费用,
         '-1',
         0,
         DAT_预约开始时间,
         DAT_预约结束时间,
         STR_日班次标识,
         STR_排班ID);
    
      INT_返回值 := SQL%ROWCOUNT;
      IF INT_返回值 = 0 THEN
        INT_返回值   := 99;
        STR_返回信息 := '保存挂号数据失败！';
        GOTO 退出;
      END IF;
    
      -- 生成收支款记录
      INSERT INTO 财务管理_收支款
        (机构编码,
         单据号,
         收费金额,
         付款方式,
         业务类型,
         操作员编码,
         操作员姓名,
         收费时间,
         挂号序号,
         发票序号,
         挂号收费标志,
         病人类型编码,
         病人类型名称)
      VALUES
        (STR_机构编码,
         STR_挂号单号,
         NUM_总费用,
         STR_付款方式,
         '挂号',
         STR_平台标识,
         STR_平台名称,
         SYSDATE,
         STR_挂号序号,
         STR_挂号序号,
         '挂号',
         STR_病人类型编码,
         STR_病人类型名称);
    
      INT_返回值 := SQL%ROWCOUNT;
      IF INT_返回值 = 0 THEN
        INT_返回值   := 99;
        STR_返回信息 := '保存收支款数据失败！';
        GOTO 退出;
      END IF;
    
      -- 更新预约状态
      UPDATE 门诊管理_预约挂号
         SET 去向标志 = '看诊',
             挂号序号 = STR_挂号序号,
             取号时间 = DAT_系统时间
       WHERE 机构编码 = STR_机构编码
         AND 主键ID = STR_预约单号;
    
      INT_返回值 := SQL%ROWCOUNT;
      IF INT_返回值 = 0 THEN
        INT_返回值   := -1;
        STR_返回信息 := '更新预约状态失败！';
        GOTO 退出;
      END IF;
    
      -- 更新订单
      UPDATE 互联互通_订单
         SET 就诊病历号 = STR_门诊病历号
       WHERE 平台标识 = STR_平台标识
         AND 医院编码 = STR_机构编码
         AND 平台订单号 = STR_平台订单号
         AND 关联编码 = STR_预约单号
         AND 订单类型 = '预约挂号';
    
      INT_返回值 := SQL%ROWCOUNT;
      IF INT_返回值 = 0 THEN
        INT_返回值   := 99;
        STR_返回信息 := '更新订单状态失败！';
        GOTO 退出;
      END IF;
    
      IF STR_调用标识 = '0' THEN
        STR_SQL      := 'SELECT ''' || STR_医院候诊号 ||
                        ''' AS HOSP_SERIAL_NUM,      
                         ''挂号单号:' || STR_挂号单号 ||
                        ',病历号:' || STR_门诊病历号 ||
                        ',请根据此信息到挂号窗口打印挂号单'' AS REMARK FROM DUAL';
        LOB_响应参数 := FU_互联互通_得到响应参数(STR_SQL, 'RES', '');
      ELSE
        LOB_响应参数 := STR_挂号单号;
      END IF;
    
      INT_返回值   := 0;
      STR_返回信息 := '交易成功';
    
      COMMIT;
    
    EXCEPTION
      WHEN OTHERS THEN
        INT_返回值   := 99;
        STR_返回信息 := '响应请求报错:' || SQLERRM;
        GOTO 退出;
    END;
  
  END;
  <<退出>>

  -- 【保存日志】
  PR_互联互通_操作日志(STR_平台标识 => STR_平台标识,
               STR_医院编码 => STR_机构编码,
               STR_功能编码 => STR_功能编码,
               STR_请求参数 => STR_请求参数,
               DAT_请求时间 => DAT_系统时间,
               INT_返回值   => INT_返回值,
               STR_返回信息 => STR_返回信息,
               DAT_执行时间 => SYSDATE);
  ROLLBACK;
  RETURN;

END PR_互联互通_预约挂号取号;
/
