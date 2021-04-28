CREATE OR REPLACE PROCEDURE PR_互联互通_预约挂号退款(STR_请求参数 IN VARCHAR2,
                                           STR_平台标识 IN VARCHAR2, --2010
                                           STR_功能编码 IN VARCHAR2,
                                           LOB_响应参数 OUT CLOB,
                                           INT_返回值   OUT INTEGER,
                                           STR_返回信息 OUT VARCHAR2) IS

  --【请求参数】
  STR_医院ID       VARCHAR2(50);
  STR_平台订单号   VARCHAR2(50);
  STR_医院订单号   VARCHAR2(50);
  STR_平台退款单号 VARCHAR2(50);
  STR_退款流水号   VARCHAR2(50);
  STR_总金额       VARCHAR2(50);
  STR_退款金额     VARCHAR2(50);
  STR_退款日期     VARCHAR2(50);
  STR_退款时间     VARCHAR2(50);
  STR_交易响应代码 VARCHAR2(50);
  STR_交易响应描述 VARCHAR2(50);
  STR_退款原因     VARCHAR2(50);

  STR_预约单号     VARCHAR2(50);
  STR_订单状态     VARCHAR2(50);
  STR_SQL          VARCHAR2(1000);
  STR_医院退款单号 VARCHAR2(50);
  NUM_实付金额     NUMBER;
  STR_日排班标识   VARCHAR2(50);
  str_支付渠道     varchar2(50);
  NUM_换算比例     NUMBER(10, 3);
  STR_机构编码     VARCHAR2(50);

