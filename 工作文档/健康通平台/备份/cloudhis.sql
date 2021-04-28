prompt PL/SQL Developer Export User Objects for user CLOUDHIS@47.104.4.221:9900/YKEY
prompt Created by syyyhl on 2020-06-12
set define off
spool cloudhis.log

prompt
prompt Creating table 互联互通_操作日志
prompt ========================
prompt
create table CLOUDHIS.互联互通_操作日志
(
  流水码  VARCHAR2(50) not null,
  平台标识 VARCHAR2(50),
  医院编码 VARCHAR2(50),
  功能编码 VARCHAR2(50),
  请求参数 VARCHAR2(4000),
  请求时间 DATE,
  返回值  NUMBER,
  返回信息 VARCHAR2(50),
  执行时间 DATE
)
tablespace CLOUDHIS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column CLOUDHIS.互联互通_操作日志.流水码
  is '流水码';
comment on column CLOUDHIS.互联互通_操作日志.平台标识
  is '平台标识';
comment on column CLOUDHIS.互联互通_操作日志.医院编码
  is '医院编码';
comment on column CLOUDHIS.互联互通_操作日志.功能编码
  is '功能编码';
comment on column CLOUDHIS.互联互通_操作日志.请求参数
  is '请求参数';
comment on column CLOUDHIS.互联互通_操作日志.请求时间
  is '请求时间';
comment on column CLOUDHIS.互联互通_操作日志.返回值
  is '返回值';
comment on column CLOUDHIS.互联互通_操作日志.返回信息
  is '返回信息';
comment on column CLOUDHIS.互联互通_操作日志.执行时间
  is '执行时间';
alter table CLOUDHIS.互联互通_操作日志
  add constraint PK_互联互通_操作日志 primary key (流水码)
  using index 
  tablespace CLOUDHIS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table 互联互通_订单
prompt ======================
prompt
create table CLOUDHIS.互联互通_订单
(
  流水码     NUMBER not null,
  平台标识    VARCHAR2(50),
  医院编码    VARCHAR2(50),
  病人id    VARCHAR2(50),
  就诊病历号   VARCHAR2(50),
  关联编码    VARCHAR2(50),
  订单状态    VARCHAR2(50),
  医院订单号   VARCHAR2(50),
  平台订单号   VARCHAR2(50),
  平台订单时间  DATE,
  挂号费用    NUMBER(10,4),
  诊疗费用    NUMBER(10,4),
  挂号类型    VARCHAR2(50),
  挂号渠道    VARCHAR2(50),
  预约挂号类型  VARCHAR2(50),
  医院支付号   VARCHAR2(50),
  平台支付号   VARCHAR2(50),
  平台交易流水号 VARCHAR2(50),
  平台交易时间  DATE,
  支付渠道    VARCHAR2(50),
  总金额     NUMBER(10,4),
  应付金额    NUMBER(10,4),
  实付金额    NUMBER(10,4),
  医院退款号   VARCHAR2(50),
  平台退款号   VARCHAR2(50),
  平台退款流水号 VARCHAR2(50),
  平台退款时间  DATE,
  退款金额    NUMBER(10,4),
  退款原因    VARCHAR2(100),
  退款标志    VARCHAR2(50),
  订单类型    VARCHAR2(50),
  过期时间    DATE,
  取消时间    DATE,
  取消原因    VARCHAR2(1000),
  创建人     VARCHAR2(50),
  创建时间    DATE,
  更新人     VARCHAR2(50),
  更新时间    DATE,
  排序号     INTEGER,
  备注      VARCHAR2(4000),
  状态      VARCHAR2(50)
)
tablespace CLOUDHIS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLOUDHIS.互联互通_订单
  is '互联互通_订单';
comment on column CLOUDHIS.互联互通_订单.流水码
  is '流水码';
comment on column CLOUDHIS.互联互通_订单.平台标识
  is '平台标识';
comment on column CLOUDHIS.互联互通_订单.医院编码
  is '医院编码';
comment on column CLOUDHIS.互联互通_订单.病人id
  is '病人ID';
comment on column CLOUDHIS.互联互通_订单.就诊病历号
  is '就诊病历号';
comment on column CLOUDHIS.互联互通_订单.关联编码
  is '预约挂号表的主键值';
comment on column CLOUDHIS.互联互通_订单.订单状态
  is '待支付；已支付；已退款；已取消；已删除；';
comment on column CLOUDHIS.互联互通_订单.医院订单号
  is '医院订单号';
comment on column CLOUDHIS.互联互通_订单.平台订单号
  is '平台订单号';
comment on column CLOUDHIS.互联互通_订单.平台订单时间
  is '平台订单时间';
comment on column CLOUDHIS.互联互通_订单.挂号费用
  is '挂号费用';
comment on column CLOUDHIS.互联互通_订单.诊疗费用
  is '诊疗费用';
comment on column CLOUDHIS.互联互通_订单.挂号类型
  is '1本人；2子女；3他人';
comment on column CLOUDHIS.互联互通_订单.挂号渠道
  is '挂号渠道';
comment on column CLOUDHIS.互联互通_订单.预约挂号类型
  is '1当天挂号；2预约挂号；3锁号挂号';
comment on column CLOUDHIS.互联互通_订单.医院支付号
  is '医院支付号';
comment on column CLOUDHIS.互联互通_订单.平台支付号
  is '平台支付号';
comment on column CLOUDHIS.互联互通_订单.平台交易流水号
  is '平台交易流水号';
comment on column CLOUDHIS.互联互通_订单.平台交易时间
  is '平台交易时间';
comment on column CLOUDHIS.互联互通_订单.支付渠道
  is '支付渠道';
comment on column CLOUDHIS.互联互通_订单.总金额
  is '总金额';
comment on column CLOUDHIS.互联互通_订单.应付金额
  is '应付金额';
comment on column CLOUDHIS.互联互通_订单.实付金额
  is '实付金额';
comment on column CLOUDHIS.互联互通_订单.医院退款号
  is '医院退款号';
comment on column CLOUDHIS.互联互通_订单.平台退款号
  is '平台退款号';
comment on column CLOUDHIS.互联互通_订单.平台退款流水号
  is '平台退款流水号';
comment on column CLOUDHIS.互联互通_订单.平台退款时间
  is '平台退款时间';
comment on column CLOUDHIS.互联互通_订单.退款金额
  is '退款金额';
comment on column CLOUDHIS.互联互通_订单.退款原因
  is '退款原因';
comment on column CLOUDHIS.互联互通_订单.退款标志
  is '0失败，1我方退款，2院内退款';
comment on column CLOUDHIS.互联互通_订单.订单类型
  is '预约挂号；预约退号；门诊收费；预缴押金；出院结算';
comment on column CLOUDHIS.互联互通_订单.过期时间
  is '过期时间';
comment on column CLOUDHIS.互联互通_订单.取消时间
  is '取消时间';
comment on column CLOUDHIS.互联互通_订单.取消原因
  is '取消原因';
comment on column CLOUDHIS.互联互通_订单.创建人
  is '创建人';
comment on column CLOUDHIS.互联互通_订单.创建时间
  is '创建时间';
comment on column CLOUDHIS.互联互通_订单.更新人
  is '更新人';
comment on column CLOUDHIS.互联互通_订单.更新时间
  is '更新时间';
comment on column CLOUDHIS.互联互通_订单.排序号
  is '排序号';
comment on column CLOUDHIS.互联互通_订单.备注
  is '备注';
comment on column CLOUDHIS.互联互通_订单.状态
  is '状态';
alter table CLOUDHIS.互联互通_订单
  add constraint PK_互联互通_订单 primary key (流水码)
  using index 
  tablespace CLOUDHIS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table 互联互通_订单明细
prompt ========================
prompt
create table CLOUDHIS.互联互通_订单明细
(
  流水码  NUMBER not null,
  大类编码 VARCHAR2(50),
  小类编码 VARCHAR2(50),
  项目编码 VARCHAR2(50),
  项目名称 VARCHAR2(100),
  规格   VARCHAR2(100),
  批次号  VARCHAR2(50),
  数量   NUMBER(10,4),
  单位   VARCHAR2(50),
  单价   NUMBER(10,4),
  总金额  NUMBER(10,4),
  归类编码 VARCHAR2(50),
  唯一编码 VARCHAR2(50),
  订单号  VARCHAR2(50)
)
tablespace CLOUDHIS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column CLOUDHIS.互联互通_订单明细.流水码
  is '流水码';
comment on column CLOUDHIS.互联互通_订单明细.大类编码
  is '大类编码';
comment on column CLOUDHIS.互联互通_订单明细.小类编码
  is '小类编码';
comment on column CLOUDHIS.互联互通_订单明细.项目编码
  is '项目编码';
comment on column CLOUDHIS.互联互通_订单明细.项目名称
  is '项目名称';
comment on column CLOUDHIS.互联互通_订单明细.规格
  is '规格';
comment on column CLOUDHIS.互联互通_订单明细.批次号
  is '批次号';
comment on column CLOUDHIS.互联互通_订单明细.数量
  is '数量';
comment on column CLOUDHIS.互联互通_订单明细.单位
  is '单位';
comment on column CLOUDHIS.互联互通_订单明细.单价
  is '单价';
comment on column CLOUDHIS.互联互通_订单明细.总金额
  is '总金额';
comment on column CLOUDHIS.互联互通_订单明细.归类编码
  is '归类编码';
comment on column CLOUDHIS.互联互通_订单明细.唯一编码
  is '唯一编码';
comment on column CLOUDHIS.互联互通_订单明细.订单号
  is '订单号';
alter table CLOUDHIS.互联互通_订单明细
  add constraint PK_互联互通_订单明细 primary key (流水码)
  using index 
  tablespace CLOUDHIS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table 互联互通_用户信息
prompt ========================
prompt
create table CLOUDHIS.互联互通_用户信息
(
  流水码     VARCHAR2(50) not null,
  医院编码    VARCHAR2(50),
  平台标识    VARCHAR2(50),
  病人id    VARCHAR2(50),
  用户类别    VARCHAR2(50),
  姓名      VARCHAR2(50),
  性别      VARCHAR2(50),
  出生日期    DATE,
  证件类型    VARCHAR2(50),
  证件号码    VARCHAR2(50),
  证件发证日期  VARCHAR2(50),
  证件有效日期  VARCHAR2(50),
  手机号码    VARCHAR2(50),
  联系地址    VARCHAR2(100),
  监护人证件类型 VARCHAR2(50),
  监护人证件号码 VARCHAR2(50),
  监护人姓名   VARCHAR2(50),
  用户卡类型   VARCHAR2(50),
  用户卡号    VARCHAR2(50),
  创建人     VARCHAR2(50),
  创建时间    DATE
)
tablespace CLOUDHIS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column CLOUDHIS.互联互通_用户信息.流水码
  is '流水码';
comment on column CLOUDHIS.互联互通_用户信息.医院编码
  is '医院编码';
comment on column CLOUDHIS.互联互通_用户信息.平台标识
  is '平台标识';
comment on column CLOUDHIS.互联互通_用户信息.病人id
  is '病人ID';
comment on column CLOUDHIS.互联互通_用户信息.用户类别
  is '用户类别';
comment on column CLOUDHIS.互联互通_用户信息.姓名
  is '姓名';
comment on column CLOUDHIS.互联互通_用户信息.性别
  is '性别';
comment on column CLOUDHIS.互联互通_用户信息.出生日期
  is '出生日期';
comment on column CLOUDHIS.互联互通_用户信息.证件类型
  is '证件类型';
comment on column CLOUDHIS.互联互通_用户信息.证件号码
  is '证件号码';
comment on column CLOUDHIS.互联互通_用户信息.证件发证日期
  is '证件发证日期';
comment on column CLOUDHIS.互联互通_用户信息.证件有效日期
  is '证件有效日期';
comment on column CLOUDHIS.互联互通_用户信息.手机号码
  is '手机号码';
comment on column CLOUDHIS.互联互通_用户信息.联系地址
  is '联系地址';
comment on column CLOUDHIS.互联互通_用户信息.监护人证件类型
  is '监护人证件类型';
comment on column CLOUDHIS.互联互通_用户信息.监护人证件号码
  is '监护人证件号码';
comment on column CLOUDHIS.互联互通_用户信息.监护人姓名
  is '监护人姓名';
comment on column CLOUDHIS.互联互通_用户信息.用户卡类型
  is '用户卡类型';
comment on column CLOUDHIS.互联互通_用户信息.用户卡号
  is '用户卡号';
comment on column CLOUDHIS.互联互通_用户信息.创建人
  is '创建人';
comment on column CLOUDHIS.互联互通_用户信息.创建时间
  is '创建时间';
alter table CLOUDHIS.互联互通_用户信息
  add constraint PK_互联互通_用户信息 primary key (流水码)
  using index 
  tablespace CLOUDHIS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating sequence SEQ_互联互通_操作日志_流水码
prompt ===================================
prompt
create sequence CLOUDHIS.SEQ_互联互通_操作日志_流水码
minvalue 1
maxvalue 9999999999
start with 1
increment by 1
cache 10;

prompt
prompt Creating sequence SEQ_互联互通_订单_流水码
prompt =================================
prompt
create sequence CLOUDHIS.SEQ_互联互通_订单_流水码
minvalue 1
maxvalue 9999999999
start with 11
increment by 1
cache 10;

prompt
prompt Creating sequence SEQ_互联互通_订单明细_流水码
prompt ===================================
prompt
create sequence CLOUDHIS.SEQ_互联互通_订单明细_流水码
minvalue 1
maxvalue 9999999999
start with 11
increment by 1
cache 10;

prompt
prompt Creating sequence SEQ_互联互通_用户信息_流水码
prompt ===================================
prompt
create sequence CLOUDHIS.SEQ_互联互通_用户信息_流水码
minvalue 1
maxvalue 9999999999
start with 21
increment by 1
cache 10;

prompt
prompt Creating function FU_互联互通_得到响应参数
prompt ================================
prompt
CREATE OR REPLACE FUNCTION CLOUDHIS.FU_互联互通_得到响应参数(STR_SQL    VARCHAR2,
                                          STR_根标签 VARCHAR2,
                                          STR_行标签 VARCHAR2) RETURN CLOB IS
  LOB_响应参数 CLOB;
  XML_结果集   DBMS_XMLGEN.CTXTYPE;
BEGIN

  XML_结果集 := DBMS_XMLGEN.NEWCONTEXT(STR_SQL);

  DBMS_XMLGEN.SETROWSETTAG(XML_结果集, STR_根标签); --重置行集标签ROWSET

  DBMS_XMLGEN.SETROWTAG(XML_结果集, STR_行标签); --=重置行标签ROW

  DBMS_XMLGEN.SETNULLHANDLING(XML_结果集, DBMS_XMLGEN.EMPTY_TAG); --处理空值

  LOB_响应参数 := DBMS_XMLGEN.GETXML(XML_结果集);

  LOB_响应参数 := SUBSTR(LOB_响应参数, INSTR(LOB_响应参数, '>')+1); --去掉<?XML VERSION="1.0">

  RETURN(LOB_响应参数);

END FU_互联互通_得到响应参数;
/

prompt
prompt Creating function FU_互联互通_节点值
prompt =============================
prompt
CREATE OR REPLACE FUNCTION CLOUDHIS.FU_互联互通_节点值(STR_传入串 VARCHAR2,
                                       STR_节点名 VARCHAR2) RETURN VARCHAR2 IS
  STR_节点值 VARCHAR2(100);
BEGIN
  BEGIN
    --FUNCTIONRESULT := XMLTYPE(STR_传入串).EXTRACT('/REQ/' || STR_节点名 ||'/text()').GETSTRINGVAL();
    SELECT EXTRACTVALUE(XMLTYPE(STR_传入串), '/REQ/' || STR_节点名)
      INTO STR_节点值
      FROM DUAL;
  
  EXCEPTION
    WHEN OTHERS THEN
      STR_节点值 := '';
  END;

  RETURN(STR_节点值);
END FU_互联互通_节点值;
/

prompt
prompt Creating function FU_互联互通_添加新节点
prompt ===============================
prompt
CREATE OR REPLACE FUNCTION CLOUDHIS.FU_互联互通_添加新节点(LOB_响应参数   CLOB,
                                         STR_添加位置   VARCHAR2,
                                         STR_添加节点名 VARCHAR2,
                                         STR_添加节点值 VARCHAR2) RETURN CLOB IS
  LOB_响应参数新 CLOB;
  STR_新加节点   VARCHAR2(100);
BEGIN

  --在 <STR_添加位置>节点前添加新的节点<STR_添加节点名>

  /*  SELECT INSERTCHILDXMLAFTER(XMLTYPE(LOB_响应参数), '/RES', STR_添加位置, XMLTYPE('<' || STR_添加节点名 || '>' || STR_添加节点值 || '</' || STR_添加节点名 || '>')).GETCLOBVAL()
  INTO LOB_响应参数新
  FROM DUAL;*/

  STR_新加节点   := '<' || STR_添加节点名 || '>' || STR_添加节点值 || '</' || STR_添加节点名 || '>';
  LOB_响应参数新 := SUBSTR(LOB_响应参数,
                      0,
                      INSTR(LOB_响应参数, '<' || STR_添加位置, 1, 1) - 1) ||
               STR_新加节点 ||
               SUBSTR(LOB_响应参数,
                      INSTR(LOB_响应参数, '<' || STR_添加位置, 1, 1));

  RETURN(LOB_响应参数新);
END FU_互联互通_添加新节点;
/

prompt
prompt Creating function FU_互联互通_验证日期
prompt ==============================
prompt
CREATE OR REPLACE FUNCTION CLOUDHIS.FU_互联互通_验证日期(p_date IN VARCHAR2) RETURN BOOLEAN IS
  v_flag       BOOLEAN;
  v_year       NUMBER;
  v_month      NUMBER;
  v_day        NUMBER;
  v_isLeapYear BOOLEAN;
BEGIN
  --[初始化]--
  v_flag := TRUE;

  --[获取信息]--
  v_year  := to_number(substr(p_date, 1, 4));
  v_month := to_number(substr(p_date, 5, 2));
  v_day   := to_number(substr(p_date, 7, 2));

  --[判断是否为闰年]--
  IF (MOD(v_year, 400) = 0)
     OR (MOD(v_year, 100) <> 0 AND MOD(v_year, 4) = 0) THEN
    v_isLeapYear := TRUE;
  ELSE
    v_isLeapYear := FALSE;
  END IF;

  --[判断月份]--
  IF v_month < 1
     OR v_month > 12 THEN
    v_flag := FALSE;
    RETURN v_flag;
  END IF;

  --[判断日期]--
  IF v_month IN (1, 3, 5, 7, 8, 10, 12)
     AND (v_day < 1 OR v_day > 31) THEN
    v_flag := FALSE;
  END IF;
  IF v_month IN (4, 6, 9, 11)
     AND (v_day < 1 OR v_day > 30) THEN
    v_flag := FALSE;
  END IF;
  IF v_month IN (2) THEN
    IF (v_isLeapYear) THEN
      --[闰年]--
      IF (v_day < 1 OR v_day > 29) THEN
        v_flag := FALSE;
      END IF;
    ELSE
      --[非闰年]--
      IF (v_day < 1 OR v_day > 28) THEN
        v_flag := FALSE;
      END IF;
    END IF;
  END IF;

  --[返回结果]--
  RETURN v_flag;
END FU_互联互通_验证日期;
/

prompt
prompt Creating function FU_互联互通_验证数值
prompt ==============================
prompt
CREATE OR REPLACE FUNCTION CLOUDHIS.FU_互联互通_验证数值(p_string IN VARCHAR2)
  RETURN BOOLEAN
    Is
        i           number;
        k           number;
        flag        boolean;
        v_length    number;
    Begin
        /*
        算法:
            通过ASCII码判断是否数字，介于[48, 57]之间。
            select ascii('0'),ascii('1'),ascii('2'),ascii('3'),ascii('4'),ascii('5'),ascii('6'),ascii('7'),ascii('8'),ascii('9') from dual;
        */

        flag := True;
    SELECT length(p_string) INTO v_length FROM dual;

    FOR i IN 1 .. v_length
    LOOP
      k := ascii(substr(p_string, i, 1));
      IF k < 48
         OR k > 57 THEN
        flag := FALSE;
        EXIT;
      END IF;
    END LOOP;

    RETURN flag;
    END FU_互联互通_验证数值;
/

prompt
prompt Creating function FU_互联互通_验证身份证
prompt ===============================
prompt
CREATE OR REPLACE FUNCTION CLOUDHIS.FU_互联互通_验证身份证(P_IDCARD IN VARCHAR2)
  RETURN INTEGER IS
  V_SUM         NUMBER;
  V_MOD         NUMBER;
  V_LENGTH      NUMBER;
  V_DATE        VARCHAR2(10);
  V_ISDATE      BOOLEAN;
  V_ISNUMBER    BOOLEAN;
  V_ISNUMBER_17 BOOLEAN;
  V_CHECKBIT    CHAR(1);
  V_CHECKCODE   CHAR(11) := '10X98765432';
  V_AREACODE    VARCHAR2(2000) := '11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91,';
