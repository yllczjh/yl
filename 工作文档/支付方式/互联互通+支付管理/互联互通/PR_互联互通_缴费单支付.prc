CREATE OR REPLACE PROCEDURE PR_互联互通_缴费单支付(STR_请求参数 IN VARCHAR2,
                                          STR_平台标识 IN VARCHAR2,
                                          STR_功能编码 IN VARCHAR2, --3003
                                          LOB_响应参数 OUT CLOB,
                                          INT_返回值   OUT INTEGER,
                                          STR_返回信息 OUT VARCHAR2) IS

  STR_SQL VARCHAR2(1000);
  --【固定参数】
  STR_医院ID           VARCHAR2(50);
  STR_平台订单号       VARCHAR2(50);
  STR_医院订单号       VARCHAR2(50);
  STR_流水号           VARCHAR2(50);
  STR_交易日期         VARCHAR2(50);
  STR_交易时间         VARCHAR2(50);
  STR_支付渠道ID       VARCHAR2(50);
  STR_总金额           VARCHAR2(50);
  STR_应付金额         VARCHAR2(50);
  STR_个人自付金额     VARCHAR2(50);
  STR_医疗统筹支付金额 VARCHAR2(50);
  STR_交易响应代码     VARCHAR2(50);
  STR_交易响应描述     VARCHAR2(50);
  STR_商户号           VARCHAR2(50);
  STR_终端号           VARCHAR2(50);
  STR_银行卡号         VARCHAR2(50);
  STR_第三方支付帐号   VARCHAR2(50);
  STR_操作员ID         VARCHAR2(50);
  STR_收据号           VARCHAR2(50);

  --【业务参数】
  DAT_系统时间     DATE;
  CUR_预算信息     SYS_REFCURSOR;
  STR_预算结果明细 VARCHAR2(4000);

  STR_执行科室编码   VARCHAR(50);
  NUM_费用总额       NUMBER(18, 3);
  NUM_自付总额       NUMBER(18, 3);
  NUM_优惠总额       NUMBER(18, 3);
  NUM_应收总额       NUMBER(18, 3);
  NUM_舍入总额       NUMBER(18, 3);
  NUM_实收总额       NUMBER(18, 3);
  NUM_补偿总额       NUMBER(18, 3);
  NUM_银联卡支付总额 NUMBER(18, 3);

  INT_小数位数       INTEGER;
  STR_舍入方式       VARCHAR2(50);
  STR_收费直接扣库存 VARCHAR2(50);
  STR_按执行科室分票 VARCHAR2(50);

  STR_收费序号 VARCHAR2(50);
  STR_病人ID   VARCHAR2(50);
  STR_挂号序号 VARCHAR2(50);
  STR_医嘱号   VARCHAR2(50);
  STR_发票号   VARCHAR2(50);
  STR_发票序号 VARCHAR2(50);

  STR_订单类型     VARCHAR2(50);
  STR_支付方式     VARCHAR2(50);
  STR_病人类型编码 VARCHAR2(50);
  STR_病人类型名称 VARCHAR2(50);
  STR_门诊病历号   VARCHAR2(50);
  NUM_换算比例     NUMBER(10, 3);

  STR_机构编码 VARCHAR2(50);
  STR_订单状态 VARCHAR2(50);
