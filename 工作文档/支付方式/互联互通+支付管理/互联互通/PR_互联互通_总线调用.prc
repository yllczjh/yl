CREATE OR REPLACE PROCEDURE PR_互联互通_总线调用(STR_功能号   IN VARCHAR2,
                                         STR_请求参数 IN VARCHAR2,
                                         LOB_响应参数 OUT CLOB,
                                         RES_CODE     OUT VARCHAR2,
                                         RES_MSG      OUT VARCHAR2) IS
  STR_平台标识     VARCHAR2(10) := '12320';
  STR_状态         VARCHAR2(50);
  STR_是否启动排班 VARCHAR2(50);
BEGIN

  BEGIN
    SELECT 状态
      INTO STR_状态
      FROM 互联互通_平台功能配置
     WHERE 平台标识 = STR_平台标识
       AND 功能编码 = STR_功能号;
  EXCEPTION
    WHEN OTHERS THEN
      STR_状态 := '0';
  END;
  IF STR_状态 = '0' THEN
    RES_CODE := '-1';
    RES_MSG  := '该功能暂未开启';
    RETURN;
  END IF;

  --门诊是否启用排班管理
  BEGIN
    SELECT 值
      INTO STR_是否启动排班
      FROM 基础项目_机构参数列表
     WHERE 参数编码＝ '910536'
       AND 机构编码 = '522633020000001';
  EXCEPTION
    WHEN OTHERS THEN
      STR_是否启动排班 := '否';
  END;
  
   IF STR_是否启动排班 = '否' THEN
    RES_CODE := '-1';
    RES_MSG  := '该功能暂未开启';
    RETURN;
  END IF;

  BEGIN
    IF STR_功能号 = '1001' THEN
      LOB_响应参数 := FU_互联互通_得到响应参数('SELECT TO_CHAR(SYSDATE,''yyyy-MM-dd hh24:mi:ss'') AS "SYSDATE" FROM DUAL',
                                 'RES',
                                 '');
      RES_CODE     := '0';
      RES_MSG      := '交易成功';
    ELSIF STR_功能号 = '1002' THEN
      PR_互联互通_用户信息注册(STR_请求参数 => STR_请求参数,
                     STR_平台标识 => STR_平台标识,
                     STR_功能编码 => STR_功能号,
                     LOB_响应参数 => LOB_响应参数,
                     INT_返回值   => RES_CODE,
                     STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '1003' THEN
      PR_互联互通_用户信息查询(STR_请求参数 => STR_请求参数,
                     STR_平台标识 => STR_平台标识,
                     STR_功能编码 => STR_功能号,
                     LOB_响应参数 => LOB_响应参数,
                     INT_返回值   => RES_CODE,
                     STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '1004' THEN
      PR_互联互通_医院信息查询(STR_请求参数 => STR_请求参数,
                     STR_平台标识 => STR_平台标识,
                     STR_功能编码 => STR_功能号,
                     LOB_响应参数 => LOB_响应参数,
                     INT_返回值   => RES_CODE,
                     STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '1005' THEN
      RES_CODE := 200502;
      RES_MSG  := '用户卡信息不匹配';
    ELSIF STR_功能号 = '2001' THEN
      PR_互联互通_科室查询(STR_请求参数 => STR_请求参数,
                   STR_平台标识 => STR_平台标识,
                   STR_功能编码 => STR_功能号,
                   LOB_响应参数 => LOB_响应参数,
                   INT_返回值   => RES_CODE,
                   STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '2002' THEN
      PR_互联互通_医生查询(STR_请求参数 => STR_请求参数,
                   STR_平台标识 => STR_平台标识,
                   STR_功能编码 => STR_功能号,
                   LOB_响应参数 => LOB_响应参数,
                   INT_返回值   => RES_CODE,
                   STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '2003' THEN
      PR_互联互通_排班信息查询(STR_请求参数 => STR_请求参数,
                     STR_平台标识 => STR_平台标识,
                     STR_功能编码 => STR_功能号,
                     LOB_响应参数 => LOB_响应参数,
                     INT_返回值   => RES_CODE,
                     STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '2004' THEN
      PR_互联互通_排班分时查询(STR_请求参数 => STR_请求参数,
                     STR_平台标识 => STR_平台标识,
                     STR_功能编码 => STR_功能号,
                     LOB_响应参数 => LOB_响应参数,
                     INT_返回值   => RES_CODE,
                     STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '2005' THEN
      PR_互联互通_号源锁定(STR_请求参数 => STR_请求参数,
                   STR_平台标识 => STR_平台标识,
                   STR_功能编码 => STR_功能号,
                   LOB_响应参数 => LOB_响应参数,
                   INT_返回值   => RES_CODE,
                   STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '2006' THEN
      PR_互联互通_号源解锁(STR_请求参数 => STR_请求参数,
                   STR_平台标识 => STR_平台标识,
                   STR_功能编码 => STR_功能号,
                   LOB_响应参数 => LOB_响应参数,
                   INT_返回值   => RES_CODE,
                   STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '2007' THEN
      PR_互联互通_预约挂号登记(STR_请求参数 => STR_请求参数,
                     STR_平台标识 => STR_平台标识,
                     STR_功能编码 => STR_功能号,
                     LOB_响应参数 => LOB_响应参数,
                     INT_返回值   => RES_CODE,
                     STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '2008' THEN
      PR_互联互通_预约挂号支付(STR_请求参数 => STR_请求参数,
                     STR_平台标识 => STR_平台标识,
                     STR_功能编码 => STR_功能号,
                     LOB_响应参数 => LOB_响应参数,
                     INT_返回值   => RES_CODE,
                     STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '2009' THEN
      PR_互联互通_预约挂号取消(STR_请求参数 => STR_请求参数,
                     STR_平台标识 => STR_平台标识,
                     STR_功能编码 => STR_功能号,
                     LOB_响应参数 => LOB_响应参数,
                     INT_返回值   => RES_CODE,
                     STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '2010' THEN
      PR_互联互通_预约挂号退款(STR_请求参数 => STR_请求参数,
                     STR_平台标识 => STR_平台标识,
                     STR_功能编码 => STR_功能号,
                     LOB_响应参数 => LOB_响应参数,
                     INT_返回值   => RES_CODE,
                     STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '2011' THEN
      PR_互联互通_预约挂号取号(STR_请求参数 => STR_请求参数,
                     STR_平台标识 => STR_平台标识,
                     STR_功能编码 => STR_功能号,
                     STR_调用标识 => '0',
                     LOB_响应参数 => LOB_响应参数,
                     INT_返回值   => RES_CODE,
                     STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '2012' THEN
      PR_互联互通_预约挂号记录查询(STR_请求参数 => STR_请求参数,
                       STR_平台标识 => STR_平台标识,
                       STR_功能编码 => STR_功能号,
                       LOB_响应参数 => LOB_响应参数,
                       INT_返回值   => RES_CODE,
                       STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '2020' THEN
      PR_互联互通_医生门诊数据查询(STR_请求参数 => STR_请求参数,
                       STR_平台标识 => STR_平台标识,
                       STR_功能编码 => STR_功能号,
                       LOB_响应参数 => LOB_响应参数,
                       INT_返回值   => RES_CODE,
                       STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '3001' THEN
      PR_互联互通_缴费记录查询(STR_请求参数 => STR_请求参数,
                     STR_平台标识 => STR_平台标识,
                     STR_功能编码 => STR_功能号,
                     LOB_响应参数 => LOB_响应参数,
                     INT_返回值   => RES_CODE,
                     STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '3002' THEN
      PR_互联互通_缴费明细查询(STR_请求参数 => STR_请求参数,
                     STR_平台标识 => STR_平台标识,
                     STR_功能编码 => STR_功能号,
                     LOB_响应参数 => LOB_响应参数,
                     INT_返回值   => RES_CODE,
                     STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '3003' THEN
      PR_互联互通_缴费单支付(STR_请求参数 => STR_请求参数,
                    STR_平台标识 => STR_平台标识,
                    STR_功能编码 => STR_功能号,
                    LOB_响应参数 => LOB_响应参数,
                    INT_返回值   => RES_CODE,
                    STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '3004' THEN
      PR_互联互通_缴费订单查询(STR_请求参数 => STR_请求参数,
                     STR_平台标识 => STR_平台标识,
                     STR_功能编码 => STR_功能号,
                     LOB_响应参数 => LOB_响应参数,
                     INT_返回值   => RES_CODE,
                     STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '4001' THEN
      RES_CODE := 400101;
      RES_MSG  := '排队记录不存在，未查询到排队记录';
    ELSIF STR_功能号 = '8001' THEN
      PR_互联互通_检查检验列表查询(STR_请求参数 => STR_请求参数,
                       STR_平台标识 => STR_平台标识,
                       STR_功能编码 => STR_功能号,
                       LOB_响应参数 => LOB_响应参数,
                       INT_返回值   => RES_CODE,
                       STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '8002' THEN
      PR_互联互通_检验报告查询(STR_请求参数 => STR_请求参数,
                     STR_平台标识 => STR_平台标识,
                     STR_功能编码 => STR_功能号,
                     LOB_响应参数 => LOB_响应参数,
                     INT_返回值   => RES_CODE,
                     STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '8003' THEN
      PR_互联互通_检验报告查询(STR_请求参数 => STR_请求参数,
                     STR_平台标识 => STR_平台标识,
                     STR_功能编码 => STR_功能号,
                     LOB_响应参数 => LOB_响应参数,
                     INT_返回值   => RES_CODE,
                     STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '8004' THEN
      PR_互联互通_检查报告查询(STR_请求参数 => STR_请求参数,
                     STR_平台标识 => STR_平台标识,
                     STR_功能编码 => STR_功能号,
                     LOB_响应参数 => LOB_响应参数,
                     INT_返回值   => RES_CODE,
                     STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '9003' THEN
      PR_互联互通_系统订单查询(STR_请求参数 => STR_请求参数,
                     STR_平台标识 => STR_平台标识,
                     STR_功能编码 => STR_功能号,
                     LOB_响应参数 => LOB_响应参数,
                     INT_返回值   => RES_CODE,
                     STR_返回信息 => RES_MSG);
    
    ELSIF STR_功能号 = '5004' THEN
      PR_互联互通_预约挂号取号(STR_请求参数 => STR_请求参数,
                     STR_平台标识 => STR_平台标识,
                     STR_功能编码 => STR_功能号,
                     STR_调用标识 => '1',
                     LOB_响应参数 => LOB_响应参数,
                     INT_返回值   => RES_CODE,
                     STR_返回信息 => RES_MSG);
    ELSE
      RES_CODE := '-1';
      RES_MSG  := '功能号错误';
    END IF;
    RETURN;
  END;

END PR_互联互通_总线调用;
/