BEGIN
  /*
  返回值说明:
      -1      身份证号码位数不对
      -2      身份证号码出生日期超出范围
      -3      身份证号码含有非法字符
      -4      身份证号码校验码错误
      -5      身份证号码地区码非法
      0       身份证号码通过校验
  */
  --[长度校验]--
  IF P_IDCARD IS NULL THEN
    RETURN(-1);
  END IF;

  SELECT LENGTHB(P_IDCARD) INTO V_LENGTH FROM DUAL;
  IF V_LENGTH NOT IN (15, 18) THEN
    RETURN(-1);
  END IF;

  --[区位码校验]--
  IF INSTRB(V_AREACODE, SUBSTR(P_IDCARD, 1, 2) || ',') = 0 THEN
    RETURN(-5);
  END IF;

  --[格式化校验]--
  IF V_LENGTH = 15 THEN
    V_ISNUMBER := FU_互联互通_验证数值(P_IDCARD);
    IF NOT (V_ISNUMBER) THEN
      RETURN(-3);
    END IF;
  ELSIF V_LENGTH = 18 THEN
    V_ISNUMBER    := FU_互联互通_验证数值(P_IDCARD);
    V_ISNUMBER_17 := FU_互联互通_验证数值(SUBSTR(P_IDCARD, 1, 17));
    IF NOT ((V_ISNUMBER) OR
        (V_ISNUMBER_17 AND UPPER(SUBSTR(P_IDCARD, 18, 1)) = 'X')) THEN
      RETURN(-3);
    END IF;
  END IF;

  --[出生日期校验]--
  IF V_LENGTH = 15 THEN
    SELECT '19' || SUBSTR(P_IDCARD, 7, 6) INTO V_DATE FROM DUAL;
  ELSIF V_LENGTH = 18 THEN
    SELECT SUBSTR(P_IDCARD, 7, 8) INTO V_DATE FROM DUAL;
  END IF;
  V_ISDATE := FU_互联互通_验证日期(V_DATE);
  IF NOT (V_ISDATE) THEN
    RETURN(-2);
  END IF;

  --[校验码校验]--
  IF V_LENGTH = 18 THEN
    V_SUM      := (TO_NUMBER(SUBSTRB(P_IDCARD, 1, 1)) +
                  TO_NUMBER(SUBSTRB(P_IDCARD, 11, 1))) * 7 +
                  (TO_NUMBER(SUBSTRB(P_IDCARD, 2, 1)) +
                  TO_NUMBER(SUBSTRB(P_IDCARD, 12, 1))) * 9 +
                  (TO_NUMBER(SUBSTRB(P_IDCARD, 3, 1)) +
                  TO_NUMBER(SUBSTRB(P_IDCARD, 13, 1))) * 10 +
                  (TO_NUMBER(SUBSTRB(P_IDCARD, 4, 1)) +
                  TO_NUMBER(SUBSTRB(P_IDCARD, 14, 1))) * 5 +
                  (TO_NUMBER(SUBSTRB(P_IDCARD, 5, 1)) +
                  TO_NUMBER(SUBSTRB(P_IDCARD, 15, 1))) * 8 +
                  (TO_NUMBER(SUBSTRB(P_IDCARD, 6, 1)) +
                  TO_NUMBER(SUBSTRB(P_IDCARD, 16, 1))) * 4 +
                  (TO_NUMBER(SUBSTRB(P_IDCARD, 7, 1)) +
                  TO_NUMBER(SUBSTRB(P_IDCARD, 17, 1))) * 2 +
                  TO_NUMBER(SUBSTRB(P_IDCARD, 8, 1)) * 1 +
                  TO_NUMBER(SUBSTRB(P_IDCARD, 9, 1)) * 6 +
                  TO_NUMBER(SUBSTRB(P_IDCARD, 10, 1)) * 3;
    V_MOD      := MOD(V_SUM, 11);
    V_CHECKBIT := SUBSTRB(V_CHECKCODE, V_MOD + 1, 1);

    IF V_CHECKBIT = UPPER(SUBSTRB(P_IDCARD, 18, 1)) THEN
      RETURN 0;
    ELSE
      RETURN(-4);
    END IF;
  ELSE
    RETURN 0;
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    RETURN(-1);
END FU_互联互通_验证身份证;
/

prompt
prompt Creating function FU_互联互通_验证手机号
prompt ===============================
prompt
CREATE OR REPLACE FUNCTION CLOUDHIS.FU_互联互通_验证手机号(STR_手机号码 VARCHAR2) RETURN INTEGER IS
  INT_返回值 INTEGER;
BEGIN
  /*
    有效条件：
      1)11位
      2)以1开头
      3)只能由数字构成
    返回值：
      -1，失败；0，成功
  */

  SELECT REGEXP_INSTR(STR_手机号码, '1\d{10}$')
    INTO INT_返回值
    FROM DUAL;
  IF INT_返回值 = 0 THEN
    RETURN - 1;
  END IF;

  RETURN 0;

END FU_互联互通_验证手机号;
/

prompt
prompt Creating procedure PR_互联互通_操作日志
prompt ===============================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_操作日志(Str_平台标识 IN VARCHAR2,
                                         Str_医院编码 IN VARCHAR2,
                                         Str_功能编码 IN VARCHAR2,
                                         Str_请求参数 IN VARCHAR2,
                                         Dat_请求时间 IN DATE,
                                         INT_返回值   IN INTEGER,
                                         Str_返回信息 IN VARCHAR2,
                                         Dat_执行时间 IN DATE) IS

  PRAGMA AUTONOMOUS_TRANSACTION; --自制事物不影响主事物
BEGIN

  BEGIN
    INSERT INTO 互联互通_操作日志
      (流水码,
       平台标识,
       医院编码,
       功能编码,
       请求参数,
       请求时间,
       返回值,
       返回信息,
       执行时间)
    VALUES
      (seq_平台接口_操作日志_流水码.nextval,
       Str_平台标识,
       Str_医院编码,
       Str_功能编码,
       Str_请求参数,
       Dat_请求时间,
       INT_返回值,
       Str_返回信息,
       Dat_执行时间);
  
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RETURN;
  END;

  COMMIT;

  RETURN;

END PR_互联互通_操作日志;
/

prompt
prompt Creating procedure PR_互联互通_待缴费记录支付
prompt ==================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_待缴费记录支付(STR_请求参数 IN VARCHAR2,
                                            LOB_响应参数 OUT CLOB,
                                            RES_CODE     OUT INTEGER,
                                            RES_MSG      OUT VARCHAR2) IS

  STR_SQL              VARCHAR2(1000);
  STR_医院ID           VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
  STR_平台订单号       VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'ORDER_ID');
  STR_缴费单唯一ID     VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'HOSP_SEQUENCE');
  STR_流水号           VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'SERIAL_NUM');
  STR_交易日期         VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'PAY_DATE');
  STR_交易时间         VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'PAY_TIME');
  STR_支付渠道ID       VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数,
                                               'PAY_CHANNEL_ID');
  STR_总金额           VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数,
                                                'PAY_TOTAL_FEE');
  STR_应付金额         VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数,
                                               'PAY_BEHOOVE_FEE');
  STR_个人自付金额     VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'PAY_ACTUAL_FEE');
  STR_医疗统筹支付金额 VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'PAY_MI_FEE');
  STR_交易响应代码     VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'PAY_RES_CODE');
  STR_交易响应描述     VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'PAY_RES_DESC');
  STR_商户号           VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'MERCHANT_ID');
  STR_终端号           VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'TERMINAL_ID');
  STR_银行卡号         VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'BANK_NO');
  STR_第三方支付帐号   VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'PAY_ACCOUNT');
  STR_操作员ID         VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'OPERATOR_ID');
  STR_收据号           VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'RECEIPT_ID');

BEGIN
  BEGIN
  
    IF DBMS_LOB.GETLENGTH(LOB_响应参数) > 0 THEN
    
      RES_CODE := 0;
      RES_MSG  := '交易成功';
    ELSE
      RES_CODE := 300201;
      RES_MSG  := '无效的缴费记录';
    END IF;
  
  END;

END PR_互联互通_待缴费记录支付;
/

prompt
prompt Creating procedure PR_互联互通_挂号记录查询
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_挂号记录查询(STR_请求参数 IN VARCHAR2,
                                           STR_平台标识 IN VARCHAR2,
                                           STR_功能编码 IN VARCHAR2,
                                           LOB_响应参数 OUT CLOB,
                                           INT_返回值   OUT INTEGER,
                                           STR_返回信息 OUT VARCHAR2) IS

  --【请求参数】
  STR_医院ID     VARCHAR2(50);
  STR_平台订单号 VARCHAR2(50);
  STR_医院订单号 VARCHAR2(50);
  STR_起始日期   VARCHAR2(50);
  STR_结束日期   VARCHAR2(50);
  STR_当前页数   VARCHAR2(50);
  STR_每页数量   VARCHAR2(50);

  STR_SQL VARCHAR2(2000);

BEGIN

  --【请求参数解析】
  STR_医院ID     := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
  STR_平台订单号 := FU_互联互通_节点值(STR_请求参数, 'ORDER_ID');
  STR_医院订单号 := FU_互联互通_节点值(STR_请求参数, 'HOSP_ORDER_ID');
  STR_起始日期   := FU_互联互通_节点值(STR_请求参数, 'BEGIN_DATE');
  STR_结束日期   := FU_互联互通_节点值(STR_请求参数, 'END_DATE');
  STR_当前页数   := FU_互联互通_节点值(STR_请求参数, 'PAGE_CURRENT');
  STR_每页数量   := FU_互联互通_节点值(STR_请求参数, 'PAGE_SIZE');
  BEGIN
  
    STR_SQL := 'SELECT T.平台订单号 AS ORDER_ID,
                   DECODE(T.订单状态,
                          ''待支付'',
                          ''2'',
                          ''已取号'',
                          ''3'',
                          ''已取消'',
                          ''4'',
                          ''已退款'',
                          ''5'',
                          ''已支付'',
                          ''6'',
                          ''1'') AS ORDER_STATUS,
                   '''' AS HOSP_SERIAL_NUM,
                   TT.取号时间 AS GET_REGNO_DATE,
                   T.医院交易号 AS HOSP_PAY_ID,
                   T.就诊病历号 AS HOSP_MEDICAL_NUM,
                   TO_CHAR(TT.预约时段开始, ''hh24:mi'') || ''-'' ||
                   TO_CHAR(TT.预约时段结束, ''hh24:mi'') AS ORDER_STATUS,
                   T.医院退款号 AS HOSP_REFUND_ID,
                   T.退款标志 AS REFUND_FLAG,
                   T.取消时间 AS CANCEL_DATE
              FROM 互联互通_订单 T, 门诊管理_预约挂号 TT
             WHERE T.医院编码 = TT.机构编码
               AND T.关联编码 = TT.主键ID
               AND (T.平台订单号=''' || STR_平台订单号 || ''' OR ''' ||
               STR_平台订单号 || ''' IS NULL)
               AND TT.预约时间 BETWEEN ' || 'TO_DATE(''' ||
               STR_起始日期 || ''', ''yyyy-MM-dd'')  AND 
                    TO_DATE(''' || STR_结束日期 ||
               ''', ''yyyy-MM-dd'')';
  
  
    LOB_响应参数 := FU_互联互通_得到响应参数(STR_SQL, 'RES', 'ORDER_LIST');
  
    IF DBMS_LOB.GETLENGTH(LOB_响应参数) > 0 THEN
    
      SELECT COUNT(1)
        INTO INT_返回值
        FROM 互联互通_订单 T, 门诊管理_预约挂号 TT
       WHERE T.医院编码 = TT.机构编码
         AND T.关联编码 = TT.主键ID
         AND (T.平台订单号 = STR_平台订单号 OR STR_平台订单号 IS NULL)
         AND TT.预约时间 BETWEEN TO_DATE(STR_起始日期, 'yyyy-MM-dd ') AND
             TO_DATE(STR_结束日期, 'yyyy-MM-dd');
    
      LOB_响应参数 := FU_互联互通_添加新节点(LOB_响应参数,
                                'ORDER_LIST',
                                'COUNT',
                                INT_返回值);
    
      INT_返回值   := 0;
      STR_返回信息 := '交易成功';
    ELSE
      INT_返回值   := 201201;
      STR_返回信息 := '未查询到挂号订单记录';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := 99;
      STR_返回信息 := '响应请求报错:' || SQLERRM;
      GOTO 退出;
  END;
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;

  -- 【保存日志】
  PR_互联互通_操作日志(STR_平台标识 => STR_平台标识,
               STR_医院编码 => STR_医院ID,
               STR_功能编码 => STR_功能编码,
               STR_请求参数 => STR_请求参数,
               DAT_请求时间 => SYSDATE,
               INT_返回值   => INT_返回值,
               STR_返回信息 => STR_返回信息,
               DAT_执行时间 => SYSDATE);
              
  RETURN;
END PR_互联互通_挂号记录查询;
/

prompt
prompt Creating procedure PR_互联互通_挂号支付
prompt ===============================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_挂号支付(STR_请求参数 IN VARCHAR2,
                                         STR_平台标识 IN VARCHAR2,
                                         STR_功能编码 IN VARCHAR2,
                                         LOB_响应参数 OUT CLOB,
                                         INT_返回值   OUT INTEGER,
                                         STR_返回信息 OUT VARCHAR2) IS

  --【请求参数】
  STR_医院ID         VARCHAR2(50);
  STR_平台订单号     VARCHAR2(50);
  STR_医院订单号     VARCHAR2(50);
  STR_流水号         VARCHAR2(50);
  STR_交易日期       VARCHAR2(50);
  STR_交易时间       VARCHAR2(50);
  STR_支付渠道ID     VARCHAR2(50);
  STR_总金额         VARCHAR2(50);
  STR_应付金额       VARCHAR2(50);
  STR_实付金额       VARCHAR2(50);
  STR_交易响应代码   VARCHAR2(50);
  STR_交易响应描述   VARCHAR2(50);
  STR_商户号         VARCHAR2(50);
  STR_终端号         VARCHAR2(50);
  STR_银行卡号       VARCHAR2(50);
  STR_第三方支付账号 VARCHAR2(50);

  --【业务参数】
  STR_SQL          VARCHAR2(1000);
  STR_预约单号     VARCHAR2(50);
  STR_订单状态     VARCHAR2(50);
  DAT_系统时间     DATE;
  STR_医院支付单号 VARCHAR2(50);
  NUM_挂号费用     NUMBER(10, 4);
  NUM_诊疗费用     NUMBER(10, 4);
  STR_班次标识 varchar2(50);

BEGIN
  BEGIN
    --【请求参数解析】
    STR_医院ID         := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
    STR_平台订单号     := FU_互联互通_节点值(STR_请求参数, 'ORDER_ID');
    STR_医院订单号     := FU_互联互通_节点值(STR_请求参数, 'HOSP_ORDER_ID');
    STR_流水号         := FU_互联互通_节点值(STR_请求参数, 'SERIAL_NUM');
    STR_交易日期       := FU_互联互通_节点值(STR_请求参数, 'PAY_DATE');
    STR_交易时间       := FU_互联互通_节点值(STR_请求参数, 'PAY_TIME');
    STR_支付渠道ID     := FU_互联互通_节点值(STR_请求参数, 'PAY_CHANNEL_ID');
    STR_总金额         := FU_互联互通_节点值(STR_请求参数, 'PAY_TOTAL_FEE');
    STR_应付金额       := FU_互联互通_节点值(STR_请求参数, 'PAY_COPE_FEE');
    STR_实付金额       := FU_互联互通_节点值(STR_请求参数, 'PAY_FEE');
    STR_交易响应代码   := FU_互联互通_节点值(STR_请求参数, 'PAY_RES_CODE');
    STR_交易响应描述   := FU_互联互通_节点值(STR_请求参数, 'PAY_RES_DESC');
    STR_商户号         := FU_互联互通_节点值(STR_请求参数, 'MERCHANT_ID');
    STR_终端号         := FU_互联互通_节点值(STR_请求参数, 'TERMINAL_ID');
    STR_银行卡号       := FU_互联互通_节点值(STR_请求参数, 'BANK_NO');
    STR_第三方支付账号 := FU_互联互通_节点值(STR_请求参数, 'PAY_ACCOUNT');
  
    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
  
    -- 【医院支付单号】
    SELECT SYS_GUID() INTO STR_医院支付单号 FROM DUAL;
  
    --【验证数据】
    IF STR_平台订单号 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '平台订单号不能为空！';
      GOTO 退出;
    END IF;
    IF STR_流水号 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '流水号不能为空！';
      GOTO 退出;
    END IF;
    IF STR_交易日期 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '交易日期不能为空！';
      GOTO 退出;
    END IF;
    IF STR_交易时间 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '交易时间不能为空！';
      GOTO 退出;
    END IF;
    IF STR_总金额 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '总金额不能为空！';
      GOTO 退出;
    END IF;
    IF STR_应付金额 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '应付金额不能为空！';
      GOTO 退出;
    END IF;
    IF STR_实付金额 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '实付金额不能为空！';
      GOTO 退出;
    END IF;
  
    --【验证订单状态】
    BEGIN
      SELECT 关联编码, 订单状态, 挂号费用, 诊疗费用
        INTO STR_预约单号, STR_订单状态, NUM_挂号费用, NUM_诊疗费用
        FROM 互联互通_订单
       WHERE 医院编码 = STR_医院ID
         AND 平台订单号 = STR_平台订单号
         AND (医院订单号 = STR_医院订单号 OR STR_医院订单号 IS NULL);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        INT_返回值   := 200801;
        STR_返回信息 := '挂号订单不存在';
        GOTO 退出;
      WHEN OTHERS THEN
        INT_返回值   := -1;
        STR_返回信息 := '系统异常：' || SQLERRM;
        GOTO 退出;
    END;
    IF NUM_挂号费用 + NUM_诊疗费用 <> to_NUMBER(STR_实付金额) THEN
      INT_返回值   := 200804;
      STR_返回信息 := '挂号金额不正确';
      GOTO 退出;
    END IF;
  
    IF STR_订单状态 = '已支付' THEN
      INT_返回值   := 200802;
      STR_返回信息 := '挂号订单已支付';
      GOTO 退出;
    ELSIF STR_订单状态 = '已取消' THEN
      INT_返回值   := 200805;
      STR_返回信息 := '挂号订单已取消';
      GOTO 退出;
    ELSIF STR_订单状态 = '已退款' THEN
      INT_返回值   := 200806;
      STR_返回信息 := '挂号订单已退款';
      GOTO 退出;
    END IF;
  
    -- 验证预约单
    SELECT COUNT(1)
      INTO INT_返回值
      FROM 门诊管理_预约挂号
     WHERE 机构编码 = STR_医院ID
       AND 主键ID = STR_预约单号
       AND 去向标志 = '占号'
       AND 超时时间 < SYSDATE;
  
    IF INT_返回值 > 0 THEN
      INT_返回值   := 200803;
      STR_返回信息 := '挂号订单已关闭';
      GOTO 退出;
    END IF;
  
   -- 获取日班次标识
    SELECT 日班次标识
      INTO STR_班次标识
      FROM 门诊管理_预约挂号
     WHERE 机构编码 = STR_医院ID
       AND 主键ID = STR_预约单号;

  
    -- 【功能处理】
    BEGIN
    
      -- 更新预约单
      UPDATE 门诊管理_预约挂号 G
         SET 支付标志 = '是', 去向标志 = '预约'
       WHERE 机构编码 = STR_医院ID
         AND 主键ID = STR_预约单号;
    
      INT_返回值 := SQL%ROWCOUNT;
      IF INT_返回值 = 0 THEN
        INT_返回值   := -1;
        STR_返回信息 := '更新预约单失败！';
        GOTO 退出;
      END IF;
      
       -- 锁号
      UPDATE 门诊管理_日排班时段表
         SET 已挂号数 = 已挂号数 + 1
       WHERE 机构编码 = STR_医院ID
         AND 日班次标识 = STR_班次标识;
    
      INT_返回值 := SQL%ROWCOUNT;
      IF INT_返回值 = 0 THEN
        INT_返回值   := 99;
        STR_返回信息 := '锁定号源失败！';
        GOTO 退出;
      END IF;
    
      -- 更新订单状态
      UPDATE 互联互通_订单
         SET 订单状态       = '已支付',
             总金额         = TO_NUMBER(STR_总金额),
             应付金额       = TO_NUMBER(STR_应付金额),
             实付金额       = TO_NUMBER(STR_实付金额),
             平台交易流水号 = STR_流水号,
             平台交易时间   = TO_DATE(STR_交易日期 || ' ' || STR_交易时间,
                                'yyyy-MM-dd hh24:mi:ss'),
             医院支付号     = STR_医院支付单号,
             支付渠道       = STR_支付渠道ID,
             平台退款号     = NULL,
             平台退款时间   = NULL,
             更新人         = STR_平台标识,
             更新时间       = DAT_系统时间
       WHERE 平台标识 = STR_平台标识
         AND 医院编码 = STR_医院ID
         AND 平台订单号 = STR_平台订单号
         AND 订单状态 = '待支付';
    
      INT_返回值 := SQL%ROWCOUNT;
      IF INT_返回值 = 0 THEN
        INT_返回值   := -1;
        STR_返回信息 := '更新订单失败！';
        GOTO 退出;
      END IF;
    
    END;
  
    STR_SQL      := 'select ''' || STR_医院支付单号 ||
                    ''' as HOSP_PAY_ID,
                            '''' as RECEIPT_ID,
                            '''' as HOSP_SERIAL_NUM,
                            '''' as HOSP_MEDICAL_NUM,
                            '''' as HOSP_GETREG_DATE,
                            '''' as HOSP_SEE_DOCT_ADDR,
                            '''' as HOSP_REMARK
                            from dual';
    LOB_响应参数 := FU_互联互通_得到响应参数(STR_SQL, 'RES', '');
  
    INT_返回值   := 0;
    STR_返回信息 := '交易成功';
  
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '响应请求报错：' || SQLERRM;
      GOTO 退出;
  END;

  COMMIT;
  RETURN;

  --【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;

  -- 【保存日志】
  PR_互联互通_操作日志(STR_平台标识 => STR_平台标识,
               STR_医院编码 => STR_医院ID,
               STR_功能编码 => STR_功能编码,
               STR_请求参数 => STR_请求参数,
               DAT_请求时间 => DAT_系统时间,
               INT_返回值   => INT_返回值,
               STR_返回信息 => STR_返回信息,
               DAT_执行时间 => SYSDATE);

  ROLLBACK;
  RETURN;

END PR_互联互通_挂号支付;
/

prompt
prompt Creating procedure PR_互联互通_号源锁定
prompt ===============================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_号源锁定(STR_请求参数 IN VARCHAR2,
                                         LOB_响应参数 OUT CLOB,
                                         RES_CODE     OUT INTEGER,
                                         RES_MSG      OUT VARCHAR2) IS

  STR_SQL          VARCHAR2(1000);
  STR_号源锁定ID   VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'LOCK_ID');
  STR_挂号渠道ID   VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'CHANNEL_ID');
  STR_排班ID       VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'REG_ID');
  STR_医院ID       VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
  STR_科室ID       VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'DEPT_ID');
  STR_医生ID       VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'DOCTOR_ID');
  STR_出诊日期     VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'REG_DATE');
  STR_时段         VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'TIME_FLAG');
  STR_分时开始时间 VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'BEGIN_TIME');
  STR_分时结束时间 VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'END_TIME');
  STR_挂号费用     VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'REG_FEE');
  STR_诊疗费用     VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'TREAT_FEE');
  STR_座席工号     VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'AGENT_ID');
BEGIN
  BEGIN
  
    IF DBMS_LOB.GETLENGTH(LOB_响应参数) > 0 THEN
    
      RES_CODE := 0;
      RES_MSG  := '交易成功';
    ELSE
      RES_CODE := 200101;
      RES_MSG  := '科室不存在，未查询到科室记录';
    END IF;
  
  END;

END PR_互联互通_号源锁定;
/

prompt
prompt Creating procedure PR_互联互通_检查报告查询
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_检查报告查询(STR_请求参数 IN VARCHAR2,
                                             STR_平台标识 IN VARCHAR2,
                                             STR_功能编码 IN VARCHAR2,
                                             LOB_响应参数 OUT CLOB,
                                             INT_返回值   OUT INTEGER,
                                             STR_返回信息 OUT VARCHAR2) IS

  STR_SQL VARCHAR2(3000);
  --【请求参数】
  STR_医院ID       VARCHAR2(50);
  STR_检查报告单号 VARCHAR2(50);
  STR_用户院内ID   VARCHAR2(50);
BEGIN
  BEGIN
  
    --【请求参数】
    STR_医院ID       := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
    STR_检查报告单号 := FU_互联互通_节点值(STR_请求参数, 'REPORT_ID');
    STR_用户院内ID   := FU_互联互通_节点值(STR_请求参数, 'HOSP_PATIENT_ID');
    
    IF STR_检查报告单号 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '报告单号不能为空';
      GOTO 退出;
    END IF;
  
    STR_SQL      := 'SELECT S.机构编码 as HOS_ID,
                           S.病人ID AS HOSP_PATIENT_ID,
                           '''' as PATIENT_IDCARD_TYPE,
                           (select A.身份证号
                              from 基础项目_病人信息 A
                             where A.机构编码 = S.机构编码
                               and A.病人ID = S.病人ID) as PATIENT_IDCARD_NO,
                           '''' as PATIENT_CARD_TYPE,
                           '''' as PATIENT_CARD_NO,
                           (select A.姓名
                              from 基础项目_病人信息 A
                             where A.机构编码 = S.机构编码
                               and A.病人ID = S.病人ID) as PATIENT_NAME,
                           (select A.性别
                              from 基础项目_病人信息 A
                             where A.机构编码 = S.机构编码
                               and A.病人ID = S.病人ID) as PATIENT_SEX,
                           (select A.年龄
                              from 基础项目_病人信息 A
                             where A.机构编码 = S.机构编码
                               and A.病人ID = S.病人ID) as PATIENT_AGE,
                           '''' as VISIT_NUMBER,
                           ''医保'' as MEDICAL_INSURANNCE_TYPE,
                           '''' as SPECIMEN_NAME,
                           J.样本号 as SPECIMEN_ID,
                           S.项目名称 as ITEM_NAME,
                           '''' as COMPLAINT,
                           J.检查结论 as DIAGNOSIS,
                           J.检查所见 as SEEN,
                           J.文字报告内容 as "CONTENT",
                           to_char(J.报告时间, ''yyyy-MM-dd hh24:mi:ss'') as REPORT_TIME,
                           (select B.科室名称
                              from 基础项目_科室资料 B
                             where B.机构编码 = S.机构编码
                               and B.科室编码 = S.执行科室编码) as DEPT_NAME,
                           (select C.人员姓名
                              from 基础项目_人员资料 C
                             where C.机构编码 = S.机构编码
                               and C.人员编码 = S.医生编码) as DOCTOR_NAME,
                           (select C.人员姓名
                              from 基础项目_人员资料 C
                             where C.机构编码 = S.机构编码
                               and C.人员编码 = J.审核医生编码) as REVIEW_NAME,
                           to_char(J.审核时间, ''yyyy-MM-dd hh24:mi:ss'') as REVIEW_TIME,
                           '''' as REMARK
                      FROM 检验检查_申请 S, 检验检查_结果 J
                     WHERE S.机构编码 = J.机构编码
                       AND S.申请单ID = J.申请单ID     
                       AND S.机构编码=''' || STR_医院ID || '''
                       AND J.报告单号 =''' || STR_检查报告单号||'''';
                       
    LOB_响应参数 := FU_互联互通_得到响应参数(STR_SQL, 'RES', '');
    IF DBMS_LOB.GETLENGTH(LOB_响应参数) > 0 THEN    
      INT_返回值   := 0;
      STR_返回信息 := '交易成功';
    ELSE
      INT_返回值   := 800401;
      STR_返回信息 := '检查/检验报告单号不存在';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '响应请求报错：'||SQLERRM;
      GOTO 退出;
  END;

  -- 【异常退出】
  <<退出>>