BEGIN
  BEGIN
    --【固定参数解析】
    STR_医院ID           := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
    STR_平台订单号       := FU_互联互通_节点值(STR_请求参数, 'ORDER_ID');
    STR_医院订单号       := FU_互联互通_节点值(STR_请求参数, 'HOSP_SEQUENCE');
    STR_流水号           := FU_互联互通_节点值(STR_请求参数, 'SERIAL_NUM');
    STR_交易日期         := FU_互联互通_节点值(STR_请求参数, 'PAY_DATE');
    STR_交易时间         := FU_互联互通_节点值(STR_请求参数, 'PAY_TIME');
    STR_支付渠道ID       := FU_互联互通_节点值(STR_请求参数, 'PAY_CHANNEL_ID');
    STR_总金额           := FU_互联互通_节点值(STR_请求参数, 'PAY_TOTAL_FEE');
    STR_应付金额         := FU_互联互通_节点值(STR_请求参数, 'PAY_BEHOOVE_FEE');
    STR_个人自付金额     := FU_互联互通_节点值(STR_请求参数, 'PAY_ACTUAL_FEE');
    STR_医疗统筹支付金额 := FU_互联互通_节点值(STR_请求参数, 'PAY_MI_FEE');
    STR_交易响应代码     := FU_互联互通_节点值(STR_请求参数, 'PAY_RES_CODE');
    STR_交易响应描述     := FU_互联互通_节点值(STR_请求参数, 'PAY_RES_DESC');
    STR_商户号           := FU_互联互通_节点值(STR_请求参数, 'MERCHANT_ID');
    STR_终端号           := FU_互联互通_节点值(STR_请求参数, 'TERMINAL_ID');
    STR_银行卡号         := FU_互联互通_节点值(STR_请求参数, 'BANK_NO');
    STR_第三方支付帐号   := FU_互联互通_节点值(STR_请求参数, 'PAY_ACCOUNT');
    STR_操作员ID         := FU_互联互通_节点值(STR_请求参数, 'OPERATOR_ID');
    STR_收据号           := FU_互联互通_节点值(STR_请求参数, 'RECEIPT_ID');
  
    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
    STR_订单类型     := '门诊缴费';
    STR_病人类型编码 := '1';
    STR_病人类型名称 := '现金';
  
    --【参数验证】
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
      STR_返回信息 := '请传入就诊登记号';
      GOTO 退出;
    END IF;
    IF STR_流水号 IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请传入流水号';
      GOTO 退出;
    END IF;
    IF STR_交易日期 IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请传入交易日期';
      GOTO 退出;
    END IF;
    IF STR_交易时间 IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请传入交易时间';
      GOTO 退出;
    END IF;
    IF STR_支付渠道ID IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请传入支付渠道ID';
      GOTO 退出;
    END IF;
    IF STR_总金额 IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请传入总金额';
      GOTO 退出;
    END IF;
    IF STR_应付金额 IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请传入应付金额';
      GOTO 退出;
    END IF;
    IF STR_个人自付金额 IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请传入个人自付金额';
      GOTO 退出;
    END IF;
    IF STR_医疗统筹支付金额 IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请传入医疗统筹支付金额';
      GOTO 退出;
    END IF;
  
    STR_机构编码 := FU_互联互通_医院ID转换(STR_平台标识, STR_医院ID, '1');
    IF STR_机构编码 IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '医院ID无效';
      GOTO 退出;
    END IF;
  
    -- 【系统参数】
    BEGIN
      SELECT 值
        INTO STR_舍入方式
        FROM 基础项目_机构参数列表
       WHERE 参数编码 = '53'
         AND 机构编码 = STR_机构编码;
    EXCEPTION
      WHEN OTHERS THEN
        STR_舍入方式 := '2';
    END;
  
    BEGIN
      SELECT TO_NUMBER(值)
        INTO INT_小数位数
        FROM 基础项目_机构参数列表
       WHERE 参数编码 = '52'
         AND 机构编码 = STR_机构编码;
    EXCEPTION
      WHEN OTHERS THEN
        INT_小数位数 := 2;
    END;
  
    BEGIN
      SELECT 值
        INTO STR_收费直接扣库存
        FROM 基础项目_机构参数列表
       WHERE 参数编码 = '164'
         AND 机构编码 = STR_机构编码;
    EXCEPTION
      WHEN OTHERS THEN
        STR_收费直接扣库存 := '否';
    END;
  
    BEGIN
      SELECT 值
        INTO STR_按执行科室分票
        FROM 基础项目_机构参数列表
       WHERE 参数编码 = '50'
         AND 机构编码 = STR_机构编码;
    EXCEPTION
      WHEN OTHERS THEN
        STR_按执行科室分票 := '0';
    END;
  
    BEGIN
      SELECT 换算比例, 支付方式
        INTO NUM_换算比例, STR_支付方式
        FROM 互联互通_平台参数配置
       WHERE 平台标识 = STR_平台标识
         AND 有效状态 = '1';
    EXCEPTION
      WHEN OTHERS THEN
        NUM_换算比例 := 100;
    END;
  
    --【验证订单】
    BEGIN
      SELECT 关联编码, 病人ID, 就诊病历号, 订单状态, 应付金额
        INTO STR_收费序号,
             STR_病人ID,
             STR_门诊病历号,
             STR_订单状态,
             NUM_应收总额
        FROM 互联互通_订单
       WHERE 平台标识 = STR_平台标识
         AND 医院编码 = STR_机构编码
         AND 医院订单号 = STR_医院订单号
         AND 订单类型 = STR_订单类型;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        INT_返回值   := 300301;
        STR_返回信息 := '缴费订单不存在';
        GOTO 退出;
      WHEN OTHERS THEN
        INT_返回值   := -1;
        STR_返回信息 := '系统异常：' || SQLERRM;
        GOTO 退出;
    END;
    IF STR_订单状态 = '已支付' THEN
      INT_返回值   := 300302;
      STR_返回信息 := '缴费订单已支付';
      GOTO 退出;
    END IF;
    IF TO_NUMBER(STR_应付金额) / NUM_换算比例 <> NUM_应收总额 OR
       (TO_NUMBER(STR_个人自付金额) + TO_NUMBER(STR_医疗统筹支付金额)) / NUM_换算比例 <>
       NUM_应收总额 THEN
      INT_返回值   := 300304;
      STR_返回信息 := '缴费金额不正确';
      GOTO 退出;
    END IF;
  
    -- 【验证医嘱状态】
    SELECT COUNT(1)
      INTO INT_返回值
      FROM 门诊管理_门诊医嘱明细 M, 门诊管理_门诊医嘱 Y
     WHERE M.机构编码 = Y.机构编码
       AND M.病人ID = Y.病人ID
       AND M.门诊病历号 = Y.门诊病历号
       AND M.序号 = Y.序号
       AND M.医嘱号 = Y.医嘱号
       AND M.机构编码 = STR_机构编码
       AND M.病人ID = STR_病人ID
       AND M.收费序号 = STR_收费序号
       AND Y.收费状态 = '发送未收费'
       AND Y.划价方式 <> '退费自动划价';
  
    IF INT_返回值 <= 0 THEN
      INT_返回值   := 300303;
      STR_返回信息 := '缴费订单已关闭';
      GOTO 退出;
    END IF;
  
    -- 【验证处方状态】
    SELECT COUNT(1)
      INTO INT_返回值
      FROM 门诊管理_门诊医嘱明细 M, 门诊管理_门诊处方 C
     WHERE M.机构编码 = C.机构编码
       AND M.病人ID = C.病人ID
       AND M.门诊病历号 = C.门诊病历号
       AND M.序号 = C.序号
       AND M.医嘱号 = C.医嘱号
       AND M.流水码 = C.医嘱流水码
       AND M.机构编码 = STR_机构编码
       AND M.病人ID = STR_病人ID
       AND M.收费序号 = STR_收费序号;
  
    IF INT_返回值 > 0 THEN
      INT_返回值   := 300303;
      STR_返回信息 := '缴费订单已关闭';
      GOTO 退出;
    END IF;
  
    -- 【验证医嘱明细】
    BEGIN
      SELECT DISTINCT 挂号序号, 医嘱号
        INTO STR_挂号序号, STR_医嘱号
        FROM 门诊管理_门诊医嘱明细
       WHERE 机构编码 = STR_机构编码
         AND 病人ID = STR_病人ID
         AND 收费序号 = STR_收费序号;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        INT_返回值   := 300301;
        STR_返回信息 := '缴费订单不存在';
        GOTO 退出;
      WHEN OTHERS THEN
        INT_返回值   := 99;
        STR_返回信息 := '系统异常：' || SQLERRM;
        GOTO 退出;
    END;
  
    -- 生成发票号
    SELECT FU_公用_获取当前票据号(STR_机构编码, STR_平台标识, '1')
      INTO STR_发票号
      FROM DUAL;
  
    IF STR_发票号 = '请到财务先领用票据' THEN
      INT_返回值   := 99;
      STR_返回信息 := '该操作员无发票号,请通知财务先领用票据!';
      GOTO 退出;
    END IF;
  
    -- 生成发票序号
    SELECT SEQ_门诊管理_发票登记_发票序号.NEXTVAL
      INTO STR_发票序号
      FROM DUAL;
  
    -- 【功能处理】
    BEGIN
    
      PR_门诊管理_预结算(STR_机构编码       => STR_机构编码,
                  STR_唯一编码       => STR_收费序号,
                  STR_会员类型编码   => '-1',
                  DEC_优惠值         => 0,
                  NUM_补偿总额       => 0,
                  STR_按执行科室分票 => STR_按执行科室分票,
                  STR_舍入方式       => STR_舍入方式,
                  INT_舍入位数       => INT_小数位数,
                  CUR_预算信息       => CUR_预算信息,
                  INT_返回值         => INT_返回值,
                  STR_返回信息       => STR_返回信息);
    
      IF INT_返回值 = 0 THEN
        INT_返回值   := 99;
        STR_返回信息 := '生成预结算记录失败!';
        GOTO 退出;
      END IF;
    
      LOOP
        FETCH CUR_预算信息
          INTO STR_执行科室编码,
               NUM_费用总额,
               NUM_补偿总额,
               NUM_自付总额,
               NUM_优惠总额,
               NUM_应收总额,
               NUM_舍入总额,
               NUM_实收总额,
               NUM_银联卡支付总额;
        EXIT WHEN CUR_预算信息%NOTFOUND;
      
        STR_预算结果明细 := STR_预算结果明细 || STR_发票号 || '~' || STR_执行科室编码 || '~' ||
                      NUM_费用总额 || '~' || NUM_补偿总额 || '~' || NUM_自付总额 || '~' ||
                      NUM_优惠总额 || '~' || NUM_应收总额 || '~' || NUM_舍入总额 || '~' ||
                      NUM_实收总额 || '~' || STR_发票序号 || '~' || 0 || '~' ||
                      NUM_应收总额 || '~' || 0 || '~' || NUM_应收总额 || '~' ||
                      NUM_银联卡支付总额 || '~~|';
      END LOOP;
    
      CLOSE CUR_预算信息;
    
      IF STR_预算结果明细 IS NULL THEN
        INT_返回值   := 99;
        STR_返回信息 := '构建预结算记录失败!';
        GOTO 退出;
      END IF;
    
      STR_预算结果明细 := '发票号,执行科室编码,费用总额,补偿总额,自付总额,优惠总额,应收总额,舍入总额,实收总额,发票序号,原发票医卡通支付金额,本次退费总额,本次卡退费总额,本次现金退费总额,银联卡支付总额##' ||
                    STR_预算结果明细;
    
      DBMS_OUTPUT.PUT_LINE(STR_预算结果明细);
    
      PR_门诊管理_门诊收费(STR_机构编码       => STR_机构编码,
                   STR_病人ID         => STR_病人ID,
                   STR_门诊病历号     => STR_门诊病历号,
                   STR_挂号序号       => STR_挂号序号,
                   STR_病人类型编码   => STR_病人类型编码,
                   STR_病人类型名称   => STR_病人类型名称,
                   STR_收费序号       => STR_收费序号,
                   STR_预算结果明细   => STR_预算结果明细,
                   STR_付款方式       => STR_支付方式 || '|' || NUM_应收总额 || '@',
                   STR_原发票序号     => '0',
                   INT_打折比例       => 0,
                   STR_打折方式       => '-1',
                   STR_操作员编码     => STR_平台标识,
                   STR_操作员名称     => STR_平台标识,
                   STR_收费直接扣库存 => STR_收费直接扣库存,
                   INT_小数位数       => INT_小数位数,
                   STR_舍入方式       => STR_舍入方式,
                   STR_补偿信息       => '',
                   DAT_系统时间       => DAT_系统时间,
                   INT_返回值         => INT_返回值,
                   STR_返回信息       => STR_返回信息,
                   STR_一卡通交易号   => '',
                   STR_结算方式       => '');
    
      IF INT_返回值 <> 1 THEN
        INT_返回值   := 99;
        STR_返回信息 := '保存缴费记录失败!';
        GOTO 退出;
      END IF;
    
      -- 更新订单状态
      UPDATE 互联互通_订单
         SET 订单状态         = '已支付',
             平台订单号       = STR_平台订单号,
             实付金额         = TO_NUMBER(STR_个人自付金额) / NUM_换算比例,
             医疗统筹支付金额 = TO_NUMBER(STR_医疗统筹支付金额) / NUM_换算比例,
             医院支付号       = STR_发票序号,
             平台交易流水号   = STR_流水号,
             支付时间         = TO_DATE(STR_交易日期 || ' ' || STR_交易时间,
                                    'yyyy-MM-dd hh24:mi:ss'),
             支付渠道         = STR_支付渠道ID,
             更新人           = STR_平台标识,
             更新时间         = DAT_系统时间
       WHERE 平台标识 = STR_平台标识
         AND 病人ID = STR_病人ID
         AND 医院订单号 = STR_医院订单号
         AND 订单类型 = STR_订单类型
         AND 订单状态 = '待支付';
    
      STR_SQL := 'SELECT ''' || STR_发票序号 || ''' AS HOSP_ORDER_ID,
    '''' AS RECEIPT_ID,''' || STR_门诊病历号 ||
                 ''' AS HOSP_MEDICAL_NUM ,''发票号:' || STR_发票号 ||
                        ',病历号:' || STR_门诊病历号 ||
                        ',请根据此信息到缴费窗口打印缴费单据'' AS  HOSP_REMARK FROM DUAL';
    
      LOB_响应参数 := FU_互联互通_得到响应参数(STR_SQL, 'RES', '');
    
      INT_返回值   := 0;
      STR_返回信息 := '交易成功';
    
      COMMIT;
    
    EXCEPTION
      WHEN OTHERS THEN
        INT_返回值   := 99;
        STR_返回信息 := '响应请求报错；' || SQLERRM;
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
END PR_互联互通_缴费单支付;
/