BEGIN
  --【请求参数解析】
  STR_医院ID       := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
  STR_平台订单号   := FU_互联互通_节点值(STR_请求参数, 'ORDER_ID');
  STR_医院订单号   := FU_互联互通_节点值(STR_请求参数, 'HOSP_ORDER_ID');
  STR_平台退款单号 := FU_互联互通_节点值(STR_请求参数, 'REFUND_ID');
  STR_退款流水号   := FU_互联互通_节点值(STR_请求参数, 'REFUND_SERIAL_NUM');
  STR_总金额       := FU_互联互通_节点值(STR_请求参数, 'TOTAL_FEE');
  STR_退款金额     := FU_互联互通_节点值(STR_请求参数, 'REFUND_FEE');
  STR_退款日期     := FU_互联互通_节点值(STR_请求参数, 'REFUND_DATE');
  STR_退款时间     := FU_互联互通_节点值(STR_请求参数, 'REFUND_TIME');
  STR_交易响应代码 := FU_互联互通_节点值(STR_请求参数, 'REFUND_RES_CODE');
  STR_交易响应描述 := FU_互联互通_节点值(STR_请求参数, 'REFUND_RES_DESC');
  STR_退款原因     := FU_互联互通_节点值(STR_请求参数, 'REFUND_REMARK');

  --【验证参数】
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
  IF STR_医院订单号 IS NULL THEN
    INT_返回值   := 1;
    STR_返回信息 := '请传入医院订单号';
    GOTO 退出;
  END IF;
  IF STR_平台退款单号 IS NULL THEN
    INT_返回值   := 1;
    STR_返回信息 := '请传入平台退款单号';
    GOTO 退出;
  END IF;
  IF STR_总金额 IS NULL THEN
    INT_返回值   := 1;
    STR_返回信息 := '请传入总金额';
    GOTO 退出;
  END IF;
  IF STR_退款金额 IS NULL THEN
    INT_返回值   := 1;
    STR_返回信息 := '请传入退款金额';
    GOTO 退出;
  END IF;
  STR_机构编码 := FU_互联互通_医院ID转换(STR_平台标识, STR_医院ID, '1');
  IF STR_机构编码 IS NULL THEN
    INT_返回值   := 1;
    STR_返回信息 := '医院ID无效';
    GOTO 退出;
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

  --【验证订单状态】
  BEGIN
    SELECT 关联编码, 订单状态, 实付金额, 医院订单号, 支付渠道
      INTO STR_预约单号,
           STR_订单状态,
           NUM_实付金额,
           STR_医院订单号,
           str_支付渠道
      FROM 互联互通_订单
     WHERE 平台标识 = STR_平台标识
       AND 医院编码 = STR_机构编码
       AND 平台订单号 = STR_平台订单号;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INT_返回值   := 201001;
      STR_返回信息 := '挂号订单不存在';
      GOTO 退出;
    WHEN OTHERS THEN
      INT_返回值   := 99;
      STR_返回信息 := '系统异常：' || SQLERRM;
      GOTO 退出;
  END;

  IF STR_订单状态 = '已取消' THEN
    INT_返回值   := 200805;
    STR_返回信息 := '挂号订单已取消';
    GOTO 退出;
  ELSIF STR_订单状态 = '已退款' THEN
    INT_返回值   := 200806;
    STR_返回信息 := '挂号订单已退款';
    GOTO 退出;
  END IF;

  IF NUM_实付金额 * NUM_换算比例 <> TO_NUMBER(STR_退款金额) THEN
    INT_返回值   := 201003;
    STR_返回信息 := '退款金额不正确';
    GOTO 退出;
  END IF;

  -- 验证预约单
  BEGIN
    SELECT 日班次标识
      INTO STR_日排班标识
      FROM 门诊管理_预约挂号
     WHERE 机构编码 = STR_机构编码
       AND 主键ID = STR_预约单号
       AND 去向标志 = '预约';
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INT_返回值   := 201001;
      STR_返回信息 := '挂号订单不存在';
      GOTO 退出;
    WHEN OTHERS THEN
      INT_返回值   := 99;
      STR_返回信息 := '系统异常：' || SQLERRM;
      GOTO 退出;
    
  END;

  -- 【功能处理】
  BEGIN
  
    -- 解锁号
    UPDATE 门诊管理_日排班时段表
       SET 已挂号数 = 已挂号数 - 1
     WHERE 机构编码 = STR_机构编码
       AND 日班次标识 = STR_日排班标识;
    INT_返回值 := SQL%ROWCOUNT;
    IF INT_返回值 = 0 THEN
      INT_返回值   := 99;
      STR_返回信息 := '解锁号源失败！';
      GOTO 退出;
    END IF;
  
    -- 更新预约单
    UPDATE 门诊管理_预约挂号
       SET 去向标志 = '消号'
     WHERE 机构编码 = STR_机构编码
       AND 主键ID = STR_预约单号
       AND 去向标志 = '预约';
  
    INT_返回值 := SQL%ROWCOUNT;
    IF INT_返回值 = 0 THEN
      INT_返回值   := 99;
      STR_返回信息 := '更新预约单失败！';
      GOTO 退出;
    END IF;
  
  
    -- 更新订单状态
    UPDATE 互联互通_订单 T
       SET T.订单状态       = '已退款',
           T.平台退款号     = STR_平台退款单号,
           T.平台退款流水号 = STR_退款流水号,
           T.退款时间       = DECODE(STR_退款日期,
                                 NULL,
                                 SYSDATE,
                                 TO_DATE(STR_退款日期 || ' ' || STR_退款时间,
                                         'yyyy-MM-dd hh24:mi:ss')),
           T.医院退款号     = T.医院支付号 || '-1',
           T.退款金额       = NUM_实付金额,
           T.退款标志       = '1', --成功 平台退款
           T.更新人         = STR_平台标识,
           T.更新时间       = SYSDATE
     WHERE T.平台标识 = STR_平台标识
       AND T.医院编码 = STR_机构编码
       AND T.平台订单号 = STR_平台订单号
       AND T.关联编码 = STR_预约单号;
  
    INT_返回值 := SQL%ROWCOUNT;
    IF INT_返回值 = 0 THEN
      INT_返回值   := 99;
      STR_返回信息 := '更新订单失败！';
      GOTO 退出;
    END IF;
  
    STR_SQL := 'SELECT ''' || STR_医院退款单号 ||
               ''' AS HOSP_REFUND_ID, 
                   ''1'' AS REFUND_FLAG FROM DUAL';
  
    LOB_响应参数 := FU_互联互通_得到响应参数(STR_SQL, 'RES', '');
  
    INT_返回值   := 0;
    STR_返回信息 := '交易成功';
  
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := 99;
      STR_返回信息 := '响应请求报错:' || SQLERRM;
      GOTO 退出;
  END;

  COMMIT;

  --【异常退出】
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

  ROLLBACK;
  RETURN;

END PR_互联互通_预约挂号退款;
/