-- 【保存日志】
  PR_互联互通_操作日志(STR_平台标识 => STR_平台标识,
               STR_医院编码 => STR_医院ID,
               STR_功能编码 => STR_功能编码,
               STR_请求参数 => STR_请求参数,
               DAT_请求时间 => SYSDATE,
               INT_返回值   => INT_返回值,
               STR_返回信息 => STR_返回信息,
               DAT_执行时间 => SYSDATE);

  RETURN;

END PR_互联互通_检查报告查询;
/

prompt
prompt Creating procedure PR_互联互通_检查检验列表查询
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_检查检验列表查询(STR_请求参数 IN VARCHAR2,
                                             STR_平台标识 IN VARCHAR2,
                                             STR_功能编码 IN VARCHAR2,
                                             LOB_响应参数 OUT CLOB,
                                             INT_返回值   OUT INTEGER,
                                             STR_返回信息 OUT VARCHAR2) IS

  STR_SQL VARCHAR2(1000);
  --【请求参数】
  STR_医院ID       VARCHAR2(50);
  STR_用户院内ID   VARCHAR2(50);
  STR_用户证件类型 VARCHAR2(50);
  STR_用户证件号码 VARCHAR2(50);
  STR_用户卡类型   VARCHAR2(50);
  STR_用户卡号     VARCHAR2(50);
  STR_用户姓名     VARCHAR2(50);
  STR_用户性别     VARCHAR2(50);
  STR_用户年龄     VARCHAR2(50);
  STR_起始日期     VARCHAR2(50);
  STR_结束日期     VARCHAR2(50);
BEGIN
  BEGIN
  
    --【请求参数解析】
    STR_医院ID       := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
    STR_用户院内ID   := FU_互联互通_节点值(STR_请求参数, 'HOSP_PATIENT_ID');
    STR_用户证件类型 := FU_互联互通_节点值(STR_请求参数, 'PATIENT_IDCARD_TYPE');
    STR_用户证件号码 := FU_互联互通_节点值(STR_请求参数, 'PATIENT_IDCARD_NO');
    STR_用户卡类型   := FU_互联互通_节点值(STR_请求参数, 'PATIENT_CARD_TYPE');
    STR_用户卡号     := FU_互联互通_节点值(STR_请求参数, 'PATIENT_CARD_NO');
    STR_用户姓名     := FU_互联互通_节点值(STR_请求参数, 'PATIENT_NAME');
    STR_用户性别     := FU_互联互通_节点值(STR_请求参数, 'PATIENT_SEX');
    STR_用户年龄     := FU_互联互通_节点值(STR_请求参数, 'PATIENT_AGE');
    STR_起始日期     := FU_互联互通_节点值(STR_请求参数, 'BEGIN_DATE');
    STR_结束日期     := FU_互联互通_节点值(STR_请求参数, 'END_DATE');
  
    if STR_起始日期 is null or fu_尝试转日期(STR_起始日期) is null then
      INT_返回值   := '-1';
      STR_返回信息 := '请输入正确的起始日期!';
      GOTO 退出;
    end if;
    if STR_结束日期 is null or fu_尝试转日期(STR_结束日期) is null then
      INT_返回值   := '-1';
      STR_返回信息 := '请输入正确的结束日期!';
      GOTO 退出;
    end if;
  
    IF STR_用户证件号码 IS NULL AND STR_用户卡号 IS NULL THEN
      INT_返回值   := '-1';
      STR_返回信息 := '证件号码或卡号必填其中一项!';
      GOTO 退出;
    END IF;
  
    IF STR_用户院内ID IS NOT NULL THEN
      SELECT COUNT(1) INTO INT_返回值 FROM 基础项目_病人信息;
      IF INT_返回值 = 0 THEN
        INT_返回值   := '800102';
        STR_返回信息 := '用户不存在';
        GOTO 退出;
      END IF;
    ELSE
      SELECT A.病人ID
        INTO STR_用户院内ID
        FROM 基础项目_病人信息 A
       WHERE A.姓名 = STR_用户姓名
         AND A.性别 = STR_用户性别
         AND A.年龄 = STR_用户年龄
         AND (A.身份证号 = STR_用户证件号码 OR A.病人ID = STR_用户卡号)
         AND ROWNUM = 1;
      IF STR_用户院内ID IS NULL THEN
        INT_返回值   := '800102';
        STR_返回信息 := '用户不存在';
        GOTO 退出;
      END IF;
    END IF;
  
    STR_SQL := 'SELECT J.报告单号 AS REPORT_ID,
                     '''' AS DIAGNOSIS,
                     S.项目名称 AS ITEM_NAME,
                     '''' AS SPECIMEN_NAME,
                     J.样本号 AS SPECIMEN_ID,
                     TO_CHAR(J.报告时间, ''yyyy-MM-dd hh24:mi:ss'') AS REPORT_TIME,
                     (SELECT B.科室名称
                        FROM 基础项目_科室资料 B
                       WHERE B.机构编码 = S.机构编码
                         AND B.科室编码 = S.执行科室编码) AS DEPT_NAME,
                     (SELECT C.人员姓名
                        FROM 基础项目_人员资料 C
                       WHERE C.机构编码 = S.机构编码
                         AND C.人员编码 = S.医生编码) AS DOCTOR_NAME,
                     decode(S.类型,''检验'',''0'',''2'') AS REPORT_TYPE,
                     '''' AS REMARK
                FROM 检验检查_申请 S, 检验检查_结果 J
               WHERE S.机构编码 = J.机构编码
                 AND S.申请单ID = J.申请单ID
                 AND S.机构编码=' || STR_医院ID || 'AND S.病人ID=' ||
               STR_用户院内ID || 'AND J.报告时间 BETWEEN TO_DATE(''' || STR_起始日期 ||
               ''',''yyyy-MM-dd'') AND TO_DATE(''' || STR_结束日期 ||
               ''',''yyyy-MM-dd'')';
  
    LOB_响应参数 := fu_互联互通_得到响应参数(LOB_响应参数, 'REPORT_INFO', 'REPORT_INFO');
    IF DBMS_LOB.GETLENGTH(LOB_响应参数) > 0 THEN
    
      LOB_响应参数 := fu_互联互通_添加新节点(LOB_响应参数,
                                'REPORT_INFO',
                                'HOS_ID',
                                STR_医院ID);
      LOB_响应参数 := fu_互联互通_添加新节点(LOB_响应参数,
                                'REPORT_INFO',
                                'HOSP_PATIENT_ID',
                                STR_用户院内ID);
      LOB_响应参数 := fu_互联互通_添加新节点(LOB_响应参数,
                                'REPORT_INFO',
                                'PATIENT_IDCARD_TYPE',
                                STR_用户证件类型);
      LOB_响应参数 := fu_互联互通_添加新节点(LOB_响应参数,
                                'REPORT_INFO',
                                'PATIENT_IDCARD_NO',
                                STR_用户证件号码);
      LOB_响应参数 := fu_互联互通_添加新节点(LOB_响应参数,
                                'REPORT_INFO',
                                'PATIENT_CARD_TYPE',
                                STR_用户卡类型);
      LOB_响应参数 := fu_互联互通_添加新节点(LOB_响应参数,
                                'REPORT_INFO',
                                'PATIENT_CARD_NO',
                                STR_用户卡号);
      LOB_响应参数 := fu_互联互通_添加新节点(LOB_响应参数,
                                'REPORT_INFO',
                                'PATIENT_NAME',
                                STR_用户姓名);
      LOB_响应参数 := fu_互联互通_添加新节点(LOB_响应参数,
                                'REPORT_INFO',
                                'PATIENT_SEX',
                                STR_用户性别);
      LOB_响应参数 := fu_互联互通_添加新节点(LOB_响应参数,
                                'REPORT_INFO',
                                'PATIENT_AGE',
                                STR_用户年龄);
      LOB_响应参数 := fu_互联互通_添加新节点(LOB_响应参数,
                                'REPORT_INFO',
                                'VISIT_NUMBER',
                                '');
      LOB_响应参数 := fu_互联互通_添加新节点(LOB_响应参数,
                                'REPORT_INFO',
                                'MEDICAL_INSURANNCE_TYPE',
                                '');
      LOB_响应参数 := '<RES>' || LOB_响应参数 || '</RES>';
    
      INT_返回值   := 0;
      STR_返回信息 := '交易成功';
    ELSE
      INT_返回值   := 800101;
      STR_返回信息 := '检查/检验报告记录不存在，未查询到检查/检验报告记录';
    END IF;
  
  EXCEPTION
    -- 未检测的系统异常
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '响应请求报错：' || SQLERRM;
      GOTO 退出;
    
  END;

  -- 【异常退出】
  <<退出>>
-- 【保存日志】
  PR_互联互通_操作日志(STR_平台标识 => STR_平台标识,
               STR_医院编码 => STR_医院ID,
               STR_功能编码 => STR_功能编码,
               STR_请求参数 => STR_请求参数,
               DAT_请求时间 => SYSDATE,
               INT_返回值   => INT_返回值,
               STR_返回信息 => STR_返回信息,
               DAT_执行时间 => SYSDATE);

  RETURN;

END PR_互联互通_检查检验列表查询;
/

prompt
prompt Creating procedure PR_互联互通_缴费订单查询
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_缴费订单查询(STR_请求参数 IN VARCHAR2,
                                            LOB_响应参数 OUT CLOB,
                                            RES_CODE     OUT INTEGER,
                                            RES_MSG      OUT VARCHAR2) IS

  STR_SQL              VARCHAR2(1000);
  STR_医院ID           VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
--下面还有

BEGIN
  BEGIN
  
    IF DBMS_LOB.GETLENGTH(LOB_响应参数) > 0 THEN
    
      RES_CODE := 0;
      RES_MSG  := '交易成功';
    ELSE
      RES_CODE := 300201;
      RES_MSG  := '无效的缴费记录';
    END IF;
  
  END;

END PR_互联互通_缴费订单查询;
/

prompt
prompt Creating procedure PR_互联互通_缴费记录查询
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_缴费记录查询(STR_请求参数 IN VARCHAR2,
                                           STR_平台标识 IN VARCHAR2,
                                           STR_功能编码 IN VARCHAR2,
                                           LOB_响应参数 OUT CLOB,
                                           INT_返回值   OUT INTEGER,
                                           STR_返回信息 OUT VARCHAR2) IS

  --【请求参数】
  STR_医院ID       VARCHAR2(50);
  STR_用户院内ID   VARCHAR2(50);
  STR_用户证件类型 VARCHAR2(50);
  STR_用户证件号码 VARCHAR2(50);
  STR_用户卡类型   VARCHAR2(50);
  STR_用户卡号     VARCHAR2(50);
  STR_用户姓名     VARCHAR2(50);
  STR_用户性别     VARCHAR2(50);
  STR_用户年龄     VARCHAR2(50);
  STR_查询状态类型 VARCHAR2(50);
  STR_起始日期     VARCHAR2(50);
  STR_结束日期     VARCHAR2(50);

  STR_SQL VARCHAR2(1000);

BEGIN
  BEGIN
    --【请求参数解析】
    STR_医院ID       := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
    STR_用户院内ID   := FU_互联互通_节点值(STR_请求参数, 'HOSP_PATIENT_ID');
    STR_用户证件类型 := FU_互联互通_节点值(STR_请求参数, 'IDCARD_TYPE');
    STR_用户证件号码 := FU_互联互通_节点值(STR_请求参数, 'IDCARD_NO');
    STR_用户卡类型   := FU_互联互通_节点值(STR_请求参数, 'CARD_TYPE');
    STR_用户卡号     := FU_互联互通_节点值(STR_请求参数, 'CARD_NO');
    STR_用户姓名     := FU_互联互通_节点值(STR_请求参数, 'PATIENT_NAME');
    STR_用户性别     := FU_互联互通_节点值(STR_请求参数, 'PATIENT_SEX');
    STR_用户年龄     := FU_互联互通_节点值(STR_请求参数, 'PATIENT_AGE');
    STR_查询状态类型 := FU_互联互通_节点值(STR_请求参数, 'QUERY_TYPE');
    STR_起始日期     := FU_互联互通_节点值(STR_请求参数, 'BEGIN_DATE');
    STR_结束日期     := FU_互联互通_节点值(STR_请求参数, 'END_DATE');
  
    IF STR_用户证件号码 IS NULL AND STR_用户卡号 IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请传入证件号码或卡号';
      GOTO 退出;
    END IF;
  
    IF STR_查询状态类型 IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请传入查询状态类型';
      GOTO 退出;
    END IF;
    IF STR_起始日期 IS NULL OR FU_尝试转日期(STR_起始日期) IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请传入正确的起始日期';
      GOTO 退出;
    END IF;
    IF STR_结束日期 IS NULL OR FU_尝试转日期(STR_结束日期) IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请传入正确的结束日期';
      GOTO 退出;
    END IF;
  
    IF STR_用户院内ID IS NULL THEN
      BEGIN
        SELECT 病人ID
          INTO STR_用户院内ID
          FROM 互联互通_用户信息
         WHERE 医院编码 = STR_医院ID
           AND (证件号码 = STR_用户证件号码 OR 证件号码 = STR_用户证件号码);
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          INT_返回值   := 300102;
          STR_返回信息 := '用户不存在';
          GOTO 退出;
        WHEN OTHERS THEN
          INT_返回值   := 99;
          STR_返回信息 := '系统错误:' || SQLERRM;
          GOTO 退出;
      END;
    END IF;
  
    STR_SQL := 'SELECT T.流水码 AS HOSP_SEQUENCE,
                     (SELECT A.挂号科室名称
                        FROM 门诊管理_预约挂号 A
                       WHERE A.机构编码 = T.医院编码
                         AND A.主键ID = T.关联编码) AS DEPT_NAME,
                     (SELECT A.挂号医生姓名
                        FROM 门诊管理_预约挂号 A
                       WHERE A.机构编码 = T.医院编码
                         AND A.主键ID = T.关联编码) AS DOCTOR_NAME,
                     T.实付金额 AS PAY_AMOUT,
                     T.支付渠道 AS PAY_CHANNEL_ID,
                     DECODE(T.订单状态, ''待支付'', ''0'', ''已支付'', ''1'', ''已退款'', ''2'') AS ORDER_STATUS,
                     '''' AS RECEIPT_ID,
                     '''' AS PAY_REMARK,
                     T.平台订单时间 AS RECEIPT_DATE
                FROM 互联互通_订单 T
               WHERE T.平台标识 = STR_平台标识
                 AND T.医院编码 = STR_医院ID
                 AND T.病人ID = STR_用户院内ID
                 AND T.平台订单时间 BETWEEN TO_DATE(''' || STR_起始日期 ||
               ''', ''yyyy-MM-dd'') AND
                     TO_DATE(''' || STR_结束日期 ||
               ''', ''yyyy-MM-dd'')
                 AND T.订单状态 = DECODE(STR_查询状态类型,
                                     ''0'',
                                     T.订单状态,
                                     ''1'',
                                     ''待支付'',
                                     ''2'',
                                     ''已支付'',
                                     ''3'',
                                     ''已退款'')';
  
    LOB_响应参数 := FU_互联互通_得到响应参数(STR_SQL, 'RES', 'PAY_LIST');
    IF DBMS_LOB.GETLENGTH(LOB_响应参数) > 0 THEN
    
      LOB_响应参数 := FU_互联互通_添加新节点(LOB_响应参数   => LOB_响应参数,
                                STR_添加位置   => 'PAY_LIST',
                                STR_添加节点名 => 'USER_NAME',
                                STR_添加节点值 => STR_用户姓名);
      LOB_响应参数 := FU_互联互通_添加新节点(LOB_响应参数   => LOB_响应参数,
                                STR_添加位置   => 'PAY_LIST',
                                STR_添加节点名 => 'HOSP_PATIENT_ID',
                                STR_添加节点值 => STR_用户院内ID);
      LOB_响应参数 := FU_互联互通_添加新节点(LOB_响应参数   => LOB_响应参数,
                                STR_添加位置   => 'PAY_LIST',
                                STR_添加节点名 => 'IDCARD_TYPE',
                                STR_添加节点值 => STR_用户证件类型);
      LOB_响应参数 := FU_互联互通_添加新节点(LOB_响应参数   => LOB_响应参数,
                                STR_添加位置   => 'PAY_LIST',
                                STR_添加节点名 => 'IDCARD_NO',
                                STR_添加节点值 => STR_用户证件号码);
      LOB_响应参数 := FU_互联互通_添加新节点(LOB_响应参数   => LOB_响应参数,
                                STR_添加位置   => 'PAY_LIST',
                                STR_添加节点名 => 'CARD_TYPE',
                                STR_添加节点值 => STR_用户卡类型);
      LOB_响应参数 := FU_互联互通_添加新节点(LOB_响应参数   => LOB_响应参数,
                                STR_添加位置   => 'PAY_LIST',
                                STR_添加节点名 => 'CARD_NO',
                                STR_添加节点值 => STR_用户卡号);
    
      INT_返回值   := 0;
      STR_返回信息 := '交易成功';
    ELSE
      INT_返回值   := 300101;
      STR_返回信息 := '缴费记录不存在，未查询到缴费订单记录';
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
               STR_医院编码 => STR_医院ID,
               STR_功能编码 => STR_功能编码,
               STR_请求参数 => STR_请求参数,
               DAT_请求时间 => SYSDATE,
               INT_返回值   => INT_返回值,
               STR_返回信息 => STR_返回信息,
               DAT_执行时间 => SYSDATE);
  RETURN;
END PR_互联互通_缴费记录查询;
/

prompt
prompt Creating procedure PR_互联互通_缴费明细查询
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_缴费明细查询(STR_请求参数 IN VARCHAR2,
                                           STR_平台标识 IN VARCHAR2,
                                           STR_功能编码 IN VARCHAR2,
                                           LOB_响应参数 OUT CLOB,
                                           INT_返回值   OUT INTEGER,
                                           STR_返回信息 OUT VARCHAR2) IS

  --【请求参数】
  STR_医院ID       VARCHAR2(50);
  STR_用户院内ID   VARCHAR2(50);
  STR_缴费单唯一ID VARCHAR2(50);

  STR_SQL      VARCHAR2(1000);
  STR_用户姓名 VARCHAR2(50);
  STR_总金额   VARCHAR2(50);
  STR_应付金额 VARCHAR2(50);
  STR_实付金额 VARCHAR2(50);

BEGIN
  BEGIN
    STR_医院ID       := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
    STR_用户院内ID   := FU_互联互通_节点值(STR_请求参数, 'HOSP_PATIENT_ID');
    STR_缴费单唯一ID := FU_互联互通_节点值(STR_请求参数, 'HOSP_SEQUENCE');
  
    IF STR_缴费单唯一ID IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请传入缴费单唯一ID';
      GOTO 退出;
    END IF;
  
    BEGIN
      SELECT T.病人ID, T.总金额, T.应付金额, T.实付金额
        INTO STR_用户院内ID, STR_总金额, STR_应付金额, STR_实付金额
        FROM 互联互通_订单 T
       WHERE T.流水码 = STR_缴费单唯一ID;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        INT_返回值   := 300201;
        STR_返回信息 := '无效的缴费记录';
        GOTO 退出;
      WHEN OTHERS THEN
        INT_返回值   := 99;
        STR_返回信息 := '系统异常' || SQLERRM;
        GOTO 退出;
    END;
  
    BEGIN
      SELECT T.姓名
        INTO STR_用户姓名
        FROM 互联互通_用户信息 T
       WHERE T.平台标识 = STR_平台标识
         AND T.医院编码 = STR_医院ID
         AND T.病人ID = STR_用户院内ID;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        INT_返回值   := 300201;
        STR_返回信息 := '无效的缴费记录';
        GOTO 退出;
      WHEN OTHERS THEN
        INT_返回值   := 99;
        STR_返回信息 := '系统异常' || SQLERRM;
        GOTO 退出;
    END;
  
    STR_SQL      := ' SELECT TT.项目编码 AS DETAIL_TYPE,
                     TT.项目名称 AS DETAIL_NAME,
                     TT.流水码 AS DETAIL_ID,
                     TT.单位 AS DETAIL_UNIT,
                     TT.数量 AS DETAIL_COUNT,
                     TT.单价 AS DETAIL_PRICE,
                     TT.规格 AS DETAIL_SPEC,
                     TT.总金额 AS DETAIL_AMOUT,
                     ''0'' AS DETAIL_MI
                FROM 互联互通_订单 T, 互联互通_订单明细 TT
               WHERE T.医院订单号 = TT.订单号
                 AND T.流水码 = STR_缴费单唯一ID';
    LOB_响应参数 := FU_互联互通_得到响应参数(STR_SQL, 'RES', 'PAY_DETAIL_LIST');
    IF DBMS_LOB.GETLENGTH(LOB_响应参数) > 0 THEN
      LOB_响应参数 := FU_互联互通_添加新节点(LOB_响应参数   => LOB_响应参数,
                                STR_添加位置   => 'PAY_DETAIL_LIST',
                                STR_添加节点名 => 'USER_NAME',
                                STR_添加节点值 => STR_用户姓名);
      LOB_响应参数 := FU_互联互通_添加新节点(LOB_响应参数   => LOB_响应参数,
                                STR_添加位置   => 'PAY_DETAIL_LIST',
                                STR_添加节点名 => 'HOSP_PATIENT_ID',
                                STR_添加节点值 => STR_用户院内ID);
      LOB_响应参数 := FU_互联互通_添加新节点(LOB_响应参数   => LOB_响应参数,
                                STR_添加位置   => 'PAY_DETAIL_LIST',
                                STR_添加节点名 => 'MEDICAL_INSURANNCE_TYPE',
                                STR_添加节点值 => '自费');
      LOB_响应参数 := FU_互联互通_添加新节点(LOB_响应参数   => LOB_响应参数,
                                STR_添加位置   => 'PAY_DETAIL_LIST',
                                STR_添加节点名 => 'PAY_TOTAL_FEE',
                                STR_添加节点值 => STR_总金额);
      LOB_响应参数 := FU_互联互通_添加新节点(LOB_响应参数   => LOB_响应参数,
                                STR_添加位置   => 'PAY_DETAIL_LIST',
                                STR_添加节点名 => 'PAY_BEHOOVE_FEE',
                                STR_添加节点值 => STR_应付金额);
      LOB_响应参数 := FU_互联互通_添加新节点(LOB_响应参数   => LOB_响应参数,
                                STR_添加位置   => 'PAY_DETAIL_LIST',
                                STR_添加节点名 => 'PAY_ACTUAL_FEE',
                                STR_添加节点值 => STR_实付金额);
      LOB_响应参数 := FU_互联互通_添加新节点(LOB_响应参数   => LOB_响应参数,
                                STR_添加位置   => 'PAY_DETAIL_LIST',
                                STR_添加节点名 => 'PAY_MI_FEE',
                                STR_添加节点值 => '0');
      LOB_响应参数 := FU_互联互通_添加新节点(LOB_响应参数   => LOB_响应参数,
                                STR_添加位置   => 'PAY_DETAIL_LIST',
                                STR_添加节点名 => 'RECEIPT_ID',
                                STR_添加节点值 => '');
      INT_返回值   := 0;
      STR_返回信息 := '交易成功';
    ELSE
      INT_返回值   := 300201;
      STR_返回信息 := '无效的缴费记录';
    END IF;
  
  END;

  <<退出>>
-- 【保存日志】
  PR_互联互通_操作日志(STR_平台标识 => STR_平台标识,
               STR_医院编码 => STR_医院ID,
               STR_功能编码 => STR_功能编码,
               STR_请求参数 => STR_请求参数,
               DAT_请求时间 => SYSDATE,
               INT_返回值   => INT_返回值,
               STR_返回信息 => STR_返回信息,
               DAT_执行时间 => SYSDATE);
  RETURN;

END PR_互联互通_缴费明细查询;
/

prompt
prompt Creating procedure PR_互联互通_解锁号源锁定
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_解锁号源锁定(STR_请求参数 IN VARCHAR2,
                                         LOB_响应参数 OUT CLOB,
                                         RES_CODE     OUT INTEGER,
                                         RES_MSG      OUT VARCHAR2) IS

  STR_SQL          VARCHAR2(1000);
  STR_医院ID       VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
  STR_号源锁定ID   VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'LOCK_ID');
BEGIN
  BEGIN
  
    IF DBMS_LOB.GETLENGTH(LOB_响应参数) > 0 THEN
    
      RES_CODE := 0;
      RES_MSG  := '交易成功';
    ELSE
      RES_CODE := 200101;
      RES_MSG  := '科室不存在，未查询到科室记录';
    END IF;
  
  END;

END PR_互联互通_解锁号源锁定;
/

prompt
prompt Creating procedure PR_互联互通_科室查询
prompt ===============================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_科室查询(STR_请求参数 IN VARCHAR2,
                                         STR_平台标识 IN VARCHAR2,
                                         STR_功能编码 IN VARCHAR2,
                                         LOB_响应参数 OUT CLOB,
                                         INT_返回值   OUT INTEGER,
                                         STR_返回信息 OUT VARCHAR2) IS

  --【请求参数】
  STR_医院ID VARCHAR2(50);
  STR_科室ID VARCHAR2(50);

  STR_SQL VARCHAR2(1000);

BEGIN
  BEGIN
    --【请求参数解析】  
    STR_医院ID := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
    STR_科室ID := FU_互联互通_节点值(STR_请求参数, 'DEPT_ID');
  
    IF STR_科室ID IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '科室ID不能为空';
      GOTO 退出;
    END IF;
  
    --【业务响应SQL】
    STR_SQL := 'select 科室编码 as DEPT_ID,
                                      科室名称 as DEPT_NAME,
                                      所属部门 as PARENT_ID,
                                      '''' as SORT_ID,
                                      备注 as "DESC",
                                      科室主任 as EXPERTISE,
                                      '''' as "LEVEL",
                                      '''' as ADDRESS,
                                      decode(有效状态, ''有效'', ''1'', ''2'') as STATUS
                                from 基础项目_科室资料
                                where 机构编码=' || STR_医院ID ||
               ' and 科室编码 in (select tt.科室编码 from 门诊管理_门诊一周排班表 tt) and (科室编码 =' ||
               STR_科室ID || ' or ' || STR_科室ID || '=''-1'' or ' || STR_科室ID ||
               '=''0'')';
  
    LOB_响应参数 := FU_互联互通_得到响应参数(STR_SQL    => STR_SQL,
                               STR_根标签 => 'RES',
                               STR_行标签 => 'DEPT_LIST');
    IF DBMS_LOB.GETLENGTH(LOB_响应参数) > 0 THEN
      --【添加HOST_ID节点】
      LOB_响应参数 := FU_互联互通_添加新节点(LOB_响应参数   => LOB_响应参数,
                                STR_添加位置   => 'DEPT_LIST',
                                STR_添加节点名 => 'HOST_ID',
                                STR_添加节点值 => STR_医院ID);
    
      INT_返回值   := 0;
      STR_返回信息 := '交易成功';
    ELSE
      INT_返回值   := 200101;
      STR_返回信息 := '科室不存在，未查询到科室记录';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := 99;
      STR_返回信息 := '响应请求错误' || SQLERRM;
      GOTO 退出;
  END;

  <<退出>>

  -- 【保存日志】
  PR_互联互通_操作日志(STR_平台标识 => STR_平台标识,
               STR_医院编码 => STR_医院ID,
               STR_功能编码 => STR_功能编码,
               STR_请求参数 => STR_请求参数,
               DAT_请求时间 => SYSDATE,
               INT_返回值   => INT_返回值,
               STR_返回信息 => STR_返回信息,
               DAT_执行时间 => SYSDATE);

  RETURN;

