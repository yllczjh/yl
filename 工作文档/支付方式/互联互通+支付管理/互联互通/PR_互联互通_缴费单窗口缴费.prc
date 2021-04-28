CREATE OR REPLACE PROCEDURE PR_互联互通_缴费单窗口缴费(STR_机构编码         IN VARCHAR2,
                                            STR_病人ID           IN VARCHAR2,
                                            STR_门诊病历号       IN VARCHAR2,
                                            STR_原发票序号       IN VARCHAR2,
                                            STR_门诊收费预算结果 IN VARCHAR2,
                                            STR_退费明细流水码   IN VARCHAR2) IS
  STR_平台标识           VARCHAR2(10) := 12320;
  STR_门诊收费预算结果串 VARCHAR2(500);
  DEC_实收总额           NUMERIC(18, 3) := 0;
  STR_发票序号           VARCHAR2(50);
  STR_退费类型           VARCHAR2(50);

  STR_订单号   VARCHAR2(50);
  INT_返回值   INTEGER;
  STR_返回信息 VARCHAR2(50);

BEGIN

  --全退为NULL   部分退及缴费不为NULL
  IF STR_门诊收费预算结果 IS NOT NULL THEN
    STR_门诊收费预算结果串 := SUBSTR(STR_门诊收费预算结果,
                            INSTR(STR_门诊收费预算结果, '##') + 2);
    IF STR_门诊收费预算结果串 IS NOT NULL THEN
      DEC_实收总额 := FU_通用_截取字符串值(STR_门诊收费预算结果串, '~', 9);
      STR_发票序号 := FU_通用_截取字符串值(STR_门诊收费预算结果串, '~', 10);
      STR_退费类型 := '部分退';
    ELSE
      STR_退费类型 := '全退';
    END IF;
  ELSE
    STR_退费类型 := '全退';
  END IF;

  BEGIN
    --缴费
    IF STR_原发票序号 = 0 THEN
      UPDATE 互联互通_订单 T
         SET T.订单状态         = '已支付',
             T.实付金额         = DEC_实收总额,
             T.医疗统筹支付金额 = 0,
             T.医院支付号       = STR_发票序号,
             T.支付时间         = SYSDATE,
             T.支付渠道         = '6', --窗口支付
             T.更新人           = STR_平台标识,
             T.更新时间         = SYSDATE
       WHERE T.平台标识 = STR_平台标识
         AND T.医院编码 = STR_机构编码
         AND T.病人ID = STR_病人ID
         AND T.就诊病历号 = STR_门诊病历号
         AND T.订单类型 = '门诊缴费'
         AND T.订单状态 = '待支付';
    ELSE
      --退费
      IF STR_退费类型 = '全退' THEN
        --全退
        UPDATE 互联互通_订单 T
           SET T.订单状态   = '已退款',
               T.退款时间   = SYSDATE,
               T.医院退款号 = STR_原发票序号 || '-1',
               T.退款金额   = T.实付金额,
               T.退款标志   = '2', --院内退款
               T.更新人     = STR_平台标识,
               T.更新时间   = SYSDATE
         WHERE T.平台标识 = STR_平台标识
           AND T.医院编码 = STR_机构编码
           AND T.病人ID = STR_病人ID
           AND T.就诊病历号 = STR_门诊病历号
           AND T.医院支付号 = STR_原发票序号
           AND T.订单类型 = '门诊缴费'
           AND T.订单状态 = '已支付';
      ELSE
        --部分退
      
        -- 1)生成订单号
        PR_获取_系统唯一号(PRM_唯一号编码 => '6002',
                    PRM_机构编码   => STR_机构编码,
                    PRM_事物类型   => '1',
                    PRM_返回唯一号 => STR_订单号,
                    PRM_执行结果   => INT_返回值,
                    PRM_错误信息   => STR_返回信息);
        IF INT_返回值 <> 0 THEN
          RETURN;
        END IF;
      
       
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
          SELECT SEQ_互联互通_订单明细_流水码.NEXTVAL,
                 STR_订单号,
                 T.计价ID,
                 T.大类编码,
                 T.小类编码,
                 T.项目编码,
                 T.项目名称,
                 T.规格,
                 T.批次号,
                 T.数量,
                 T.单位名称,
                 T.单价,
                 T.总金额,
                 T.归类编码
            FROM 门诊管理_门诊处方 T
           WHERE  T.机构编码 = STR_机构编码
             AND T.病人ID = STR_病人ID
             AND T.门诊病历号 = STR_门诊病历号
             AND T.发票序号 = STR_发票序号;
      
        INT_返回值 := SQL%ROWCOUNT;
        IF INT_返回值 = 0 THEN
          ROLLBACK;
          RETURN;
        END IF;
      
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
           医院支付号,
           支付时间,
           支付渠道,
           总金额,
           应付金额,
           实付金额,
           医疗统筹支付金额,
           订单状态,
           创建人,
           创建时间,
           更新人,
           更新时间)
          SELECT SEQ_互联互通_订单_流水码.NEXTVAL,
                 T.平台标识,
                 T.医院编码,
                 T.病人ID,
                 T.就诊病历号,
                 T.关联编码,
                 T.订单类型,
                 T.订单时间,
                 STR_订单号,
                 STR_发票序号,
                 SYSDATE,
                 T.支付渠道,
                 DEC_实收总额,
                 DEC_实收总额,
                 DEC_实收总额,
                 0,
                 '已支付',
                 STR_平台标识,
                 SYSDATE,
                 STR_平台标识,
                 SYSDATE
            FROM 互联互通_订单 T
           WHERE T.平台标识 = STR_平台标识
             AND T.医院编码 = STR_机构编码
             AND T.病人ID = STR_病人ID
             AND T.就诊病历号 = STR_门诊病历号
             AND T.医院支付号 = STR_原发票序号
             AND T.订单类型 = '门诊缴费'
             AND T.订单状态 = '已支付';
      
        INT_返回值 := SQL%ROWCOUNT;
        IF INT_返回值 = 0 THEN
          ROLLBACK;
          RETURN;
        END IF;
      
        UPDATE 互联互通_订单 T
           SET T.订单状态   = '已退款',
               T.退款时间   = SYSDATE,
               T.医院退款号 = STR_发票序号 || '-1',
               T.退款金额   = T.实付金额,
               T.退款标志   = '2', --院内退款
               T.更新人     = STR_平台标识,
               T.更新时间   = SYSDATE
         WHERE T.平台标识 = STR_平台标识
           AND T.医院编码 = STR_机构编码
           AND T.病人ID = STR_病人ID
           AND T.就诊病历号 = STR_门诊病历号
           AND T.医院支付号 = STR_原发票序号
           AND T.订单类型 = '门诊缴费'
           AND T.订单状态 = '已支付';
      
      END IF;
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RETURN;
    
  END;
  COMMIT;

  RETURN;
END PR_互联互通_缴费单窗口缴费;
/