END PR_互联互通_科室查询;
/

prompt
prompt Creating procedure PR_互联互通_排班分时查询
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_排班分时查询(STR_请求参数 IN VARCHAR2,
                                           STR_平台标识 IN VARCHAR2,
                                           STR_功能编码 IN VARCHAR2,
                                           LOB_响应参数 OUT CLOB,
                                           INT_返回值   OUT INTEGER,
                                           STR_返回信息 OUT VARCHAR2) IS

  --【请求参数】
  STR_医院ID   VARCHAR2(50);
  STR_科室ID   VARCHAR2(50);
  STR_医生ID   VARCHAR2(50);
  STR_出诊日期 VARCHAR2(50);
  STR_出诊时段 VARCHAR2(50);

  STR_SQL VARCHAR2(1000);

BEGIN
  BEGIN
  
    --【请求参数解析】
    STR_医院ID   := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
    STR_科室ID   := FU_互联互通_节点值(STR_请求参数, 'DEPT_ID');
    STR_医生ID   := FU_互联互通_节点值(STR_请求参数, 'DOCTOR_ID');
    STR_出诊日期 := FU_互联互通_节点值(STR_请求参数, 'REG_DATE');
    STR_出诊时段 := FU_互联互通_节点值(STR_请求参数, 'TIME_FLAG');
  
    -- 【数据校验】
    IF STR_科室ID IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '科室ID不能为空';
      GOTO 退出;
    END IF;
    IF STR_医生ID IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '医生ID不能为空';
      GOTO 退出;
    END IF;
    IF STR_出诊日期 IS NULL OR FU_尝试转日期(STR_出诊日期) IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请传入有效的出诊日期';
      GOTO 退出;
    END IF;
  
    --【验证科室排班信息】
    SELECT COUNT(1)
      INTO INT_返回值
      FROM 门诊管理_当天排班记录
     WHERE 机构编码 = STR_医院ID
       AND 科室编码 = STR_科室ID
       AND 排班日期 = TO_DATE(STR_出诊日期, 'yyyy-MM-dd');
  
    IF INT_返回值 = 0 THEN
      INT_返回值   := 200401;
      STR_返回信息 := '科室不存在';
      GOTO 退出;
    END IF;
  
    --【验证医生排班信息】
    SELECT COUNT(1)
      INTO INT_返回值
      FROM 门诊管理_当天排班记录
     WHERE 机构编码 = STR_医院ID
       AND 医生编码 = STR_医生ID
       AND 排班日期 = TO_DATE(STR_出诊日期, 'yyyy-MM-dd');
  
    IF INT_返回值 = 0 THEN
      INT_返回值   := 200402;
      STR_返回信息 := '医生不存在';
      GOTO 退出;
    END IF;
  
    STR_SQL := 'select ''4'' as TIME_FLAG,
                       tt.开始时间 as BEGIN_TIME,
                       tt.结束时间 as END_TIME,
                       decode(tt.限号数, ''-1'', ''99'', tt.限号数) as TOTAL,
                       decode(tt.限号数, ''-1'', ''99'', tt.限号数-tt.已挂号数) as OVER_COUNT,
                       tt.日班次标识 as REG_ID
                from 门诊管理_当天排班记录 t, 门诊管理_日排班时段表 tt
                where t.机构编码 = tt.机构编码
                      and t.排班序号 = tt.排班序号
                      and t.记录id = tt.记录id
                      and t.机构编码=' || STR_医院ID ||
               ' and t.科室编码=' || STR_科室ID || ' and t.医生编码=' || STR_医生ID ||
               ' and t.排班日期=to_date(''' || STR_出诊日期 || ''',''yyyy-MM-dd'')';
  
    LOB_响应参数 := FU_互联互通_得到响应参数(STR_SQL, 'RES', 'TIME_REG_LIST');
    IF DBMS_LOB.GETLENGTH(LOB_响应参数) > 0 THEN
      INT_返回值   := 0;
      STR_返回信息 := '交易成功';
    ELSE
      INT_返回值   := 200403;
      STR_返回信息 := '排班不存在';
    END IF;
  EXCEPTION
    -- 未检测的系统异常
    WHEN OTHERS THEN
      INT_返回值   := 99;
      STR_返回信息 := '响应请求报错' || SQLERRM;
      GOTO 退出;
    
  END;

  -- 【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;

  -- 【保存日志】
  PR_互联互通_操作日志(STR_平台标识 => STR_平台标识,
               STR_医院编码 => STR_医院ID,
               STR_功能编码 => STR_功能编码,
               STR_请求参数 => STR_请求参数,
               DAT_请求时间 => SYSDATE,
               INT_返回值   => INT_返回值,
               STR_返回信息 => STR_返回信息,
               DAT_执行时间 => SYSDATE);

  RETURN;

END PR_互联互通_排班分时查询;
/

prompt
prompt Creating procedure PR_互联互通_排班信息查询
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_排班信息查询(STR_请求参数 IN VARCHAR2,
                                           STR_平台标识 IN VARCHAR2,
                                           STR_功能编码 IN VARCHAR2,
                                           LOB_响应参数 OUT CLOB,
                                           INT_返回值   OUT INTEGER,
                                           STR_返回信息 OUT VARCHAR2) IS

  STR_SQL  VARCHAR2(2000);
  STR_SQL1 VARCHAR2(2000);
  --【请求参数】
  STR_医院ID       VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
  STR_科室ID       VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'DEPT_ID');
  STR_医生ID       VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'DOCTOR_ID');
  STR_排班开始日期 VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'START_DATE');
  STR_排班结束日期 VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'END_DATE');

  STR_临时医生ID   VARCHAR2(50) := '-999';
  STR_临时出诊日期 DATE := TO_DATE('1990-01-01', 'yyyy-MM-dd');

  CURSOR CUR_排班信息 IS
    SELECT T.机构编码,
           T.记录ID,
           T.排班序号,
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
     WHERE T.机构编码 = STR_医院ID
       AND T.科室编码 = STR_科室ID
       AND (T.医生编码 = STR_医生ID OR STR_医生ID = '-1')
       AND T.排班日期 BETWEEN TO_DATE(STR_排班开始日期, 'yyyy-MM-dd') AND
           TO_DATE(STR_排班结束日期, 'yyyy-MM-dd')
     ORDER BY T.科室编码, T.医生编码, T.排班日期;

  ROW_排班信息 CUR_排班信息%ROWTYPE;

BEGIN

  BEGIN
  
    FOR ROW_排班信息 IN CUR_排班信息 LOOP
      EXIT WHEN CUR_排班信息%NOTFOUND;
    
      STR_SQL := 'SELECT T.日班次标识 AS REG_ID,
                       ''4'' AS TIME_FLAG,
                       ''2'' AS REG_STATUS,
                       DECODE(T.限号数, -1, 99, T.限号数) AS TOTAL,
                       DECODE(T.限号数, -1, 99, T.限号数 - T.已挂号数) AS OVER_COUNT,
                       1 AS REG_LEVEL,
                       T2.挂号费 * 100 AS REG_FEE,
                       T2.诊查费 * 100 AS TREAT_FEE,
                       0 AS ISTIME
                  FROM 门诊管理_日排班时段表 T,
                       门诊管理_当天排班记录 T1,
                       基础项目_挂号类型     T2
                 WHERE T.机构编码 = T1.机构编码
                   AND T1.机构编码 = T2.机构编码
                   AND T.记录ID = T1.记录ID
                   AND T.排班序号 = T1.排班序号
                   AND T1.挂号类型编码 = T2.类型编码
                   AND T.机构编码=' || STR_医院ID ||
                 ' AND T.记录ID=''' || ROW_排班信息.记录ID || ''' AND T.排班序号=' ||
                 ROW_排班信息.排班序号;
    
      STR_SQL1 := 'SELECT T1.记录ID AS REG_ID,
                         ''4'' AS TIME_FLAG,
                         ''2'' AS REG_STATUS,      
                         (select sum(限号数)
                            from 门诊管理_日排班时段表
                           where 机构编码 = T1.机构编码
                             and 记录ID = T1.记录ID
                             and 限号数 > 0) TOTAL,
                         (select sum(限号数) - sum(已挂号数)
                            from 门诊管理_日排班时段表
                           where 机构编码 = T1.机构编码
                             and 记录ID = T1.记录ID
                             and 限号数 > 0) OVER_COUNT,
                         1 AS REG_LEVEL,
                         T2.挂号费 * 100 AS REG_FEE,
                         T2.诊查费 * 100 AS TREAT_FEE,
                         1 AS ISTIME
                    FROM 门诊管理_当天排班记录 T1, 基础项目_挂号类型 T2
                   WHERE T1.机构编码 = T2.机构编码
                     AND T1.挂号类型编码 = T2.类型编码
                   AND T1.机构编码=' || STR_医院ID ||
                  ' AND T1.记录ID=''' || ROW_排班信息.记录ID || ''' AND T1.排班序号=' ||
                  ROW_排班信息.排班序号;
    
      IF STR_临时医生ID <> ROW_排班信息.医生编码 THEN
        STR_临时医生ID := ROW_排班信息.医生编码;
        IF DBMS_LOB.GETLENGTH(LOB_响应参数) > 0 THEN
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
        
          LOB_响应参数 := LOB_响应参数 || '</REG_LIST>'; --出诊日期节点结束
        
        END IF;
      ELSE
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
        
          LOB_响应参数 := LOB_响应参数 || '</REG_LIST>'; --出诊日期节点结束
        
        END IF;
      END IF;
    
    END LOOP;
    IF DBMS_LOB.GETLENGTH(LOB_响应参数) > 0 THEN
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
      STR_返回信息 := '响应请求报错：' || SQLERRM;
      GOTO 退出;
  END;
  <<退出>>

  -- 【保存日志】
  PR_互联互通_操作日志(STR_平台标识 => STR_平台标识,
               STR_医院编码 => STR_医院ID,
               STR_功能编码 => STR_功能编码,
               STR_请求参数 => STR_请求参数,
               DAT_请求时间 => SYSDATE,
               INT_返回值   => INT_返回值,
               STR_返回信息 => STR_返回信息,
               DAT_执行时间 => SYSDATE);

  RETURN;

END PR_互联互通_排班信息查询;
/

prompt
prompt Creating procedure PR_互联互通_排队列表查询
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_排队列表查询(STR_请求参数 IN VARCHAR2,
                                           LOB_响应参数 OUT CLOB,
                                           RES_CODE     OUT INTEGER,
                                           RES_MSG      OUT VARCHAR2) IS

  STR_SQL          VARCHAR2(1000);
  STR_医院ID       VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
  STR_用户院内ID   VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'HOSP_PATIENT_ID');
  STR_用户证件类型 VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数,
                                         'PATIENT_IDCARD_TYPE');
  STR_用户证件号码 VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'PATIENT_IDCARD_NO');
  STR_用户卡类型   VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'PATIENT_CARD_TYPE');
  STR_用户卡号     VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'PATIENT_CARD_NO');
  STR_用户姓名     VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'PATIENT_NAME');
  STR_用户性别     VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'PATIENT_SEX');
  STR_用户年龄     VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'PATIENT_AGE');

BEGIN
  BEGIN
  
    IF DBMS_LOB.GETLENGTH(LOB_响应参数) > 0 THEN
    
      RES_CODE := 0;
      RES_MSG  := '交易成功';
    ELSE
      RES_CODE := 300201;
      RES_MSG  := '无效的缴费记录';
    END IF;
  
  END;

END PR_互联互通_排队列表查询;
/

prompt
prompt Creating procedure PR_互联互通_普通检验报告查询
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_普通检验报告查询(STR_请求参数 IN VARCHAR2,
                                             STR_平台标识 IN VARCHAR2,
                                             STR_功能编码 IN VARCHAR2,
                                             LOB_响应参数 OUT CLOB,
                                             INT_返回值   OUT INTEGER,
                                             STR_返回信息 OUT VARCHAR2) IS

  --【请求参数】
  STR_医院ID       VARCHAR2(50);
  STR_检验报告单号 VARCHAR2(50);
  STR_用户院内ID   VARCHAR2(50);

  STR_SQL          VARCHAR2(4000);
  LOB_响应参数临时 CLOB;

BEGIN
  BEGIN
    --【请求参数解析】
    STR_医院ID       := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
    STR_检验报告单号 := FU_互联互通_节点值(STR_请求参数, 'REPORT_ID');
    STR_用户院内ID   := FU_互联互通_节点值(STR_请求参数, 'HOSP_PATIENT_ID');
  
    STR_SQL := 'SELECT S.病人ID AS HOSP_PATIENT_ID,
                           '''' as PATIENT_IDCARD_TYPE,
                           (select A.身份证号
                              from 基础项目_病人信息 A
                             where A.机构编码 = S.机构编码
                               and A.病人ID = S.病人ID) as PATIENT_IDCARD_NO,
                           '''' as PATIENT_CARD_TYPE,
                           '''' as PATIENT_CARD_NO,
                           (select A.姓名
                              from 基础项目_病人信息 A
                             where A.机构编码 = S.机构编码
                               and A.病人ID = S.病人ID) as PATIENT_NAME,
                           (select A.性别
                              from 基础项目_病人信息 A
                             where A.机构编码 = S.机构编码
                               and A.病人ID = S.病人ID) as PATIENT_SEX,
                           (select A.年龄
                              from 基础项目_病人信息 A
                             where A.机构编码 = S.机构编码
                               and A.病人ID = S.病人ID) as PATIENT_AGE,
                           '''' as VISIT_NUMBER,
                           ''医保'' as MEDICAL_INSURANNCE_TYPE,
                           J.检查结论 as DIAGNOSIS,
                           S.项目名称 as ITEM_NAME,
                           J.样本号 as SPECIMEN_ID,                                           
                           to_char(J.报告时间, ''yyyy-MM-dd hh24:mi:ss'') as REPORT_TIME,
                           (select B.科室名称
                              from 基础项目_科室资料 B
                             where B.机构编码 = S.机构编码
                               and B.科室编码 = S.执行科室编码) as DEPT_NAME,
                           (select C.人员姓名
                              from 基础项目_人员资料 C
                             where C.机构编码 = S.机构编码
                               and C.人员编码 = S.医生编码) as DOCTOR_NAME,
                           (select C.人员姓名
                              from 基础项目_人员资料 C
                             where C.机构编码 = S.机构编码
                               and C.人员编码 = J.审核医生编码) as REVIEW_NAME,
                           to_char(J.审核时间, ''yyyy-MM-dd hh24:mi:ss'') as REVIEW_TIME,
                           '''' as REMARK
                      FROM 检验检查_申请 S, 检验检查_结果 J
                     WHERE S.机构编码 = J.机构编码
                       AND S.申请单ID = J.申请单ID     
                       AND S.机构编码=''' || STR_医院ID || '''
                       AND J.报告单号 =''' || STR_检验报告单号 || '''';
  
    LOB_响应参数 := FU_互联互通_得到响应参数(STR_SQL, 'RES', 'REPORT_INFO');
  
    IF DBMS_LOB.GETLENGTH(LOB_响应参数) > 0 THEN
    
      STR_SQL := 'SELECT M.细项名称 AS CHECK_NAME,
                     M.细项值 AS "RESULT",
                     M.单位 AS UNIT,
                     DECODE(M.结论, ''L'', ''偏低'', ''H'', ''偏高'', ''正常'') as NORMAL_FLAG,
                     M.参考值上限 AS REFERENCE_VALUE,
                     '''' as "DESC"
                FROM 检验检查_结果_明细 M
               WHERE M.机构编码 = ''' || STR_医院ID || '''
                 AND M.报告单ID = ''' || STR_检验报告单号 || '''';
      --829
      LOB_响应参数临时 := FU_互联互通_得到响应参数(STR_SQL, 'CHECK_LIST', 'DETAIL');
    
      --合并两个XML
      SELECT INSERTCHILDXMLAFTER(XMLTYPE(LOB_响应参数), '/RES', 'REPORT_INFO', XMLTYPE(LOB_响应参数临时).EXTRACT('/CHECK_LIST')).GETCLOBVAL()
        INTO LOB_响应参数
        FROM DUAL;
        
         --【添加HOST_ID节点】
      LOB_响应参数 := FU_互联互通_添加新节点(LOB_响应参数   => LOB_响应参数,
                                STR_添加位置   => 'REPORT_INFO',
                                STR_添加节点名 => 'HOST_ID',
                                STR_添加节点值 => STR_医院ID);
    
      INT_返回值   := 0;
      STR_返回信息 := '交易成功';
    ELSE
      INT_返回值   := 800201;
      STR_返回信息 := '检查/检验报告单号不存在';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := SQLERRM;
      GOTO 退出;
    
  END;
  -- 【异常退出】
  <<退出>>
   -- 【保存日志】
  PR_互联互通_操作日志(STR_平台标识 => STR_平台标识,
               STR_医院编码 => STR_医院ID,
               STR_功能编码 => STR_功能编码,
               STR_请求参数 => STR_请求参数,
               DAT_请求时间 => SYSDATE,
               INT_返回值   => INT_返回值,
               STR_返回信息 => STR_返回信息,
               DAT_执行时间 => SYSDATE);

  RETURN;

END PR_互联互通_普通检验报告查询;
/

prompt
prompt Creating procedure PR_互联互通_取号
prompt =============================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_取号(STR_请求参数 IN VARCHAR2,
                                       STR_平台标识 IN VARCHAR2,
                                       STR_功能编码 IN VARCHAR2,
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

BEGIN
  BEGIN
  
    --【请求参数解析】
    STR_医院ID     := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
    STR_平台订单号 := FU_互联互通_节点值(STR_请求参数, 'ORDER_ID');
  
    -- 【变量初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
  
    IF STR_平台订单号 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '平台订单号不能为空';
      GOTO 退出;
    END IF;
  
    -- 【获取预约单号】
    BEGIN
      SELECT 关联编码
        INTO STR_预约单号
        FROM 互联互通_订单
       WHERE 医院编码 = STR_医院ID
         AND 平台标识 = STR_平台标识
         AND 平台订单号 = STR_平台订单号
         AND 订单状态 = '已支付';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        INT_返回值   := 201101;
        STR_返回信息 := '挂号订单不存在';
        GOTO 退出;
      WHEN OTHERS THEN
        INT_返回值   := -1;
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
       WHERE G.机构编码 = STR_医院ID
         AND G.主键ID = STR_预约单号
         AND G.去向标志 = '预约'
         AND G.支付标志 = '是'
         AND TO_CHAR(G.预约时间, 'yyyymmdd') = TO_CHAR(SYSDATE, 'yyyymmdd');
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        INT_返回值   := -1;
        STR_返回信息 := '未找到有效的预约记录！';
        GOTO 退出;
      WHEN OTHERS THEN
        INT_返回值   := -1;
        STR_返回信息 := '系统异常：' || SQLERRM;
        GOTO 退出;
    END;
  
    -- 产生【门诊病历号】
    PR_公用_取得业务病历号(STR_机构编码   => STR_医院ID,
                  STR_病历号类型 => '门诊病历号',
                  STR_返回病历号 => STR_门诊病历号,
                  INT_返回值     => INT_返回值,
                  STR_返回信息   => STR_返回信息);
    IF INT_返回值 <> 1 THEN
      STR_返回信息 := '产生门诊病历号失败,原因:' + STR_返回信息;
      GOTO 退出;
    END IF;
  
    -- 产生【挂号序号】
    PR_获取_系统唯一号(PRM_唯一号编码 => '26',
                PRM_机构编码   => STR_医院ID,
                PRM_事物类型   => '1',
                PRM_返回唯一号 => STR_挂号序号,
                PRM_执行结果   => INT_返回值,
                PRM_错误信息   => STR_返回信息);
    IF INT_返回值 <> 0 THEN
      STR_返回信息 := '产生挂号序号失败!';
      GOTO 退出;
    END IF;
  
    -- 产生【挂号单号】
    SELECT FU_公用_获取当前票据号(STR_医院ID, STR_平台标识, '4')
      INTO STR_挂号单号
      FROM DUAL;
  
    IF STR_挂号单号 = '请到财务先领用票据' THEN
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
        (STR_医院ID,
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
        INT_返回值   := -1;
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
        (STR_医院ID,
         STR_挂号单号,
         NUM_总费用,
         STR_付款方式,
         '挂号',
         STR_平台标识,
         STR_平台标识,
         SYSDATE,
         STR_挂号序号,
         STR_挂号序号,
         '挂号',
         STR_病人类型编码,
         STR_病人类型名称);
    
      INT_返回值 := SQL%ROWCOUNT;
      IF INT_返回值 = 0 THEN
        INT_返回值   := -1;
        STR_返回信息 := '保存收支款数据失败！';
        GOTO 退出;
      END IF;
    
      -- 更新预约状态
      UPDATE 门诊管理_预约挂号
         SET 去向标志 = '看诊',
             挂号序号 = STR_挂号序号,
             取号时间 = DAT_系统时间
       WHERE 机构编码 = STR_医院ID
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
       WHERE 关联编码 = STR_预约单号
         AND 平台标识 = STR_平台标识
         AND 医院编码 = STR_医院ID
         AND 平台订单号 = STR_平台订单号
         AND 订单类型 = '预约挂号';
    
      INT_返回值 := SQL%ROWCOUNT;
      IF INT_返回值 = 0 THEN
        INT_返回值   := -1;
        STR_返回信息 := '更新订单状态失败！';
        GOTO 退出;
      END IF;
    
      STR_SQL := '';
      IF DBMS_LOB.GETLENGTH(LOB_响应参数) > 0 THEN
      
        INT_返回值   := 0;
        STR_返回信息 := '交易成功';
      ELSE
        INT_返回值   := 200101;
        STR_返回信息 := '科室不存在，未查询到科室记录';
      END IF;
      
      COMMIT;
      RETURN;
      
    EXCEPTION
      WHEN OTHERS THEN
        INT_返回值   := -1;
        STR_返回信息 := STR_返回信息 || SQLERRM;
        GOTO 退出;
      
    END;
  
  END;
  <<退出>>
-- 【保存日志】
  PR_互联互通_操作日志(STR_平台标识 => STR_平台标识,
               STR_医院编码 => STR_医院ID,
               STR_功能编码 => STR_功能编码,
               STR_请求参数 => STR_请求参数,
               DAT_请求时间 => SYSDATE,
               INT_返回值   => INT_返回值,
               STR_返回信息 => STR_返回信息,
               DAT_执行时间 => SYSDATE);
  ROLLBACK;
  RETURN;

END PR_互联互通_取号;
/

prompt
prompt Creating procedure PR_互联互通_取消挂号
prompt ===============================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_取消挂号(STR_请求参数 IN VARCHAR2,
                                         STR_平台标识 IN VARCHAR2,
                                         STR_功能编码 IN VARCHAR2,
                                         LOB_响应参数 OUT CLOB,
                                         INT_返回值   OUT INTEGER,
                                         STR_返回信息 OUT VARCHAR2) IS

  --【请求参数】
  STR_医院ID     VARCHAR2(50);
  STR_平台订单号 VARCHAR2(50);
  STR_医院订单号 VARCHAR2(50);
  STR_取消时间   VARCHAR2(50);
  STR_取消原因   VARCHAR2(50);

  --【业务参数】
  STR_预约单号 varchar2(50);
  STR_订单状态 varchar2(50);

BEGIN

  --【请求参数】
  STR_医院ID     := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
  STR_平台订单号 := FU_互联互通_节点值(STR_请求参数, 'ORDER_ID');
  STR_医院订单号 := FU_互联互通_节点值(STR_请求参数, 'HOSP_ORDER_ID');
  STR_取消时间   := FU_互联互通_节点值(STR_请求参数, 'CANCEL_DATE');
  STR_取消原因   := FU_互联互通_节点值(STR_请求参数, 'CANCEL_REMARK');
  --【验证数据】
  if STR_平台订单号 is null then
    INT_返回值   := -1;
    STR_返回信息 := '平台订单号不能为空';
    GOTO 退出;
  end if;

  IF STR_取消时间 IS NULL OR FU_尝试转日期(STR_取消时间) IS NULL THEN
    INT_返回值   := -1;
    STR_返回信息 := '取消时间格式不正确！';
    GOTO 退出;
  END IF;

  --【验证订单状态】
  BEGIN
    SELECT 关联编码, 订单状态
      INTO STR_预约单号, STR_订单状态
      FROM 互联互通_订单
     WHERE 医院编码 = STR_医院ID
       AND 平台订单号 = STR_平台订单号
       AND (医院订单号 = STR_医院订单号 OR STR_医院订单号 is null);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INT_返回值   := 200901;
      STR_返回信息 := '挂号订单不存在';
      GOTO 退出;
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '系统异常：' || SQLERRM;
      GOTO 退出;
  END;

  IF STR_订单状态 = '已支付' THEN
  
    INT_返回值   := 200902;
    STR_返回信息 := '挂号订单已支付';
    GOTO 退出;
  elsif STR_订单状态 = '已取消' THEN
    INT_返回值   := 200805;
    STR_返回信息 := '挂号订单已取消';
    GOTO 退出;
  elsif STR_订单状态 = '已退款' THEN
    INT_返回值   := 200806;
    STR_返回信息 := '挂号订单已退款';
    GOTO 退出;
  END IF;

  -- 【功能处理】
  BEGIN
  
    -- 更新预约单
    UPDATE 门诊管理_预约挂号
       SET 去向标志 = '消号'
     WHERE 机构编码 = STR_医院ID
       AND 主键ID = STR_预约单号
       AND (去向标志 = '预约' OR 去向标志 = '占号');
  
    INT_返回值 := SQL%ROWCOUNT;
    IF INT_返回值 = 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '更新预约单失败！';
      GOTO 退出;
    END IF;
  
    -- 更新订单状态
    UPDATE 互联互通_订单
       SET 订单状态 = '已取消',
           取消时间 = to_date(STR_取消时间, 'yyyy-MM-dd hh24:mi:ss'),
           取消原因 = STR_取消原因,
           更新人   = STR_平台标识,
           更新时间 = sysdate
     WHERE 平台标识 = STR_平台标识
       AND 平台订单号 = STR_平台订单号
       AND 关联编码 = STR_预约单号
       AND 订单状态 = '待支付';
  
    INT_返回值 := SQL%ROWCOUNT;
    IF INT_返回值 = 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '更新订单失败！';
      GOTO 退出;
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := STR_返回信息 || SQLERRM;
      GOTO 退出;
  END;

  BEGIN
  
    LOB_响应参数 := '<RES></RES>';
  
    INT_返回值   := 0;
    STR_返回信息 := '交易成功';
  
  END;

  COMMIT;
  RETURN;

  --【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;

  -- 【保存日志】
  PR_互联互通_操作日志(STR_平台标识 => STR_平台标识,
               STR_医院编码 => STR_医院ID,
               STR_功能编码 => STR_功能编码,
               STR_请求参数 => STR_请求参数,
               DAT_请求时间 => sysdate,
               INT_返回值   => INT_返回值,
               STR_返回信息 => STR_返回信息,
               DAT_执行时间 => SYSDATE);

  ROLLBACK;
  RETURN;

END PR_互联互通_取消挂号;
/

prompt
prompt Creating procedure PR_互联互通_退款挂号
prompt ===============================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_退款挂号(STR_请求参数 IN VARCHAR2,
                                         STR_平台标识 IN VARCHAR2,
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
  NUM_实付金额     NUMBER(10, 4);

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

  --【生成退款单号】
  SELECT SYS_GUID() INTO STR_医院退款单号 FROM DUAL;

  --【验证订单状态】
  BEGIN
    SELECT 关联编码, 订单状态, 实付金额
      INTO STR_预约单号, STR_订单状态, NUM_实付金额
      FROM 互联互通_订单
     WHERE 医院编码 = STR_医院ID
       AND 平台订单号 = STR_平台订单号
       AND (医院订单号 = STR_医院订单号 OR STR_医院订单号 IS NULL);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INT_返回值   := 201001;
      STR_返回信息 := '挂号订单不存在';
      GOTO 退出;
    WHEN OTHERS THEN
      INT_返回值   := -1;
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

  IF NUM_实付金额 <> TO_NUMBER(STR_退款金额) THEN
    INT_返回值   := 201003;
    STR_返回信息 := '退款金额不正确';
    GOTO 退出;
  END IF;

  -- 验证预约单
  SELECT COUNT(1)
    INTO INT_返回值
    FROM 门诊管理_预约挂号
   WHERE 机构编码 = STR_医院ID
     AND 主键ID = STR_预约单号
     AND 去向标志 = '占号'
     AND 超时时间 < SYSDATE;

  IF INT_返回值 > 0 THEN
    INT_返回值   := 200803;
    STR_返回信息 := '挂号订单已关闭';
    GOTO 退出;
  END IF;

  -- 【功能处理】
  BEGIN
  
    -- 更新预约单
    UPDATE 门诊管理_预约挂号
       SET 去向标志 = '消号'
     WHERE 机构编码 = STR_医院ID
       AND 主键ID = STR_预约单号
       AND (去向标志 = '预约' OR 去向标志 = '占号');
  
    INT_返回值 := SQL%ROWCOUNT;
    IF INT_返回值 = 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '更新预约单失败！';
      GOTO 退出;
    END IF;
  
    -- 更新订单状态
    UPDATE 互联互通_订单
       SET 订单状态       = '已退款',
           平台退款号     = STR_平台退款单号,
           平台退款流水号 = STR_退款流水号,
           平台退款时间   = DECODE(STR_退款日期,
                             NULL,
                             TO_DATE(TO_CHAR(SYSDATE, 'yyyy-MM-dd'),
                                     'yyyy-MM-dd'),
                             TO_DATE(STR_退款日期 || ' ' || STR_退款时间,
                                     'yyyy-MM-dd hh24:mi:ss')),
           医院退款号     = STR_医院退款单号,
           退款标志       = '1', --成功 平台退款
           更新人         = STR_平台标识,
           更新时间       = SYSDATE
     WHERE 平台标识 = STR_平台标识
       AND 平台订单号 = STR_平台订单号
       AND 关联编码 = STR_预约单号;
  
    INT_返回值 := SQL%ROWCOUNT;
    IF INT_返回值 = 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '更新订单失败！';
      GOTO 退出;
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := STR_返回信息 || SQLERRM;
      GOTO 退出;
  END;

  BEGIN
  
    STR_SQL := 'select ''' || STR_平台退款单号 ||
               ''' as HOSP_REFUND_ID, 
                   ''1'' as REFUND_FLAG from dual';
  
    LOB_响应参数 := FU_互联互通_得到响应参数(STR_SQL, 'RES', '');
    INT_返回值   := 0;
    STR_返回信息 := '交易成功';
  
  END;

  COMMIT;
  RETURN;

  --【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  -- 【保存日志】
  PR_互联互通_操作日志(STR_平台标识 => STR_平台标识,
               STR_医院编码 => STR_医院ID,
               STR_功能编码 => STR_功能编码,
               STR_请求参数 => STR_请求参数,
               DAT_请求时间 => SYSDATE,
               INT_返回值   => INT_返回值,
               STR_返回信息 => STR_返回信息,
               DAT_执行时间 => SYSDATE);

  ROLLBACK;
  RETURN;

END PR_互联互通_退款挂号;
/

prompt
prompt Creating procedure PR_互联互通_系统订单查询
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_系统订单查询(STR_请求参数 IN VARCHAR2,
                                           STR_平台标识 IN VARCHAR2,
                                           STR_功能编码 IN VARCHAR2,
                                           LOB_响应参数 OUT CLOB,
                                           INT_返回值   OUT INTEGER,
                                           STR_返回信息 OUT VARCHAR2) IS

  --【请求参数】
  STR_医院ID       VARCHAR2(50);
  STR_记账日期     VARCHAR2(50);
  STR_账单类型     VARCHAR2(50);
  STR_页码数       VARCHAR2(50);
  STR_每页记录条数 VARCHAR2(50);

  STR_SQL1 VARCHAR2(1000);
  STR_SQL2 VARCHAR2(1000);
  STR_SQL  VARCHAR2(3000);

BEGIN
  BEGIN
    --【请求参数解析】
    STR_医院ID       := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
    STR_记账日期     := FU_互联互通_节点值(STR_请求参数, 'BILL_DATE');
    STR_账单类型     := FU_互联互通_节点值(STR_请求参数, 'BILL_TYPE'); --1所有 2支付  3退款
    STR_页码数       := FU_互联互通_节点值(STR_请求参数, 'PAGE_CURRENT');
    STR_每页记录条数 := FU_互联互通_节点值(STR_请求参数, 'PAGE_SIZE');
  
    IF STR_记账日期 IS NULL OR FU_尝试转日期(STR_记账日期) IS NULL THEN
      INT_返回值   := 0;
      STR_返回信息 := '请输入正确的记账日期';
      GOTO 退出;
    END IF;
  
    STR_SQL1 := 'select ''1'' as BUSS_TYPE,
                       t.医院支付号 as TRADE_ORDER_NO,
                       t.平台订单号 as ORDER_NO_12320,
                       t.平台交易流水号 as TRANSACTION_ID,
                       t.支付渠道 as TRADE_CHANNEL_ID,
                       t.实付金额 as TRADE_AMOUNT,
                       t.平台交易时间 as TRADE_TIME,
                       ''1'' as FEE_TYPE
                  from 互联互通_订单 t
                 where t.订单状态 = ''已支付'' and to_date(t.平台交易时间,''yyyy-MM-dd'')=to_date(''' ||
                STR_记账日期 || ''',''yyyy-MM-dd'')';
  
    STR_SQL2 := 'select ''2'' as BUSS_TYPE,
                       t.医院退款号 as TRADE_ORDER_NO,
                       t.平台订单号 as ORDER_NO_12320,
                       t.平台退款流水号 as TRANSACTION_ID,
                       t.支付渠道 as TRADE_CHANNEL_ID,
                       t.退款金额 as TRADE_AMOUNT,
                       t.平台退款时间 as TRADE_TIME,
                       ''1'' as FEE_TYPE
                  from 互联互通_订单 t
                 where t.订单状态 = ''已退款'' and to_date(t.平台退款时间,''yyyy-MM-dd'')=to_date(''' ||
                STR_记账日期 || ''',''yyyy-MM-dd'')';
    IF STR_账单类型 = '2' THEN
      STR_SQL := STR_SQL1;
    ELSIF STR_账单类型 = '3' THEN
      STR_SQL := STR_SQL2;
    ELSE
      STR_SQL := STR_SQL1 || ' union all ' || STR_SQL2;
    END IF;
  
    LOB_响应参数 := FU_互联互通_得到响应参数(STR_SQL, 'RES', 'ORDER_LIST');
  
    IF DBMS_LOB.GETLENGTH(LOB_响应参数) > 0 THEN
    
      INT_返回值   := 0;
      STR_返回信息 := '交易成功';
    ELSE
      INT_返回值   := 900301;
      STR_返回信息 := '未查询到数据';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '响应请求报错:' || SQLERRM;
      GOTO 退出;
    
  END;

  <<退出>>
-- 【保存日志】
  PR_互联互通_操作日志(STR_平台标识 => STR_平台标识,
               STR_医院编码 => STR_医院ID,
               STR_功能编码 => STR_功能编码,
               STR_请求参数 => STR_请求参数,
               DAT_请求时间 => SYSDATE,
               INT_返回值   => INT_返回值,
               STR_返回信息 => STR_返回信息,
               DAT_执行时间 => SYSDATE);

  RETURN;

END PR_互联互通_系统订单查询;
/

prompt
prompt Creating procedure PR_互联互通_医生查询
prompt ===============================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_医生查询(STR_请求参数 IN VARCHAR2,
                                         STR_平台标识 IN VARCHAR2,
                                         STR_功能编码 IN VARCHAR2,
                                         LOB_响应参数 OUT CLOB,
                                         INT_返回值   OUT INTEGER,
                                         STR_返回信息 OUT VARCHAR2) IS

  --【请求参数】
  STR_医院ID VARCHAR2(50);
  STR_科室ID VARCHAR2(50);
  STR_医生ID VARCHAR2(50);

  STR_SQL VARCHAR2(2000);

BEGIN
  BEGIN
    --【请求参数解析】  
    STR_医院ID := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
    STR_科室ID := FU_互联互通_节点值(STR_请求参数, 'DEPT_ID'); --  -1查询所有科室
    STR_医生ID := FU_互联互通_节点值(STR_请求参数, 'DOCTOR_ID'); --  -1查询科室下所有医生
  
    IF STR_科室ID IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '科室ID不能为空';
      GOTO 退出;
    END IF;
    IF STR_医生ID IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '医生ID不能为空';
      GOTO 退出;
    END IF;
  
    IF STR_科室ID <> '-1' THEN
      SELECT COUNT(1)
        INTO INT_返回值
        FROM 门诊管理_门诊一周排班表
       WHERE 机构编码 = STR_医院ID
         AND 科室编码 = STR_科室ID;
    
      IF INT_返回值 = 0 THEN
        INT_返回值   := 200201;
        STR_返回信息 := '科室不存在';
        GOTO 退出;
      END IF;
    END IF;
  
    --【业务响应SQL】
    STR_SQL := 'select tt.科室编码 as DEPT_ID,
                       t.人员编码  as DOCTOR_ID,
                       t.人员姓名  as "NAME",
                       t.身份证号  as IDCARD,
                       t.个人简介  as "DESC",
                       t.专科特长1 as SPECIAL,
                       t.职称 as JOB_TITLE,
                       (select a.诊查费*100 from 基础项目_挂号类型 a where a.类型编码=(select b.挂号类型编码 from 门诊管理_门诊一周排班表 b where b.医生编码=t.人员编码 and rownum=1)) as REG_FEE,    
                       decode(t.有效状态,''有效'',''1'',''2'') as STATUS,
                       t.性别代码 as SEX,
                       to_char(t.出生日期,''yyyy-MM-dd'') as BIRTHDAY,
                       t.手机号码 as MOBILE,
                       t.办公室电话号码 as TEL       
                  from 基础项目_人员资料 t, 基础项目_人员科室列表 tt
                 where t.人员编码 = tt.人员编码
                   and tt.删除标志 = ''0''
                   and tt.科室编码 in (select t1.科室编码 from 门诊管理_门诊一周排班表 t1)
                   and t.人员编码 in (select t1.医生编码 from 门诊管理_门诊一周排班表 t1)
                   and  t.机构编码=' || STR_医院ID ||
               ' and (tt.科室编码 =' || STR_科室ID || 'or ''-1''=' || STR_科室ID || ') 
                   and (t.人员编码 =' || STR_医生ID || 'or ''-1''=' ||
               STR_医生ID || ')';
  
    LOB_响应参数 := FU_互联互通_得到响应参数(STR_SQL    => STR_SQL,
                               STR_根标签 => 'RES',
                               STR_行标签 => 'DOCTOR_LIST');
    IF DBMS_LOB.GETLENGTH(LOB_响应参数) > 0 THEN
      --【添加HOST_ID节点】  
      LOB_响应参数 := FU_互联互通_添加新节点(LOB_响应参数   => LOB_响应参数,
                                STR_添加位置   => 'DOCTOR_LIST',
                                STR_添加节点名 => 'HOST_ID',
                                STR_添加节点值 => STR_医院ID);
    
      INT_返回值   := 0;
      STR_返回信息 := '交易成功';
    ELSE
      INT_返回值   := 200202;
      STR_返回信息 := '医生不存在，未查询到医生记录';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := 99;
      STR_返回信息 := '请求响应错误:' || SQLERRM;
      GOTO 退出;
  END;
  <<退出>>

  -- 【保存日志】
  PR_互联互通_操作日志(STR_平台标识 => STR_平台标识,
               STR_医院编码 => STR_医院ID,
               STR_功能编码 => STR_功能编码,
               STR_请求参数 => STR_请求参数,
               DAT_请求时间 => SYSDATE,
               INT_返回值   => INT_返回值,
               STR_返回信息 => STR_返回信息,
               DAT_执行时间 => SYSDATE);

  RETURN;
END PR_互联互通_医生查询;
/

prompt
prompt Creating procedure PR_互联互通_医生门诊数据查询
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_医生门诊数据查询(STR_请求参数 IN VARCHAR2,
                                             STR_平台标识 IN VARCHAR2,
                                             STR_功能编码 IN VARCHAR2,
                                             LOB_响应参数 OUT CLOB,
                                             INT_返回值   OUT INTEGER,
                                             STR_返回信息 OUT VARCHAR2) IS

  --【请求参数】
  STR_医院ID       VARCHAR2(50);
  STR_病区名称     VARCHAR2(50);
  STR_科室ID       VARCHAR2(50);
  STR_医生ID       VARCHAR2(50);
  STR_数据统计日期 VARCHAR2(50);
  STR_当前页数     VARCHAR2(50);
  STR_每页数量     VARCHAR2(50);

   STR_SQL VARCHAR2(4000);

BEGIN
  BEGIN
    --【请求参数解析】
    STR_医院ID       := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
    STR_病区名称     := FU_互联互通_节点值(STR_请求参数, 'AREA_NAME');
    STR_科室ID       := FU_互联互通_节点值(STR_请求参数, 'DEPT_ID');
    STR_医生ID       := FU_互联互通_节点值(STR_请求参数, 'DOCTOR_ID');
    STR_数据统计日期 := FU_互联互通_节点值(STR_请求参数, 'COUNT_DATE');
    STR_当前页数     := FU_互联互通_节点值(STR_请求参数, 'PAGE_CURRENT');
    STR_每页数量     := FU_互联互通_节点值(STR_请求参数, 'PAGE_SIZE');
  
    IF STR_科室ID IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '科室ID不能为空';
      GOTO 退出;
    END IF;
    IF STR_医生ID IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '医生ID不能为空';
      GOTO 退出;
    END IF;
    IF STR_数据统计日期 IS NULL OR FU_尝试转日期(STR_数据统计日期) IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '请输入有效的统计日期';
      GOTO 退出;
    END IF;
  
    STR_SQL := 'SELECT T.人员编码 AS DOCTOR_ID,                  
                  (SELECT COUNT(1)
                      FROM 门诊管理_预约挂号 A
                     WHERE A.挂号科室编码 = T.科室编码
                       AND A.挂号医生编码 = T.人员编码
                       AND A.机构编码=' || STR_医院ID || '
                       AND A.支付标志 = ''是''
                       AND A.去向标志 = ''预约''
                       AND A.预约时间 = TO_DATE(''' || STR_数据统计日期 ||
               ''', ''yyyy-MM-dd'') + 1) AS NEXT_COUNT,
                  (SELECT COUNT(1)
                      FROM 门诊管理_预约挂号 A
                     WHERE A.挂号科室编码 = T.科室编码
                       AND A.挂号医生编码 = T.人员编码
                       AND A.机构编码=' || STR_医院ID || '
                       AND A.预约时间 = TO_DATE(''' || STR_数据统计日期 ||
               ''', ''yyyy-MM-dd'')) AS BOOK_COUNT,
                  (SELECT COUNT(1)
                      FROM 门诊管理_挂号登记 A
                     WHERE A.挂号科室编码 = T.科室编码
                       AND A.挂号医生编码 = T.人员编码
                       AND A.机构编码=' || STR_医院ID || '
                       AND A.挂号时间 = TO_DATE(''' || STR_数据统计日期 ||
               ''', ''yyyy-MM-dd'')) AS REG_COUNT,
                  (SELECT COUNT(1)
                      FROM 门诊管理_预约挂号 A
                     WHERE A.挂号科室编码 = T.科室编码
                       AND A.挂号医生编码 = T.人员编码
                       AND A.机构编码=' || STR_医院ID || '
                       AND A.支付标志 = ''是''
                       AND A.去向标志 = ''看诊''
                       AND A.预约时间 = TO_DATE(''' || STR_数据统计日期 ||
               ''', ''yyyy-MM-dd'')) AS RECEIVE_BOOK,
                   (SELECT COUNT(1)
                      FROM 门诊管理_挂号登记 A
                     WHERE A.就诊科室编码 = T.科室编码
                       AND A.就诊医生编码 = T.人员编码
                       AND A.机构编码=' || STR_医院ID || '
                       AND A.就诊状态 IN (''正在接诊'', ''完成接诊'')
                       AND A.挂号时间 = TO_DATE(''' || STR_数据统计日期 ||
               ''', ''yyyy-MM-dd'')) AS RECEIVE_REG
              FROM 基础项目_人员科室列表 T
             WHERE  T.机构编码=''' || STR_医院ID ||
               ''' AND T.删除标志 = ''0''
             AND T.科室编码=' || STR_科室ID || ' AND (人员编码=
             ' || STR_医生ID || ' OR ''-1''=' || STR_医生ID || ')';
  
    LOB_响应参数 := fu_互联互通_得到响应参数(STR_SQL, 'RES', 'DOCTOR_INFO');
    IF DBMS_LOB.GETLENGTH(LOB_响应参数) > 0 THEN
    
      select count(1)
        into INT_返回值
        FROM 基础项目_人员科室列表 T
       WHERE T.机构编码 = STR_医院ID
         AND T.删除标志 = '0'
         AND T.科室编码 = STR_科室ID
         AND (人员编码 = STR_医生ID OR STR_医生ID = '-1');
    
      LOB_响应参数 := fu_互联互通_添加新节点(LOB_响应参数,
                                'DOCTOR_INFO',
                                'COUNT',
                                INT_返回值);
    
      INT_返回值   := 0;
      STR_返回信息 := '交易成功';
    ELSE
      INT_返回值   := 202001;
      STR_返回信息 := '未查询到医生记录';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '响应请求报错:' || SQLERRM;
      GOTO 退出;
  END;

  <<退出>>

  -- 【保存日志】
  PR_互联互通_操作日志(STR_平台标识 => STR_平台标识,
               STR_医院编码 => STR_医院ID,
               STR_功能编码 => STR_功能编码,
               STR_请求参数 => STR_请求参数,
               DAT_请求时间 => SYSDATE,
               INT_返回值   => INT_返回值,
               STR_返回信息 => STR_返回信息,
               DAT_执行时间 => SYSDATE);
  RETURN;

END PR_互联互通_医生门诊数据查询;
/

prompt
prompt Creating procedure PR_互联互通_医院信息查询
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_医院信息查询(STR_请求参数 IN VARCHAR2,
                                           STR_平台标识 IN VARCHAR2,
                                           STR_功能编码 IN VARCHAR2,
                                           LOB_响应参数 OUT CLOB,
                                           INT_返回值   OUT INTEGER,
                                           STR_返回信息 OUT VARCHAR2) IS

  STR_SQL          VARCHAR2(1000);
  STR_医院ID       VARCHAR2(50);
  INT_最大预约天数 INTEGER;

BEGIN
  BEGIN
  
    STR_医院ID := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
  
    --【获取最大预约天数】
    BEGIN
      SELECT 值
        INTO INT_最大预约天数
        FROM 基础项目_机构参数列表
       WHERE 参数编码＝ '910540'
         AND 机构编码 = STR_医院ID
         and 删除标志 = '0';
    EXCEPTION
      WHEN OTHERS THEN
        INT_最大预约天数 := 15;
    END;
  
    --【业务响应SQL】
    STR_SQL := 'select 机构编码 as HOS_ID,
                      机构名称 as "NAME",
                      ''营口二院'' as SHORT_NAME, 
                      机构地址 as ADDRESS,
                      联系电话 as TEL,
                      '''' as WEBSITE,
                      '''' as WEIBO,
                      ''2'' as "LEVEL",
                      '''' as "DESC",
                      '''' as SPECIAL,
                      '''' as LONGITUDE,
                      '''' as LATITUDE,
                      ' || INT_最大预约天数 ||
               ' as MAX_REG_DAYS,
                      '''' as START_REG_TIME,
                      '''' as END_REG_TIME,
                      '''' as STOP_BOOK_TIMEA,
                      '''' as STOP_BOOK_TIMEP                      
               from 基础项目_机构资料 where 机构编码=' || STR_医院ID;
  
    LOB_响应参数 := FU_互联互通_得到响应参数(STR_SQL    => STR_SQL,
                               STR_根标签 => 'RES',
                               STR_行标签 => '');
    IF DBMS_LOB.GETLENGTH(LOB_响应参数) > 0 THEN
      INT_返回值   := 0;
      STR_返回信息 := '交易成功';
    ELSE
      INT_返回值   := 100401;
      STR_返回信息 := '医院不存在，未查询到医院信息记录';
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
               STR_医院编码 => STR_医院ID,
               STR_功能编码 => STR_功能编码,
               STR_请求参数 => STR_请求参数,
               DAT_请求时间 => SYSDATE,
               INT_返回值   => INT_返回值,
               STR_返回信息 => STR_返回信息,
               DAT_执行时间 => SYSDATE);

  RETURN;
END PR_互联互通_医院信息查询;
/

prompt
prompt Creating procedure PR_互联互通_用户卡验证
prompt ================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_用户卡验证(STR_请求参数 IN VARCHAR2,
                                          LOB_响应参数 OUT CLOB,
                                          RES_CODE     OUT INTEGER,
                                          RES_MSG      OUT VARCHAR2) IS

  STR_SQL            VARCHAR2(1000);
  STR_机构编码       VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
  STR_用户ID         VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数,'HOSP_PATIENT_ID');
  STR_证件类型       VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'ID_TYPE');
  STR_证件号码       VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'ID_NO');
  STR_卡类型         VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'CARD_TYPE');
  STR_卡号           VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'CARD_NO');
  STR_姓名           VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'NAME');
  STR_性别           VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'SEX');
  STR_出生日期       VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'BIRTHDAY');
  STR_监护人证件类型 VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'PARENT_ID_TYPE');
  STR_监护人证件号码 VARCHAR2(50) := FU_互联互通_节点值(STR_请求参数, 'PARENT_ID_CARD');
BEGIN
  BEGIN
  
    IF DBMS_LOB.GETLENGTH(LOB_响应参数) > 0 THEN
    
      RES_CODE := 0;
      RES_MSG  := '交易成功';
    ELSE
      RES_CODE := 200101;
      RES_MSG  := '科室不存在，未查询到科室记录';
    END IF;
  
  END;

END PR_互联互通_用户卡验证;
/

prompt
prompt Creating procedure PR_互联互通_用户信息查询
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_用户信息查询(STR_请求参数 IN VARCHAR2,
                                           STR_平台标识 IN VARCHAR2,
                                           STR_功能编码 IN VARCHAR2,
                                           LOB_响应参数 OUT CLOB,
                                           INT_返回值   OUT INTEGER,
                                           STR_返回信息 OUT VARCHAR2) IS

  --【请求参数】
  STR_医院ID         VARCHAR2(50);
  STR_用户ID         VARCHAR2(50);
  STR_用户证件类型   VARCHAR2(50);
  STR_用户证件号码   VARCHAR2(50);
  STR_用户姓名       VARCHAR2(50);
  STR_用户性别       VARCHAR2(50);
  STR_用户出生日期   VARCHAR2(50);
  STR_监护人证件类型 VARCHAR2(50);
  STR_监护人证件号码 VARCHAR2(50);

  --【业务参数】
  STR_SQL          VARCHAR2(1000);
  STR_用户注册时间 VARCHAR2(50);
  DAT_系统时间     DATE;

BEGIN
  BEGIN
    --【请求参数解析】
    STR_医院ID         := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
    STR_用户ID         := FU_互联互通_节点值(STR_请求参数, 'HOSP_PATIENT_ID');
    STR_用户证件类型   := FU_互联互通_节点值(STR_请求参数, 'ID_TYPE');
    STR_用户证件号码   := FU_互联互通_节点值(STR_请求参数, 'ID_NO');
    STR_用户姓名       := FU_互联互通_节点值(STR_请求参数, 'NAME');
    STR_用户性别       := FU_互联互通_节点值(STR_请求参数, 'SEX');
    STR_用户出生日期   := FU_互联互通_节点值(STR_请求参数, 'BIRTHDAY');
    STR_监护人证件类型 := FU_互联互通_节点值(STR_请求参数, 'PARENT_ID_TYPE');
    STR_监护人证件号码 := FU_互联互通_节点值(STR_请求参数, 'PARENT_ID_CARD');
  
    --【获取系统时间】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
  
    --【信息验证】
    --1.姓名
    IF STR_用户姓名 IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请输入姓名！';
      GOTO 退出;
    END IF;
    --2.性别
    IF STR_用户性别 IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请输入性别！';
      GOTO 退出;
    END IF;
    --3.出生日期
    IF STR_用户出生日期 IS NULL OR FU_尝试转日期(STR_用户出生日期) IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请输入有效的出生日期！';
      GOTO 退出;
    END IF;
  
    --【判断用户是否存在 并获取用户ID】
  
    SELECT COUNT(1)
      INTO INT_返回值
      FROM 互联互通_用户信息 B
     WHERE B.医院编码 = STR_医院ID
       AND B.平台标识 = STR_平台标识
       AND (B.病人ID = STR_用户ID OR STR_用户ID IS NULL)
       AND B.姓名 = STR_用户姓名
       AND B.性别 = STR_用户性别
       AND B.出生日期 = TO_DATE(STR_用户出生日期, 'yyyy-MM-dd')
       AND (B.监护人证件号码 = STR_监护人证件号码 OR B.证件号码 = STR_用户证件号码)
       AND ROWNUM = 1;
  
    IF INT_返回值 = 0 THEN
      INT_返回值   := 100301;
      STR_返回信息 := '用户未在医院注册';
      GOTO 退出;
    END IF;
  
    SELECT B.病人ID, TO_CHAR(B.创建时间, 'yyyy-MM-dd hh24:mi:ss')
      INTO STR_用户ID, STR_用户注册时间
      FROM 互联互通_用户信息 B
     WHERE B.医院编码 = STR_医院ID
       AND B.平台标识 = STR_平台标识
       AND (B.病人ID = STR_用户ID OR STR_用户ID IS NULL)
       AND B.姓名 = STR_用户姓名
       AND B.性别 = STR_用户性别
       AND B.出生日期 = TO_DATE(STR_用户出生日期, 'yyyy-MM-dd')
       AND (B.监护人证件号码 = STR_监护人证件号码 OR B.证件号码 = STR_用户证件号码)
       AND ROWNUM = 1;
  
    STR_SQL := 'select 病人ID as HOSP_PATIENT_ID,
                  '''' as HOSP_PATIENT_ID,
                  ''99'' as CARD_TYPE,
                  病人ID as CARD_NO,
                  ''0'' as CARD_STATUS,
                  '''' as CARD_TIME,
                  '''' as LAST_TIME,
                  手机号码 as MOBILE,
                  联系地址 as ADDRESS                 
   from 互联互通_用户信息 where 医院编码=' || STR_医院ID || ' and 平台标识=' ||
               STR_平台标识 || ' and 病人ID =' || STR_用户ID;
  
    LOB_响应参数 := FU_互联互通_得到响应参数(STR_SQL    => STR_SQL,
                               STR_根标签 => 'RES',
                               STR_行标签 => 'CARD_INFO');
    IF DBMS_LOB.GETLENGTH(LOB_响应参数) > 0 THEN
      --【添加CREATE_TIME节点】
      LOB_响应参数 := FU_互联互通_添加新节点(LOB_响应参数   => LOB_响应参数,
                                STR_添加位置   => 'CARD_INFO',
                                STR_添加节点名 => 'CREATE_TIME',
                                STR_添加节点值 => STR_用户注册时间);
    
      INT_返回值   := 0;
      STR_返回信息 := '交易成功';
    ELSE
      INT_返回值   := 100301;
      STR_返回信息 := '用户未在医院注册';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := 99;
      STR_返回信息 := '请求响应错误' || SQLERRM;
      GOTO 退出;
  END;

  <<退出>>

  -- 【保存日志】
  PR_互联互通_操作日志(STR_平台标识 => STR_平台标识,
               STR_医院编码 => STR_医院ID,
               STR_功能编码 => STR_功能编码,
               STR_请求参数 => STR_请求参数,
               DAT_请求时间 => DAT_系统时间,
               INT_返回值   => INT_返回值,
               STR_返回信息 => STR_返回信息,
               DAT_执行时间 => SYSDATE);

  RETURN;

END PR_互联互通_用户信息查询;
/

prompt
prompt Creating procedure PR_互联互通_用户信息注册
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_用户信息注册(STR_请求参数 IN VARCHAR2,
                                           STR_平台标识 IN VARCHAR2,
                                           STR_功能编码 IN VARCHAR2,
                                           LOB_响应参数 OUT CLOB,
                                           INT_返回值   OUT INTEGER,
                                           STR_返回信息 OUT VARCHAR2) IS

  --【请求参数】
  STR_医院ID         VARCHAR2(50);
  STR_证件类型       VARCHAR2(50);
  STR_证件号码       VARCHAR2(50);
  STR_发证日期       VARCHAR2(50);
  STR_有效日期       VARCHAR2(50);
  STR_卡类型         VARCHAR2(50);
  STR_卡号           VARCHAR2(50);
  STR_姓名           VARCHAR2(50);
  STR_性别           VARCHAR2(50);
  STR_出生日期       VARCHAR2(50);
  STR_手机号码       VARCHAR2(50);
  STR_地址           VARCHAR2(50);
  STR_监护人证件类型 VARCHAR2(50);
  STR_监护人证件号码 VARCHAR2(50);
  STR_监护人姓名     VARCHAR2(50);

  --【业务参数】
  STR_SQL      VARCHAR2(1000);
  STR_病人ID   VARCHAR2(50);
  DAT_系统时间 DATE;
BEGIN
  BEGIN
    --【请求参数解析】
    STR_医院ID         := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
    STR_证件类型       := FU_互联互通_节点值(STR_请求参数, 'ID_TYPE');
    STR_证件号码       := FU_互联互通_节点值(STR_请求参数, 'ID_NO');
    STR_发证日期       := FU_互联互通_节点值(STR_请求参数, 'ID_ISSUE_DATE');
    STR_有效日期       := FU_互联互通_节点值(STR_请求参数, 'ID_EFFECT_DATE');
    STR_卡类型         := FU_互联互通_节点值(STR_请求参数, 'CARD_TYPE');
    STR_卡号           := FU_互联互通_节点值(STR_请求参数, 'CARD_NO');
    STR_姓名           := FU_互联互通_节点值(STR_请求参数, 'NAME');
    STR_性别           := FU_互联互通_节点值(STR_请求参数, 'SEX');
    STR_出生日期       := FU_互联互通_节点值(STR_请求参数, 'BIRTHDAY');
    STR_手机号码       := FU_互联互通_节点值(STR_请求参数, 'MOBILE');
    STR_地址           := FU_互联互通_节点值(STR_请求参数, 'ADDRESS');
    STR_监护人证件类型 := FU_互联互通_节点值(STR_请求参数, 'PARENT_ID_TYPE');
    STR_监护人证件号码 := FU_互联互通_节点值(STR_请求参数, 'PARENT_ID_CARD');
    STR_监护人姓名     := FU_互联互通_节点值(STR_请求参数, 'PARENT_NAME');
  
    --【获取DAT_系统时间】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
  
    --【信息验证】
    --1.姓名
    IF STR_姓名 IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请输入姓名！';
      GOTO 退出;
    END IF;
    --2.性别
    IF STR_性别 IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请输入性别！';
      GOTO 退出;
    END IF;
    --3.手机号码
    IF STR_手机号码 IS NULL OR FU_互联互通_验证手机号(STR_手机号码) <> 0 THEN
      INT_返回值   := 1;
      STR_返回信息 := '请输入有效的手机号码！';
      GOTO 退出;
    END IF;
    --4.出生日期
    IF STR_出生日期 IS NULL OR FU_尝试转日期(STR_出生日期) IS NULL THEN
      INT_返回值   := 1;
      STR_返回信息 := '请输入有效的出生日期！';
      GOTO 退出;
    END IF;
    --5.证件信息
    IF (STR_证件类型 IS NULL OR STR_证件号码 IS NULL) AND
       (STR_监护人证件类型 IS NULL OR STR_监护人证件号码 IS NULL OR STR_监护人姓名 IS NULL) THEN
      INT_返回值   := 1;
      STR_返回信息 := '请填写用户证件信息或监护人证件信息！';
      GOTO 退出;
    END IF;
  
    IF STR_证件类型 = '1' AND FU_互联互通_验证身份证(STR_证件号码) <> 0 THEN
      STR_返回信息 := '无效的用户身份证号码';
      INT_返回值   := 1;
      GOTO 退出;
    END IF;
    IF STR_监护人证件类型 = '1' AND FU_互联互通_验证身份证(STR_监护人证件号码) <> 0 THEN
      STR_返回信息 := '无效的监护人证件号码';
      INT_返回值   := 1;
      GOTO 退出;
    END IF;
  
    --【验证是否存在该用户】
    SELECT COUNT(1)
      INTO INT_返回值
      FROM 互联互通_用户信息 B
     WHERE B.平台标识 = STR_平台标识
       AND B.医院编码 = STR_医院ID
       AND B.姓名 = STR_姓名
       AND (B.监护人证件号码 = STR_监护人证件号码 OR B.证件号码 = STR_证件号码);
  
    IF INT_返回值 <= 0 THEN
      -- 【生成病人ID】
      PR_获取_系统唯一号(PRM_唯一号编码 => '30',
                  PRM_机构编码   => STR_医院ID,
                  PRM_事物类型   => '1',
                  PRM_返回唯一号 => STR_病人ID,
                  PRM_执行结果   => INT_返回值,
                  PRM_错误信息   => STR_返回信息);
      IF INT_返回值 <> 0 THEN
        INT_返回值   := 99;
        STR_返回信息 := '生成病人ID失败,原因:' + STR_返回信息;
        GOTO 退出;
      END IF;
    
      -- 【插入病人信息】
      INSERT INTO 基础项目_病人信息
        (机构编码,
         病人ID,
         居民编码,
         卡号,
         姓名,
         性别,
         出生日期,
         年龄,
         家庭地址,
         工作单位,
         手机号码,
         固定电话,
         邮政编码,
         民族ID,
         登记时间,
         拼音码,
         五笔码,
         健康档案编码,
         身份证号,
         婚姻状况,
         录入人编码,
         保险个人编码,
         一卡通唯一号,
         农合个人编码,
         医保个人编码,
         城居个人编码,
         公费个人编码,
         离休个人编码,
         公卫体检个人编码,
         自费计生个人编码,
         健康卡号)
      VALUES
        (STR_医院ID,
         STR_病人ID,
         NULL,
         STR_卡号,
         STR_姓名,
         STR_性别,
         TO_DATE(STR_出生日期, 'yyyy-MM-dd'),
         TO_CHAR(FU_得到_年龄_精确年(TO_DATE(STR_出生日期, 'yyyy-MM-dd'))),
         STR_地址,
         NULL,
         STR_手机号码,
         NULL,
         NULL,
         NULL,
         SYSDATE,
         FU_通用_汉字_转换_首拼(STR_姓名),
         FU_通用_汉字_转换_五笔(STR_姓名),
         NULL,
         STR_证件号码,
         NULL,
         STR_医院ID,
         NULL,
         NULL,
         NULL,
         NULL,
         NULL,
         NULL,
         NULL,
         NULL,
         NULL,
         DECODE(STR_卡类型, '1', STR_卡号, NULL));
    
      -- 【插入病人辅助信息】
      INSERT INTO 基础项目_病人信息_其他
        (机构编码,
         病人ID,
         医保卡号,
         家长姓名,
         职业,
         显示信息,
         籍贯,
         学校,
         病人类别,
         监护人姓名,
         监护人身份证号,
         监护人手机号码,
         监护人联系地址,
         病人来源)
      VALUES
        (STR_医院ID,
         STR_病人ID,
         NULL,
         NULL,
         NULL,
         NULL,
         NULL,
         NULL,
         NULL,
         STR_监护人姓名,
         STR_监护人证件号码,
         NULL,
         NULL,
         '1');
    
    ELSE
      INT_返回值   := 100202;
      STR_返回信息 := '院内多个用户档案，请先联系医院处理';
    END IF;
  
    -- 【注册病人信息】
    INSERT INTO 互联互通_用户信息
      (流水码,
       平台标识,
       医院编码,
       病人ID,
       用户类别,
       姓名,
       性别,
       出生日期,
       证件类型,
       证件号码,
       证件发证日期,
       证件有效日期,
       手机号码,
       联系地址,
       监护人姓名,
       监护人证件类型,
       监护人证件号码,
       用户卡类型,
       用户卡号,
       创建人,
       创建时间)
    VALUES
      (SEQ_互联互通_用户信息_流水码.NEXTVAL,
       STR_平台标识,
       STR_医院ID,
       STR_病人ID,
       NULL,
       STR_姓名,
       STR_性别,
       TO_DATE(STR_出生日期, 'yyyy-MM-dd'),
       STR_证件类型,
       STR_证件号码,
       STR_发证日期,
       STR_有效日期,
       STR_手机号码,
       STR_地址,
       STR_监护人姓名,
       STR_监护人证件类型,
       STR_监护人证件号码,
       STR_卡类型,
       STR_卡号,
       STR_平台标识,
       DAT_系统时间);
  
    -- 【正常退出】   
    STR_SQL := 'SELECT ''' || STR_病人ID || ''' AS HOSP_PATIENT_ID, 
             ''' || STR_卡类型 || ''' AS CARD_TYPE, 
             ''' || STR_卡号 || ''' AS CARD_NO,
             '''' as HOSP_MEDICAL_NUM
      FROM DUAL';
  
    LOB_响应参数 := FU_互联互通_得到响应参数(STR_SQL    => STR_SQL,
                               STR_根标签 => 'RES',
                               STR_行标签 => '');
    INT_返回值   := 0;
    STR_返回信息 := '交易成功';
  
    COMMIT;
    RETURN;
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := 99;
      STR_返回信息 := '响应请求报错:' || SQLERRM;
      GOTO 退出;
  END;

  <<退出>>

  -- 【保存日志】
  PR_互联互通_操作日志(STR_平台标识 => STR_平台标识,
               STR_医院编码 => STR_医院ID,
               STR_功能编码 => STR_功能编码,
               STR_请求参数 => STR_请求参数,
               DAT_请求时间 => DAT_系统时间,
               INT_返回值   => INT_返回值,
               STR_返回信息 => STR_返回信息,
               DAT_执行时间 => SYSDATE);

  ROLLBACK;
  RETURN;

END PR_互联互通_用户信息注册;
/

prompt
prompt Creating procedure PR_互联互通_预挂号
prompt ==============================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_预挂号(STR_请求参数 IN VARCHAR2,
                                        STR_平台标识 IN VARCHAR2,
                                        STR_功能编码 IN VARCHAR2,
                                        LOB_响应参数 OUT CLOB,
                                        INT_返回值   OUT INTEGER,
                                        STR_返回信息 OUT VARCHAR2) IS
  --【请求参数】
  STR_平台订单号       VARCHAR2(50);
  STR_病人ID           VARCHAR2(50);
  STR_挂号渠道ID       VARCHAR2(50);
  STR_是否为预约挂号   VARCHAR2(50);
  STR_班次标识         VARCHAR2(50);
  STR_排班类别         VARCHAR2(50);
  STR_医院ID           VARCHAR2(50);
  STR_科室ID           VARCHAR2(50);
  STR_医生ID           VARCHAR2(50);
  STR_出诊日期         VARCHAR2(50);
  STR_时段             VARCHAR2(50);
  STR_分时开始时间     VARCHAR2(50);
  STR_分时结束时间     VARCHAR2(50);
  STR_挂号费用         VARCHAR2(50);
  STR_诊疗费用         VARCHAR2(50);
  STR_挂号类型         VARCHAR2(50);
  STR_患者证件类型     VARCHAR2(50);
  STR_患者证件号码     VARCHAR2(50);
  STR_患者卡类型       VARCHAR2(50);
  STR_患者卡号         VARCHAR2(50);
  STR_患者姓名         VARCHAR2(50);
  STR_患者性别         VARCHAR2(50);
  STR_患者出生日期     VARCHAR2(50);
  STR_患者所在地       VARCHAR2(50);
  STR_患者手机号码     VARCHAR2(50);
  STR_挂号人证件类型   VARCHAR2(50);
  STR_挂号人身份证号码 VARCHAR2(50);
  STR_挂号人姓名       VARCHAR2(50);
  STR_挂号人手机号码   VARCHAR2(50);
  STR_座席工号         VARCHAR2(50);
  STR_下单时间         VARCHAR2(50);

  --【业务参数】
  STR_SQL      VARCHAR2(1000);
  STR_预约单号 VARCHAR2(50);
  STR_婚姻状况 VARCHAR2(50);
  STR_家庭地址 VARCHAR2(50);
  STR_工作单位 VARCHAR2(50);

  NUM_挂号费   NUMBER(18, 3);
  NUM_诊查费   NUMBER(18, 3);
  STR_归类编码 VARCHAR2(50);
  NUM_应付金额 NUMBER(18, 3);

  STR_排班记录ID   VARCHAR2(50);
  DAT_排班日期     DATE;
  STR_挂号科室编码 VARCHAR2(50);
  STR_挂号科室名称 VARCHAR2(50);
  STR_挂号科室位置 VARCHAR2(50);
  STR_挂号医生编码 VARCHAR2(50);
  STR_挂号医生姓名 VARCHAR2(50);
  STR_挂号类型编码 VARCHAR2(50);
  STR_挂号类型名称 VARCHAR2(50);
  STR_预约时段编码 VARCHAR2(50);
  STR_预约时段开始 VARCHAR2(50);
  STR_预约时段结束 VARCHAR2(50);

  DAT_订单过期时间 DATE;
  DAT_系统时间     DATE;
  STR_订单号       VARCHAR2(50);
  STR_订单备注     VARCHAR2(50);

  STR_用户姓名     VARCHAR2(50);
  STR_用户性别     VARCHAR2(50);
  STR_用户出生日期 VARCHAR2(50);
  STR_用户身份证号 VARCHAR2(50);

BEGIN
  BEGIN
  
    --【请求参数解析】
    STR_平台订单号       := FU_互联互通_节点值(STR_请求参数, 'ORDER_ID');
    STR_病人ID           := FU_互联互通_节点值(STR_请求参数, 'HOSP_PATIENT_ID');
    STR_挂号渠道ID       := FU_互联互通_节点值(STR_请求参数, 'CHANNEL_ID');
    STR_是否为预约挂号   := FU_互联互通_节点值(STR_请求参数, 'IS_REG');
    STR_班次标识         := FU_互联互通_节点值(STR_请求参数, 'REG_ID');
    STR_排班类别         := FU_互联互通_节点值(STR_请求参数, 'REG_LEVEL');
    STR_医院ID           := FU_互联互通_节点值(STR_请求参数, 'HOS_ID');
    STR_科室ID           := FU_互联互通_节点值(STR_请求参数, 'DEPT_ID');
    STR_医生ID           := FU_互联互通_节点值(STR_请求参数, 'DOCTOR_ID');
    STR_出诊日期         := FU_互联互通_节点值(STR_请求参数, 'REG_DATE');
    STR_时段             := FU_互联互通_节点值(STR_请求参数, 'TIME_FLAG');
    STR_分时开始时间     := FU_互联互通_节点值(STR_请求参数, 'BEGIN_TIME');
    STR_分时结束时间     := FU_互联互通_节点值(STR_请求参数, 'END_TIME');
    STR_挂号费用         := FU_互联互通_节点值(STR_请求参数, 'REG_FEE');
    STR_诊疗费用         := FU_互联互通_节点值(STR_请求参数, 'TREAT_FEE');
    STR_挂号类型         := FU_互联互通_节点值(STR_请求参数, 'REG_TYPE'); --1本人 2子女 3他人
    STR_患者证件类型     := FU_互联互通_节点值(STR_请求参数, 'IDCARD_TYPE');
    STR_患者证件号码     := FU_互联互通_节点值(STR_请求参数, 'IDCARD_NO');
    STR_患者卡类型       := FU_互联互通_节点值(STR_请求参数, 'CARD_TYPE');
    STR_患者卡号         := FU_互联互通_节点值(STR_请求参数, 'CARD_NO');
    STR_患者姓名         := FU_互联互通_节点值(STR_请求参数, 'NAME');
    STR_患者性别         := FU_互联互通_节点值(STR_请求参数, 'SEX');
    STR_患者出生日期     := FU_互联互通_节点值(STR_请求参数, 'BIRTHDAY');
    STR_患者所在地       := FU_互联互通_节点值(STR_请求参数, 'ADDRESS');
    STR_患者手机号码     := FU_互联互通_节点值(STR_请求参数, 'MOBILE');
    STR_挂号人证件类型   := FU_互联互通_节点值(STR_请求参数, 'OPER_IDCARD_TYPE');
    STR_挂号人身份证号码 := FU_互联互通_节点值(STR_请求参数, 'OPER_IDCARD_NO');
    STR_挂号人姓名       := FU_互联互通_节点值(STR_请求参数, 'OPER_NAME');
    STR_挂号人手机号码   := FU_互联互通_节点值(STR_请求参数, 'OPER_MOBILE');
    STR_座席工号         := FU_互联互通_节点值(STR_请求参数, 'AGENT_ID');
    STR_下单时间         := FU_互联互通_节点值(STR_请求参数, 'ORDER_TIME');
  
    --【验证科室排班信息】
    IF STR_科室ID IS NOT NULL THEN
      SELECT COUNT(1)
        INTO INT_返回值
        FROM 门诊管理_当天排班记录
       WHERE 机构编码 = STR_医院ID
         AND 科室编码 = STR_科室ID
         AND 排班日期 = TO_DATE(STR_出诊日期, 'yyyy-MM-dd');
    
      IF INT_返回值 = 0 THEN
        INT_返回值   := 200706;
        STR_返回信息 := '科室不存在';
        GOTO 退出;
      END IF;
    END IF;
  
    --【验证医生排班信息】
    IF STR_医生ID IS NOT NULL THEN
      SELECT COUNT(1)
        INTO INT_返回值
        FROM 门诊管理_当天排班记录
       WHERE 机构编码 = STR_医院ID
         AND 医生编码 = STR_医生ID
         AND 排班日期 = TO_DATE(STR_出诊日期, 'yyyy-MM-dd');
    
      IF INT_返回值 = 0 THEN
        INT_返回值   := 200707;
        STR_返回信息 := '医生不存在';
        GOTO 退出;
      END IF;
    END IF;
  
    --【验证平台订单号】
    SELECT COUNT(1)
      INTO INT_返回值
      FROM 互联互通_订单
     WHERE 医院编码 = STR_医院ID
       AND 平台标识 = STR_平台标识
       AND 平台订单号 = STR_平台订单号;
  
    IF INT_返回值 > 0 THEN
      INT_返回值   := 200708;
      STR_返回信息 := '平台订单号已存在';
      GOTO 退出;
    END IF;
  
    -- 【获取DAT_系统时间】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
  
    --【读取排班信息】
    BEGIN
      SELECT D.记录ID,
             D.排班日期,
             D.科室编码,
             D.科室名称,
             D.诊室位置,
             D.医生编码,
             D.医生姓名,
             D.挂号类型编码,
             D.挂号类型名称,
             S.时段编码,
             S.开始时间,
             S.结束时间
        INTO STR_排班记录ID,
             DAT_排班日期,
             STR_挂号科室编码,
             STR_挂号科室名称,
             STR_挂号科室位置,
             STR_挂号医生编码,
             STR_挂号医生姓名,
             STR_挂号类型编码,
             STR_挂号类型名称,
             STR_预约时段编码,
             STR_预约时段开始,
             STR_预约时段结束
        FROM 门诊管理_日排班时段表 S, 门诊管理_当天排班记录 D
       WHERE S.机构编码 = D.机构编码
         AND S.排班序号 = D.排班序号
         AND S.记录ID = D.记录ID
         AND D.机构编码 = STR_医院ID
         AND S.日班次标识 = STR_班次标识
         AND TO_DATE(TO_CHAR(D.排班日期, 'yyyy-MM-dd'), 'yyyy-MM-dd') >=
             TO_DATE(TO_CHAR(SYSDATE, 'yyyy-MM-dd'), 'yyyy-MM-dd');
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        INT_返回值   := 200705;
        STR_返回信息 := '无效的排班';
        GOTO 退出;
      WHEN OTHERS THEN
        INT_返回值   := -1;
        STR_返回信息 := '系统异常：' || SQLERRM;
        GOTO 退出;
    END;
    --【读取排班信息结束】
  
    --【读取挂号类型信息】
    BEGIN
      SELECT 类型编码, 类型名称, 挂号费, 诊查费, 归类编码
        INTO STR_挂号类型编码,
             STR_挂号类型名称,
             NUM_挂号费,
             NUM_诊查费,
             STR_归类编码
        FROM 基础项目_挂号类型
       WHERE 机构编码 = STR_医院ID
         AND 类型编码 = STR_挂号类型编码
         AND 有效状态 = '有效'
         AND 删除标志 = '0';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        INT_返回值   := -1;
        STR_返回信息 := '未找到有效的挂号类型！';
        GOTO 退出;
      WHEN OTHERS THEN
        INT_返回值   := 99;
        STR_返回信息 := '系统异常：' || SQLERRM;
        GOTO 退出;
    END;
    --【读取挂号类型信息结束】
  
    IF TO_NUMBER(STR_挂号费用) <> NUM_挂号费 OR TO_NUMBER(STR_诊疗费用) <> NUM_诊查费 THEN
      INT_返回值   := 1;
      STR_返回信息 := '挂费用与该排班所需费用不符';
      GOTO 退出;
    END IF;
  
    --【注册或获取病人信息开始】
    BEGIN
    
      --【验证是否存在该用户】
      BEGIN
        SELECT B.病人ID
          INTO STR_病人ID
          FROM 互联互通_用户信息 B
         WHERE B.平台标识 = STR_平台标识
           AND B.医院编码 = STR_医院ID
           AND (B.病人ID = STR_病人ID OR STR_病人ID IS NULL)
           AND B.姓名 = STR_患者姓名
           AND (B.监护人证件号码 = STR_挂号人身份证号码 OR B.证件号码 = STR_患者证件号码);
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          INT_返回值 := 0;
        WHEN OTHERS THEN
          INT_返回值   := 1;
          STR_返回信息 := '系统异常：' || SQLERRM;
          GOTO 退出;
      END;
    
      --2. 病人ID不存在或为NULL时 需注册
      IF INT_返回值 = 0 OR STR_病人ID IS NULL THEN
        PR_获取_系统唯一号(PRM_唯一号编码 => '30',
                    PRM_机构编码   => STR_医院ID,
                    PRM_事物类型   => '1',
                    PRM_返回唯一号 => STR_病人ID,
                    PRM_执行结果   => INT_返回值,
                    PRM_错误信息   => STR_返回信息);
      
        IF INT_返回值 <> 0 THEN
          INT_返回值   := 1;
          STR_返回信息 := '获取病人ID失败';
          GOTO 退出;
        END IF;
      
        --【信息验证】
        --1.姓名
        IF STR_患者姓名 IS NULL THEN
          INT_返回值   := 1;
          STR_返回信息 := '请输入姓名！';
          GOTO 退出;
        END IF;
        --2.性别
        IF STR_患者性别 IS NULL THEN
          INT_返回值   := 1;
          STR_返回信息 := '请输入性别！';
          GOTO 退出;
        END IF;
        --3.手机号码
        IF STR_患者手机号码 IS NULL OR FU_互联互通_验证手机号(STR_患者手机号码) <> 0 THEN
          INT_返回值   := 1;
          STR_返回信息 := '请输入有效的手机号码！';
          GOTO 退出;
        END IF;
        --4.出生日期
        IF STR_患者出生日期 IS NULL OR FU_尝试转日期(STR_患者出生日期) IS NULL THEN
          INT_返回值   := 1;
          STR_返回信息 := '请输入有效的出生日期！';
          GOTO 退出;
        END IF;
        --5.证件信息
        IF STR_挂号类型 = '2' THEN
          --子女
          IF STR_挂号人身份证号码 IS NULL OR FU_互联互通_验证身份证(STR_挂号人身份证号码) <> 0 THEN
            INT_返回值   := 1;
            STR_返回信息 := '请正确填写挂号人证件信息！';
            GOTO 退出;
          END IF;
        ELSE
          --本人或其他
          IF STR_患者证件号码 IS NULL OR FU_互联互通_验证身份证(STR_患者证件号码) <> 0 THEN
            INT_返回值   := 1;
            STR_返回信息 := '请正确填写患者证件信息！';
            GOTO 退出;
          END IF;
        END IF;
      
        -- 2.1. 插入病人基本信息
        INSERT INTO 基础项目_病人信息
          (机构编码,
           病人ID,
           卡号,
           姓名,
           性别,
           出生日期,
           年龄,
           家庭地址,
           手机号码,
           拼音码,
           五笔码,
           登记时间,
           录入人编码,
           身份证号)
        VALUES
          (STR_医院ID,
           STR_病人ID,
           STR_患者卡号,
           STR_患者姓名,
           STR_患者性别,
           TO_DATE(STR_患者出生日期, 'yyyy-MM-dd'),
           FU_得到_年龄(TO_DATE(STR_患者出生日期, 'yyyy-MM-dd')),
           STR_患者所在地,
           STR_患者手机号码,
           FU_通用_汉字_转换_首拼(STR_患者姓名),
           FU_通用_汉字_转换_五笔(STR_患者姓名),
           SYSDATE,
           STR_医院ID,
           STR_患者证件号码);
      
        INT_返回值 := SQL%ROWCOUNT;
        IF INT_返回值 = 0 THEN
          INT_返回值   := 200703;
          STR_返回信息 := '用户建档失败';
          GOTO 退出;
        END IF;
      
        --2.2. 插入病人辅助信息
        INSERT INTO 基础项目_病人信息_其他
          (机构编码,
           病人ID,
           监护人姓名,
           监护人身份证号,
           监护人手机号码,
           监护人联系地址,
           病人来源)
        VALUES
          (STR_医院ID,
           STR_病人ID,
           DECODE(STR_挂号类型, '2', STR_挂号人姓名, NULL),
           DECODE(STR_挂号类型, '2', STR_挂号人身份证号码, NULL),
           DECODE(STR_挂号类型, '2', STR_挂号人手机号码, NULL),
           NULL,
           '1');
        INT_返回值 := SQL%ROWCOUNT;
        IF INT_返回值 = 0 THEN
          INT_返回值   := 200703;
          STR_返回信息 := '用户建档失败';
          GOTO 退出;
        END IF;
      
        -- 【注册病人信息】
        INSERT INTO 互联互通_用户信息
          (流水码,
           平台标识,
           医院编码,
           病人ID,
           用户类别,
           姓名,
           性别,
           出生日期,
           证件类型,
           证件号码,
           证件发证日期,
           证件有效日期,
           手机号码,
           联系地址,
           监护人姓名,
           监护人证件类型,
           监护人证件号码,
           用户卡类型,
           用户卡号,
           创建人,
           创建时间)
        VALUES
          (SEQ_互联互通_用户信息_流水码.NEXTVAL,
           STR_平台标识,
           STR_医院ID,
           STR_病人ID,
           STR_挂号类型,
           STR_患者姓名,
           STR_患者性别,
           TO_DATE(STR_患者出生日期, 'yyyy-MM-dd'),
           STR_患者证件类型,
           STR_患者证件号码,
           NULL,
           NULL,
           STR_患者手机号码,
           STR_患者所在地,
           STR_挂号人姓名,
           STR_挂号人证件类型,
           STR_挂号人身份证号码,
           STR_患者卡类型,
           STR_患者卡号,
           STR_平台标识,
           DAT_系统时间);
      
        INT_返回值 := SQL%ROWCOUNT;
        IF INT_返回值 = 0 THEN
          INT_返回值   := 200703;
          STR_返回信息 := '用户建档失败';
          GOTO 退出;
        END IF;
      
      ELSE
      
        --补充病人信息
        SELECT A.姓名, A.性别, A.出生日期, A.证件号码
          INTO STR_用户姓名,
               STR_用户性别,
               STR_用户出生日期,
               STR_用户身份证号
          FROM 互联互通_用户信息 A
         WHERE A.平台标识 = STR_平台标识
           AND A.医院编码 = STR_医院ID
           AND A.病人ID = STR_病人ID;
      
        IF STR_用户姓名 <> STR_患者姓名 OR STR_用户性别 <> STR_患者性别 OR
           STR_用户出生日期 <> STR_患者出生日期 OR
           (STR_患者证件号码 IS NOT NULL AND STR_用户身份证号 <> STR_患者证件号码) THEN
          INT_返回值   := 200711;
          STR_返回信息 := '就诊人身份信息和医院档案不匹配';
          GOTO 退出;
        END IF;
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        INT_返回值   := '200703';
        STR_返回信息 := '用户建档失败';
        GOTO 退出;
    END;
    --【注册或获取病人信息结束】
  
    --【生成订单号】
    PR_获取_系统唯一号(PRM_唯一号编码 => '6001',
                PRM_机构编码   => STR_医院ID,
                PRM_事物类型   => '1',
                PRM_返回唯一号 => STR_订单号,
                PRM_执行结果   => INT_返回值,
                PRM_错误信息   => STR_返回信息);
    IF INT_返回值 <> 0 THEN
      INT_返回值   := 99;
      STR_返回信息 := '产生订单号失败!';
      GOTO 退出;
    END IF;
    -- 【生成金额】
    NUM_应付金额 := STR_挂号费用 + STR_诊疗费用;
  
    -- 【生成过期时间】
    SELECT SYSDATE + (1 / (24 * 60)) * 30 INTO DAT_订单过期时间 FROM DUAL;
  
    -- 【生成订单备注】
    STR_订单备注 := '请在30分钟内完成支付，过期自动取消';
  
    --【生成预约单号】
    SELECT SEQ_门诊管理_预约挂号_唯一ID.NEXTVAL
      INTO STR_预约单号
      FROM DUAL;
  
    BEGIN
    
      -- 插入预约记录
      INSERT INTO 门诊管理_预约挂号
        (机构编码,
         主键ID,
         姓名,
         性别,
         出生日期,
         婚姻状况,
         联系电话,
         家庭地址,
         工作单位,
         身份证号,
         拼音码,
         五笔码,
         挂号科室编码,
         挂号科室名称,
         挂号科室位置,
         挂号医生编码,
         挂号医生姓名,
         挂号类型编码,
         挂号类型名称,
         排序号,
         预约时间,
         去向标志,
         挂号序号,
         病人ID,
         预约类型,
         记录人编码,
         记录时间,
         排班ID,
         支付标志,
         挂号费,
         诊查费,
         归类编码,
         超时时间,
         预约时段编码,
         预约时段开始,
         预约时段结束,
         日班次标识)
      VALUES
        (STR_医院ID,
         STR_预约单号,
         STR_患者姓名,
         STR_患者性别,
         TO_DATE(STR_患者出生日期, 'yyyy-MM-dd'),
         STR_婚姻状况,
         STR_患者手机号码,
         STR_家庭地址,
         STR_工作单位,
         STR_患者证件号码,
         FU_通用_汉字_转换_首拼(STR_患者姓名),
         FU_通用_汉字_转换_五笔(STR_患者姓名),
         STR_挂号科室编码,
         STR_挂号科室名称,
         STR_挂号科室位置,
         STR_挂号医生编码,
         STR_挂号医生姓名,
         STR_挂号类型编码,
         STR_挂号类型名称,
         NULL,
         DAT_排班日期,
         '占号',
         NULL,
         STR_病人ID,
         '网上预约',
         STR_医院ID,
         DAT_系统时间,
         STR_排班记录ID,
         '否',
         NUM_挂号费,
         NUM_诊查费,
         STR_归类编码,
         DAT_订单过期时间,
         STR_预约时段编码,
         TO_DATE(TO_CHAR(DAT_排班日期, 'yyyy-mm-dd') || ' ' || STR_预约时段开始,
                 'yyyy-mm-dd hh24:mi:ss'),
         TO_DATE(TO_CHAR(DAT_排班日期, 'yyyy-mm-dd') || ' ' || STR_预约时段结束,
                 'yyyy-mm-dd hh24:mi:ss'),
         STR_班次标识);
    
      INT_返回值 := SQL%ROWCOUNT;
      IF INT_返回值 = 0 THEN
        INT_返回值   := 99;
        STR_返回信息 := '保存预约记录失败！';
        GOTO 退出;
      END IF;
    
      -- 插入订单
      INSERT INTO 互联互通_订单
        (流水码,
         平台标识,
         医院编码,
         病人ID,
         关联编码,
         平台订单号,
         订单类型,
         平台订单时间,
         医院订单号,
         挂号费用,
         诊疗费用,
         过期时间,
         订单状态,
         挂号类型,
         挂号渠道,
         创建人,
         创建时间,
         更新人,
         更新时间)
      VALUES
        (SEQ_互联互通_订单_流水码.NEXTVAL,
         STR_平台标识,
         STR_医院ID,
         STR_病人ID,
         STR_预约单号,
         STR_平台订单号,
         '预约挂号',
         TO_DATE(STR_下单时间, 'yyyy-MM-dd hh24:mi:ss'),
         STR_订单号,
         TO_NUMBER(STR_挂号费用),
         TO_NUMBER(STR_诊疗费用),
         DAT_订单过期时间,
         '待支付',
         STR_挂号渠道ID,
         STR_挂号类型,
         STR_平台标识,
         DAT_系统时间,
         STR_平台标识,
         DAT_系统时间);
    
      INT_返回值 := SQL%ROWCOUNT;
      IF INT_返回值 = 0 THEN
        INT_返回值   := 99;
        STR_返回信息 := '保存订单失败！';
        GOTO 退出;
      END IF;
    
      -- 插入订单明细
      -- 挂号费
      INSERT INTO 互联互通_订单明细
        (流水码,
         订单号,
         项目编码,
         项目名称,
         数量,
         单位,
         单价,
         总金额,
         归类编码)
      VALUES
        (SEQ_互联互通_订单明细_流水码.NEXTVAL,
         STR_订单号,
         '挂号费',
         '挂号费',
         1,
         '项',
         NUM_挂号费,
         NUM_挂号费,
         STR_归类编码);
    
      INT_返回值 := SQL%ROWCOUNT;
      IF INT_返回值 = 0 THEN
        INT_返回值   := 99;
        STR_返回信息 := '保存订单明细失败！';
        GOTO 退出;
      END IF;
    
      -- 诊查费
      INSERT INTO 平台接口_订单明细
        (流水码,
         订单号,
         项目编码,
         项目名称,
         数量,
         单位,
         单价,
         总金额,
         归类编码)
      VALUES
        (SEQ_互联互通_订单明细_流水码.NEXTVAL,
         STR_订单号,
         '诊查费',
         '诊查费',
         1,
         '项',
         NUM_诊查费,
         NUM_诊查费,
         STR_归类编码);
    
      INT_返回值 := SQL%ROWCOUNT;
      IF INT_返回值 = 0 THEN
        INT_返回值   := 99;
        STR_返回信息 := '保存订单明细失败！';
        GOTO 退出;
      END IF;
    
     
    
    EXCEPTION
      WHEN OTHERS THEN
        INT_返回值   := 99;
        STR_返回信息 := '系统异常：' || SQLERRM;
        GOTO 退出;
      
    END;
  
    STR_SQL      := 'select ''' || STR_订单号 || ''' as HOSP_ORDER_ID,''' ||
                    STR_病人ID || ''' as HOSP_PATIENT_ID,
               '''' as HOSP_SERIAL_NUM,
               '''' as HOSP_MEDICAL_NUM,
               '''' as HOSP_GETREG_DATE,
               '''' as HOSP_SEE_DOCT_ADDR,
               '''' as HOSP_CARD_NO,
               ''' || STR_订单备注 ||
                    ''' as HOSP_REMARK,
               ''0'' as IS_CONCESSIONS
               from dual';
    LOB_响应参数 := FU_互联互通_得到响应参数(STR_SQL, 'RES', '');
  
    INT_返回值   := 0;
    STR_返回信息 := '交易成功';
  
    COMMIT;
    RETURN;
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := 99;
      STR_返回信息 := '系统异常：' || SQLERRM;
      GOTO 退出;
    
  END;

  <<退出>>

  -- 【保存日志】
  PR_互联互通_操作日志(STR_平台标识 => STR_平台标识,
               STR_医院编码 => STR_医院ID,
               STR_功能编码 => STR_功能编码,
               STR_请求参数 => STR_请求参数,
               DAT_请求时间 => DAT_系统时间,
               INT_返回值   => INT_返回值,
               STR_返回信息 => STR_返回信息,
               DAT_执行时间 => SYSDATE);

  ROLLBACK;
  RETURN;

END PR_互联互通_预挂号;
/

prompt
prompt Creating procedure PR_互联互通_总线调用
prompt ===============================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_互联互通_总线调用(STR_功能号   IN VARCHAR2,
                                         STR_请求参数 IN VARCHAR2,
                                         LOB_响应参数 OUT CLOB,
                                         RES_CODE     OUT INTEGER,
                                         RES_MSG      OUT VARCHAR2) IS
  STR_平台标识 VARCHAR2(10) := '12320';
BEGIN
  BEGIN
    IF STR_功能号 = '1001' THEN
      LOB_响应参数 := FU_互联互通_得到响应参数('SELECT SYSDATE FROM DUAL', 'RES', '');
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
      PR_互联互通_用户卡验证(STR_请求参数, LOB_响应参数, RES_CODE, RES_MSG);
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
      PR_互联互通_号源锁定(STR_请求参数, LOB_响应参数, RES_CODE, RES_MSG);
    ELSIF STR_功能号 = '2006' THEN
      PR_互联互通_解锁号源锁定(STR_请求参数, LOB_响应参数, RES_CODE, RES_MSG);
    ELSIF STR_功能号 = '2007' THEN
      --挂号费 诊疗费
      PR_互联互通_预挂号(STR_请求参数 => STR_请求参数,
                  STR_平台标识 => STR_平台标识,
                  STR_功能编码 => STR_功能号,
                  LOB_响应参数 => LOB_响应参数,
                  INT_返回值   => RES_CODE,
                  STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '2008' THEN
      --医院支付单号
      PR_互联互通_挂号支付(STR_请求参数 => STR_请求参数,
                   STR_平台标识 => STR_平台标识,
                   STR_功能编码 => STR_功能号,
                   LOB_响应参数 => LOB_响应参数,
                   INT_返回值   => RES_CODE,
                   STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '2009' THEN
      PR_互联互通_取消挂号(STR_请求参数 => STR_请求参数,
                   STR_平台标识 => STR_平台标识,
                   STR_功能编码 => STR_功能号,
                   LOB_响应参数 => LOB_响应参数,
                   INT_返回值   => RES_CODE,
                   STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '2010' THEN
      --院内退 平台退
      PR_互联互通_退款挂号(STR_请求参数 => STR_请求参数,
                   STR_平台标识 => STR_平台标识,
                   STR_功能编码 => STR_功能号,
                   LOB_响应参数 => LOB_响应参数,
                   INT_返回值   => RES_CODE,
                   STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '2011' THEN
      PR_互联互通_取号(STR_请求参数 => STR_请求参数,
                   STR_平台标识 => STR_平台标识,
                   STR_功能编码 => STR_功能号,
                   LOB_响应参数 => LOB_响应参数,
                   INT_返回值   => RES_CODE,
                   STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '2012' THEN
      PR_互联互通_挂号记录查询(STR_请求参数 => STR_请求参数,
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
      PR_互联互通_待缴费记录支付(STR_请求参数, LOB_响应参数, RES_CODE, RES_MSG);
    ELSIF STR_功能号 = '3004' THEN
      PR_互联互通_缴费订单查询(STR_请求参数, LOB_响应参数, RES_CODE, RES_MSG);
    ELSIF STR_功能号 = '4001' THEN
      PR_互联互通_排队列表查询(STR_请求参数, LOB_响应参数, RES_CODE, RES_MSG);
    ELSIF STR_功能号 = '8001' THEN
      PR_互联互通_检查检验列表查询(STR_请求参数 => STR_请求参数,
                       STR_平台标识 => STR_平台标识,
                       STR_功能编码 => STR_功能号,
                       LOB_响应参数 => LOB_响应参数,
                       INT_返回值   => RES_CODE,
                       STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '8002' THEN
      PR_互联互通_普通检验报告查询(STR_请求参数 => STR_请求参数,
                       STR_平台标识 => STR_平台标识,
                       STR_功能编码 => STR_功能号,
                       LOB_响应参数 => LOB_响应参数,
                       INT_返回值   => RES_CODE,
                       STR_返回信息 => RES_MSG);
    ELSIF STR_功能号 = '8003' THEN
      PR_互联互通_普通检验报告查询(STR_请求参数 => STR_请求参数,
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
    ELSE
      RES_CODE := '-1';
      RES_MSG  := '功能号错误';
    END IF;
  
  END;

END PR_互联互通_总线调用;
/


prompt Done
spool off
set define on
