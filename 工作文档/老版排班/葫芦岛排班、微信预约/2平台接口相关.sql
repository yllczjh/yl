prompt PL/SQL Developer Export User Objects for user USERS@47.104.4.221:9900/YKEY
prompt Created by syyyhl on 2021-02-03
set define off
spool 互联互通存储过程.log

prompt
prompt Creating table 平台接口_操作日志
prompt ========================
prompt
create table 平台接口_操作日志
(
  流水码   NUMBER not null,
  平台标识  VARCHAR2(50),
  客户端标识 VARCHAR2(50),
  医院编码  VARCHAR2(50),
  功能编码  VARCHAR2(50),
  请求参数  VARCHAR2(4000),
  请求时间  DATE,
  请求结果  VARCHAR2(4000),
  关联编码  VARCHAR2(50),
  执行人   VARCHAR2(50),
  执行时间  DATE,
  执行状态  VARCHAR2(50) default 0 not null
)
tablespace USERS
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
comment on table 平台接口_操作日志
  is '平台接口_操作日志';
comment on column 平台接口_操作日志.流水码
  is '流水码';
comment on column 平台接口_操作日志.平台标识
  is '平台标识';
comment on column 平台接口_操作日志.客户端标识
  is '客户端标识';
comment on column 平台接口_操作日志.医院编码
  is '医院编码';
comment on column 平台接口_操作日志.功能编码
  is '功能编码';
comment on column 平台接口_操作日志.请求参数
  is '请求参数';
comment on column 平台接口_操作日志.请求时间
  is '请求时间';
comment on column 平台接口_操作日志.请求结果
  is '请求结果';
comment on column 平台接口_操作日志.关联编码
  is '关联处理业务的流水码';
comment on column 平台接口_操作日志.执行人
  is '执行人';
comment on column 平台接口_操作日志.执行时间
  is '执行时间';
comment on column 平台接口_操作日志.执行状态
  is '0、成功；-1、失败';
alter table 平台接口_操作日志
  add primary key (流水码)
  using index 
  tablespace USERS
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
prompt Creating table 平台接口_订单
prompt ======================
prompt
create table 平台接口_订单
(
  流水码    NUMBER not null,
  平台标识   VARCHAR2(50) not null,
  客户端标识  VARCHAR2(50) not null,
  医院编码   VARCHAR2(50),
  病人id   VARCHAR2(50) not null,
  就诊病历号  VARCHAR2(50),
  关联编码   VARCHAR2(50),
  订单号    VARCHAR2(50) not null,
  订单类型   VARCHAR2(50) not null,
  订单时间   DATE not null,
  应付金额   NUMBER(10,4) not null,
  优惠金额   NUMBER(10,4),
  实收金额   NUMBER(10,4) not null,
  过期时间   DATE,
  订单状态   VARCHAR2(50) not null,
  医院订单号  VARCHAR2(50),
  医院交易号  VARCHAR2(50),
  医院退款号  VARCHAR2(50),
  平台订单号  VARCHAR2(50),
  平台订单时间 DATE,
  平台交易号  VARCHAR2(50),
  平台交易时间 DATE,
  平台退款号  VARCHAR2(50),
  平台退款时间 DATE,
  创建人    VARCHAR2(50) not null,
  创建时间   DATE not null,
  更新人    VARCHAR2(50),
  更新时间   DATE,
  排序号    INTEGER default 0,
  备注     VARCHAR2(4000),
  状态     VARCHAR2(50) default 0 not null
)
tablespace USERS
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
comment on table 平台接口_订单
  is '平台接口_订单';
comment on column 平台接口_订单.流水码
  is '流水码';
comment on column 平台接口_订单.平台标识
  is '平台标识';
comment on column 平台接口_订单.客户端标识
  is '客户端标识';
comment on column 平台接口_订单.医院编码
  is '医院编码';
comment on column 平台接口_订单.病人id
  is '病人ID';
comment on column 平台接口_订单.就诊病历号
  is '住院病历号；门诊病历号';
comment on column 平台接口_订单.关联编码
  is '关联编码';
comment on column 平台接口_订单.订单号
  is '订单号';
comment on column 平台接口_订单.订单类型
  is '预约挂号；预约退号；门诊收费；预缴押金；出院结算';
comment on column 平台接口_订单.订单时间
  is '订单时间';
comment on column 平台接口_订单.应付金额
  is '应付金额';
comment on column 平台接口_订单.优惠金额
  is '优惠金额';
comment on column 平台接口_订单.实收金额
  is '实收金额';
comment on column 平台接口_订单.过期时间
  is '默认为订单创建时间+15分钟';
comment on column 平台接口_订单.订单状态
  is '待支付；已支付；已退款；已取消；已删除；';
comment on column 平台接口_订单.医院订单号
  is '医院订单号';
comment on column 平台接口_订单.医院交易号
  is '医院交易号';
comment on column 平台接口_订单.医院退款号
  is '医院交易号';
comment on column 平台接口_订单.平台订单号
  is '平台订单号';
comment on column 平台接口_订单.平台订单时间
  is '平台订单时间';
comment on column 平台接口_订单.平台交易号
  is '平台交易号';
comment on column 平台接口_订单.平台交易时间
  is '平台交易时间';
comment on column 平台接口_订单.平台退款号
  is '平台退款号';
comment on column 平台接口_订单.平台退款时间
  is '平台退款时间';
comment on column 平台接口_订单.创建人
  is '创建人';
comment on column 平台接口_订单.创建时间
  is '创建时间';
comment on column 平台接口_订单.更新人
  is '更新人';
comment on column 平台接口_订单.更新时间
  is '更新时间';
comment on column 平台接口_订单.排序号
  is '排序号';
comment on column 平台接口_订单.备注
  is '备注';
comment on column 平台接口_订单.状态
  is '状态';
alter table 平台接口_订单
  add primary key (流水码)
  using index 
  tablespace USERS
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
prompt Creating table 平台接口_订单明细
prompt ========================
prompt
create table 平台接口_订单明细
(
  流水码  NUMBER not null,
  订单号  VARCHAR2(50) not null,
  大类编码 VARCHAR2(50),
  小类编码 VARCHAR2(50),
  项目编码 VARCHAR2(50),
  项目名称 VARCHAR2(200),
  规格   VARCHAR2(200),
  批次号  VARCHAR2(50),
  数量   NUMBER(10,4) not null,
  单位   VARCHAR2(50),
  单价   NUMBER(10,4) not null,
  总金额  NUMBER(10,4) not null,
  归类编码 VARCHAR2(50),
  唯一编码 VARCHAR2(50)
)
tablespace USERS
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
comment on table 平台接口_订单明细
  is '平台接口_订单明细';
comment on column 平台接口_订单明细.流水码
  is '流水码';
comment on column 平台接口_订单明细.订单号
  is '订单号';
comment on column 平台接口_订单明细.大类编码
  is '大类编码';
comment on column 平台接口_订单明细.小类编码
  is '小类编码';
comment on column 平台接口_订单明细.项目编码
  is '项目编码';
comment on column 平台接口_订单明细.项目名称
  is '项目名称';
comment on column 平台接口_订单明细.规格
  is '规格';
comment on column 平台接口_订单明细.批次号
  is '批次号';
comment on column 平台接口_订单明细.数量
  is '数量';
comment on column 平台接口_订单明细.单位
  is '单位';
comment on column 平台接口_订单明细.单价
  is '单价';
comment on column 平台接口_订单明细.总金额
  is '总金额';
comment on column 平台接口_订单明细.归类编码
  is '归类编码';
comment on column 平台接口_订单明细.唯一编码
  is '唯一编码';
alter table 平台接口_订单明细
  add primary key (流水码)
  using index 
  tablespace USERS
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
prompt Creating table 平台接口_就诊人信息
prompt =========================
prompt
create table 平台接口_就诊人信息
(
  流水码     NUMBER not null,
  平台标识    VARCHAR2(50) not null,
  客户端标识   VARCHAR2(50) not null,
  医院编码    VARCHAR2(50) not null,
  病人id    VARCHAR2(50) not null,
  就诊人类别   VARCHAR2(50) not null,
  姓名      VARCHAR2(200) not null,
  性别      VARCHAR2(50),
  出生日期    DATE,
  身份证号    VARCHAR2(50),
  手机号码    VARCHAR2(50),
  联系地址    VARCHAR2(50),
  监护人姓名   VARCHAR2(200),
  监护人身份证号 VARCHAR2(50),
  监护人手机号码 VARCHAR2(50),
  监护人联系地址 VARCHAR2(50),
  创建人     VARCHAR2(50) not null,
  创建时间    DATE not null,
  更新人     VARCHAR2(50),
  更新时间    DATE,
  排序号     INTEGER default 0 not null,
  备注      VARCHAR2(4000),
  状态      VARCHAR2(50) default 0 not null
)
tablespace USERS
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
comment on table 平台接口_就诊人信息
  is '平台接口_就诊人信息';
comment on column 平台接口_就诊人信息.流水码
  is '流水码';
comment on column 平台接口_就诊人信息.平台标识
  is '平台标识';
comment on column 平台接口_就诊人信息.客户端标识
  is '客户端标识';
comment on column 平台接口_就诊人信息.医院编码
  is '医院编码';
comment on column 平台接口_就诊人信息.病人id
  is '病人ID';
comment on column 平台接口_就诊人信息.就诊人类别
  is '就诊人类别';
comment on column 平台接口_就诊人信息.姓名
  is '姓名';
comment on column 平台接口_就诊人信息.性别
  is '性别';
comment on column 平台接口_就诊人信息.出生日期
  is '出生日期';
comment on column 平台接口_就诊人信息.身份证号
  is '身份证号';
comment on column 平台接口_就诊人信息.手机号码
  is '手机号码';
comment on column 平台接口_就诊人信息.联系地址
  is '联系地址';
comment on column 平台接口_就诊人信息.监护人姓名
  is '监护人姓名';
comment on column 平台接口_就诊人信息.监护人身份证号
  is '监护人身份证号';
comment on column 平台接口_就诊人信息.监护人手机号码
  is '监护人手机号码';
comment on column 平台接口_就诊人信息.监护人联系地址
  is '监护人联系地址';
comment on column 平台接口_就诊人信息.创建人
  is '创建人';
comment on column 平台接口_就诊人信息.创建时间
  is '创建时间';
comment on column 平台接口_就诊人信息.更新人
  is '更新人';
comment on column 平台接口_就诊人信息.更新时间
  is '更新时间';
comment on column 平台接口_就诊人信息.排序号
  is '排序号';
comment on column 平台接口_就诊人信息.备注
  is '备注';
comment on column 平台接口_就诊人信息.状态
  is '0,已绑定；-1,已解绑；1,已删除';
alter table 平台接口_就诊人信息
  add primary key (流水码)
  using index 
  tablespace USERS
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
prompt Creating table 平台接口_平台功能配置
prompt ==========================
prompt
create table 平台接口_平台功能配置
(
  流水码  NUMBER not null,
  平台标识 VARCHAR2(50) not null,
  功能编码 VARCHAR2(50) not null,
  医院编码 VARCHAR2(50) not null,
  创建人  VARCHAR2(50) not null,
  创建时间 DATE not null,
  更新人  VARCHAR2(50),
  更新时间 DATE,
  排序号  INTEGER default 0 not null,
  备注   VARCHAR2(4000),
  状态   VARCHAR2(50) default 0 not null
)
tablespace USERS
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
comment on table 平台接口_平台功能配置
  is '平台接口_平台功能配置';
comment on column 平台接口_平台功能配置.流水码
  is '流水码';
comment on column 平台接口_平台功能配置.平台标识
  is '平台标识';
comment on column 平台接口_平台功能配置.功能编码
  is '功能编码';
comment on column 平台接口_平台功能配置.医院编码
  is '医院编码';
comment on column 平台接口_平台功能配置.创建人
  is '创建人';
comment on column 平台接口_平台功能配置.创建时间
  is '创建时间';
comment on column 平台接口_平台功能配置.更新人
  is '更新人';
comment on column 平台接口_平台功能配置.更新时间
  is '更新时间';
comment on column 平台接口_平台功能配置.排序号
  is '排序号';
comment on column 平台接口_平台功能配置.备注
  is '备注';
comment on column 平台接口_平台功能配置.状态
  is '0、有效；-1、停用；1、删除';
alter table 平台接口_平台功能配置
  add primary key (流水码)
  using index 
  tablespace USERS
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
prompt Creating table 平台接口_平台配置
prompt ========================
prompt
create table 平台接口_平台配置
(
  流水码  NUMBER not null,
  平台标识 VARCHAR2(50) not null,
  平台名称 VARCHAR2(200) not null,
  认证密钥 VARCHAR2(50) not null,
  创建人  VARCHAR2(50) not null,
  创建时间 DATE not null,
  更新人  VARCHAR2(50),
  更新时间 DATE,
  排序号  INTEGER default 0 not null,
  备注   VARCHAR2(4000),
  状态   VARCHAR2(50) default 0 not null,
  支付方式 VARCHAR2(50),
  限号类型 VARCHAR2(50)
)
tablespace USERS
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
comment on table 平台接口_平台配置
  is '平台接口_平台配置';
comment on column 平台接口_平台配置.流水码
  is '流水码';
comment on column 平台接口_平台配置.平台标识
  is '平台标识';
comment on column 平台接口_平台配置.平台名称
  is '平台名称';
comment on column 平台接口_平台配置.认证密钥
  is '认证密钥';
comment on column 平台接口_平台配置.创建人
  is '创建人';
comment on column 平台接口_平台配置.创建时间
  is '创建时间';
comment on column 平台接口_平台配置.更新人
  is '更新人';
comment on column 平台接口_平台配置.更新时间
  is '更新时间';
comment on column 平台接口_平台配置.排序号
  is '排序号';
comment on column 平台接口_平台配置.备注
  is '备注';
comment on column 平台接口_平台配置.状态
  is '0、有效；-1、停用；1、删除';
comment on column 平台接口_平台配置.支付方式
  is '支付方式';
comment on column 平台接口_平台配置.限号类型
  is '限号类型';
alter table 平台接口_平台配置
  add primary key (流水码)
  using index 
  tablespace USERS
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
prompt Creating table 平台接口_系统功能
prompt ========================
prompt
create table 平台接口_系统功能
(
  流水码  NUMBER not null,
  功能编码 VARCHAR2(50) not null,
  功能名称 VARCHAR2(200) not null,
  功能说明 VARCHAR2(4000),
  创建人  VARCHAR2(50) not null,
  创建时间 DATE not null,
  更新人  VARCHAR2(50),
  更新时间 DATE,
  排序号  INTEGER default 0 not null,
  备注   VARCHAR2(4000),
  状态   VARCHAR2(50) default 0 not null,
  存储过程 VARCHAR2(200)
)
tablespace USERS
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
comment on table 平台接口_系统功能
  is '平台接口_系统功能';
comment on column 平台接口_系统功能.流水码
  is '流水码';
comment on column 平台接口_系统功能.功能编码
  is '功能编码';
comment on column 平台接口_系统功能.功能名称
  is '功能名称';
comment on column 平台接口_系统功能.功能说明
  is '功能说明';
comment on column 平台接口_系统功能.创建人
  is '创建人';
comment on column 平台接口_系统功能.创建时间
  is '创建时间';
comment on column 平台接口_系统功能.更新人
  is '更新人';
comment on column 平台接口_系统功能.更新时间
  is '更新时间';
comment on column 平台接口_系统功能.排序号
  is '排序号';
comment on column 平台接口_系统功能.备注
  is '备注';
comment on column 平台接口_系统功能.状态
  is '0、有效；-1、停用；1、删除';
comment on column 平台接口_系统功能.存储过程
  is '存储过程';
create unique index U_平台接口_系统功能_唯一行 on 平台接口_系统功能 (功能编码)
  tablespace USERS
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
alter table 平台接口_系统功能
  add primary key (流水码)
  using index 
  tablespace USERS
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
prompt Creating sequence SEQ_平台接口_操作日志_流水码
prompt ===================================
prompt
create sequence SEQ_平台接口_操作日志_流水码
minvalue 1
maxvalue 9999999999
start with 8841
increment by 1
cache 10;

prompt
prompt Creating sequence SEQ_平台接口_订单_订单号
prompt =================================
prompt
create sequence SEQ_平台接口_订单_订单号
minvalue 1
maxvalue 9999999999
start with 1
increment by 1
cache 10;

prompt
prompt Creating sequence SEQ_平台接口_订单_流水码
prompt =================================
prompt
create sequence SEQ_平台接口_订单_流水码
minvalue 1
maxvalue 9999999999
start with 291
increment by 1
cache 10;

prompt
prompt Creating sequence SEQ_平台接口_订单明细_流水码
prompt ===================================
prompt
create sequence SEQ_平台接口_订单明细_流水码
minvalue 1
maxvalue 9999999999
start with 371
increment by 1
cache 10;

prompt
prompt Creating sequence SEQ_平台接口_就诊人信息_流水码
prompt ====================================
prompt
create sequence SEQ_平台接口_就诊人信息_流水码
minvalue 1
maxvalue 9999999999
start with 121
increment by 1
cache 10;

prompt
prompt Creating sequence SEQ_平台接口_平台功能_流水码
prompt ===================================
prompt
create sequence SEQ_平台接口_平台功能_流水码
minvalue 1
maxvalue 9999999999
start with 11
increment by 1
cache 10;

prompt
prompt Creating sequence SEQ_平台接口_平台配置_流水码
prompt ===================================
prompt
create sequence SEQ_平台接口_平台配置_流水码
minvalue 1
maxvalue 9999999999
start with 11
increment by 1
cache 10;

prompt
prompt Creating sequence SEQ_平台接口_系统功能_流水码
prompt ===================================
prompt
create sequence SEQ_平台接口_系统功能_流水码
minvalue 1
maxvalue 9999999999
start with 11
increment by 1
cache 10;

prompt
prompt Creating function FU_平台接口_截取字符串值
prompt ================================
prompt
CREATE OR REPLACE FUNCTION FU_平台接口_截取字符串值(str_字符串   IN VARCHAR2,
                                        str_拆分字符 IN VARCHAR2,
                                        int_位置     IN NUMBER)
  RETURN VARCHAR2 IS
  RESULT   VARCHAR2(500);
  LL_START NUMBER(5);
  LL_END   NUMBER(5);
BEGIN

  IF int_位置 < 1 THEN
    RESULT := '';
    RETURN(RESULT);
  END IF;

  IF int_位置 = 1 THEN
    LL_START := 1;
    LL_END   := INSTR(str_字符串, str_拆分字符, 1, int_位置);
    IF LL_END = 0 THEN
      RESULT := '';
    ELSE
      RESULT := SubStr(str_字符串, LL_START, LL_END - 1);
    END IF;
  ELSE
    LL_START := INSTR(str_字符串, str_拆分字符, 1, int_位置 - 1);
    IF LL_START = 0 THEN
      RESULT := '';
    ELSE
      LL_END := INSTR(str_字符串, str_拆分字符, 1, int_位置);
      IF LL_END = 0 THEN
        RESULT := SubStr(str_字符串, LL_START + LENGTH(str_拆分字符),
                         LENGTH(str_字符串) - LL_START);
      ELSE
        RESULT := SubStr(str_字符串, LL_START + LENGTH(str_拆分字符),
                         LL_END - (LL_START + LENGTH(str_拆分字符)));
      END IF;
    END IF;
  END IF;

  RETURN(RESULT);
END FU_平台接口_截取字符串值;
/

prompt
prompt Creating function FU_平台接口_验证数值
prompt ==============================
prompt
CREATE OR REPLACE FUNCTION FU_平台接口_验证数值(p_string IN VARCHAR2)
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
    END FU_平台接口_验证数值;
/

prompt
prompt Creating function FU_平台接口_验证日期
prompt ==============================
prompt
CREATE OR REPLACE FUNCTION FU_平台接口_验证日期(p_date IN VARCHAR2) RETURN BOOLEAN IS
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
END FU_平台接口_验证日期;
/

prompt
prompt Creating function FU_平台接口_验证身份证
prompt ===============================
prompt
CREATE OR REPLACE FUNCTION FU_平台接口_验证身份证(P_IDCARD IN VARCHAR2)
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
    V_ISNUMBER := FU_平台接口_验证数值(P_IDCARD);
    IF NOT (V_ISNUMBER) THEN
      RETURN(-3);
    END IF;
  ELSIF V_LENGTH = 18 THEN
    V_ISNUMBER    := FU_平台接口_验证数值(P_IDCARD);
    V_ISNUMBER_17 := FU_平台接口_验证数值(SUBSTR(P_IDCARD, 1, 17));
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
  V_ISDATE := FU_平台接口_验证日期(V_DATE);
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
END FU_平台接口_验证身份证;
/

prompt
prompt Creating function FU_平台接口_解构身份证
prompt ===============================
prompt
CREATE OR REPLACE FUNCTION FU_平台接口_解构身份证(STR_身份证号 IN VARCHAR2,

                                         DAT_出生日期 OUT DATE,
                                         STR_年龄     OUT VARCHAR2,
                                         STR_性别     OUT VARCHAR2,
                                         STR_返回信息 OUT VARCHAR2)
  RETURN INTEGER IS
BEGIN
  IF FU_平台接口_验证身份证(STR_身份证号) <> 0 THEN
    STR_返回信息 := '无效的身份证号码';
    RETURN(-1);
  ELSE
    SELECT DECODE(MOD(TO_NUMBER(SUBSTR(STR_身份证号, 17, 1)), 2), 0, '2', '1'),
           TO_DATE(SUBSTR(STR_身份证号, 7, 8), 'yyyy-mm-dd')
      INTO STR_性别,
           DAT_出生日期
      FROM DUAL;
    STR_年龄     := FU_得到_年龄(DAT_出生日期);
    STR_返回信息 := '成功！';
    RETURN(0);
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    STR_返回信息 := '解构身份证号失败，请检查身份证是否正确';
    STR_性别     := NULL;
    DAT_出生日期 := NULL;
    STR_年龄     := NULL;
    RETURN(-1);
END FU_平台接口_解构身份证;
/

prompt
prompt Creating function FU_平台接口_取得平台名称
prompt ================================
prompt
CREATE OR REPLACE FUNCTION FU_平台接口_取得平台名称(STR_平台标识 IN VARCHAR2)
  RETURN VARCHAR2 IS
  STR_平台名称 VARCHAR2(50);
BEGIN
  BEGIN
    SELECT NVL(平台名称, '')
      INTO STR_平台名称
      FROM 平台接口_平台配置 P
     WHERE P.平台标识 = STR_平台标识;
    RETURN STR_平台名称;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN('');
  END;
END FU_平台接口_取得平台名称;
/

prompt
prompt Creating function FU_平台接口_验证就诊人信息
prompt =================================
prompt
CREATE OR REPLACE FUNCTION FU_平台接口_验证就诊人信息(STR_请求参数 IN VARCHAR2)
  RETURN INTEGER IS
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);
  STR_病人ID     VARCHAR2(50);
  INT_记录数     INTEGER;
BEGIN

  -- 初始值
  INT_记录数 := 0;

  BEGIN

    IF STR_请求参数 IS NULL THEN
      RETURN(-1);
    END IF;

    -- 请求参数解构
    STR_平台标识   := FU_平台接口_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_平台接口_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_平台接口_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 5);
    STR_病人ID     := FU_平台接口_截取字符串值(STR_请求参数, '|', 6);

    -- 数据值判断
    IF STR_平台标识 IS NULL
       OR STR_认证密匙 IS NULL
       OR STR_客户端标识 IS NULL
       OR STR_功能编码 IS NULL
       OR STR_医院编码 IS NULL
       OR STR_病人ID IS NULL THEN
      RETURN(-1);
    END IF;

    -- 功能有效性判断
    SELECT COUNT(1)
      INTO INT_记录数
      FROM 平台接口_就诊人信息
     WHERE 平台标识 = STR_平台标识
       AND 客户端标识 = STR_客户端标识
       AND 医院编码 = STR_医院编码
       AND 病人ID = STR_病人ID
       AND 状态 = 0;

    IF INT_记录数 <= 0 THEN
      RETURN(-1);
    END IF;

    RETURN 0;

  EXCEPTION
    WHEN OTHERS THEN
      RETURN(-1);
  END;

END FU_平台接口_验证就诊人信息;
/

prompt
prompt Creating function FU_平台接口_验证手机号
prompt ===============================
prompt
CREATE OR REPLACE FUNCTION FU_平台接口_验证手机号(STR_手机号码 VARCHAR2) RETURN INTEGER IS
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

END FU_平台接口_验证手机号;
/

prompt
prompt Creating function FU_平台接口_验证网络请求
prompt ================================
prompt
CREATE OR REPLACE FUNCTION FU_平台接口_验证网络请求(STR_请求参数 IN VARCHAR2)
  RETURN INTEGER IS
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);
  INT_记录数     INTEGER;
BEGIN

  -- 初始值
  INT_记录数 := 0;

  BEGIN

    IF STR_请求参数 IS NULL THEN
      RETURN(-1);
    END IF;

    -- 请求参数解构
    STR_平台标识   := FU_平台接口_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_平台接口_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_平台接口_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 5);

    -- 数据值判断
    IF STR_平台标识 IS NULL
       OR STR_认证密匙 IS NULL
       OR STR_客户端标识 IS NULL
       OR STR_功能编码 IS NULL
       OR STR_医院编码 IS NULL THEN
      RETURN(-1);
    END IF;

    -- 功能有效性判断
    SELECT COUNT(1)
      INTO INT_记录数
      FROM 平台接口_平台功能配置 G, 平台接口_平台配置 P
     WHERE G.平台标识 = P.平台标识
       AND P.认证密钥 = STR_认证密匙
       AND G.平台标识 = STR_平台标识
       AND G.功能编码 = STR_功能编码
       AND G.医院编码 = STR_医院编码
       AND G.状态 = '0';

    IF INT_记录数 <= 0 THEN
      RETURN(-1);
    END IF;

    RETURN 0;

  EXCEPTION
    WHEN OTHERS THEN
      RETURN(-1);
  END;

END FU_平台接口_验证网络请求;
/

prompt
prompt Creating function FU_平台接口_验证性别
prompt ==============================
prompt
CREATE OR REPLACE FUNCTION FU_平台接口_验证性别(STR_性别 IN VARCHAR2) RETURN INTEGER IS
BEGIN
  IF STR_性别 IS NULL THEN
    RETURN(-1);
  END IF;
  IF STR_性别 = '1' --男
     OR STR_性别 = '2' THEN
    --女
    RETURN 0;
  ELSE
    RETURN(-1);
  END IF;
END FU_平台接口_验证性别;
/

prompt
prompt Creating procedure PR_平台接口_操作日志
prompt ===============================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_操作日志(Str_平台标识   IN VARCHAR2,
                                         Str_客户端标识 IN VARCHAR2,
                                         Str_医院编码   IN VARCHAR2,
                                         Str_功能编码   IN VARCHAR2,
                                         Str_请求参数   IN VARCHAR2,
                                         Dat_请求时间   IN DATE,
                                         Str_请求结果 IN VARCHAR2,
                                         Str_关联编码 IN VARCHAR2,
                                         Str_执行人   IN VARCHAR2,
                                         Dat_执行时间 IN DATE,
                                         Str_执行状态 IN VARCHAR2) IS

  PRAGMA AUTONOMOUS_TRANSACTION; --自制事物不影响主事物
BEGIN

  BEGIN
    INSERT INTO 平台接口_操作日志
      (流水码,
       平台标识,
       客户端标识,
       医院编码,
       功能编码,
       请求参数,
       请求时间,
       请求结果,
       关联编码,
       执行人,
       执行时间,
       执行状态)
    VALUES
      (seq_平台接口_操作日志_流水码.nextval,
       Str_平台标识,
       Str_客户端标识,
       Str_医院编码,
       Str_功能编码,
       Str_请求参数,
       Dat_请求时间,
       Str_请求结果,
       Str_关联编码,
       Str_执行人,
       Dat_执行时间,
       Str_执行状态);

  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RETURN;
  END;

  COMMIT;

  RETURN;

END PR_平台接口_操作日志;
/

prompt
prompt Creating procedure PR_平台接口_病人缴费记录查询
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_病人缴费记录查询(STR_请求参数   IN VARCHAR2,
                                             CUR_返回结果集 OUT SYS_REFCURSOR,
                                             INT_返回值     OUT INTEGER,
                                             STR_返回信息   OUT VARCHAR2) IS
  -- 固定参数
  DAT_系统时间 DATE;

  -- 请求参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_病人ID   VARCHAR2(50);
  STR_订单号   VARCHAR2(50);
  STR_订单状态 VARCHAR2(50);

BEGIN
  BEGIN
  
    -- 请求功能有效性验证
    IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '非法请求！';
      GOTO 退出;
    END IF;
  
    -- 就诊人有效性验证
    IF FU_平台接口_验证就诊人信息(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '就诊人信息无效！';
      GOTO 退出;
    END IF;
  
    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
  
    -- 【请求参数解析】
    STR_平台标识   := FU_平台接口_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_平台接口_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_平台接口_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 5);
  
    -- 【功能参数解析】
    STR_病人ID   := FU_平台接口_截取字符串值(STR_请求参数, '|', 6);
    STR_订单号   := FU_平台接口_截取字符串值(STR_请求参数, '|', 7);
    STR_订单状态 := FU_平台接口_截取字符串值(STR_请求参数, '|', 8);
  
    -- 数据验证
    IF STR_病人ID IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的病人ID！';
      GOTO 退出;
    END IF;
  
    IF STR_订单号 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的订单号！';
      GOTO 退出;
    END IF;
  
    IF STR_订单状态 IS NULL
       OR STR_订单状态 NOT IN ('全部', '已取消', '待支付', '已支付') THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的就诊状态！';
      GOTO 退出;
    END IF;
  
    /*
    说明：
        1）只显示1月内的订单信息
    */
    OPEN CUR_返回结果集 FOR
      SELECT 病人ID     AS 病人ID,
             就诊病历号 AS 就诊病历号,
             订单类型   AS 订单类型,
             订单号     AS 订单号,
             实收金额   AS 订单总额,
             订单状态   AS 订单状态,
             订单时间   AS 创建时间,
             平台订单时间  AS 支付时间
        FROM 平台接口_订单
       WHERE 平台标识 = STR_平台标识
         AND 客户端标识 = STR_客户端标识
         AND 医院编码 = STR_医院编码
         AND 病人ID = STR_病人ID
         AND 订单号 = DECODE(STR_订单号, '-1', 订单号, STR_订单号)
         AND 订单状态 = DECODE(STR_订单状态, '全部', 订单状态, STR_订单状态)
         AND 订单时间 > ADD_MONTHS(SYSDATE, -1);
  
    INT_返回值   := 0;
    STR_返回信息 := '成功!';
  
    -- 【保存日志】
    PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
                 STR_客户端标识 => STR_客户端标识,
                 STR_医院编码   => STR_医院编码,
                 STR_功能编码   => STR_功能编码,
                 STR_请求参数   => STR_请求参数,
                 DAT_请求时间   => DAT_系统时间,
                 STR_请求结果   => STR_返回信息,
                 STR_关联编码   => STR_订单号,
                 STR_执行人     => STR_平台标识,
                 DAT_执行时间   => SYSDATE,
                 STR_执行状态   => INT_返回值);
  
    RETURN;
  
  EXCEPTION
    -- 未检测的系统异常
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := SQLERRM;
      GOTO 退出;
  END;

  -- 【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  RETURN;

END PR_平台接口_病人缴费记录查询;
/

prompt
prompt Creating procedure PR_平台接口_病人缴费明细查询
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_病人缴费明细查询(STR_请求参数   IN VARCHAR2,
                                             CUR_返回结果集 OUT SYS_REFCURSOR,
                                             INT_返回值     OUT INTEGER,
                                             STR_返回信息   OUT VARCHAR2) IS
  -- 固定参数
  DAT_系统时间 DATE;

  -- 请求参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_病人ID VARCHAR2(50);
  STR_订单号 VARCHAR2(50);

BEGIN
  BEGIN
  
    -- 请求功能有效性验证
    IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '非法请求！';
      GOTO 退出;
    END IF;
  
    -- 就诊人有效性验证
    IF FU_平台接口_验证就诊人信息(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '就诊人信息无效！';
      GOTO 退出;
    END IF;
  
    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
  
    -- 【请求参数解析】
    STR_平台标识   := FU_平台接口_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_平台接口_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_平台接口_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 5);
  
    -- 【功能参数解析】
    STR_病人ID := FU_平台接口_截取字符串值(STR_请求参数, '|', 6);
    STR_订单号 := FU_平台接口_截取字符串值(STR_请求参数, '|', 7);
  
    -- 数据验证
    IF STR_病人ID IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的病人ID！';
      GOTO 退出;
    END IF;
  
    IF STR_订单号 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的订单号！';
      GOTO 退出;
    END IF;
  
    /*
    说明：
        1）只显示1月内的订单信息
    */
    OPEN CUR_返回结果集 FOR
      SELECT D.病人ID   AS 病人ID,
             M.订单号   AS 订单号,
             M.项目编码 AS 项目编码,
             M.项目名称 AS 项目名称,
             M.规格     AS 规格,
             M.数量     AS 数量,
             M.单位     AS 单位,
             M.单价     AS 单价,
             M.总金额   AS 总金额
        FROM 平台接口_订单 D, 平台接口_订单明细 M
       WHERE D.订单号 = M.订单号
         AND D.平台标识 = STR_平台标识
         AND D.客户端标识 = STR_客户端标识
         AND D.医院编码 = STR_医院编码
         AND D.病人ID = STR_病人ID
         AND D.订单号 = DECODE(STR_订单号, '-1', D.订单号, STR_订单号)
         AND D.订单时间 > ADD_MONTHS(SYSDATE, -1);
  
    INT_返回值   := 0;
    STR_返回信息 := '成功!';
  
    -- 【保存日志】
    PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
                 STR_客户端标识 => STR_客户端标识,
                 STR_医院编码   => STR_医院编码,
                 STR_功能编码   => STR_功能编码,
                 STR_请求参数   => STR_请求参数,
                 DAT_请求时间   => DAT_系统时间,
                 STR_请求结果   => STR_返回信息,
                 STR_关联编码   => STR_订单号,
                 STR_执行人     => STR_平台标识,
                 DAT_执行时间   => SYSDATE,
                 STR_执行状态   => INT_返回值);
  
    RETURN;
  
  EXCEPTION
    -- 未检测的系统异常
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := SQLERRM;
      GOTO 退出;
  END;

  -- 【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  RETURN;

END PR_平台接口_病人缴费明细查询;
/

prompt
prompt Creating procedure PR_平台接口_测试_医嘱数据
prompt ==================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_测试_医嘱数据(STR_请求参数   IN VARCHAR2,
                                            CUR_返回结果集 OUT SYS_REFCURSOR,
                                            INT_返回值     OUT INTEGER,
                                            STR_返回信息   OUT VARCHAR2) IS
  ----4499|123456|wx000000000010|1004|522633020000001|0000000159|             挂号并生成医嘱
  ----4499|123456|wx000000000010|1004|522633020000001|0000000159|2021028657   只生成医嘱
  STR_平台名称 VARCHAR2(50);
  DAT_系统时间 DATE;

  -- 固定参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_病人ID     VARCHAR2(50);
  STR_门诊病历号 VARCHAR2(50);

  -- 处理参数
  ----病人信息
  STR_姓名     VARCHAR2(50);
  STR_性别     VARCHAR2(50);
  STR_出生日期 VARCHAR2(50);
  STR_婚姻状况 VARCHAR2(50);
  STR_联系电话 VARCHAR2(50);
  STR_家庭地址 VARCHAR2(200);
  STR_工作单位 VARCHAR2(200);
  STR_身份证号 VARCHAR2(50);

  ----挂号相关
  STR_挂号序号     VARCHAR2(50);
  STR_挂号单号     VARCHAR2(50);
  STR_挂号类型编码 VARCHAR2(50);
  STR_挂号类型名称 VARCHAR2(50);
  NUM_挂号费       NUMBER(18, 3);
  NUM_诊查费       NUMBER(18, 3);
  NUM_总费用       NUMBER(18, 3);
  STR_归类编码     VARCHAR2(50);
  STR_病人类型编码 VARCHAR2(50);
  STR_病人类型名称 VARCHAR2(50);
  STR_就诊状态     VARCHAR2(50);
  STR_挂号来源     VARCHAR2(50);
  STR_付款方式     VARCHAR2(50);

  ----医嘱项目相关
  STR_大类编码     VARCHAR2(50);
  STR_小类编码     VARCHAR2(50);
  STR_项目编码     VARCHAR2(50);
  STR_项目名称     VARCHAR2(100);
  STR_单位编码     VARCHAR2(50);
  STR_单位名称     VARCHAR2(50);
  STR_执行科室编码 VARCHAR2(50);
  STR_医嘱号       VARCHAR2(50);
  STR_项目ID       VARCHAR2(50);
  STR_序号         VARCHAR2(50);
  STR_申请单ID     VARCHAR2(50);

  TYPE REF_CURSOR_TYPE IS REF CURSOR;
  CUR_临时数据 REF_CURSOR_TYPE;
  STR_SQL      VARCHAR2(1000);

BEGIN

  -- 【请求功能有效性验证】
  IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
    INT_返回值   := -1;
    STR_返回信息 := '非法请求！';
    GOTO 退出;
  END IF;

  -- 【就诊人有效性验证】
  IF FU_平台接口_验证就诊人信息(STR_请求参数) <> 0 THEN
    INT_返回值   := -1;
    STR_返回信息 := '就诊人信息无效！';
    GOTO 退出;
  END IF;

  -- 【数据初始化】
  SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;

  STR_病人类型编码 := '1';
  STR_病人类型名称 := '现金';
  STR_就诊状态     := '正在接诊';
  STR_挂号来源     := '预约';

  -- 【固定参数解析】
  STR_平台标识   := FU_通用_截取字符串值(STR_请求参数, '|', 1);
  STR_认证密匙   := FU_通用_截取字符串值(STR_请求参数, '|', 2);
  STR_客户端标识 := FU_通用_截取字符串值(STR_请求参数, '|', 3);
  STR_功能编码   := FU_通用_截取字符串值(STR_请求参数, '|', 4);
  STR_医院编码   := FU_通用_截取字符串值(STR_请求参数, '|', 5);

  -- 【功能参数解析】
  STR_病人ID     := FU_通用_截取字符串值(STR_请求参数, '|', 6);
  STR_门诊病历号 := FU_通用_截取字符串值(STR_请求参数, '|', 7);
  BEGIN
  
    BEGIN
      SELECT P.支付方式, P.平台名称
        INTO STR_付款方式, STR_平台名称
        FROM 平台接口_平台配置 P
       WHERE P.平台标识 = STR_平台标识;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        INT_返回值   := -1;
        STR_返回信息 := '未找到有效的平台信息！';
        GOTO 退出;
      WHEN OTHERS THEN
        INT_返回值   := -1;
        STR_返回信息 := '系统异常：' || SQLERRM;
        GOTO 退出;
    END;
  
    -- 【入参有期性验证】
    IF STR_病人ID IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '请输入有效的病人ID！';
      GOTO 退出;
    END IF;
  
    --【获取挂号费用相关信息】
    BEGIN
      SELECT 类型编码, 类型名称, 挂号费, 诊查费, 挂号费 + 诊查费, 归类编码
        INTO STR_挂号类型编码,
             STR_挂号类型名称,
             NUM_挂号费,
             NUM_诊查费,
             NUM_总费用,
             STR_归类编码
        FROM 基础项目_挂号类型
       WHERE 机构编码 = STR_医院编码
         AND 类型编码 = '000002' --免费号
         AND 有效状态 = '有效'
         AND 删除标志 = '0';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        INT_返回值   := -1;
        STR_返回信息 := '未找到有效的挂号类型！';
        GOTO 退出;
      WHEN OTHERS THEN
        INT_返回值   := -1;
        STR_返回信息 := '系统异常：' || SQLERRM;
        GOTO 退出;
    END;
  
    --【获取病人信息】
    BEGIN
      SELECT 姓名,
             性别,
             出生日期,
             婚姻状况,
             手机号码,
             家庭地址,
             工作单位,
             身份证号
        INTO STR_姓名,
             STR_性别,
             STR_出生日期,
             STR_婚姻状况,
             STR_联系电话,
             STR_家庭地址,
             STR_工作单位,
             STR_身份证号
        FROM 基础项目_病人信息
       WHERE 机构编码 = STR_医院编码
         AND 病人ID = STR_病人ID;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        INT_返回值   := -1;
        STR_返回信息 := '未找到有效的病人信息！';
        GOTO 退出;
      WHEN OTHERS THEN
        INT_返回值   := -1;
        STR_返回信息 := '系统异常：' || SQLERRM;
        GOTO 退出;
    END;
    if STR_门诊病历号 is null then
      -- 【构造数据】
      ---- 产生【门诊病历号】
      PR_公用_取得业务病历号(STR_机构编码   => STR_医院编码,
                    STR_病历号类型 => '门诊病历号',
                    STR_返回病历号 => STR_门诊病历号,
                    INT_返回值     => INT_返回值,
                    STR_返回信息   => STR_返回信息);
      IF INT_返回值 <> 1 THEN
        STR_返回信息 := '产生门诊病历号失败,原因:' + STR_返回信息;
        GOTO 退出;
      END IF;
    
      ---- 产生【挂号序号】
      PR_获取_系统唯一号(PRM_唯一号编码 => '26',
                  PRM_机构编码   => STR_医院编码,
                  PRM_事物类型   => '1',
                  PRM_返回唯一号 => STR_挂号序号,
                  PRM_执行结果   => INT_返回值,
                  PRM_错误信息   => STR_返回信息);
      IF INT_返回值 <> 0 THEN
        STR_返回信息 := '产生挂号序号失败!';
        GOTO 退出;
      END IF;
      ---- 产生【挂号单号】
      SELECT FU_公用_获取当前票据号(STR_医院编码, STR_平台标识, '4')
        INTO STR_挂号单号
        FROM DUAL;
    
      IF STR_挂号单号 = '请到财务先领用票据' THEN
        STR_返回信息 := '该操作员无挂号单号,请通知财务先领用票据!';
        GOTO 退出;
      END IF;
    
      -- 【生成挂号记录】 
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
           卡支付金额)
        VALUES
          (STR_医院编码,
           STR_病人ID,
           STR_门诊病历号,
           STR_挂号序号,
           STR_挂号单号,
           '', --挂号科室编码
           NULL,
           STR_平台标识,
           STR_挂号类型编码,
           STR_平台标识,
           DAT_系统时间,
           '否',
           STR_归类编码,
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
           '', --挂号科室编码
           STR_平台标识,
           0,
           0,
           '-1',
           0);
      
        INT_返回值 := SQL%ROWCOUNT;
        IF INT_返回值 = 0 THEN
          INT_返回值   := -1;
          STR_返回信息 := '保存挂号数据失败！';
          GOTO 退出;
        END IF;
      
        -- 【生成收支款记录】
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
          (STR_医院编码,
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
          INT_返回值   := -1;
          STR_返回信息 := '保存收支款数据失败！';
          GOTO 退出;
        END IF;
      
      EXCEPTION
        WHEN OTHERS THEN
          INT_返回值   := -1;
          STR_返回信息 := STR_返回信息 || SQLERRM;
          GOTO 退出;
      END;
    else
      begin
        select g.挂号序号
          into STR_挂号序号
          from 门诊管理_挂号登记 g
         where g.机构编码 = STR_医院编码
           and g.门诊病历号 = STR_门诊病历号;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          INT_返回值   := -1;
          STR_返回信息 := '未找到有效的挂号信息！';
          GOTO 退出;
        WHEN OTHERS THEN
          INT_返回值   := -1;
          STR_返回信息 := '系统异常1：' || SQLERRM;
          GOTO 退出;
      END;
    end if;
  
    update 门诊管理_门诊医嘱
       set 收费状态 = '发送已收费'
     where 机构编码 = STR_医院编码
       and 病人ID = STR_病人ID
       and 门诊病历号 = STR_门诊病历号;
  
    ---- 产生【医嘱号】
    PR_获取_系统唯一号(PRM_唯一号编码 => '8',
                PRM_机构编码   => STR_医院编码,
                PRM_事物类型   => '1',
                PRM_返回唯一号 => STR_医嘱号,
                PRM_执行结果   => INT_返回值,
                PRM_错误信息   => STR_返回信息);
    IF INT_返回值 <> 0 THEN
      STR_返回信息 := '产生医嘱号失败!';
      GOTO 退出;
    END IF;
  
    STR_SQL := 'SELECT 大类编码,
             小类编码,
             单位编码,
             单位名称,
             项目编码,
             项目名称,
             门诊执行科室编码,
             归类编码,
             门诊价 FROM 基础项目_诊疗字典
       WHERE 机构编码 = ''' || STR_医院编码 || '''
         AND 项目编码 in ( ''260000002*'',''31070100105'')';
    OPEN CUR_临时数据 FOR STR_SQL;
  
    LOOP
      FETCH CUR_临时数据
        INTO STR_大类编码,
             STR_小类编码,
             STR_单位编码,
             STR_单位名称,
             STR_项目编码,
             STR_项目名称,
             STR_执行科室编码,
             STR_归类编码,
             NUM_总费用;
      EXIT WHEN CUR_临时数据%NOTFOUND;
    
      ---- 产生【申请单ID】
      PR_获取_系统唯一号(PRM_唯一号编码 => '33',
                  PRM_机构编码   => STR_医院编码,
                  PRM_事物类型   => '1',
                  PRM_返回唯一号 => STR_申请单ID,
                  PRM_执行结果   => INT_返回值,
                  PRM_错误信息   => STR_返回信息);
      IF INT_返回值 <> 0 THEN
        STR_返回信息 := '产生申请单ID失败!';
        GOTO 退出;
      END IF;
    
      ----产生【项目ID】
      SELECT SYS_GUID() INTO STR_项目ID FROM DUAL;
    
      ----产生【序号】
      SELECT SEQ_门诊医嘱_序号.NEXTVAL INTO STR_序号 FROM DUAL;
    
      --【生成门诊医嘱】
      INSERT INTO 门诊管理_门诊医嘱
        (机构编码,
         序号,
         病人ID,
         门诊病历号,
         医嘱号,
         开方科室编码,
         核算科室编码,
         执行科室编码,
         病人科室编码,
         开方医生编码,
         操作员编码,
         操作员姓名,
         录入时间,
         大类编码,
         小类编码,
         项目编码,
         项目名称,
         组号,
         用量,
         剂量编码,
         剂量名称,
         总量,
         剂数,
         单位编码,
         单位名称,
         用法编码,
         用法名称,
         频率编码,
         频率名称,
         开始时间,
         紧急,
         医嘱状态,
         排序号,
         换算比例,
         检验申请ID,
         挂号序号,
         处方序号,
         天数,
         皮试标志,
         收费状态,
         划价方式,
         总金额,
         单价,
         项目ID,
         医嘱内容,
         医嘱性质)
      VALUES
        (STR_医院编码,
         STR_序号,
         STR_病人ID,
         STR_门诊病历号,
         STR_医嘱号,
         '', --开方科室编码
         '', --核算科室编码
         STR_执行科室编码,
         '', --病人科室编码
         STR_平台标识,
         STR_平台标识,
         STR_平台名称,
         SYSDATE,
         STR_大类编码,
         STR_小类编码,
         STR_项目编码,
         STR_项目名称,
         SEQ_门诊医嘱_组号.NEXTVAL,
         1,
         '37',
         '项',
         1,
         1,
         STR_单位编码,
         STR_单位名称,
         '0000000002',
         '处置',
         '1003',
         '一次性',
         SYSDATE,
         '否',
         '有效',
         1,
         1,
         STR_申请单ID,
         STR_挂号序号,
         SEQ_门诊医嘱_处方序号.NEXTVAL,
         1,
         '-1',
         '发送未收费',
         '医生划价',
         NUM_总费用,
         NUM_总费用,
         STR_项目ID,
         STR_项目名称,
         '0000003920');
    
      INT_返回值 := SQL%ROWCOUNT;
      IF INT_返回值 = 0 THEN
        INT_返回值   := -1;
        STR_返回信息 := '保存门诊医嘱失败！';
        GOTO 退出;
      END IF;
    
      --【生成门诊医嘱项目】
      INSERT INTO 门诊管理_门诊医嘱项目
        (机构编码,
         病人ID,
         门诊病历号,
         医嘱号,
         项目ID,
         大类编码,
         小类编码,
         项目编码,
         项目名称,
         换算比例,
         用量,
         剂量编码,
         剂量名称,
         剂数,
         总量,
         单价,
         总金额,
         单位编码,
         单位名称,
         用法编码,
         用法名称,
         执行科室编码,
         生成时间,
         大单位单价,
         小单位单价,
         计价ID,
         划价方式,
         操作员编码,
         开方医生编码,
         开方科室编码,
         序号,
         归类编码)
      VALUES
        (STR_医院编码,
         STR_病人ID,
         STR_门诊病历号,
         STR_医嘱号,
         STR_项目ID,
         STR_大类编码,
         STR_小类编码,
         STR_项目编码,
         STR_项目名称,
         1,
         1,
         '37',
         '项',
         1,
         1,
         NUM_总费用,
         NUM_总费用,
         STR_单位编码,
         STR_单位名称,
         '0000000002',
         '处置',
         STR_执行科室编码,
         SYSDATE,
         0,
         NUM_总费用,
         SYS_GUID(),
         '医生划价',
         STR_平台标识,
         STR_平台标识,
         '', --开方科室编码
         STR_序号,
         STR_归类编码);
      INT_返回值 := SQL%ROWCOUNT;
      IF INT_返回值 = 0 THEN
        INT_返回值   := -1;
        STR_返回信息 := '保存门诊医嘱项目失败！';
        GOTO 退出;
      END IF;
    
      --【生成检验检查_申请】
      INSERT INTO 检验检查_申请
        (机构编码,
         申请单ID,
         项目编码,
         项目名称,
         执行科室编码,
         医生编码,
         申请时间,
         结果状态,
         唯一ID,
         ID类型,
         医嘱号,
         病人ID,
         病历号,
         挂号序号,
         套餐类型,
         类型)
      VALUES
        (STR_医院编码,
         STR_申请单ID,
         STR_项目编码,
         STR_项目名称,
         STR_执行科室编码,
         STR_平台标识,
         SYSDATE,
         '未报告',
         SYS_GUID(),
         '门诊',
         STR_医嘱号,
         STR_病人ID,
         STR_门诊病历号,
         STR_挂号序号,
         1,
         '检验');
      INT_返回值 := SQL%ROWCOUNT;
      IF INT_返回值 = 0 THEN
        INT_返回值   := -1;
        STR_返回信息 := '保存检验检查申请失败！';
        GOTO 退出;
      END IF;
    
     
    
    END LOOP;
  
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '系统异常：' || SQLERRM;
      GOTO 退出;
  END;

  INT_返回值   := 0;
  STR_返回信息 := '处理成功!' || STR_门诊病历号;

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  COMMIT;
  RETURN;

  --【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  --【错误日志】
  /*PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
  STR_客户端标识 => STR_客户端标识,
  STR_医院编码   => STR_医院编码,
  STR_功能编码   => STR_功能编码,
  STR_请求参数   => STR_请求参数,
  DAT_请求时间   => DAT_系统时间,
  STR_请求结果   => STR_返回信息,
  STR_关联编码   => NULL,
  STR_执行人     => STR_平台标识,
  DAT_执行时间   => SYSDATE,
  STR_执行状态   => INT_返回值);*/
  ROLLBACK;
  RETURN;

END PR_平台接口_测试_医嘱数据;
/

prompt
prompt Creating procedure PR_平台接口_检查报告结果
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_检查报告结果(STR_请求参数   IN VARCHAR2,

                                           CUR_返回结果集 OUT SYS_REFCURSOR,
                                           INT_返回值     OUT INTEGER,
                                           STR_返回信息   OUT VARCHAR2) IS
  -- 固定参数
  DAT_系统时间 DATE;

  -- 请求参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_病人ID   VARCHAR2(50);
  STR_病历号   VARCHAR2(50);
  STR_报告单号 VARCHAR2(50);

BEGIN
  BEGIN

    -- 请求功能有效性验证
    IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '非法请求！';
      GOTO 退出;
    END IF;

    -- 就诊人有效性验证
    IF FU_平台接口_验证就诊人信息(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '就诊人信息无效！';
      GOTO 退出;
    END IF;

    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;

    -- 【请求参数解析】
    STR_平台标识   := FU_平台接口_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_平台接口_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_平台接口_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 5);

    -- 【功能参数解析】
    STR_病人ID   := FU_平台接口_截取字符串值(STR_请求参数, '|', 6);
    STR_病历号   := FU_平台接口_截取字符串值(STR_请求参数, '|', 7);
    STR_报告单号 := FU_平台接口_截取字符串值(STR_请求参数, '|', 8);

    -- 数据验证
    IF STR_病人ID IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的病人ID！';
      GOTO 退出;
    END IF;

    IF STR_病历号 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的病历号！';
      GOTO 退出;
    END IF;

    IF STR_报告单号 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的报告单号！';
      GOTO 退出;
    END IF;

    /*
    说明：
        1）只显示6个月内的检查报告
    */
    OPEN CUR_返回结果集 FOR
      SELECT S.病人ID AS 病人ID,
             S.病历号 AS 病历号,
             J.报告单号 AS 报告单号,
             J.文字报告内容 AS 检查所见,
             '' AS 检查结论,
             NVL((SELECT 人员姓名
                   FROM 基础项目_人员资料 Z
                  WHERE Z.机构编码 = J.机构编码
                    AND Z.人员编码 = J.报告医生编码),
                 '') AS 报告医生,
             J.报告时间 AS 报告时间
        FROM 检验检查_申请 S, 检验检查_结果 J
       WHERE S.机构编码 = J.机构编码
         AND S.申请单ID = J.申请单ID
         AND S.机构编码 = STR_医院编码
         AND S.病人ID = STR_病人ID
         AND S.病历号 = STR_病历号
         AND J.报告单号 = STR_报告单号
         AND S.申请时间 > ADD_MONTHS(SYSDATE, -6);

    INT_返回值   := 0;
    STR_返回信息 := '成功!';

    -- 【保存日志】
    PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
                 STR_客户端标识 => STR_客户端标识,
                 STR_医院编码   => STR_医院编码,
                 STR_功能编码   => STR_功能编码,
                 STR_请求参数   => STR_请求参数,
                 DAT_请求时间   => DAT_系统时间,
                 STR_请求结果   => STR_返回信息,
                 STR_关联编码   => STR_报告单号,
                 STR_执行人     => STR_平台标识,
                 DAT_执行时间   => SYSDATE,
                 STR_执行状态   => INT_返回值);

    RETURN;

  EXCEPTION
    -- 未检测的系统异常
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := SQLERRM;
      GOTO 退出;
  END;

  -- 【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  RETURN;

END PR_平台接口_检查报告结果;
/

prompt
prompt Creating procedure PR_平台接口_检验报告结果
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_检验报告结果(STR_请求参数   IN VARCHAR2,
                                           CUR_返回结果集 OUT SYS_REFCURSOR,
                                           INT_返回值     OUT INTEGER,
                                           STR_返回信息   OUT VARCHAR2) IS
  -- 固定参数
  DAT_系统时间 DATE;

  -- 请求参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_病人ID   VARCHAR2(50);
  STR_病历号   VARCHAR2(50);
  STR_报告单号 VARCHAR2(50);

BEGIN
  BEGIN
  
    -- 请求功能有效性验证
    IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '非法请求！';
      GOTO 退出;
    END IF;
  
    -- 就诊人有效性验证
    IF FU_平台接口_验证就诊人信息(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '就诊人信息无效！';
      GOTO 退出;
    END IF;
  
    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
  
    -- 【请求参数解析】
    STR_平台标识   := FU_平台接口_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_平台接口_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_平台接口_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 5);
  
    -- 【功能参数解析】
    STR_病人ID   := FU_平台接口_截取字符串值(STR_请求参数, '|', 6);
    STR_病历号   := FU_平台接口_截取字符串值(STR_请求参数, '|', 7);
    STR_报告单号 := FU_平台接口_截取字符串值(STR_请求参数, '|', 8);
  
    -- 数据验证
    IF STR_病人ID IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的病人ID！';
      GOTO 退出;
    END IF;
  
    IF STR_病历号 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的病历号！';
      GOTO 退出;
    END IF;
  
    IF STR_报告单号 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的报告单号！';
      GOTO 退出;
    END IF;
  
    /*
    说明：
        1）只显示6个月内的检验报告
    */
    OPEN CUR_返回结果集 FOR
      SELECT S.病人ID AS 病人ID,
             S.病历号 AS 病历号,
             J.报告单号 AS 报告单号,
             M.序号 AS 顺序号,
             M.细项名称 AS 检验项目,
             M.细项编码 AS 项目编码,
             M.细项值 AS 检验结果,
             M.单位 AS 单位,
             M.参考值上限 AS 参考范围,
             M.结论 AS 检验结论,
             NVL((SELECT 人员姓名
                   FROM 基础项目_人员资料 Z
                  WHERE Z.机构编码 = J.机构编码
                    AND Z.人员编码 = J.报告医生编码),
                 '') AS 报告医生,
             J.报告时间 AS 报告时间
        FROM 检验检查_申请 S, 检验检查_结果 J, 检验检查_结果_明细 M
       WHERE S.机构编码 = J.机构编码
         AND S.申请单ID = J.申请单ID
         AND S.机构编码 = M.机构编码
         AND J.报告单号 = M.报告单ID
         AND S.机构编码 = STR_医院编码
         AND S.病人ID = STR_病人ID
         AND S.病历号 = STR_病历号
         AND J.报告单号 = STR_报告单号
         AND S.结果状态 = '已报告'
         AND S.申请时间 > ADD_MONTHS(SYSDATE, -6);
  
    INT_返回值   := 0;
    STR_返回信息 := '成功!';
  
    -- 【保存日志】
    PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
                 STR_客户端标识 => STR_客户端标识,
                 STR_医院编码   => STR_医院编码,
                 STR_功能编码   => STR_功能编码,
                 STR_请求参数   => STR_请求参数,
                 DAT_请求时间   => DAT_系统时间,
                 STR_请求结果   => STR_返回信息,
                 STR_关联编码   => STR_报告单号,
                 STR_执行人     => STR_平台标识,
                 DAT_执行时间   => SYSDATE,
                 STR_执行状态   => INT_返回值);
  
    RETURN;
  
  EXCEPTION
    -- 未检测的系统异常
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := SQLERRM;
      GOTO 退出;
  END;

  -- 【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  RETURN;

END PR_平台接口_检验报告结果;
/

prompt
prompt Creating procedure PR_平台接口_检验检查报告列表
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_检验检查报告列表(STR_请求参数   IN VARCHAR2,
                                             CUR_返回结果集 OUT SYS_REFCURSOR,
                                             INT_返回值     OUT INTEGER,
                                             STR_返回信息   OUT VARCHAR2) IS
  -- 固定参数
  DAT_系统时间 DATE;

  -- 请求参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_病人ID   VARCHAR2(50);
  STR_病历号   VARCHAR2(50);
  STR_报告来源 VARCHAR2(50);
  STR_报告类型 VARCHAR2(50);

BEGIN
  BEGIN

    -- 请求功能有效性验证
    IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '非法请求！';
      GOTO 退出;
    END IF;

    -- 就诊人有效性验证
    IF FU_平台接口_验证就诊人信息(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '就诊人信息无效！';
      GOTO 退出;
    END IF;

    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;

    -- 【请求参数解析】
    STR_平台标识   := FU_平台接口_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_平台接口_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_平台接口_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 5);

    -- 【功能参数解析】
    STR_病人ID   := FU_平台接口_截取字符串值(STR_请求参数, '|', 6);
    STR_病历号   := FU_平台接口_截取字符串值(STR_请求参数, '|', 7);
    STR_报告来源 := FU_平台接口_截取字符串值(STR_请求参数, '|', 8);
    STR_报告类型 := FU_平台接口_截取字符串值(STR_请求参数, '|', 9);

    -- 数据验证
    IF STR_病人ID IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的病人ID！';
      GOTO 退出;
    END IF;

    IF STR_病历号 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的病历号！';
      GOTO 退出;
    END IF;

    IF STR_报告来源 IS NULL
       OR (STR_报告来源 <> '门诊' AND STR_报告来源 <> '住院') THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的报告来源！';
      GOTO 退出;
    END IF;

    IF STR_报告类型 IS NULL
       OR (STR_报告类型 <> '检验' AND STR_报告类型 <> '检查') THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的报告类型！';
      GOTO 退出;
    END IF;

    /*
    说明：
        1）只显示6个月内的检验/检查申请
        2）只显示已报告的申请
        3）返回报表单号
    */
    OPEN CUR_返回结果集 FOR
      SELECT S.病人ID   AS 病人ID,
             S.病历号   AS 病历号,
             J.报告单号 AS 报告单号,
             S.项目名称 AS 项目名称,
             J.报告时间 AS 报告时间
        FROM 检验检查_申请 S, 检验检查_结果 J
       WHERE S.机构编码 = J.机构编码
         AND S.申请单ID = J.申请单ID
         AND S.机构编码 = STR_医院编码
         AND S.病人ID = STR_病人ID
         AND S.病历号 = DECODE(STR_病历号, '-1', S.病历号, STR_病历号)
         AND S.ID类型 = STR_报告来源
         AND S.类型 = STR_报告类型
         AND S.结果状态 = '已报告'
         AND S.申请时间 > ADD_MONTHS(SYSDATE, -6);

    INT_返回值   := 0;
    STR_返回信息 := '成功!';

    -- 【保存日志】
    PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
                 STR_客户端标识 => STR_客户端标识,
                 STR_医院编码   => STR_医院编码,
                 STR_功能编码   => STR_功能编码,
                 STR_请求参数   => STR_请求参数,
                 DAT_请求时间   => DAT_系统时间,
                 STR_请求结果   => STR_返回信息,
                 STR_关联编码   => NULL,
                 STR_执行人     => STR_平台标识,
                 DAT_执行时间   => SYSDATE,
                 STR_执行状态   => INT_返回值);

    RETURN;

  EXCEPTION
    -- 未检测的系统异常
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := SQLERRM;
      GOTO 退出;
  END;

  -- 【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  RETURN;

END PR_平台接口_检验检查报告列表;
/

prompt
prompt Creating procedure PR_平台接口_就诊人查询
prompt ================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_就诊人查询(STR_请求参数   IN VARCHAR2,
                                          CUR_返回结果集 OUT SYS_REFCURSOR,
                                          INT_返回值     OUT INTEGER,
                                          STR_返回信息   OUT VARCHAR2) IS
  -- 固定参数
  DAT_系统时间 DATE;

  --请求参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

BEGIN
  BEGIN

    -- 请求验证
    IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '非法请求！';
      GOTO 退出;
    END IF;

    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;

    -- 【请求参数解析】
    STR_平台标识   := FU_平台接口_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_平台接口_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_平台接口_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 5);

    /*
    说明：
        1）只显示有效的就诊人列表。
    */
    OPEN CUR_返回结果集 FOR
      SELECT 病人ID,
             就诊人类别,
             姓名,
             性别,
             出生日期,
             身份证号,
             手机号码,
             联系地址,
             监护人姓名,
             监护人身份证号,
             监护人手机号码,
             监护人联系地址,
             创建时间 AS 注册时间
        FROM 平台接口_就诊人信息 J
       WHERE 平台标识 = STR_平台标识
         AND 客户端标识 = STR_客户端标识
         AND 医院编码 = STR_医院编码
         AND 状态 = 0;

    INT_返回值   := 0;
    STR_返回信息 := '成功!';

    -- 【保存日志】
    PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
                 STR_客户端标识 => STR_客户端标识,
                 STR_医院编码   => STR_医院编码,
                 STR_功能编码   => STR_功能编码,
                 STR_请求参数   => STR_请求参数,
                 DAT_请求时间   => DAT_系统时间,
                 STR_请求结果   => STR_返回信息,
                 STR_关联编码   => NULL,
                 STR_执行人     => STR_平台标识,
                 DAT_执行时间   => SYSDATE,
                 STR_执行状态   => INT_返回值);

    RETURN;

  EXCEPTION
    -- 未检测的系统异常
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := SQLERRM;
      GOTO 退出;
  END;

  -- 【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  RETURN;

END PR_平台接口_就诊人查询;
/

prompt
prompt Creating procedure PR_平台接口_就诊人注册
prompt ================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_就诊人注册(STR_请求参数   IN VARCHAR2,
                                          CUR_返回结果集 OUT SYS_REFCURSOR,
                                          INT_返回值     OUT INTEGER,
                                          STR_返回信息   OUT VARCHAR2) IS
  -- 固定参数
  DAT_系统时间 DATE;

  --请求参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 业务参数
  STR_就诊人类别     VARCHAR2(50);
  STR_病人ID         VARCHAR2(50);
  STR_姓名           VARCHAR2(50);
  STR_性别           VARCHAR2(50);
  STR_出生日期       VARCHAR2(50);
  DAT_出生日期       DATE;
  STR_年龄           VARCHAR2(50);
  STR_手机号码       VARCHAR2(50);
  STR_身份证号       VARCHAR2(50);
  STR_联系地址       VARCHAR2(100);
  STR_监护人姓名     VARCHAR2(50);
  STR_监护人身份证号 VARCHAR2(50);
  STR_监护人手机号码 VARCHAR2(50);
  STR_监护人联系地址 VARCHAR2(100);

BEGIN
  BEGIN
  
    -- 请求验证
    IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '非法请求！请确认平台标识、认证密钥、医院编码及功能编码是否正确！';
      GOTO 退出;
    END IF;
  
    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
  
    -- 【请求参数解析】
    STR_平台标识   := FU_平台接口_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_平台接口_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_平台接口_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 5);
  
    --【功能定义部分】
    STR_就诊人类别     := FU_平台接口_截取字符串值(STR_请求参数, '|', 6);
    STR_姓名           := FU_平台接口_截取字符串值(STR_请求参数, '|', 7);
    STR_性别           := FU_平台接口_截取字符串值(STR_请求参数, '|', 8);
    STR_出生日期       := FU_平台接口_截取字符串值(STR_请求参数, '|', 9);
    STR_身份证号       := FU_平台接口_截取字符串值(STR_请求参数, '|', 10);
    STR_手机号码       := FU_平台接口_截取字符串值(STR_请求参数, '|', 11);
    STR_联系地址       := FU_平台接口_截取字符串值(STR_请求参数, '|', 12);
    STR_监护人姓名     := FU_平台接口_截取字符串值(STR_请求参数, '|', 13);
    STR_监护人身份证号 := FU_平台接口_截取字符串值(STR_请求参数, '|', 14);
    STR_监护人手机号码 := FU_平台接口_截取字符串值(STR_请求参数, '|', 15);
    STR_监护人联系地址 := FU_平台接口_截取字符串值(STR_请求参数, '|', 16);
  
    /*
    处理流程：
        1）判断请求是否是合法请求
        2）请求参数解析
        3）请求参数有效性判断
        4）病人类型为本人或其他时，身份证必添，并根据身份证生成性别/出生日期
        5）病人类型为子女人时，身份证可不添，如果添写了身份证则推断生成性别/出生日期，
           如果未添，则必须添写性别/年龄/出生日期/监护人信息
        6）查询身份证是否已经绑定：是：返回绑定错误；否，生成病人信息，生成绑定信息
    */
  
    -- 【数据校验】
  
    -- 0)同一客户端标识只能绑定4个就诊人
    SELECT COUNT(1)
      INTO INT_返回值
      FROM 平台接口_就诊人信息 B
     WHERE B.平台标识 = STR_平台标识
       AND B.客户端标识 = STR_客户端标识
       AND B.医院编码 = STR_医院编码
       AND B.状态 = '0';
  
    IF INT_返回值 >= 4 THEN
      INT_返回值   := -1;
      STR_返回信息 := '已注册就诊人数量超过4个！';
      GOTO 退出;
    END IF;
  
    -- 1）姓名
    IF STR_姓名 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '请输入姓名！';
      GOTO 退出;
    END IF;
  
    -- 2）病人类别
    IF STR_就诊人类别 = '子女' THEN
      -- 2.1)子女
      IF STR_身份证号 IS NULL THEN
        -- 不输入身份证时，要求输入监护人信息
        -- 2.1.1)性别
        IF STR_性别 IS NULL OR FU_平台接口_验证性别(STR_性别) <> 0 THEN
          INT_返回值   := -1;
          STR_返回信息 := '请输入有效的性别！';
          GOTO 退出;
        END IF;
        -- 2.1.2)出生日期
        IF STR_出生日期 IS NULL OR FU_尝试转日期(STR_出生日期) IS NULL THEN
          INT_返回值   := -1;
          STR_返回信息 := '请输入有效的出生日期！！';
          GOTO 退出;
        END IF;
        -- 2.1.3)监护人，需要验证身份证有效期
        IF STR_监护人姓名 IS NULL OR STR_监护人身份证号 IS NULL OR STR_监护人手机号码 IS NULL OR
           FU_平台接口_验证手机号(STR_监护人手机号码) <> 0 OR
           FU_平台接口_验证身份证(STR_监护人身份证号) <> 0 THEN
          INT_返回值   := -1;
          STR_返回信息 := '请输入有效的监护人姓名、身份证号、手机号码信息！';
          GOTO 退出;
        END IF;
        -- 2.1.4)年龄
        STR_年龄     := FU_得到_年龄(TO_DATE(STR_出生日期, 'yyyy-mm-dd'));
        DAT_出生日期 := TO_DATE(STR_出生日期, 'yyyy-mm-dd');
      ELSE
        -- 输入身份证时，解构信息
        IF FU_平台接口_验证身份证(STR_身份证号) <> 0 THEN
          STR_返回信息 := '无效的身份证号码';
          INT_返回值   := -1;
          GOTO 退出;
        ELSE
          INT_返回值 := FU_平台接口_解构身份证(STR_身份证号 => STR_身份证号,
                                   DAT_出生日期 => DAT_出生日期,
                                   STR_年龄     => STR_年龄,
                                   STR_性别     => STR_性别,
                                   STR_返回信息 => STR_返回信息);
          IF INT_返回值 <> 0 THEN
            GOTO 退出;
          END IF;
        END IF;
      END IF;
    
    ELSIF STR_就诊人类别 = '本人' OR STR_就诊人类别 = '其他' THEN
      -- 2.2)本人或其他
      -- 2.2.1)身份证
      INT_返回值 := FU_平台接口_解构身份证(STR_身份证号 => STR_身份证号,
                               DAT_出生日期 => DAT_出生日期,
                               STR_年龄     => STR_年龄,
                               STR_性别     => STR_性别,
                               STR_返回信息 => STR_返回信息);
      IF INT_返回值 <> 0 THEN
        GOTO 退出;
      END IF;
      -- 2.2.2)手机号码
      IF STR_手机号码 IS NULL OR FU_平台接口_验证手机号(STR_手机号码) <> 0 THEN
        INT_返回值   := -1;
        STR_返回信息 := '请输入有效的手机号码！';
        GOTO 退出;
      END IF;
      -- 2.2.3)清除不使用的字段数据值
      STR_监护人姓名     := NULL;
      STR_监护人身份证号 := NULL;
      STR_监护人手机号码 := NULL;
      STR_监护人联系地址 := NULL;
    ELSE
      -- 2.3)无法识别
      INT_返回值   := -1;
      STR_返回信息 := '无法识别的病人类别！';
      GOTO 退出;
    END IF;
  
    -- 【判断病人信息是否存在】
    -- 1) 是否已经注册
    -- 1.1)子女
    IF STR_就诊人类别 = '子女' THEN
      SELECT COUNT(1)
        INTO INT_返回值
        FROM 平台接口_就诊人信息 B
       WHERE B.平台标识 = STR_平台标识
         AND B.医院编码 = STR_医院编码
         AND ((B.监护人身份证号 = STR_监护人身份证号 AND B.姓名 = STR_姓名) OR
             B.身份证号 = STR_身份证号)
         AND B.状态 = '0';
    ELSE
      --1.2)本人或其他
      SELECT COUNT(1)
        INTO INT_返回值
        FROM 平台接口_就诊人信息 B
       WHERE B.平台标识 = STR_平台标识
         AND B.医院编码 = STR_医院编码
         AND B.身份证号 = STR_身份证号
         AND B.状态 = '0';
    END IF;
  
    IF INT_返回值 <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '此身份证已被其他用户注册！';
      GOTO 退出;
    END IF;
  
    -- 2) HIS系统中是否存在
    IF STR_就诊人类别 = '子女' THEN
      -- 子女
      SELECT COUNT(1)
        INTO INT_返回值
        FROM 基础项目_病人信息 B
        LEFT JOIN 基础项目_病人信息_其他 C
          ON B.机构编码 = C.机构编码
         AND B.病人ID = C.病人ID
       WHERE B.机构编码 = STR_医院编码
         AND ((C.监护人身份证号 = STR_监护人身份证号 AND B.姓名 = STR_姓名) OR
             B.身份证号 = STR_身份证号);
    ELSE
      -- 本人或其他
      SELECT COUNT(1)
        INTO INT_返回值
        FROM 基础项目_病人信息 B
       WHERE B.机构编码 = STR_医院编码
         AND B.身份证号 = STR_身份证号;
    END IF;
  
    IF INT_返回值 = 0 THEN
    
      -- 2.1) 不存在则生成病人信息
      -- 生成病人ID
      PR_获取_系统唯一号(PRM_唯一号编码 => '30',
                  PRM_机构编码   => STR_医院编码,
                  PRM_事物类型   => '1',
                  PRM_返回唯一号 => STR_病人ID,
                  PRM_执行结果   => INT_返回值,
                  PRM_错误信息   => STR_返回信息);
    
      IF INT_返回值 <> 0 THEN
        INT_返回值   := -1;
        STR_返回信息 := '生成病人ID失败,原因:' + STR_返回信息;
        GOTO 退出;
      END IF;
    
      -- 插入病人信息
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
        (STR_医院编码,
         STR_病人ID,
         NULL,
         NULL,
         STR_姓名,
         STR_性别,
         DAT_出生日期,
         STR_年龄,
         NULL,
         NULL,
         STR_手机号码,
         NULL,
         NULL,
         NULL,
         SYSDATE,
         FU_通用_汉字_转换_首拼(STR_姓名),
         FU_通用_汉字_转换_五笔(STR_姓名),
         NULL,
         STR_身份证号,
         NULL,
         STR_平台标识,
         NULL,
         NULL,
         NULL,
         NULL,
         NULL,
         NULL,
         NULL,
         NULL,
         NULL,
         NULL);
    
      -- 插入病人辅助信息
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
        (STR_医院编码,
         STR_病人ID,
         NULL,
         NULL,
         NULL,
         NULL,
         NULL,
         NULL,
         STR_就诊人类别,
         STR_监护人姓名,
         STR_监护人身份证号,
         STR_监护人手机号码,
         STR_监护人联系地址,
         '1');
    ELSE
      -- 2.2) 存在则返回病人信息
      /*
        存在的问题，有可能会返回多条记录
      */
      IF STR_就诊人类别 = '子女' THEN
        -- 子女
        SELECT B.病人ID
          INTO STR_病人ID
          FROM 基础项目_病人信息 B
          LEFT JOIN 基础项目_病人信息_其他 C
            ON B.机构编码 = C.机构编码
           AND B.病人ID = C.病人ID
         WHERE B.机构编码 = STR_医院编码
           AND ((C.监护人身份证号 = STR_监护人身份证号 AND B.姓名 = STR_姓名) OR
               B.身份证号 = STR_身份证号)
           AND ROWNUM = 1;
      ELSE
        -- 本人或其他
        SELECT 病人ID
          INTO STR_病人ID
          FROM 基础项目_病人信息 B
         WHERE B.机构编码 = STR_医院编码
           AND B.身份证号 = STR_身份证号
           AND ROWNUM = 1;
      END IF;
    END IF;
  
    -- 【注册病人信息】
    INSERT INTO 平台接口_就诊人信息
      (流水码,
       平台标识,
       客户端标识,
       医院编码,
       病人ID,
       就诊人类别,
       姓名,
       性别,
       出生日期,
       身份证号,
       手机号码,
       联系地址,
       监护人姓名,
       监护人身份证号,
       监护人手机号码,
       监护人联系地址,
       创建人,
       创建时间,
       更新人,
       更新时间,
       排序号,
       备注,
       状态)
    VALUES
      (SEQ_平台接口_就诊人信息_流水码.NEXTVAL,
       STR_平台标识,
       STR_客户端标识,
       STR_医院编码,
       STR_病人ID,
       STR_就诊人类别,
       STR_姓名,
       STR_性别,
       DAT_出生日期,
       STR_身份证号,
       STR_手机号码,
       STR_联系地址,
       STR_监护人姓名,
       STR_监护人身份证号,
       STR_监护人手机号码,
       STR_监护人联系地址,
       STR_平台标识,
       DAT_系统时间,
       NULL,
       NULL,
       0,
       NULL,
       0);
  
    -- 【正常退出】
    OPEN CUR_返回结果集 FOR
      SELECT STR_病人ID AS 病人ID, DAT_系统时间 AS 注册时间 FROM DUAL;
  
    INT_返回值   := 0;
    STR_返回信息 := '成功!';
  
    -- 【保存日志】
    PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
                 STR_客户端标识 => STR_客户端标识,
                 STR_医院编码   => STR_医院编码,
                 STR_功能编码   => STR_功能编码,
                 STR_请求参数   => STR_请求参数,
                 DAT_请求时间   => DAT_系统时间,
                 STR_请求结果   => STR_返回信息,
                 STR_关联编码   => STR_病人ID,
                 STR_执行人     => STR_平台标识,
                 DAT_执行时间   => SYSDATE,
                 STR_执行状态   => INT_返回值);
  
    COMMIT;
    RETURN;
  
  EXCEPTION
    -- 未检测的系统异常
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := SQLERRM;
      GOTO 退出;
  END;

  -- 【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  ROLLBACK;
  RETURN;

END PR_平台接口_就诊人注册;
/

prompt
prompt Creating procedure PR_平台接口_就诊人注销
prompt ================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_就诊人注销(STR_请求参数   IN VARCHAR2,
                                          CUR_返回结果集 OUT SYS_REFCURSOR,
                                          INT_返回值     OUT INTEGER,
                                          STR_返回信息   OUT VARCHAR2) IS
  -- 固定参数
  DAT_系统时间 DATE;

  --请求参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 业务参数
  STR_病人ID VARCHAR2(50);

BEGIN
  BEGIN

    -- 请求功能有效性验证
    IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '非法请求！';
      GOTO 退出;
    END IF;

    -- 就诊人有效性验证
    IF FU_平台接口_验证就诊人信息(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '就诊人信息无效！';
      GOTO 退出;
    END IF;

    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;

    -- 【请求参数解析】
    STR_平台标识   := FU_平台接口_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_平台接口_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_平台接口_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 5);

    --【功能定义部分】
    STR_病人ID := FU_平台接口_截取字符串值(STR_请求参数, '|', 6);

    -- 【数据校验】
    IF STR_病人ID IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的病人ID！';
      GOTO 退出;
    END IF;

    -- 【就诊人注销】
    /*
       只能删除指定平台，指定客户端，指定医院编码，且状态为0（有效）的绑定病人ID记录。
    */
    UPDATE 平台接口_就诊人信息 J
       SET J.更新人 = STR_平台标识, J.更新时间 = DAT_系统时间, J.状态 = -1
     WHERE 平台标识 = STR_平台标识
       AND 客户端标识 = STR_客户端标识
       AND 医院编码 = STR_医院编码
       AND 状态 = 0
       AND 病人ID = STR_病人ID;

    -- 【正常退出】
    OPEN CUR_返回结果集 FOR
      SELECT NULL FROM DUAL;

    INT_返回值   := 0;
    STR_返回信息 := '成功!';

    -- 【保存日志】
    PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
                 STR_客户端标识 => STR_客户端标识,
                 STR_医院编码   => STR_医院编码,
                 STR_功能编码   => STR_功能编码,
                 STR_请求参数   => STR_请求参数,
                 DAT_请求时间   => DAT_系统时间,
                 STR_请求结果   => STR_返回信息,
                 STR_关联编码   => STR_病人ID,
                 STR_执行人     => STR_平台标识,
                 DAT_执行时间   => SYSDATE,
                 STR_执行状态   => INT_返回值);

    COMMIT;
    RETURN;

  EXCEPTION
    -- 未检测的系统异常
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := SQLERRM;
      GOTO 退出;
  END;

  -- 【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  ROLLBACK;
  RETURN;

END PR_平台接口_就诊人注销;
/

prompt
prompt Creating procedure PR_平台接口_科室列表
prompt ===============================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_科室列表(STR_请求参数   IN VARCHAR2,
                                         CUR_返回结果集 OUT SYS_REFCURSOR,
                                         INT_返回值     OUT INTEGER,
                                         STR_返回信息   OUT VARCHAR2) IS
  -- 固定参数
  DAT_系统时间 DATE;

  --请求参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_科室种类 VARCHAR2(50);

BEGIN
  BEGIN
  
    -- 请求验证
  
    IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '非法请求！';
      GOTO 退出;
    END IF;
  
    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
  
    -- 【请求参数解析】
    STR_平台标识   := FU_平台接口_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_平台接口_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_平台接口_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 5);
  
    -- 【功能参数解析】
    STR_科室种类 := FU_平台接口_截取字符串值(STR_请求参数, '|', 6);
  
    -- 数据校验
    IF STR_科室种类 <> '门诊'
       AND STR_科室种类 <> '住院' THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的科室种类！';
      GOTO 退出;
    END IF;
  
    /*
    说明：
        1）只显示有效的科室列表。
        2）门诊只显示有挂号权限的科室。
    */
    IF STR_科室种类 = '门诊' THEN
      OPEN CUR_返回结果集 FOR
        SELECT 科室编码, 科室名称
          FROM 基础项目_科室资料
         WHERE 机构编码 = STR_医院编码
           AND 有效状态 = '有效'
           AND 删除标志 = '0'
           AND 是否挂号 = '是'
           AND 科室类型 LIKE '%1.门诊,%';
    ELSIF STR_科室种类 = '住院' THEN
      OPEN CUR_返回结果集 FOR
        SELECT 科室编码, 科室名称
          FROM 基础项目_科室资料
         WHERE 机构编码 = STR_医院编码
           AND 有效状态 = '有效'
           AND 删除标志 = '0'
           AND 科室类型 LIKE '%2.住院,%';
    END IF;
  
    INT_返回值   := 0;
    STR_返回信息 := '成功!';
  
    -- 【保存日志】
    PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
                 STR_客户端标识 => STR_客户端标识,
                 STR_医院编码   => STR_医院编码,
                 STR_功能编码   => STR_功能编码,
                 STR_请求参数   => STR_请求参数,
                 DAT_请求时间   => DAT_系统时间,
                 STR_请求结果   => STR_返回信息,
                 STR_关联编码   => STR_科室种类,
                 STR_执行人     => STR_平台标识,
                 DAT_执行时间   => SYSDATE,
                 STR_执行状态   => INT_返回值);
  
    RETURN;
  
  EXCEPTION
    -- 未检测的系统异常
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := SQLERRM;
      GOTO 退出;
  END;

  -- 【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  RETURN;

END PR_平台接口_科室列表;
/

prompt
prompt Creating procedure PR_平台接口_生成医嘱明细
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_生成医嘱明细(STR_机构编码 IN VARCHAR2,
                                           STR_挂号序号 IN VARCHAR2,
                                           STR_医嘱号   IN VARCHAR2,
                                           STR_收费序号 OUT VARCHAR2,
                                           INT_返回值   OUT INTEGER,
                                           STR_返回信息 OUT VARCHAR2) IS
  STR_舍入方式       VARCHAR(50);
  INT_小数位数       NUMBER;
  STR_药品取价方式   VARCHAR(50);
  STR_使用已保存单价 VARCHAR(50);
  STR_操作类型       VARCHAR(50);
  I_天数             NUMBER;

  CUR_处方信息 SYS_REFCURSOR;
  CUR_项目信息 SYS_REFCURSOR;
  ROW_处方信息 临时表_门诊医嘱明细%ROWTYPE;
BEGIN

  -- 读取系统参数

  STR_操作类型 := '门诊管理';

  SELECT SYS_GUID() INTO STR_收费序号 FROM DUAL;

  BEGIN
    SELECT 值
      INTO STR_舍入方式
      FROM 基础项目_机构参数列表
     WHERE 参数编码 = '257'
       AND 机构编码 = STR_机构编码;
  EXCEPTION
    WHEN OTHERS THEN
      STR_舍入方式 := '1';
  END;

  BEGIN
    SELECT TO_NUMBER(值)
      INTO INT_小数位数
      FROM 基础项目_机构参数列表
     WHERE 参数编码 = '256'
       AND 机构编码 = STR_机构编码;
  EXCEPTION
    WHEN OTHERS THEN
      INT_小数位数 := '2';
  END;

  BEGIN
    SELECT 值
      INTO STR_药品取价方式
      FROM 基础项目_机构参数列表
     WHERE 参数编码 = '117'
       AND 机构编码 = STR_机构编码;
  EXCEPTION
    WHEN OTHERS THEN
      STR_药品取价方式 := '3';
  END;

  BEGIN
    SELECT 值
      INTO STR_使用已保存单价
      FROM 基础项目_机构参数列表
     WHERE 参数编码 = '187'
       AND 机构编码 = STR_机构编码;
  EXCEPTION
    WHEN OTHERS THEN
      STR_使用已保存单价 := '否';
  END;

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
  
    DELETE FROM 门诊管理_门诊医嘱明细
     WHERE 机构编码 = STR_机构编码
       AND 挂号序号 = STR_挂号序号
       AND 医嘱号 = STR_医嘱号
       AND 收费序号 = STR_收费序号;
  
    -- 整理待收费处方
    PR_门诊管理_待收费处方(STR_机构编码       => STR_机构编码,
                  STR_挂号序号       => STR_挂号序号,
                  I_天数             => I_天数,
                  STR_药品取价方式   => STR_药品取价方式, --门诊价,住院价,批发价,零售价
                  STR_使用已保存单价 => STR_使用已保存单价, --村医是否修改单价
                  STR_舍入方式       => STR_舍入方式, --四舍五入,向前进位等
                  INT_小数位数       => INT_小数位数, --保留几位小数
                  STR_传入医嘱号     => STR_医嘱号, --部位
                  STR_操作类型       => STR_操作类型, --门诊管理;药房管理,乡村医生
                  CUR_处方信息       => CUR_处方信息,
                  CUR_项目信息       => CUR_项目信息, --用于返回该次划价的医嘱项目信息
                  INT_返回值         => INT_返回值,
                  STR_返回信息       => STR_返回信息);
  
    IF INT_返回值 <> 1 THEN
      INT_返回值   := -1;
      STR_返回信息 := '无法获得有效的待缴费数据!';
      GOTO 退出;
    END IF;
  
    -- 插入医嘱明细
    LOOP
      FETCH CUR_处方信息
        INTO ROW_处方信息;
      EXIT WHEN CUR_处方信息%NOTFOUND;
      INSERT INTO 门诊管理_门诊医嘱明细
        (机构编码,
         流水码,
         病人ID,
         门诊病历号,
         挂号序号,
         医嘱号,
         序号,
         开方科室编码,
         核算科室编码,
         执行科室编码,
         病人科室编码,
         开方医生编码,
         操作员编码,
         操作员姓名,
         生成时间,
         发送时间,
         大类编码,
         小类编码,
         项目编码,
         项目名称,
         规格,
         批次号,
         批号,
         厂家名称,
         有效期,
         进价,
         国药准字,
         批准文号,
         单位编码,
         单位名称,
         换算比例,
         剂型编码,
         剂型名称,
         分类编码,
         分类名称,
         药理编码,
         药理名称,
         农合类别,
         医保类别,
         城居类别,
         打折比例,
         单价,
         数量,
         剂数,
         总金额,
         归类编码,
         组号,
         用量,
         剂量编码,
         剂量名称,
         用法编码,
         用法名称,
         频率编码,
         频率名称,
         医生嘱托,
         发送标志,
         暂存标志,
         通用名,
         国标码,
         基药分类,
         划价方式,
         原流水码,
         占用数修改标志,
         天数,
         手术登记号,
         套餐编码,
         申请单ID,
         大单位单价,
         小单位单价,
         计价ID,
         收费序号,
         草药剂数,
         原始医嘱号,
         原始序号,
         优惠金额,
         批发价,
         零售价,
         门诊价,
         住院价)
      VALUES
        (ROW_处方信息.机构编码,
         ROW_处方信息.流水码,
         ROW_处方信息.病人ID,
         ROW_处方信息.门诊病历号,
         ROW_处方信息.挂号序号,
         ROW_处方信息.医嘱号,
         ROW_处方信息.序号,
         ROW_处方信息.开方科室编码,
         ROW_处方信息.核算科室编码,
         ROW_处方信息.执行科室编码,
         ROW_处方信息.病人科室编码,
         ROW_处方信息.开方医生编码,
         ROW_处方信息.操作员编码,
         ROW_处方信息.操作员姓名,
         ROW_处方信息.生成时间,
         ROW_处方信息.发送时间,
         ROW_处方信息.大类编码,
         ROW_处方信息.小类编码,
         ROW_处方信息.项目编码,
         ROW_处方信息.项目名称,
         ROW_处方信息.规格,
         ROW_处方信息.批次号,
         ROW_处方信息.批号,
         ROW_处方信息.厂家名称,
         ROW_处方信息.有效期,
         ROW_处方信息.进价,
         ROW_处方信息.国药准字,
         ROW_处方信息.批准文号,
         ROW_处方信息.单位编码,
         ROW_处方信息.单位名称,
         ROW_处方信息.换算比例,
         ROW_处方信息.剂型编码,
         ROW_处方信息.剂型名称,
         ROW_处方信息.分类编码,
         ROW_处方信息.分类名称,
         ROW_处方信息.药理编码,
         ROW_处方信息.药理名称,
         ROW_处方信息.农合类别,
         ROW_处方信息.医保类别,
         ROW_处方信息.城居类别,
         ROW_处方信息.打折比例,
         ROW_处方信息.单价,
         ROW_处方信息.数量,
         ROW_处方信息.剂数,
         ROW_处方信息.总金额,
         ROW_处方信息.归类编码,
         ROW_处方信息.组号,
         ROW_处方信息.用量,
         ROW_处方信息.剂量编码,
         ROW_处方信息.剂量名称,
         ROW_处方信息.用法编码,
         ROW_处方信息.用法名称,
         ROW_处方信息.频率编码,
         ROW_处方信息.频率名称,
         ROW_处方信息.医生嘱托,
         ROW_处方信息.发送标志,
         ROW_处方信息.暂存标志,
         ROW_处方信息.通用名,
         ROW_处方信息.国标码,
         ROW_处方信息.基药分类,
         ROW_处方信息.划价方式,
         ROW_处方信息.原流水码,
         ROW_处方信息.占用数修改标志,
         ROW_处方信息.天数,
         ROW_处方信息.手术登记号,
         ROW_处方信息.套餐编码,
         ROW_处方信息.申请单ID,
         ROW_处方信息.大单位单价,
         ROW_处方信息.小单位单价,
         ROW_处方信息.计价ID,
         STR_收费序号,
         ROW_处方信息.草药剂数,
         ROW_处方信息.原始医嘱号,
         ROW_处方信息.原始序号,
         ROW_处方信息.优惠金额,
         ROW_处方信息.批发价,
         ROW_处方信息.零售价,
         ROW_处方信息.门诊价,
         ROW_处方信息.住院价);
    
      IF SQL%ROWCOUNT <= 0 THEN
        INT_返回值   := -1;
        STR_返回信息 := '生成缴费订单失败!';
        GOTO 退出;
      END IF;
    END LOOP;
  
    CLOSE CUR_处方信息;
  
    INT_返回值   := 0;
    STR_返回信息 := '成功';
  
    COMMIT;
    RETURN;
  
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '系统异常：' || SQLERRM;
      GOTO 退出;
  END;

  <<退出>>

  IF CUR_处方信息%ISOPEN THEN
    CLOSE CUR_处方信息;
  END IF;
  STR_收费序号 := '';
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  ROLLBACK;

END PR_平台接口_生成医嘱明细;
/

prompt
prompt Creating procedure PR_平台接口_门诊待缴费请求
prompt ==================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_门诊待缴费请求(STR_请求参数   IN VARCHAR2,
                                            CUR_返回结果集 OUT SYS_REFCURSOR,
                                            INT_返回值     OUT INTEGER,
                                            STR_返回信息   OUT VARCHAR2) IS

  DAT_系统时间 DATE;

  -- 固定参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_病人ID     VARCHAR2(50);
  STR_门诊病历号 VARCHAR2(50);

  -- 处理参数
  STR_是否接诊才能收费 VARCHAR2(50);
  I_天数               INTEGER;

  STR_收费序号 VARCHAR2(50);
  STR_医嘱号   VARCHAR2(50);
  STR_挂号序号 VARCHAR2(50);

  NUM_待缴费总额 NUMBER(18, 3);

BEGIN
  begin
  
    -- 【请求功能有效性验证】
    IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '非法请求！';
      GOTO 退出;
    END IF;
  
    -- 【就诊人有效性验证】
    IF FU_平台接口_验证就诊人信息(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '就诊人信息无效！';
      GOTO 退出;
    END IF;
  
    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
  
    -- 【固定参数解析】
  
    STR_平台标识   := FU_通用_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_通用_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_通用_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_通用_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_通用_截取字符串值(STR_请求参数, '|', 5);
  
    -- 【功能参数解析】
  
    STR_病人ID     := FU_通用_截取字符串值(STR_请求参数, '|', 6);
    STR_门诊病历号 := FU_通用_截取字符串值(STR_请求参数, '|', 7);
  
    -- 【入参有期性验证】
    IF STR_病人ID IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '请输入有效的病人ID！';
      GOTO 退出;
    END IF;
    IF STR_门诊病历号 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '请输入有效的门诊病历号！';
      GOTO 退出;
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '系统异常0：' || SQLERRM;
      GOTO 退出;
  END;

  -- 读取系统参数
  BEGIN
    SELECT TO_NUMBER(值)
      INTO I_天数
      FROM 基础项目_机构参数列表
     WHERE 参数编码 = '48'
       AND 机构编码 = STR_医院编码;
  EXCEPTION
    WHEN OTHERS THEN
      I_天数 := 15;
  END;

  BEGIN
    SELECT 值
      INTO STR_是否接诊才能收费
      FROM 基础项目_机构参数列表
     WHERE 参数编码 = '311'
       AND 机构编码 = STR_医院编码;
  EXCEPTION
    WHEN OTHERS THEN
      STR_是否接诊才能收费 := '否';
  END;

  --【构造数据】

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
       AND A.机构编码 = STR_医院编码
       AND A.门诊病历号 = STR_门诊病历号
       AND A.病人ID = STR_病人ID
       /*AND C.挂号时间 > TRUNC(SYSDATE) - I_天数 + 1
       AND A.录入时间 > TRUNC(SYSDATE) - I_天数 + 1*/
       AND C.挂号时间 > TRUNC(SYSDATE) - 11
       AND A.录入时间 > TRUNC(SYSDATE) - 11
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
  
    PR_平台接口_生成医嘱明细(STR_机构编码 => STR_医院编码,
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

  -- 【返回结果】
  BEGIN
    SELECT SUM(总金额)
      INTO NUM_待缴费总额
      FROM 门诊管理_门诊医嘱明细
     WHERE 机构编码 = STR_医院编码
       AND 门诊病历号 = STR_门诊病历号
       AND 病人ID = STR_病人ID
       AND 挂号序号 = STR_挂号序号
       AND 收费序号 = STR_收费序号;
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '系统异常：' || SQLERRM;
      GOTO 退出;
  END;

  OPEN CUR_返回结果集 FOR
    SELECT 病人ID,
           门诊病历号,
           收费序号,
           项目编码,
           项目名称,
           规格,
           数量,
           单位名称,
           单价,
           总金额,
           NUM_待缴费总额 AS 待缴费总额,
           生成时间
      FROM 门诊管理_门诊医嘱明细
     WHERE 机构编码 = STR_医院编码
       AND 门诊病历号 = STR_门诊病历号
       AND 病人ID = STR_病人ID
       AND 挂号序号 = STR_挂号序号
       AND 收费序号 = STR_收费序号;

  INT_返回值   := 0;
  STR_返回信息 := '处理成功!';

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => STR_收费序号,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  COMMIT;
  RETURN;

  --【异常退出】
  <<退出>>

  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  --【错误日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  ROLLBACK;
  RETURN;

END PR_平台接口_门诊待缴费请求;
/

prompt
prompt Creating procedure PR_平台接口_门诊待缴费生成
prompt ==================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_门诊待缴费生成(STR_请求参数   IN VARCHAR2,
                                            CUR_返回结果集 OUT SYS_REFCURSOR,
                                            INT_返回值     OUT INTEGER,
                                            STR_返回信息   OUT VARCHAR2) IS

  DAT_系统时间 DATE;

  -- 固定参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_病人ID     VARCHAR2(50);
  STR_门诊病历号 VARCHAR2(50);
  STR_收费序号   VARCHAR2(50);

  -- 处理参数
  STR_订单号       VARCHAR2(50);
  DAT_订单过期时间 DATE;
  STR_订单备注     VARCHAR2(50);
  NUM_应付金额     NUMBER(18, 3);

  CURSOR CUR_待缴费明细 IS
    SELECT *
      FROM 门诊管理_门诊医嘱明细
     WHERE 机构编码 = STR_医院编码
       AND 病人ID = STR_病人ID
       AND 门诊病历号 = STR_门诊病历号
       AND 收费序号 = STR_收费序号;

  ROW_待缴费明细 CUR_待缴费明细%ROWTYPE;

BEGIN

  -- 【请求功能有效性验证】
  IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
    INT_返回值   := -1;
    STR_返回信息 := '非法请求！';
    GOTO 退出;
  END IF;

  -- 【就诊人有效性验证】
  IF FU_平台接口_验证就诊人信息(STR_请求参数) <> 0 THEN
    INT_返回值   := -1;
    STR_返回信息 := '就诊人信息无效！';
    GOTO 退出;
  END IF;

  -- 【数据初始化】
  SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
  NUM_应付金额 := 0;

  -- 【固定参数解析】

  STR_平台标识   := FU_通用_截取字符串值(STR_请求参数, '|', 1);
  STR_认证密匙   := FU_通用_截取字符串值(STR_请求参数, '|', 2);
  STR_客户端标识 := FU_通用_截取字符串值(STR_请求参数, '|', 3);
  STR_功能编码   := FU_通用_截取字符串值(STR_请求参数, '|', 4);
  STR_医院编码   := FU_通用_截取字符串值(STR_请求参数, '|', 5);

  -- 【功能参数解析】

  STR_病人ID     := FU_通用_截取字符串值(STR_请求参数, '|', 6);
  STR_门诊病历号 := FU_通用_截取字符串值(STR_请求参数, '|', 7);
  STR_收费序号   := FU_通用_截取字符串值(STR_请求参数, '|', 8);

  -- 【入参有期性验证】
  IF STR_病人ID IS NULL THEN
    INT_返回值   := -1;
    STR_返回信息 := '请输入有效的病人ID！';
    GOTO 退出;
  END IF;
  IF STR_门诊病历号 IS NULL THEN
    INT_返回值   := -1;
    STR_返回信息 := '请输入有效的门诊病历号！';
    GOTO 退出;
  END IF;
  IF STR_收费序号 IS NULL THEN
    INT_返回值   := -1;
    STR_返回信息 := '请输入有效的收费序号！';
    GOTO 退出;
  END IF;

  -- 判断缴费状态
  -- 医嘱表
  SELECT COUNT(1)
    INTO INT_返回值
    FROM 门诊管理_门诊医嘱明细 M, 门诊管理_门诊医嘱 Y
   WHERE M.机构编码 = Y.机构编码
     AND M.病人ID = Y.病人ID
     AND M.门诊病历号 = Y.门诊病历号
     AND M.序号 = Y.序号
     AND M.医嘱号 = Y.医嘱号
     AND M.机构编码 = STR_医院编码
     AND M.病人ID = STR_病人ID
     AND M.门诊病历号 = STR_门诊病历号
     AND M.收费序号 = STR_收费序号
     AND Y.收费状态 = '发送未收费'
     AND Y.划价方式 <> '退费自动划价';

  IF INT_返回值 <= 0 THEN
    INT_返回值   := -1;
    STR_返回信息 := '缴费记录已失效!';
    GOTO 退出;
  END IF;

  -- 处方表
  SELECT COUNT(1)
    INTO INT_返回值
    FROM 门诊管理_门诊医嘱明细 M, 门诊管理_门诊处方 C
   WHERE M.机构编码 = C.机构编码
     AND M.病人ID = C.病人ID
     AND M.门诊病历号 = C.门诊病历号
     AND M.序号 = C.序号
     AND M.医嘱号 = C.医嘱号
     AND M.流水码 = C.医嘱流水码
     AND M.机构编码 = STR_医院编码
     AND M.病人ID = STR_病人ID
     AND M.门诊病历号 = STR_门诊病历号
     AND M.收费序号 = STR_收费序号;

  IF INT_返回值 > 0 THEN
    INT_返回值   := -1;
    STR_返回信息 := '缴费记录已失效!';
    GOTO 退出;
  END IF;

  BEGIN
  
    IF INT_返回值 <> -1 THEN
      -- 1)生成订单号
      PR_获取_系统唯一号(PRM_唯一号编码 => '6001',
                  PRM_机构编码   => STR_医院编码,
                  PRM_事物类型   => '1',
                  PRM_返回唯一号 => STR_订单号,
                  PRM_执行结果   => INT_返回值,
                  PRM_错误信息   => STR_返回信息);
      IF INT_返回值 <> 0 THEN
        INT_返回值   := -1;
        STR_返回信息 := '产生订单号失败!';
        GOTO 退出;
      END IF;
    
      -- 2)生成过期时间
      SELECT SYSDATE + (1 / (24 * 60)) * 15
        INTO DAT_订单过期时间
        FROM DUAL;
    
      -- 3)生成订单备注
      STR_订单备注 := '请在15分钟内完成支付，过期自动取消';
    
      -- 4)保存订单明细
      OPEN CUR_待缴费明细;
      LOOP
        FETCH CUR_待缴费明细
          INTO ROW_待缴费明细;
        EXIT WHEN CUR_待缴费明细%NOTFOUND;
      
        INSERT INTO 平台接口_订单明细
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
          (SEQ_平台接口_订单明细_流水码.NEXTVAL,
           STR_订单号,
           ROW_待缴费明细.流水码,
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
    
      -- 5)保存订单
      INSERT INTO 平台接口_订单
        (流水码,
         平台标识,
         客户端标识,
         医院编码,
         病人ID,
         就诊病历号,
         关联编码,
         订单号,
         订单类型,
         订单时间,
         应付金额,
         优惠金额,
         实收金额,
         过期时间,
         订单状态,
         创建人,
         创建时间)
      VALUES
        (SEQ_平台接口_订单_流水码.NEXTVAL,
         STR_平台标识,
         STR_客户端标识,
         STR_医院编码,
         STR_病人ID,
         STR_门诊病历号,
         STR_收费序号,
         STR_订单号,
         '门诊缴费',
         DAT_系统时间,
         NUM_应付金额,
         0,
         0,
         DAT_订单过期时间,
         '待支付',
         STR_平台标识,
         DAT_系统时间);
    
      INT_返回值 := SQL%ROWCOUNT;
      IF INT_返回值 = 0 THEN
        INT_返回值   := -1;
        STR_返回信息 := '保存订单失败！';
        GOTO 退出;
      END IF;
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '系统异常：' || SQLERRM;
      GOTO 退出;
  END;

  -- 【返回结果】
  OPEN CUR_返回结果集 FOR
    SELECT STR_病人ID AS 病人ID,
           STR_门诊病历号 AS 门诊病历号,
           STR_收费序号 AS 收费序号,
           STR_订单号 AS 订单号,
           NUM_应付金额 AS 应付金额,
           DAT_订单过期时间 AS 过期时间,
           '请在15分钟内完成支付' AS 备注
      FROM DUAL;

  INT_返回值   := 0;
  STR_返回信息 := '处理成功!';

  CLOSE CUR_待缴费明细;

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => STR_订单号,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  COMMIT;
  RETURN;

  --【异常退出】
  <<退出>>
  IF CUR_待缴费明细%ISOPEN THEN
    CLOSE CUR_待缴费明细;
  END IF;
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  --【错误日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  ROLLBACK;
  RETURN;

END PR_平台接口_门诊待缴费生成;
/

prompt
prompt Creating procedure PR_平台接口_门诊待缴费支付
prompt ==================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_门诊待缴费支付(STR_请求参数   IN VARCHAR2,
                                            CUR_返回结果集 OUT SYS_REFCURSOR,
                                            INT_返回值     OUT INTEGER,
                                            STR_返回信息   OUT VARCHAR2) IS

  DAT_系统时间 DATE;
  STR_平台名称 VARCHAR2(50);

  -- 固定参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_病人ID       VARCHAR2(50);
  STR_订单类型     VARCHAR2(50);
  STR_订单号       VARCHAR2(50);
  STR_平台订单号   VARCHAR2(50);
  STR_平台交易号   VARCHAR2(50);
  STR_订单应付金额 VARCHAR2(50);
  STR_平台实收金额 VARCHAR2(50);
  STR_平台订单时间 VARCHAR2(50);
  STR_平台交易时间 VARCHAR2(50);

  -- 处理参数
  STR_发票号         VARCHAR2(50);
  STR_发票序号       VARCHAR2(50);
  STR_医嘱号         VARCHAR2(50);
  STR_收费序号       VARCHAR2(50);
  STR_门诊病历号     VARCHAR2(50);
  INT_小数位数       INTEGER;
  STR_舍入方式       VARCHAR2(50);
  STR_收费直接扣库存 VARCHAR2(50);
  STR_按执行科室分票 VARCHAR2(50);

  STR_支付方式     VARCHAR2(50);
  STR_挂号序号     VARCHAR2(50);
  STR_病人类型编码 VARCHAR2(50);
  STR_病人类型名称 VARCHAR2(50);

  CUR_预算信息     SYS_REFCURSOR;
  STR_预算结果明细 VARCHAR2(4000);

  STR_执行科室编码 VARCHAR(50);
  NUM_费用总额     NUMBER(18, 3);
  NUM_自付总额     NUMBER(18, 3);
  NUM_优惠总额     NUMBER(18, 3);
  NUM_应收总额     NUMBER(18, 3);
  NUM_舍入总额     NUMBER(18, 3);
  NUM_实收总额     NUMBER(18, 3);
  NUM_补偿总额     NUMBER(18, 3);

  NUM_银联卡支付总额 NUMBER(18, 3);

BEGIN
  BEGIN
    -- 【请求功能有效性验证】
    IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '非法请求！';
      GOTO 退出;
    END IF;
  
    -- 【就诊人有效性验证】
    IF FU_平台接口_验证就诊人信息(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '就诊人信息无效！';
      GOTO 退出;
    END IF;
  
    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
    STR_订单类型     := '门诊缴费';
    STR_病人类型编码 := '1';
    STR_病人类型名称 := '现金';
  
    -- 【固定参数解析】
  
    STR_平台标识   := FU_通用_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_通用_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_通用_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_通用_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_通用_截取字符串值(STR_请求参数, '|', 5);
  
    -- 【功能参数解析】
  
    STR_病人ID       := FU_通用_截取字符串值(STR_请求参数, '|', 6);
    STR_订单号       := FU_通用_截取字符串值(STR_请求参数, '|', 7);
    STR_平台订单号   := FU_通用_截取字符串值(STR_请求参数, '|', 8);
    STR_平台订单时间 := FU_通用_截取字符串值(STR_请求参数, '|', 9);
    STR_平台交易号   := FU_通用_截取字符串值(STR_请求参数, '|', 10);
    STR_平台交易时间 := FU_通用_截取字符串值(STR_请求参数, '|', 11);
    STR_订单应付金额 := FU_通用_截取字符串值(STR_请求参数, '|', 12);
    STR_平台实收金额 := FU_通用_截取字符串值(STR_请求参数, '|', 13);
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '系统异常0：' || SQLERRM;
      GOTO 退出;
  END;

  -- 【读取平台信息】
  BEGIN
    SELECT P.支付方式, P.平台名称
      INTO STR_支付方式, STR_平台名称
      FROM 平台接口_平台配置 P
     WHERE P.平台标识 = STR_平台标识;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INT_返回值   := -1;
      STR_返回信息 := '未找到有效的平台信息！';
      GOTO 退出;
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '系统异常：' || SQLERRM;
      GOTO 退出;
  END;

  -- 【参数有期性验证】
  IF STR_病人ID IS NULL THEN
    INT_返回值   := -1;
    STR_返回信息 := '请输入有效的病人ID！';
    GOTO 退出;
  END IF;
  IF STR_订单号 IS NULL THEN
    INT_返回值   := -1;
    STR_返回信息 := '请输入有效的订单号！';
    GOTO 退出;
  END IF;
  IF STR_平台订单号 IS NULL THEN
    INT_返回值   := -1;
    STR_返回信息 := '请输入有效的平台订单号！';
    GOTO 退出;
  END IF;
  IF STR_平台交易号 IS NULL THEN
    INT_返回值   := -1;
    STR_返回信息 := '请输入有效的平台交易号！';
    GOTO 退出;
  END IF;
  IF STR_订单应付金额 IS NULL THEN
    INT_返回值   := -1;
    STR_返回信息 := '请输入有效的订单应付金额！';
    GOTO 退出;
  END IF;
  IF STR_平台实收金额 IS NULL THEN
    INT_返回值   := -1;
    STR_返回信息 := '请输入有效的平台实收金额！';
    GOTO 退出;
  END IF;
  IF STR_平台订单时间 IS NULL OR FU_尝试转日期(STR_平台订单时间) IS NULL THEN
    INT_返回值   := -1;
    STR_返回信息 := '请输入有效的订单时间！';
    GOTO 退出;
  END IF;
  IF STR_平台交易时间 IS NULL OR FU_尝试转日期(STR_平台交易时间) IS NULL THEN
    INT_返回值   := -1;
    STR_返回信息 := '请输入有效的交易时间！';
    GOTO 退出;
  END IF;

  IF STR_订单应付金额 <> STR_平台实收金额 THEN
    INT_返回值   := -1;
    STR_返回信息 := '应付金额与实收金额不付！';
    GOTO 退出;
  END IF;

  -- 系统参数
  BEGIN
    SELECT 值
      INTO STR_舍入方式
      FROM 基础项目_机构参数列表
     WHERE 参数编码 = '53'
       AND 机构编码 = STR_医院编码;
  EXCEPTION
    WHEN OTHERS THEN
      STR_舍入方式 := '2';
  END;

  BEGIN
    SELECT TO_NUMBER(值)
      INTO INT_小数位数
      FROM 基础项目_机构参数列表
     WHERE 参数编码 = '52'
       AND 机构编码 = STR_医院编码;
  EXCEPTION
    WHEN OTHERS THEN
      INT_小数位数 := 2;
  END;

  BEGIN
    SELECT 值
      INTO STR_收费直接扣库存
      FROM 基础项目_机构参数列表
     WHERE 参数编码 = '164'
       AND 机构编码 = STR_医院编码;
  EXCEPTION
    WHEN OTHERS THEN
      STR_收费直接扣库存 := '否';
  END;

  BEGIN
    SELECT 值
      INTO STR_按执行科室分票
      FROM 基础项目_机构参数列表
     WHERE 参数编码 = '50'
       AND 机构编码 = STR_医院编码;
  EXCEPTION
    WHEN OTHERS THEN
      STR_按执行科室分票 := '0';
  END;

  -- 验证订单
  BEGIN
    SELECT 关联编码, 就诊病历号
      INTO STR_收费序号, STR_门诊病历号
      FROM 平台接口_订单
     WHERE 平台标识 = STR_平台标识
       AND 医院编码 = STR_医院编码
       AND 客户端标识 = STR_客户端标识
       AND 病人ID = STR_病人ID
       AND 订单号 = STR_订单号
       AND 订单类型 = STR_订单类型
       AND 应付金额 = TO_NUMBER(STR_订单应付金额)
       AND 过期时间 >= SYSDATE
       AND 订单状态 = '待支付';
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的订单！';
      GOTO 退出;
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '系统异常：' || SQLERRM;
      GOTO 退出;
  END;

  -- 验证医嘱状态
  SELECT COUNT(1)
    INTO INT_返回值
    FROM 门诊管理_门诊医嘱明细 M, 门诊管理_门诊医嘱 Y
   WHERE M.机构编码 = Y.机构编码
     AND M.病人ID = Y.病人ID
     AND M.门诊病历号 = Y.门诊病历号
     AND M.序号 = Y.序号
     AND M.医嘱号 = Y.医嘱号
     AND M.机构编码 = STR_医院编码
     AND M.病人ID = STR_病人ID
     AND M.门诊病历号 = STR_门诊病历号
     AND M.收费序号 = STR_收费序号
     AND Y.收费状态 = '发送未收费'
     AND Y.划价方式 <> '退费自动划价';

  IF INT_返回值 <= 0 THEN
    INT_返回值   := -1;
    STR_返回信息 := '缴费记录已失效!';
    GOTO 退出;
  END IF;

  -- 验证处方状态
  SELECT COUNT(1)
    INTO INT_返回值
    FROM 门诊管理_门诊医嘱明细 M, 门诊管理_门诊处方 C
   WHERE M.机构编码 = C.机构编码
     AND M.病人ID = C.病人ID
     AND M.门诊病历号 = C.门诊病历号
     AND M.序号 = C.序号
     AND M.医嘱号 = C.医嘱号
     AND M.流水码 = C.医嘱流水码
     AND M.机构编码 = STR_医院编码
     AND M.病人ID = STR_病人ID
     AND M.门诊病历号 = STR_门诊病历号
     AND M.收费序号 = STR_收费序号;

  IF INT_返回值 > 0 THEN
    INT_返回值   := -1;
    STR_返回信息 := '缴费记录已失效!';
    GOTO 退出;
  END IF;

  -- 验证医嘱明细
  BEGIN
    SELECT DISTINCT 挂号序号, 医嘱号
      INTO STR_挂号序号, STR_医嘱号
      FROM 门诊管理_门诊医嘱明细
     WHERE 机构编码 = STR_医院编码
       AND 病人ID = STR_病人ID
       AND 门诊病历号 = STR_门诊病历号
       AND 收费序号 = STR_收费序号;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的缴费信息！';
      GOTO 退出;
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '系统异常：' || SQLERRM;
      GOTO 退出;
  END;

  -- 生成发票号
  SELECT FU_公用_获取当前票据号(STR_医院编码, STR_平台标识, '1')
    INTO STR_发票号
    FROM DUAL;

  IF STR_发票号 = '请到财务先领用票据' THEN
    STR_返回信息 := '该操作员无发票号,请通知财务先领用票据!';
    GOTO 退出;
  END IF;

  -- 生成发票序号
  SELECT SEQ_门诊管理_发票登记_发票序号.NEXTVAL
    INTO STR_发票序号
    FROM DUAL;

  -- 【功能处理】
  BEGIN
  
    PR_门诊管理_预结算(STR_机构编码       => STR_医院编码,
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
      INT_返回值   := -1;
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
      INT_返回值   := -1;
      STR_返回信息 := '构建预结算记录失败!';
      GOTO 退出;
    END IF;
  
    STR_预算结果明细 := '发票号,执行科室编码,费用总额,补偿总额,自付总额,优惠总额,应收总额,舍入总额,实收总额,发票序号,原发票医卡通支付金额,本次退费总额,本次卡退费总额,本次现金退费总额,银联卡支付总额##' ||
                  STR_预算结果明细;
  
    dbms_output.put_line(STR_预算结果明细);
  
    PR_门诊管理_门诊收费(STR_机构编码       => STR_医院编码,
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
                 STR_操作员名称     => STR_平台名称,
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
      INT_返回值   := -1;
      STR_返回信息 := '保存缴费记录失败!';
      GOTO 退出;
    END IF;
  
    -- 更新订单状态
    UPDATE 平台接口_订单
       SET 订单状态     = '已支付',
           实收金额     = TO_NUMBER(STR_平台实收金额),
           平台订单号   = STR_平台订单号,
           平台订单时间 = TO_DATE(STR_平台订单时间, 'yyyy/mm/dd hh24:mi:ss'),
           平台交易号   = STR_平台交易号,
           平台交易时间 = TO_DATE(STR_平台交易时间, 'yyyy/mm/dd hh24:mi:ss'),
           平台退款号   = NULL,
           平台退款时间 = NULL,
           更新人       = STR_平台标识,
           更新时间     = DAT_系统时间
     WHERE 平台标识 = STR_平台标识
       AND 客户端标识 = STR_客户端标识
       AND 病人ID = STR_病人ID
       AND 订单号 = STR_订单号
       AND 订单类型 = STR_订单类型
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

  -- 【返回结果】
  OPEN CUR_返回结果集 FOR
    SELECT STR_病人ID AS 病人ID,
           STR_门诊病历号 AS 门诊病历号,
           STR_订单号 AS 订单号,
           '' AS 票据号,
           '' AS 备注
      FROM DUAL;

  INT_返回值   := 0;
  STR_返回信息 := '处理成功!';

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => STR_订单号,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  COMMIT;
  RETURN;

  --【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  --【错误日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  ROLLBACK;
  RETURN;

END PR_平台接口_门诊待缴费支付;
/

prompt
prompt Creating procedure PR_平台接口_门诊核酸检测结果
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_门诊核酸检测结果(STR_请求参数   IN VARCHAR2,
                                             CUR_返回结果集 OUT SYS_REFCURSOR,
                                             INT_返回值     OUT INTEGER,
                                             STR_返回信息   OUT VARCHAR2) IS
  -- 固定参数
  DAT_系统时间 DATE;

  -- 请求参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_病人ID VARCHAR2(50);

BEGIN
  BEGIN
  
    -- 请求功能有效性验证
    IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '非法请求！';
      GOTO 退出;
    END IF;
  
    -- 就诊人有效性验证
    IF FU_平台接口_验证就诊人信息(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '就诊人信息无效！';
      GOTO 退出;
    END IF;
  
    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
  
    -- 【请求参数解析】
    STR_平台标识   := FU_平台接口_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_平台接口_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_平台接口_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 5);
  
    -- 【功能参数解析】
    STR_病人ID := FU_平台接口_截取字符串值(STR_请求参数, '|', 6);
  
    -- 数据验证
    IF STR_病人ID IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的病人ID！';
      GOTO 退出;
    END IF;
  
    /*
    说明：
        1）只显示6个月内的检验报告
    */
    OPEN CUR_返回结果集 FOR
      SELECT S.病人ID AS 病人ID,
             S.病历号 AS 病历号,
             J.报告单号 AS 报告单号,
             M.序号 AS 顺序号,
             M.细项名称 AS 检验项目,
             M.细项编码 AS 项目编码,
             M.细项值 AS 检验结果,
             M.单位 AS 单位,
             M.参考值上限 AS 参考范围,
             M.结论 AS 检验结论,
             NVL((SELECT 人员姓名
                   FROM 基础项目_人员资料 Z
                  WHERE Z.机构编码 = J.机构编码
                    AND Z.人员编码 = J.报告医生编码),
                 '') AS 报告医生,
             J.报告时间 AS 报告时间
        FROM 检验检查_申请 S, 检验检查_结果 J, 检验检查_结果_明细 M
       WHERE S.机构编码 = J.机构编码
         AND S.申请单ID = J.申请单ID
         AND S.机构编码 = M.机构编码
         AND J.报告单号 = M.报告单ID
         AND S.机构编码 = STR_医院编码
         AND S.病人ID = STR_病人ID
         AND S.结果状态 = '已报告'
         AND S.项目编码 = 'S250403007' --核酸检测项目
         AND S.申请时间 > ADD_MONTHS(SYSDATE, -6)
       ORDER BY S.申请时间 DESC;
  
    INT_返回值   := 0;
    STR_返回信息 := '成功!';
  
    -- 【保存日志】
    PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
                 STR_客户端标识 => STR_客户端标识,
                 STR_医院编码   => STR_医院编码,
                 STR_功能编码   => STR_功能编码,
                 STR_请求参数   => STR_请求参数,
                 DAT_请求时间   => DAT_系统时间,
                 STR_请求结果   => STR_返回信息,
                 STR_关联编码   => NULL,
                 STR_执行人     => STR_平台标识,
                 DAT_执行时间   => SYSDATE,
                 STR_执行状态   => INT_返回值);
  
    RETURN;
  
  EXCEPTION
    -- 未检测的系统异常
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := SQLERRM;
      GOTO 退出;
  END;

  -- 【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  RETURN;

END PR_平台接口_门诊核酸检测结果;
/

prompt
prompt Creating procedure PR_平台接口_门诊核酸检测预约
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_门诊核酸检测预约(STR_请求参数   IN VARCHAR2,
                                             CUR_返回结果集 OUT SYS_REFCURSOR,
                                             INT_返回值     OUT INTEGER,
                                             STR_返回信息   OUT VARCHAR2) IS
  STR_平台名称 VARCHAR2(50);
  DAT_系统时间 DATE;

  -- 固定参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_病人ID VARCHAR2(50);

  -- 处理参数
  ----病人信息
  STR_姓名     VARCHAR2(50);
  STR_性别     VARCHAR2(50);
  STR_出生日期 VARCHAR2(50);
  STR_婚姻状况 VARCHAR2(50);
  STR_联系电话 VARCHAR2(50);
  STR_家庭地址 VARCHAR2(200);
  STR_工作单位 VARCHAR2(200);
  STR_身份证号 VARCHAR2(50);

  ----挂号相关
  STR_挂号序号     VARCHAR2(50);
  STR_挂号单号     VARCHAR2(50);
  STR_门诊病历号   VARCHAR2(50);
  STR_挂号类型编码 VARCHAR2(50);
  STR_挂号类型名称 VARCHAR2(50);
  NUM_挂号费       NUMBER(18, 3);
  NUM_诊查费       NUMBER(18, 3);
  NUM_总费用       NUMBER(18, 3);
  STR_归类编码     VARCHAR2(50);
  STR_病人类型编码 VARCHAR2(50);
  STR_病人类型名称 VARCHAR2(50);
  STR_就诊状态     VARCHAR2(50);
  STR_挂号来源     VARCHAR2(50);
  STR_付款方式     VARCHAR2(50);

  ----医嘱项目相关
  STR_大类编码     VARCHAR2(50);
  STR_小类编码     VARCHAR2(50);
  STR_项目编码     VARCHAR2(50);
  STR_项目名称     VARCHAR2(100);
  STR_单位编码     VARCHAR2(50);
  STR_单位名称     VARCHAR2(50);
  STR_执行科室编码 VARCHAR2(50);
  STR_医嘱号       VARCHAR2(50);
  STR_项目ID       VARCHAR2(50);
  STR_序号         VARCHAR2(50);
  STR_申请单ID     VARCHAR2(50);

  TYPE REF_CURSOR_TYPE IS REF CURSOR;
  CUR_临时数据 REF_CURSOR_TYPE;
  STR_SQL      VARCHAR2(1000);

BEGIN

  -- 【请求功能有效性验证】
  IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
    INT_返回值   := -1;
    STR_返回信息 := '非法请求！';
    GOTO 退出;
  END IF;

  -- 【就诊人有效性验证】
  IF FU_平台接口_验证就诊人信息(STR_请求参数) <> 0 THEN
    INT_返回值   := -1;
    STR_返回信息 := '就诊人信息无效！';
    GOTO 退出;
  END IF;

  -- 【数据初始化】
  SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;

  STR_病人类型编码 := '1';
  STR_病人类型名称 := '现金';
  STR_就诊状态     := '等待接诊';
  STR_挂号来源     := '预约';

  -- 【固定参数解析】
  STR_平台标识   := FU_通用_截取字符串值(STR_请求参数, '|', 1);
  STR_认证密匙   := FU_通用_截取字符串值(STR_请求参数, '|', 2);
  STR_客户端标识 := FU_通用_截取字符串值(STR_请求参数, '|', 3);
  STR_功能编码   := FU_通用_截取字符串值(STR_请求参数, '|', 4);
  STR_医院编码   := FU_通用_截取字符串值(STR_请求参数, '|', 5);

  -- 【功能参数解析】
  STR_病人ID := FU_通用_截取字符串值(STR_请求参数, '|', 6);

  BEGIN
  
    BEGIN
      SELECT P.支付方式, P.平台名称
        INTO STR_付款方式, STR_平台名称
        FROM 平台接口_平台配置 P
       WHERE P.平台标识 = STR_平台标识;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        INT_返回值   := -1;
        STR_返回信息 := '未找到有效的平台信息！';
        GOTO 退出;
      WHEN OTHERS THEN
        INT_返回值   := -1;
        STR_返回信息 := '系统异常：' || SQLERRM;
        GOTO 退出;
    END;
  
    -- 【入参有期性验证】
    IF STR_病人ID IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '请输入有效的病人ID！';
      GOTO 退出;
    END IF;
  
    --【获取挂号费用相关信息】
    BEGIN
      SELECT 类型编码, 类型名称, 挂号费, 诊查费, 挂号费 + 诊查费, 归类编码
        INTO STR_挂号类型编码,
             STR_挂号类型名称,
             NUM_挂号费,
             NUM_诊查费,
             NUM_总费用,
             STR_归类编码
        FROM 基础项目_挂号类型
       WHERE 机构编码 = STR_医院编码
         AND 类型编码 = '000002' --免费号
         AND 有效状态 = '有效'
         AND 删除标志 = '0';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        INT_返回值   := -1;
        STR_返回信息 := '未找到有效的挂号类型！';
        GOTO 退出;
      WHEN OTHERS THEN
        INT_返回值   := -1;
        STR_返回信息 := '系统异常：' || SQLERRM;
        GOTO 退出;
    END;
  
    --【获取病人信息】
    BEGIN
      SELECT 姓名,
             性别,
             出生日期,
             婚姻状况,
             手机号码,
             家庭地址,
             工作单位,
             身份证号
        INTO STR_姓名,
             STR_性别,
             STR_出生日期,
             STR_婚姻状况,
             STR_联系电话,
             STR_家庭地址,
             STR_工作单位,
             STR_身份证号
        FROM 基础项目_病人信息
       WHERE 机构编码 = STR_医院编码
         AND 病人ID = STR_病人ID;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        INT_返回值   := -1;
        STR_返回信息 := '未找到有效的病人信息！';
        GOTO 退出;
      WHEN OTHERS THEN
        INT_返回值   := -1;
        STR_返回信息 := '系统异常：' || SQLERRM;
        GOTO 退出;
    END;
  
    -- 【构造数据】
    ---- 产生【门诊病历号】
    PR_公用_取得业务病历号(STR_机构编码   => STR_医院编码,
                  STR_病历号类型 => '门诊病历号',
                  STR_返回病历号 => STR_门诊病历号,
                  INT_返回值     => INT_返回值,
                  STR_返回信息   => STR_返回信息);
    IF INT_返回值 <> 1 THEN
      STR_返回信息 := '产生门诊病历号失败,原因:' + STR_返回信息;
      GOTO 退出;
    END IF;
  
    ---- 产生【挂号序号】
    PR_获取_系统唯一号(PRM_唯一号编码 => '26',
                PRM_机构编码   => STR_医院编码,
                PRM_事物类型   => '1',
                PRM_返回唯一号 => STR_挂号序号,
                PRM_执行结果   => INT_返回值,
                PRM_错误信息   => STR_返回信息);
    IF INT_返回值 <> 0 THEN
      STR_返回信息 := '产生挂号序号失败!';
      GOTO 退出;
    END IF;
    ---- 产生【挂号单号】
    SELECT FU_公用_获取当前票据号(STR_医院编码, STR_平台标识, '4')
      INTO STR_挂号单号
      FROM DUAL;
  
    IF STR_挂号单号 = '请到财务先领用票据' THEN
      STR_返回信息 := '该操作员无挂号单号,请通知财务先领用票据!';
      GOTO 退出;
    END IF;
  
    -- 【生成挂号记录】 
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
         卡支付金额)
      VALUES
        (STR_医院编码,
         STR_病人ID,
         STR_门诊病历号,
         STR_挂号序号,
         STR_挂号单号,
         '', --挂号科室编码
         NULL,
         STR_平台标识,
         STR_挂号类型编码,
         STR_平台标识,
         DAT_系统时间,
         '否',
         STR_归类编码,
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
         '', --挂号科室编码
         STR_平台标识,
         0,
         0,
         '-1',
         0);
    
      INT_返回值 := SQL%ROWCOUNT;
      IF INT_返回值 = 0 THEN
        INT_返回值   := -1;
        STR_返回信息 := '保存挂号数据失败！';
        GOTO 退出;
      END IF;
    
      -- 【生成收支款记录】
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
        (STR_医院编码,
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
        INT_返回值   := -1;
        STR_返回信息 := '保存收支款数据失败！';
        GOTO 退出;
      END IF;
    
    EXCEPTION
      WHEN OTHERS THEN
        INT_返回值   := -1;
        STR_返回信息 := STR_返回信息 || SQLERRM;
        GOTO 退出;
    END;
  
    ---- 产生【医嘱号】
    PR_获取_系统唯一号(PRM_唯一号编码 => '8',
                PRM_机构编码   => STR_医院编码,
                PRM_事物类型   => '1',
                PRM_返回唯一号 => STR_医嘱号,
                PRM_执行结果   => INT_返回值,
                PRM_错误信息   => STR_返回信息);
    IF INT_返回值 <> 0 THEN
      STR_返回信息 := '产生医嘱号失败!';
      GOTO 退出;
    END IF;
  
    STR_SQL := 'SELECT 大类编码,
             小类编码,
             单位编码,
             单位名称,
             项目编码,
             项目名称,
             门诊执行科室编码,
             归类编码,
             门诊价 FROM 基础项目_诊疗字典
       WHERE 机构编码 = ''' || STR_医院编码 || '''
         AND 项目编码 in ( ''S250403007'')';--填写所有核酸关联项目编码
    OPEN CUR_临时数据 FOR STR_SQL;
  
    LOOP
      FETCH CUR_临时数据
        INTO STR_大类编码,
             STR_小类编码,
             STR_单位编码,
             STR_单位名称,
             STR_项目编码,
             STR_项目名称,
             STR_执行科室编码,
             STR_归类编码,
             NUM_总费用;
      EXIT WHEN CUR_临时数据%NOTFOUND;
    
      IF STR_项目编码 = 'S250403007' THEN
        ---- 产生【申请单ID】
        PR_获取_系统唯一号(PRM_唯一号编码 => '33',
                    PRM_机构编码   => STR_医院编码,
                    PRM_事物类型   => '1',
                    PRM_返回唯一号 => STR_申请单ID,
                    PRM_执行结果   => INT_返回值,
                    PRM_错误信息   => STR_返回信息);
        IF INT_返回值 <> 0 THEN
          STR_返回信息 := '产生申请单ID失败!';
          GOTO 退出;
        END IF;
      ELSE
        STR_申请单ID := '';
      END IF;
    
      ----产生【项目ID】
      SELECT SYS_GUID() INTO STR_项目ID FROM DUAL;
    
      ----产生【序号】
      SELECT SEQ_门诊医嘱_序号.NEXTVAL INTO STR_序号 FROM DUAL;
    
      --【生成门诊医嘱】
      INSERT INTO 门诊管理_门诊医嘱
        (机构编码,
         序号,
         病人ID,
         门诊病历号,
         医嘱号,
         开方科室编码,
         核算科室编码,
         执行科室编码,
         病人科室编码,
         开方医生编码,
         操作员编码,
         操作员姓名,
         录入时间,
         大类编码,
         小类编码,
         项目编码,
         项目名称,
         组号,
         用量,
         剂量编码,
         剂量名称,
         总量,
         剂数,
         单位编码,
         单位名称,
         用法编码,
         用法名称,
         频率编码,
         频率名称,
         开始时间,
         紧急,
         医嘱状态,
         排序号,
         换算比例,
         检验申请ID,
         挂号序号,
         处方序号,
         天数,
         皮试标志,
         收费状态,
         划价方式,
         总金额,
         单价,
         项目ID,
         医嘱内容,
         医嘱性质)
      VALUES
        (STR_医院编码,
         STR_序号,
         STR_病人ID,
         STR_门诊病历号,
         STR_医嘱号,
         '', --开方科室编码
         '', --核算科室编码
         STR_执行科室编码,
         '', --病人科室编码
         STR_平台标识,
         STR_平台标识,
         STR_平台名称,
         SYSDATE,
         STR_大类编码,
         STR_小类编码,
         STR_项目编码,
         STR_项目名称,
         SEQ_门诊医嘱_组号.NEXTVAL,
         1,
         '37',
         '项',
         1,
         1,
         STR_单位编码,
         STR_单位名称,
         '0000000002',
         '处置',
         '1003',
         '一次性',
         SYSDATE,
         '否',
         '有效',
         1,
         1,
         STR_申请单ID,
         STR_挂号序号,
         SEQ_门诊医嘱_处方序号.NEXTVAL,
         1,
         '-1',
         '发送未收费',
         '医生划价',
         NUM_总费用,
         NUM_总费用,
         STR_项目ID,
         STR_项目名称,
         '0000003920');
    
      INT_返回值 := SQL%ROWCOUNT;
      IF INT_返回值 = 0 THEN
        INT_返回值   := -1;
        STR_返回信息 := '保存门诊医嘱失败！';
        GOTO 退出;
      END IF;
    
      --【生成门诊医嘱项目】
      INSERT INTO 门诊管理_门诊医嘱项目
        (机构编码,
         病人ID,
         门诊病历号,
         医嘱号,
         项目ID,
         大类编码,
         小类编码,
         项目编码,
         项目名称,
         换算比例,
         用量,
         剂量编码,
         剂量名称,
         剂数,
         总量,
         单价,
         总金额,
         单位编码,
         单位名称,
         用法编码,
         用法名称,
         执行科室编码,
         生成时间,
         大单位单价,
         小单位单价,
         计价ID,
         划价方式,
         操作员编码,
         开方医生编码,
         开方科室编码,
         序号,
         归类编码)
      VALUES
        (STR_医院编码,
         STR_病人ID,
         STR_门诊病历号,
         STR_医嘱号,
         STR_项目ID,
         STR_大类编码,
         STR_小类编码,
         STR_项目编码,
         STR_项目名称,
         1,
         1,
         '37',
         '项',
         1,
         1,
         NUM_总费用,
         NUM_总费用,
         STR_单位编码,
         STR_单位名称,
         '0000000002',
         '处置',
         STR_执行科室编码,
         SYSDATE,
         0,
         NUM_总费用,
         SYS_GUID(),
         '医生划价',
         STR_平台标识,
         STR_平台标识,
         '', --开方科室编码
         STR_序号,
         STR_归类编码);
      INT_返回值 := SQL%ROWCOUNT;
      IF INT_返回值 = 0 THEN
        INT_返回值   := -1;
        STR_返回信息 := '保存门诊医嘱项目失败！';
        GOTO 退出;
      END IF;
    
      IF STR_项目编码 = 'S250403007' THEN
        --【生成检验检查_申请】
        INSERT INTO 检验检查_申请
          (机构编码,
           申请单ID,
           项目编码,
           项目名称,
           执行科室编码,
           医生编码,
           申请时间,
           结果状态,
           唯一ID,
           ID类型,
           医嘱号,
           病人ID,
           病历号,
           挂号序号,
           套餐类型,
           类型)
        VALUES
          (STR_医院编码,
           STR_申请单ID,
           STR_项目编码,
           STR_项目名称,
           STR_执行科室编码,
           STR_平台标识,
           SYSDATE,
           '未报告',
           SYS_GUID(),
           '门诊',
           STR_医嘱号,
           STR_病人ID,
           STR_门诊病历号,
           STR_挂号序号,
           1,
           '检验');
        INT_返回值 := SQL%ROWCOUNT;
        IF INT_返回值 = 0 THEN
          INT_返回值   := -1;
          STR_返回信息 := '保存检验检查申请失败！';
          GOTO 退出;
        END IF;
      END IF;
    
    END LOOP;
  
    PR_平台接口_门诊待缴费请求(STR_请求参数   => STR_请求参数 || '|' || STR_门诊病历号,
                    CUR_返回结果集 => CUR_返回结果集,
                    INT_返回值     => INT_返回值,
                    STR_返回信息   => STR_返回信息);
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

  INT_返回值   := 0;
  STR_返回信息 := '处理成功!';

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  COMMIT;
  RETURN;

  --【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  --【错误日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  ROLLBACK;
  RETURN;

END PR_平台接口_门诊核酸检测预约;
/

prompt
prompt Creating procedure PR_平台接口_门诊就诊历史查询
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_门诊就诊历史查询(STR_请求参数   IN VARCHAR2,
                                             CUR_返回结果集 OUT SYS_REFCURSOR,
                                             INT_返回值     OUT INTEGER,
                                             STR_返回信息   OUT VARCHAR2) IS
  -- 固定参数
  DAT_系统时间 DATE;

  -- 请求参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_病人ID     VARCHAR2(50);
  STR_门诊病历号 VARCHAR2(50);
  STR_就诊状态   VARCHAR2(50);

BEGIN
  BEGIN

    -- 请求功能有效性验证
    IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '非法请求！';
      GOTO 退出;
    END IF;

    -- 就诊人有效性验证
    IF FU_平台接口_验证就诊人信息(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '就诊人信息无效！';
      GOTO 退出;
    END IF;

    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;

    -- 【请求参数解析】
    STR_平台标识   := FU_平台接口_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_平台接口_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_平台接口_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 5);

    -- 【功能参数解析】
    STR_病人ID     := FU_平台接口_截取字符串值(STR_请求参数, '|', 6);
    STR_门诊病历号 := FU_平台接口_截取字符串值(STR_请求参数, '|', 7);
    STR_就诊状态   := FU_平台接口_截取字符串值(STR_请求参数, '|', 8);

    -- 数据验证
    IF STR_病人ID IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的病人ID！';
      GOTO 退出;
    END IF;

    IF STR_门诊病历号 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的门诊病历号！';
      GOTO 退出;
    END IF;

    IF STR_就诊状态 IS NULL
       OR STR_就诊状态 NOT IN ('全部', '待接诊', '已接诊') THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的就诊状态！';
      GOTO 退出;
    END IF;

    /*
    说明：
        1）只显示1月内的就诊记录
    */
    OPEN CUR_返回结果集 FOR
      SELECT P.病人ID AS 病人ID,
             P.门诊病历号 AS 门诊病历号,
             P.就诊科室编码 AS 就诊科室编码,
             K.科室名称 AS 就诊科室名称,
             P.就诊医生编码 AS 接诊医生编码,
             R.人员姓名 AS 接诊医生姓名,
             P.就诊时间 AS 就诊时间,
             (CASE
               WHEN P.就诊状态 = '等待接诊' THEN
                '待接诊'
               WHEN P.就诊状态 IN ('正在接诊', '完成接诊') THEN
                '已接诊'
             END) AS 预约状态
        FROM 门诊管理_挂号登记 P
        LEFT JOIN 基础项目_科室资料 K
          ON P.机构编码 = K.机构编码
         AND P.就诊科室编码 = K.科室编码
        LEFT JOIN 基础项目_人员资料 R
          ON P.机构编码 = R.机构编码
         AND P.就诊医生编码 = R.人员编码
       WHERE P.机构编码 = STR_医院编码
         AND P.病人ID = STR_病人ID
         AND ((STR_就诊状态 = '全部' AND P.就诊状态 = P.就诊状态) OR
             (STR_就诊状态 = '待接诊' AND P.就诊状态 = '等待接诊') OR
             (STR_就诊状态 = '已接诊' AND P.就诊状态 IN ('正在接诊', '完成接诊')))
         AND P.挂号时间 >= ADD_MONTHS(SYSDATE, -1);

    INT_返回值   := 0;
    STR_返回信息 := '成功!';

    -- 【保存日志】
    PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
                 STR_客户端标识 => STR_客户端标识,
                 STR_医院编码   => STR_医院编码,
                 STR_功能编码   => STR_功能编码,
                 STR_请求参数   => STR_请求参数,
                 DAT_请求时间   => DAT_系统时间,
                 STR_请求结果   => STR_返回信息,
                 STR_关联编码   => STR_病人ID,
                 STR_执行人     => STR_平台标识,
                 DAT_执行时间   => SYSDATE,
                 STR_执行状态   => INT_返回值);

    RETURN;

  EXCEPTION
    -- 未检测的系统异常
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := SQLERRM;
      GOTO 退出;
  END;

  -- 【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  RETURN;

END PR_平台接口_门诊就诊历史查询;
/

prompt
prompt Creating procedure PR_平台接口_排班信息
prompt ===============================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_排班信息(STR_请求参数   IN VARCHAR2,
                                         CUR_返回结果集 OUT SYS_REFCURSOR,
                                         INT_返回值     OUT INTEGER,
                                         STR_返回信息   OUT VARCHAR2) IS
  -- 固定参数
  DAT_系统时间 DATE;

  --请求参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_科室编码 VARCHAR2(50);
  STR_医生编码 VARCHAR2(50);
  STR_排班日期 VARCHAR2(50);

  STR_限号类型 VARCHAR2(50);

BEGIN
  BEGIN
  
    -- 请求验证
  
    IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '非法请求！';
      GOTO 退出;
    END IF;
  
    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
  
    -- 【请求参数解析】
    STR_平台标识   := FU_平台接口_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_平台接口_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_平台接口_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 5);
  
    -- 【功能参数解析】
    STR_科室编码 := FU_平台接口_截取字符串值(STR_请求参数, '|', 6);
    STR_医生编码 := FU_平台接口_截取字符串值(STR_请求参数, '|', 7);
    STR_排班日期 := FU_平台接口_截取字符串值(STR_请求参数, '|', 8);
  
    -- 【读取平台信息】
    BEGIN
      SELECT P.限号类型
        INTO STR_限号类型
        FROM 平台接口_平台配置 P
       WHERE P.平台标识 = STR_平台标识;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        INT_返回值   := -1;
        STR_返回信息 := '未找到有效的平台信息！';
        GOTO 退出;
      WHEN OTHERS THEN
        INT_返回值   := -1;
        STR_返回信息 := '系统异常：' || SQLERRM;
        GOTO 退出;
    END;
  
    -- 【数据校验】
    IF STR_科室编码 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '请输入有效的科室编码！！';
      GOTO 退出;
    END IF;
    IF STR_医生编码 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '请输入有效的医生编码！！';
      GOTO 退出;
    END IF;
    IF STR_排班日期 IS NULL
       OR FU_尝试转日期(STR_排班日期) IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '请输入有效的排班日期！！';
      GOTO 退出;
    END IF;
  
    -- 【返回数据】
    /*
    说明：
        1)只能按天查询排班记录,并且只能查询今天及以后的排班记录；
        2)查询科室所有医生排班信息时，医生编码请传入-1；
        3)超出剩余号数时，无法预约
    */
    OPEN CUR_返回结果集 FOR
      SELECT S.日班次标识 AS 班次标识,
             D.科室编码,
             D.科室名称,
             D.医生编码,
             D.医生姓名,
             D.挂号类型编码,
             D.挂号类型名称,
             G.挂号费,
             G.诊查费,
             D.排班日期,
             S.开始时间,
             S.结束时间,
             S.限号数,
             DECODE(S.限号数,
                    -1,
                    -1,
                    S.限号数 - NVL(S.已挂号数, 0) -
                    (SELECT COUNT(1)
                       FROM 门诊管理_预约挂号
                      WHERE 日班次标识 = S.日班次标识
                        AND (去向标志 = '占号' and 超时时间 > SYSDATE))) AS 剩余号数
        FROM 门诊管理_日排班时段表 S,
             门诊管理_当天排班记录 D,
             基础项目_挂号类型     G
       WHERE S.机构编码 = D.机构编码
         AND S.排班序号 = D.排班序号
         AND S.记录ID = D.记录ID
         AND D.机构编码 = G.机构编码
         AND D.挂号类型编码 = G.类型编码
         AND D.机构编码 = STR_医院编码
         AND D.科室编码 = STR_科室编码
         AND D.医生编码 = DECODE(STR_医生编码, -1, D.医生编码, STR_医生编码)
         AND S.限号类型编码 = STR_限号类型
         AND TO_CHAR(D.排班日期, 'yyyy-mm-dd') = STR_排班日期
         AND D.排班日期 >= TRUNC(SYSDATE);
  
    INT_返回值   := 0;
    STR_返回信息 := '成功!';
  
    -- 【保存日志】
    PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
                 STR_客户端标识 => STR_客户端标识,
                 STR_医院编码   => STR_医院编码,
                 STR_功能编码   => STR_功能编码,
                 STR_请求参数   => STR_请求参数,
                 DAT_请求时间   => DAT_系统时间,
                 STR_请求结果   => STR_返回信息,
                 STR_关联编码   => NULL,
                 STR_执行人     => STR_平台标识,
                 DAT_执行时间   => SYSDATE,
                 STR_执行状态   => INT_返回值);
  
    RETURN;
  
  EXCEPTION
    -- 未检测的系统异常
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := SQLERRM;
      GOTO 退出;
  END;

  -- 【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  RETURN;

END PR_平台接口_排班信息;
/

prompt
prompt Creating procedure PR_平台接口_医生列表
prompt ===============================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_医生列表(STR_请求参数   IN VARCHAR2,
                                         CUR_返回结果集 OUT SYS_REFCURSOR,
                                         INT_返回值     OUT INTEGER,
                                         STR_返回信息   OUT VARCHAR2) IS
  -- 固定参数
  DAT_系统时间 DATE;

  --请求参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_科室编码 VARCHAR2(50);

BEGIN
  BEGIN

    -- 请求验证

    IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '非法请求！';
      GOTO 退出;
    END IF;

    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;

    -- 【请求参数解析】
    STR_平台标识   := FU_平台接口_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_平台接口_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_平台接口_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 5);

    -- 【功能参数解析】
    STR_科室编码 := FU_平台接口_截取字符串值(STR_请求参数, '|', 6);

    -- 数据校验
    IF STR_科室编码 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的科室编码！';
      GOTO 退出;
    END IF;

    /*
    说明：
        1）只显示有效的医生列表。
    */
    OPEN CUR_返回结果集 FOR
      SELECT 人员编码, 人员姓名
        FROM 基础项目_人员资料
       WHERE 机构编码 = STR_医院编码
         AND 有效状态 = '有效'
         AND 删除标志 = '0'
         AND 人员科室编码 LIKE '%' || STR_科室编码 || ',%';

    INT_返回值   := 0;
    STR_返回信息 := '成功!';

    -- 【保存日志】
    PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
                 STR_客户端标识 => STR_客户端标识,
                 STR_医院编码   => STR_医院编码,
                 STR_功能编码   => STR_功能编码,
                 STR_请求参数   => STR_请求参数,
                 DAT_请求时间   => DAT_系统时间,
                 STR_请求结果   => STR_返回信息,
                 STR_关联编码   => STR_科室编码,
                 STR_执行人     => STR_平台标识,
                 DAT_执行时间   => SYSDATE,
                 STR_执行状态   => INT_返回值);

    RETURN;

  EXCEPTION
    -- 未检测的系统异常
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := SQLERRM;
      GOTO 退出;
  END;

  -- 【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  RETURN;

END PR_平台接口_医生列表;
/

prompt
prompt Creating procedure PR_平台接口_预约挂号登记
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_预约挂号登记(STR_请求参数   IN VARCHAR2,
                                           CUR_返回结果集 OUT SYS_REFCURSOR,
                                           INT_返回值     OUT INTEGER,
                                           STR_返回信息   OUT VARCHAR2) IS

  DAT_系统时间 DATE;

  -- 固定参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_病人ID   VARCHAR2(50);
  STR_班次标识 VARCHAR2(50);

  -- 处理参数
  STR_订单号       VARCHAR2(50);
  DAT_订单过期时间 DATE;
  STR_订单备注     VARCHAR2(50);
  NUM_应付金额     NUMBER(18, 3);

  STR_预约单号     VARCHAR2(50);
  STR_排班记录ID   VARCHAR2(50);
  DAT_排班日期     DATE;
  STR_挂号科室编码 VARCHAR2(50);
  STR_挂号科室名称 VARCHAR2(50);
  STR_挂号科室位置 VARCHAR2(50);
  STR_挂号医生编码 VARCHAR2(50);
  STR_挂号医生姓名 VARCHAR2(50);
  STR_挂号类型编码 VARCHAR2(50);
  STR_挂号类型名称 VARCHAR2(50);

  NUM_挂号费   NUMBER(18, 3);
  NUM_诊查费   NUMBER(18, 3);
  STR_归类编码 VARCHAR2(50);

  STR_姓名     VARCHAR2(50);
  STR_性别     VARCHAR2(50);
  STR_出生日期 VARCHAR2(50);
  STR_婚姻状况 VARCHAR2(50);
  STR_联系电话 VARCHAR2(50);
  STR_家庭地址 VARCHAR2(200);
  STR_工作单位 VARCHAR2(200);
  STR_身份证号 VARCHAR2(50);

  STR_预约时段编码 VARCHAR2(50);
  STR_预约时段开始 VARCHAR2(50);
  STR_预约时段结束 VARCHAR2(50);

BEGIN
  BEGIN
    -- 【请求功能有效性验证】
    IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '非法请求！';
      GOTO 退出;
    END IF;
  
    -- 【就诊人有效性验证】
    IF FU_平台接口_验证就诊人信息(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '就诊人信息无效！';
      GOTO 退出;
    END IF;
  
    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
  
    -- 【固定参数解析】
  
    STR_平台标识   := FU_通用_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_通用_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_通用_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_通用_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_通用_截取字符串值(STR_请求参数, '|', 5);
  
    -- 【功能参数解析】
  
    STR_病人ID   := FU_通用_截取字符串值(STR_请求参数, '|', 6);
    STR_班次标识 := FU_通用_截取字符串值(STR_请求参数, '|', 7);
  
    -- 【入参有期性验证】
    IF STR_病人ID IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '请输入有效的病人ID！';
      GOTO 退出;
    END IF;
    IF STR_班次标识 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '请输入有效的班次标识！';
      GOTO 退出;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '系统异常0：' || SQLERRM;
      GOTO 退出;
  END;
  -- 【读取基础数据】
  -- 1)排班记录
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
       AND D.机构编码 = STR_医院编码
       AND S.日班次标识 = STR_班次标识
       AND TO_DATE(TO_CHAR(D.排班日期, 'yyyy/mm/dd'), 'yyyy/mm/dd') >=
           TO_DATE(TO_CHAR(SYSDATE, 'yyyy/mm/dd'), 'yyyy/mm/dd');
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INT_返回值   := -1;
      STR_返回信息 := '未找到有效的排班记录或号源不足！';
      GOTO 退出;
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '系统异常：' || SQLERRM;
      GOTO 退出;
  END;

  -- 1.1)预约记录
  -- 已经预约的，不能再次预约
  SELECT COUNT(1)
    INTO INT_返回值
    FROM 门诊管理_预约挂号
   WHERE 机构编码 = STR_医院编码
     AND 病人ID = STR_病人ID
     AND 日班次标识 = STR_班次标识
     AND 去向标志 IN ('预约', '占号', '看诊')
     and (去向标志 = '占号' and 超时时间 > sysdate);

  IF INT_返回值 > 0 THEN
    INT_返回值   := -1;
    STR_返回信息 := '已经存在预约记录，不能重复预约！';
    GOTO 退出;
  END IF;

  -- 2)挂号类型
  BEGIN
    SELECT 类型编码, 类型名称, 挂号费, 诊查费, 归类编码
      INTO STR_挂号类型编码,
           STR_挂号类型名称,
           NUM_挂号费,
           NUM_诊查费,
           STR_归类编码
      FROM 基础项目_挂号类型
     WHERE 机构编码 = STR_医院编码
       AND 类型编码 = STR_挂号类型编码
       AND 有效状态 = '有效'
       AND 删除标志 = '0';
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INT_返回值   := -1;
      STR_返回信息 := '未找到有效的挂号类型！';
      GOTO 退出;
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '系统异常：' || SQLERRM;
      GOTO 退出;
  END;

  -- 3)病人信息
  BEGIN
    SELECT 姓名,
           性别,
           出生日期,
           婚姻状况,
           手机号码,
           家庭地址,
           工作单位,
           身份证号
      INTO STR_姓名,
           STR_性别,
           STR_出生日期,
           STR_婚姻状况,
           STR_联系电话,
           STR_家庭地址,
           STR_工作单位,
           STR_身份证号
      FROM 基础项目_病人信息
     WHERE 机构编码 = STR_医院编码
       AND 病人ID = STR_病人ID;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INT_返回值   := -1;
      STR_返回信息 := '未找到有效的病人信息！';
      GOTO 退出;
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '系统异常：' || SQLERRM;
      GOTO 退出;
  END;

  -- 【构造数据】
  -- 1)生成订单号
  PR_获取_系统唯一号(PRM_唯一号编码 => '6001',
              PRM_机构编码   => STR_医院编码,
              PRM_事物类型   => '1',
              PRM_返回唯一号 => STR_订单号,
              PRM_执行结果   => INT_返回值,
              PRM_错误信息   => STR_返回信息);
  IF INT_返回值 <> 0 THEN
    INT_返回值   := -1;
    STR_返回信息 := '产生订单号失败!';
    GOTO 退出;
  END IF;

  -- 2)生成过期时间
  SELECT SYSDATE + (1 / (24 * 60)) * 15 INTO DAT_订单过期时间 FROM DUAL;

  -- 3)生成订单备注
  STR_订单备注 := '请在15分钟内完成支付，过期自动取消';

  -- 4)生成金额
  NUM_应付金额 := NUM_挂号费 + NUM_诊查费;

  -- 5)生成预约单号
  SELECT SEQ_门诊管理_预约挂号_唯一ID.NEXTVAL INTO STR_预约单号 FROM DUAL;

  -- 【插入数据】
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
      (STR_医院编码,
       STR_预约单号,
       STR_姓名,
       STR_性别,
       STR_出生日期,
       STR_婚姻状况,
       STR_联系电话,
       STR_家庭地址,
       STR_工作单位,
       STR_身份证号,
       FU_通用_汉字_转换_首拼(STR_姓名),
       FU_通用_汉字_转换_五笔(STR_姓名),
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
       STR_平台标识,
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
      INT_返回值   := -1;
      STR_返回信息 := '保存预约记录失败！';
      GOTO 退出;
    END IF;
  
    -- 插入订单
    INSERT INTO 平台接口_订单
      (流水码,
       平台标识,
       客户端标识,
       医院编码,
       病人ID,
       关联编码,
       订单号,
       订单类型,
       订单时间,
       应付金额,
       优惠金额,
       实收金额,
       过期时间,
       订单状态,
       创建人,
       创建时间)
    VALUES
      (SEQ_平台接口_订单_流水码.NEXTVAL,
       STR_平台标识,
       STR_客户端标识,
       STR_医院编码,
       STR_病人ID,
       STR_预约单号,
       STR_订单号,
       '预约挂号',
       DAT_系统时间,
       NUM_应付金额,
       0,
       0,
       DAT_订单过期时间,
       '待支付',
       STR_平台标识,
       DAT_系统时间);
  
    INT_返回值 := SQL%ROWCOUNT;
    IF INT_返回值 = 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '保存订单失败！';
      GOTO 退出;
    END IF;
  
    -- 插入订单明细
    -- 挂号费
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
      (SEQ_平台接口_订单明细_流水码.NEXTVAL,
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
      INT_返回值   := -1;
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
      (SEQ_平台接口_订单明细_流水码.NEXTVAL,
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
      INT_返回值   := -1;
      STR_返回信息 := '保存订单明细失败！';
      GOTO 退出;
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '系统异常：' || SQLERRM;
      GOTO 退出;
  END;

  -- 【返回结果】
  OPEN CUR_返回结果集 FOR
    SELECT STR_病人ID       AS 病人ID,
           STR_订单号       AS 订单号,
           NUM_应付金额     AS 应付金额,
           DAT_订单过期时间 AS 过期时间,
           STR_订单备注     AS 备注
      FROM DUAL;

  INT_返回值   := 0;
  STR_返回信息 := '处理成功!';

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => STR_订单号,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  COMMIT;
  RETURN;

  --【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  --【错误日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  ROLLBACK;
  RETURN;

END PR_平台接口_预约挂号登记;
/

prompt
prompt Creating procedure PR_平台接口_预约挂号取号
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_预约挂号取号(STR_请求参数   IN VARCHAR2,
                                           CUR_返回结果集 OUT SYS_REFCURSOR,
                                           INT_返回值     OUT INTEGER,
                                           STR_返回信息   OUT VARCHAR2) IS

  DAT_系统时间 DATE;
  STR_平台名称 VARCHAR2(50);

  -- 固定参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_取号来源 VARCHAR2(50); --1微信 2窗口
  STR_病人ID   VARCHAR2(50);
  STR_预约单号 VARCHAR2(50);

  -- 处理参数

  STR_排班ID       VARCHAR2(50);
  STR_挂号序号     VARCHAR2(50);
  STR_挂号单号     VARCHAR2(50);
  STR_门诊病历号   VARCHAR2(50);
  NUM_挂号费       NUMBER(18, 2);
  NUM_诊查费       NUMBER(18, 2);
  NUM_总费用       NUMBER(18, 2);
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
  
    -- 变量初始化
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
  
    STR_病人类型编码 := '1';
    STR_病人类型名称 := '现金';
    STR_就诊状态     := '等待接诊';
    STR_挂号来源     := '预约';
  
    -- 【固定参数解析】
    STR_平台标识   := FU_通用_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_通用_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_通用_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_通用_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_通用_截取字符串值(STR_请求参数, '|', 5);
  
    -- 【功能参数解析】
    STR_取号来源 := FU_通用_截取字符串值(STR_请求参数, '|', 6);
    STR_病人ID   := FU_通用_截取字符串值(STR_请求参数, '|', 7);
    STR_预约单号 := FU_通用_截取字符串值(STR_请求参数, '|', 8);
  
    if STR_取号来源 = '1' then
      -- 【请求功能有效性验证】
      IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
        INT_返回值   := -1;
        STR_返回信息 := '非法请求！';
        GOTO 退出;
      END IF;
    
      -- 【就诊人有效性验证】
      IF FU_平台接口_验证就诊人信息(STR_请求参数) <> 0 THEN
        INT_返回值   := -1;
        STR_返回信息 := '就诊人信息无效！';
        GOTO 退出;
      END IF;
    end if;
  
    -- 【读取平台信息】
    BEGIN
      SELECT P.支付方式, P.平台名称
        INTO STR_付款方式, STR_平台名称
        FROM 平台接口_平台配置 P
       WHERE P.平台标识 = STR_平台标识;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        INT_返回值   := -1;
        STR_返回信息 := '未找到有效的平台信息！';
        GOTO 退出;
      WHEN OTHERS THEN
        INT_返回值   := -1;
        STR_返回信息 := '系统异常：' || SQLERRM;
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
       WHERE G.机构编码 = STR_医院编码
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
    PR_公用_取得业务病历号(STR_机构编码   => STR_医院编码,
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
                PRM_机构编码   => STR_医院编码,
                PRM_事物类型   => '1',
                PRM_返回唯一号 => STR_挂号序号,
                PRM_执行结果   => INT_返回值,
                PRM_错误信息   => STR_返回信息);
    IF INT_返回值 <> 0 THEN
      STR_返回信息 := '产生挂号序号失败!';
      GOTO 退出;
    END IF;
  
    -- 产生【挂号单号】
    SELECT FU_公用_获取当前票据号(STR_医院编码, STR_平台标识, '4')
      INTO STR_挂号单号
      FROM DUAL;
  
    IF STR_挂号单号 = '请到财务先领用票据' THEN
      STR_返回信息 := '该操作员无挂号单号,请通知财务先领用票据!';
      GOTO 退出;
    END IF;
  
    -- 生成挂号记录
  
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
      (STR_医院编码,
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
      (STR_医院编码,
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
      INT_返回值   := -1;
      STR_返回信息 := '保存收支款数据失败！';
      GOTO 退出;
    END IF;
  
    -- 更新预约状态
    UPDATE 门诊管理_预约挂号
       SET 去向标志 = '看诊',
           挂号序号 = STR_挂号序号,
           取号时间 = DAT_系统时间
     WHERE 机构编码 = STR_医院编码
       AND 主键ID = STR_预约单号;
  
    INT_返回值 := SQL%ROWCOUNT;
    IF INT_返回值 = 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '更新预约状态失败！';
      GOTO 退出;
    END IF;
  
    -- 更新订单
    UPDATE 平台接口_订单
       SET 就诊病历号 = STR_门诊病历号
     WHERE 关联编码 = STR_预约单号
       AND 平台标识 = STR_平台标识
       AND 医院编码 = STR_医院编码
       AND 病人ID = STR_病人ID
       AND 订单类型 = '预约挂号'
       AND 状态 = '0';
  
    INT_返回值 := SQL%ROWCOUNT;
    IF INT_返回值 = 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '更新订单状态失败！';
      GOTO 退出;
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := STR_返回信息 || SQLERRM;
      GOTO 退出;
  END;

  -- 【返回结果】
  INT_返回值   := 0;
  STR_返回信息 := '处理成功!';
  OPEN CUR_返回结果集 FOR
    SELECT STR_挂号单号 as 挂号单号 FROM DUAL;
  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => STR_预约单号,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  COMMIT;
  RETURN;

  --【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  --【错误日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  ROLLBACK;
  RETURN;

END PR_平台接口_预约挂号取号;
/

prompt
prompt Creating procedure PR_平台接口_预约挂号取消
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_预约挂号取消(STR_请求参数   IN VARCHAR2,
                                           CUR_返回结果集 OUT SYS_REFCURSOR,
                                           INT_返回值     OUT INTEGER,
                                           STR_返回信息   OUT VARCHAR2) IS

  DAT_系统时间 DATE;

  -- 固定参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_病人ID       VARCHAR2(50);
  STR_预约单号     VARCHAR2(50);
  STR_平台退款号   VARCHAR2(50);
  STR_平台退款时间 VARCHAR2(50);

  -- 处理参数
  STR_订单号   VARCHAR2(50);
  STR_去向标志 VARCHAR2(50);
  STR_订单状态 VARCHAR2(50);

BEGIN
  BEGIN
    -- 【请求功能有效性验证】
    IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '非法请求！';
      GOTO 退出;
    END IF;
  
    -- 【就诊人有效性验证】
    IF FU_平台接口_验证就诊人信息(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '就诊人信息无效！';
      GOTO 退出;
    END IF;
  
    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
  
    -- 【固定参数解析】
  
    STR_平台标识   := FU_通用_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_通用_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_通用_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_通用_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_通用_截取字符串值(STR_请求参数, '|', 5);
  
    -- 【功能参数解析】
  
    STR_病人ID       := FU_通用_截取字符串值(STR_请求参数, '|', 6);
    STR_预约单号     := FU_通用_截取字符串值(STR_请求参数, '|', 7);
    STR_订单号       := FU_通用_截取字符串值(STR_请求参数, '|', 8);
    STR_平台退款号   := FU_通用_截取字符串值(STR_请求参数, '|', 9);
    STR_平台退款时间 := FU_通用_截取字符串值(STR_请求参数, '|', 10);
  
    -- 【参数有期性验证】
    IF STR_病人ID IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '请输入有效的病人ID！';
      GOTO 退出;
    END IF;
    IF STR_预约单号 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '请输入有效的预约单号！';
      GOTO 退出;
    END IF;
    IF STR_订单号 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '请输入有效的订单号！';
      GOTO 退出;
    END IF;
  
    -- 验证预约单
    BEGIN
      SELECT 去向标志
        INTO STR_去向标志
        FROM 门诊管理_预约挂号
       WHERE 机构编码 = STR_医院编码
         AND 主键ID = STR_预约单号
         AND (去向标志 = '预约' OR 去向标志 = '占号');
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        INT_返回值   := -1;
        STR_返回信息 := '无效的预约单！';
        GOTO 退出;
      WHEN OTHERS THEN
        INT_返回值   := -1;
        STR_返回信息 := '系统异常：' || SQLERRM;
        GOTO 退出;
    END;
  
    -- 验证订单
    BEGIN
      SELECT 订单状态
        INTO STR_订单状态
        FROM 平台接口_订单
       WHERE 平台标识 = STR_平台标识
         AND 客户端标识 = STR_客户端标识
         AND 病人ID = STR_病人ID
         AND 订单号 = STR_订单号
         AND 关联编码 = STR_预约单号
         AND (订单状态 = '待支付' OR 订单状态 = '已支付')
         AND 状态 = '0';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        INT_返回值   := -1;
        STR_返回信息 := '无效的订单！';
        GOTO 退出;
      WHEN OTHERS THEN
        INT_返回值   := -1;
        STR_返回信息 := '系统异常：' || SQLERRM;
        GOTO 退出;
    END;
  
    IF STR_订单状态 = '已支付' THEN
      IF STR_平台退款号 IS NULL THEN
        INT_返回值   := -1;
        STR_返回信息 := '请输入有效的退款号！';
        GOTO 退出;
      END IF;
      IF STR_平台退款时间 IS NULL OR FU_尝试转日期(STR_平台退款时间) IS NULL THEN
        INT_返回值   := -1;
        STR_返回信息 := '请输入有效的退款时间！';
        GOTO 退出;
      END IF;
    END IF;
  
    -- 【功能处理】
  
    -- 更新预约单
    UPDATE 门诊管理_预约挂号
       SET 去向标志 = '消号'
     WHERE 机构编码 = STR_医院编码
       AND 主键ID = STR_预约单号
       AND (去向标志 = '预约' OR 去向标志 = '占号');
  
    INT_返回值 := SQL%ROWCOUNT;
    IF INT_返回值 = 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '更新预约单失败！';
      GOTO 退出;
    END IF;
  
    -- 更新订单状态
    UPDATE 平台接口_订单
       SET 订单状态     = DECODE(STR_订单状态,
                             '待支付',
                             '已取消',
                             '已支付',
                             '已退款'),
           平台退款号   = DECODE(STR_订单状态, '已支付', STR_平台退款号, ''),
           平台退款时间 = DECODE(STR_订单状态,
                           '已支付',
                           to_date(STR_平台退款时间, 'yyyy/mm/dd hh24:mi:ss'),
                           ''),
           更新人       = STR_平台标识,
           更新时间     = DAT_系统时间
     WHERE 平台标识 = STR_平台标识
       AND 客户端标识 = STR_客户端标识
       AND 病人ID = STR_病人ID
       AND 订单号 = STR_订单号
       AND 关联编码 = STR_预约单号
       AND (订单状态 = '待支付' OR 订单状态 = '已支付');
  
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

  -- 【返回结果】
  OPEN CUR_返回结果集 FOR
    SELECT STR_病人ID AS 病人ID,
           STR_订单号 AS 订单号,
           STR_预约单号 AS 预约单号,
           '' AS 备注
      FROM DUAL;

  INT_返回值   := 0;
  STR_返回信息 := '处理成功!';

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => STR_预约单号,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  COMMIT;
  RETURN;

  --【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  --【错误日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  ROLLBACK;
  RETURN;

END PR_平台接口_预约挂号取消;
/

prompt
prompt Creating procedure PR_平台接口_预约挂号支付
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_预约挂号支付(STR_请求参数   IN VARCHAR2,
                                           CUR_返回结果集 OUT SYS_REFCURSOR,
                                           INT_返回值     OUT INTEGER,
                                           STR_返回信息   OUT VARCHAR2) IS

  DAT_系统时间 DATE;

  -- 固定参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_病人ID       VARCHAR2(50);
  STR_订单类型     VARCHAR2(50);
  STR_订单号       VARCHAR2(50);
  STR_平台订单号   VARCHAR2(50);
  STR_平台交易号   VARCHAR2(50);
  STR_订单应付金额 VARCHAR2(50);
  STR_平台实收金额 VARCHAR2(50);
  STR_平台订单时间 VARCHAR2(50);
  STR_平台交易时间 VARCHAR2(50);

  -- 处理参数
  STR_预约单号 VARCHAR2(50);
  STR_班次标识 VARCHAR2(50);

BEGIN
  BEGIN
    -- 【请求功能有效性验证】
    IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '非法请求！';
      GOTO 退出;
    END IF;
  
    -- 【就诊人有效性验证】
    IF FU_平台接口_验证就诊人信息(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '就诊人信息无效！';
      GOTO 退出;
    END IF;
  
    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
    STR_订单类型 := '预约挂号';
  
    -- 【固定参数解析】
  
    STR_平台标识   := FU_通用_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_通用_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_通用_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_通用_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_通用_截取字符串值(STR_请求参数, '|', 5);
  
    -- 【功能参数解析】
  
    STR_病人ID       := FU_通用_截取字符串值(STR_请求参数, '|', 6);
    STR_订单号       := FU_通用_截取字符串值(STR_请求参数, '|', 7);
    STR_平台订单号   := FU_通用_截取字符串值(STR_请求参数, '|', 8);
    STR_平台订单时间 := FU_通用_截取字符串值(STR_请求参数, '|', 9);
    STR_平台交易号   := FU_通用_截取字符串值(STR_请求参数, '|', 10);
    STR_平台交易时间 := FU_通用_截取字符串值(STR_请求参数, '|', 11);
    STR_订单应付金额 := FU_通用_截取字符串值(STR_请求参数, '|', 12);
    STR_平台实收金额 := FU_通用_截取字符串值(STR_请求参数, '|', 13);
  
    -- 【参数有期性验证】
    IF STR_病人ID IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '请输入有效的病人ID！';
      GOTO 退出;
    END IF;
    IF STR_订单号 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '请输入有效的订单号！';
      GOTO 退出;
    END IF;
    IF STR_平台订单号 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '请输入有效的平台订单号！';
      GOTO 退出;
    END IF;
    IF STR_平台交易号 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '请输入有效的平台交易号！';
      GOTO 退出;
    END IF;
    IF STR_订单应付金额 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '请输入有效的订单应付金额！';
      GOTO 退出;
    END IF;
    IF STR_平台实收金额 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '请输入有效的平台实收金额！';
      GOTO 退出;
    END IF;
    IF STR_平台订单时间 IS NULL OR FU_尝试转日期(STR_平台订单时间) IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '请输入有效的订单时间！';
      GOTO 退出;
    END IF;
    IF STR_平台交易时间 IS NULL OR FU_尝试转日期(STR_平台交易时间) IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '请输入有效的交易时间！';
      GOTO 退出;
    END IF;
  
    IF STR_订单应付金额 <> STR_平台实收金额 THEN
      INT_返回值   := -1;
      STR_返回信息 := '应付金额与实收金额不付！';
      GOTO 退出;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '系统异常0：' || SQLERRM;
      GOTO 退出;
  END;

  -- 验证订单
  BEGIN
    SELECT 关联编码
      INTO STR_预约单号
      FROM 平台接口_订单
     WHERE 平台标识 = STR_平台标识
       AND 客户端标识 = STR_客户端标识
       AND 病人ID = STR_病人ID
       AND 订单号 = STR_订单号
       AND 订单类型 = STR_订单类型
       AND 应付金额 = TO_NUMBER(STR_订单应付金额)
       AND 过期时间 >= SYSDATE
       AND 订单状态 = '待支付';
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的订单！';
      GOTO 退出;
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '系统异常：' || SQLERRM;
      GOTO 退出;
  END;

  -- 验证预约单
  BEGIN
    SELECT 日班次标识
      INTO STR_班次标识
      FROM 门诊管理_预约挂号
     WHERE 机构编码 = STR_医院编码
       AND 主键ID = STR_预约单号
       AND 去向标志 = '占号'
       AND 超时时间 >= SYSDATE;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的预约单！';
      GOTO 退出;
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '系统异常：' || SQLERRM;
      GOTO 退出;
  END;

  -- 【功能处理】
  BEGIN
  
    -- 更新预约单
    UPDATE 门诊管理_预约挂号 G
       SET 支付标志 = '是', 去向标志 = '预约'
     WHERE 机构编码 = STR_医院编码
       AND 主键ID = STR_预约单号;
  
    INT_返回值 := SQL%ROWCOUNT;
    IF INT_返回值 = 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '更新预约单失败！';
      GOTO 退出;
    END IF;
  
    -- 更新订单状态
    UPDATE 平台接口_订单
       SET 订单状态     = '已支付',
           实收金额     = TO_NUMBER(STR_平台实收金额),
           平台订单号   = STR_平台订单号,
           平台订单时间 = TO_DATE(STR_平台订单时间, 'yyyy/mm/dd hh24:mi:ss'),
           平台交易号   = STR_平台交易号,
           平台交易时间 = TO_DATE(STR_平台交易时间, 'yyyy/mm/dd hh24:mi:ss'),
           平台退款号   = NULL,
           平台退款时间 = NULL,
           更新人       = STR_平台标识,
           更新时间     = DAT_系统时间
     WHERE 平台标识 = STR_平台标识
       AND 客户端标识 = STR_客户端标识
       AND 病人ID = STR_病人ID
       AND 订单号 = STR_订单号
       AND 订单类型 = STR_订单类型
       AND 订单状态 = '待支付';
  
    INT_返回值 := SQL%ROWCOUNT;
    IF INT_返回值 = 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '更新订单失败！';
      GOTO 退出;
    END IF;
  
    -- 更新已挂号数
    UPDATE 门诊管理_日排班时段表
       SET 已挂号数 = 已挂号数 + 1
     WHERE 机构编码 = STR_医院编码
       AND 日班次标识 = STR_班次标识;
  
    INT_返回值 := SQL%ROWCOUNT;
    IF INT_返回值 = 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '锁定号源失败！';
      GOTO 退出;
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := STR_返回信息 || SQLERRM;
      GOTO 退出;
  END;

  -- 【返回结果】
  OPEN CUR_返回结果集 FOR
    SELECT STR_病人ID AS 病人ID,
           STR_订单号 AS 订单号,
           STR_预约单号 AS 预约单号,
           '' AS 备注
      FROM DUAL;

  INT_返回值   := 0;
  STR_返回信息 := '处理成功!';

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => STR_预约单号,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  COMMIT;
  RETURN;

  --【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  --【错误日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  ROLLBACK;
  RETURN;

END PR_平台接口_预约挂号支付;
/

prompt
prompt Creating procedure PR_平台接口_预约历史查询
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_预约历史查询(STR_请求参数   IN VARCHAR2,
                                           CUR_返回结果集 OUT SYS_REFCURSOR,
                                           INT_返回值     OUT INTEGER,
                                           STR_返回信息   OUT VARCHAR2) IS
  -- 固定参数
  DAT_系统时间 DATE;

  -- 请求参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_病人ID   VARCHAR2(50);
  STR_预约单号 VARCHAR2(50);
  STR_订单号   VARCHAR2(50);
  STR_预约状态 VARCHAR2(50);

BEGIN
  BEGIN
  
    -- 请求功能有效性验证
    IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '非法请求！';
      GOTO 退出;
    END IF;
  
    -- 就诊人有效性验证
    IF FU_平台接口_验证就诊人信息(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '就诊人信息无效！';
      GOTO 退出;
    END IF;
  
    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
  
    -- 【请求参数解析】
    STR_平台标识   := FU_平台接口_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_平台接口_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_平台接口_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 5);
  
    -- 【功能参数解析】
    STR_病人ID   := FU_平台接口_截取字符串值(STR_请求参数, '|', 6);
    STR_预约单号 := FU_平台接口_截取字符串值(STR_请求参数, '|', 7);
    STR_订单号   := FU_平台接口_截取字符串值(STR_请求参数, '|', 8);
    STR_预约状态 := FU_平台接口_截取字符串值(STR_请求参数, '|', 9);
  
    -- 数据验证
    IF STR_病人ID IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的病人ID！';
      GOTO 退出;
    END IF;
  
    IF STR_预约单号 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的预约单号！';
      GOTO 退出;
    END IF;
  
    IF STR_订单号 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的订单号！';
      GOTO 退出;
    END IF;
  
    IF STR_预约状态 IS NULL OR
       STR_预约状态 NOT IN
       ('全部', '已预约', '已取消', '待支付', '待接诊', '已就诊') THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的就诊状态！';
      GOTO 退出;
    END IF;
  
    /*
    说明：
        1）只显示1月内的预约记录
    */
    OPEN CUR_返回结果集 FOR
      SELECT G.病人ID AS 病人ID,
             G.主键ID AS 预约单号,
             R.订单号 AS 订单号,
             P.门诊病历号 AS 门诊病历号,
             G.挂号科室编码 AS 科室编码,
             G.挂号科室名称 AS 科室名称,
             G.挂号医生编码 AS 医生编码,
             G.挂号医生姓名 AS 医生姓名,
             TO_CHAR(G.预约时间, 'yyyy/mm/dd') AS 预约日期,
             TO_CHAR(G.预约时段开始, 'hh24:mi:ss') || '-' ||
             TO_CHAR(G.预约时段结束, 'hh24:mi:ss') AS 预约时段,
             (CASE
               WHEN G.去向标志 = '预约' AND G.支付标志 = '是' THEN
                '已预约'
               WHEN G.去向标志 = '消号' THEN
                '已取消'
               WHEN G.去向标志 = '预约' AND G.支付标志 = '否' THEN
                '待支付'
               when G.去向标志 = '占号' and g.超时时间 > sysdate then
                '待支付'
               when g.去向标志 = '占号' and g.超时时间 <= sysdate then
                '支付超时'
               WHEN G.去向标志 = '看诊' AND P.就诊状态 = '等待接诊' THEN
                '待接诊'
               WHEN G.去向标志 = '看诊' AND P.就诊状态 IN ('正在接诊', '完成接诊') THEN
                '已就诊'
             END) AS 状态,
             R.应付金额 AS 订单金额,
             (CASE
               WHEN (G.去向标志 = '预约' AND G.支付标志 = '否') OR
                    (G.去向标志 = '占号' AND G.超时时间 > SYSDATE) THEN
                R.过期时间
               ELSE
                NULL
             END) AS 过期时间
        FROM 门诊管理_预约挂号 G
        LEFT JOIN 平台接口_订单 R
          ON G.机构编码 = R.医院编码
         AND G.主键ID = R.关联编码
         AND G.病人ID = R.病人ID
        LEFT JOIN 门诊管理_挂号登记 P
          ON G.机构编码 = P.机构编码
         AND G.排班ID = P.排班ID
         AND G.病人ID = P.病人ID
         AND G.挂号序号 = P.挂号序号
         AND G.日班次标识 = P.日班次标识
       WHERE G.机构编码 = STR_医院编码
         AND G.病人ID = STR_病人ID
         AND G.主键ID = DECODE(STR_预约单号, '-1', G.主键ID, STR_预约单号)
         AND R.订单号 = DECODE(STR_订单号, '-1', R.订单号, STR_订单号)
         AND G.预约类型 = '网上预约'
         AND ((STR_预约状态 = '全部' AND G.去向标志 = G.去向标志) OR
             (STR_预约状态 = '已预约' AND G.去向标志 = '预约' AND G.支付标志 = '是') OR
             (STR_预约状态 = '已取消' AND G.去向标志 = '消号') OR
             (STR_预约状态 = '待支付' AND G.去向标志 = '预约' AND G.支付标志 = '否') OR
             (STR_预约状态 = '待接诊' AND G.去向标志 = '看诊' AND P.就诊状态 = '等待接诊') OR
             (STR_预约状态 = '已就诊' AND G.去向标志 = '看诊' AND
             P.就诊状态 IN ('正在接诊', '完成接诊')))
         AND G.预约时间 > ADD_MONTHS(SYSDATE, -1);
  
    INT_返回值   := 0;
    STR_返回信息 := '成功!';
  
    -- 【保存日志】
    PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
                 STR_客户端标识 => STR_客户端标识,
                 STR_医院编码   => STR_医院编码,
                 STR_功能编码   => STR_功能编码,
                 STR_请求参数   => STR_请求参数,
                 DAT_请求时间   => DAT_系统时间,
                 STR_请求结果   => STR_返回信息,
                 STR_关联编码   => STR_病人ID,
                 STR_执行人     => STR_平台标识,
                 DAT_执行时间   => SYSDATE,
                 STR_执行状态   => INT_返回值);
  
    RETURN;
  
  EXCEPTION
    -- 未检测的系统异常
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := SQLERRM;
      GOTO 退出;
  END;

  -- 【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  RETURN;

END PR_平台接口_预约历史查询;
/

prompt
prompt Creating procedure PR_平台接口_预约状态查询
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_预约状态查询(STR_请求参数   IN VARCHAR2,
                                           CUR_返回结果集 OUT SYS_REFCURSOR,
                                           INT_返回值     OUT INTEGER,
                                           STR_返回信息   OUT VARCHAR2) IS
  -- 固定参数
  DAT_系统时间 DATE;

  -- 请求参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_病人ID   VARCHAR2(50);
  STR_预约单号 VARCHAR2(50);

BEGIN
  BEGIN
  
    -- 请求功能有效性验证
    IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '非法请求！';
      GOTO 退出;
    END IF;
  
    -- 就诊人有效性验证
    IF FU_平台接口_验证就诊人信息(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '就诊人信息无效！';
      GOTO 退出;
    END IF;
  
    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
  
    -- 【请求参数解析】
    STR_平台标识   := FU_平台接口_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_平台接口_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_平台接口_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 5);
  
    -- 【功能参数解析】
    STR_病人ID   := FU_平台接口_截取字符串值(STR_请求参数, '|', 6);
    STR_预约单号 := FU_平台接口_截取字符串值(STR_请求参数, '|', 7);
  
    -- 数据验证
    IF STR_病人ID IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的病人ID！';
      GOTO 退出;
    END IF;
  
    IF STR_预约单号 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的预约单号！';
      GOTO 退出;
    END IF;
  
    /*
    说明：
        1）只显示1月内的预约记录
    */
    OPEN CUR_返回结果集 FOR
      SELECT G.病人ID AS 病人ID,
             G.主键ID AS 预约单号,
             R.订单号 AS 订单号,
             P.门诊病历号 AS 门诊病历号,
             (CASE
               WHEN G.去向标志 = '预约' AND G.支付标志 = '是' THEN
                '已预约'
               WHEN G.去向标志 = '消号' THEN
                '已取消'
               WHEN G.去向标志 = '预约' AND G.支付标志 = '否' THEN
                '待支付'
               WHEN G.去向标志 = '占号' AND G.超时时间 > SYSDATE THEN
                '待支付'
               WHEN G.去向标志 = '占号' AND G.超时时间 <= SYSDATE THEN
                '支付超时'
               WHEN G.去向标志 = '看诊' AND P.就诊状态 = '等待接诊' THEN
                '待接诊'
               WHEN G.去向标志 = '看诊' AND P.就诊状态 IN ('正在接诊', '完成接诊') THEN
                '已就诊'
             END) AS 预约状态
      
        FROM 门诊管理_预约挂号 G
        LEFT JOIN 平台接口_订单 R
          ON G.机构编码 = R.医院编码
         AND G.主键ID = R.关联编码
         AND G.病人ID = R.病人ID
        LEFT JOIN 门诊管理_挂号登记 P
          ON G.机构编码 = P.机构编码
         AND G.排班ID = P.排班ID
         AND G.病人ID = P.病人ID
         AND G.挂号序号 = P.挂号序号
         AND G.日班次标识 = P.日班次标识
       WHERE G.机构编码 = STR_医院编码
         AND G.病人ID = STR_病人ID
         AND G.主键ID = STR_预约单号
         AND G.预约类型 = '网上预约';
  
    INT_返回值   := 0;
    STR_返回信息 := '成功!';
  
    -- 【保存日志】
    PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
                 STR_客户端标识 => STR_客户端标识,
                 STR_医院编码   => STR_医院编码,
                 STR_功能编码   => STR_功能编码,
                 STR_请求参数   => STR_请求参数,
                 DAT_请求时间   => DAT_系统时间,
                 STR_请求结果   => STR_返回信息,
                 STR_关联编码   => STR_病人ID,
                 STR_执行人     => STR_平台标识,
                 DAT_执行时间   => SYSDATE,
                 STR_执行状态   => INT_返回值);
  
    RETURN;
  
  EXCEPTION
    -- 未检测的系统异常
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := SQLERRM;
      GOTO 退出;
  END;

  -- 【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  RETURN;

END PR_平台接口_预约状态查询;
/

prompt
prompt Creating procedure PR_平台接口_住院病人费用日清单
prompt ====================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_住院病人费用日清单(STR_请求参数   IN VARCHAR2,
                                            CUR_返回结果集 OUT SYS_REFCURSOR,
                                            INT_返回值     OUT INTEGER,
                                            STR_返回信息   OUT VARCHAR2) IS
  -- 固定参数
  DAT_系统时间 DATE;

  -- 请求参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_病人ID     VARCHAR2(50);
  STR_住院病历号 VARCHAR2(50);
  STR_费用日期   VARCHAR2(50);

  -- 过程内参数
  NUM_清单总额 NUMBER(18, 4);

BEGIN
  BEGIN

    -- 请求功能有效性验证
    IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '非法请求！';
      GOTO 退出;
    END IF;

    -- 就诊人有效性验证
    IF FU_平台接口_验证就诊人信息(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '就诊人信息无效！';
      GOTO 退出;
    END IF;

    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;

    -- 【请求参数解析】
    STR_平台标识   := FU_平台接口_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_平台接口_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_平台接口_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 5);

    -- 【功能参数解析】
    STR_病人ID     := FU_平台接口_截取字符串值(STR_请求参数, '|', 6);
    STR_住院病历号 := FU_平台接口_截取字符串值(STR_请求参数, '|', 7);
    STR_费用日期   := FU_平台接口_截取字符串值(STR_请求参数, '|', 8);

    -- 数据验证
    IF STR_病人ID IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的病人ID！';
      GOTO 退出;
    END IF;

    IF STR_住院病历号 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的病历号！';
      GOTO 退出;
    END IF;

    IF STR_费用日期 IS NULL
       OR FU_尝试转日期(STR_费用日期) IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的费用日期！';
      GOTO 退出;
    END IF;

    /*
    说明：
        1）只显示在院病人的指定日期清单
    */

    -- 取清单总额
    SELECT NVL(SUM(总金额), 0)
      INTO NUM_清单总额
      FROM 住院管理_在院病人处方
     WHERE 机构编码 = STR_医院编码
       AND 住院病历号 = STR_住院病历号
       AND TO_CHAR(记账时间, 'yyyy-mm-dd') = STR_费用日期;

    -- 返回结果
    OPEN CUR_返回结果集 FOR
      SELECT 病人ID AS 病人ID,
             住院病历号 AS 住院病历号,
             TO_CHAR(记账时间, 'yyyy-mm-dd') AS 费用日期,
             项目名称 AS 项目名称,
             数量 AS 数量,
             总金额 AS 金额,
             NUM_清单总额 AS 清单总额
        FROM 住院管理_在院病人处方 C
       WHERE 机构编码 = STR_医院编码
         AND 病人ID = STR_病人ID
         AND 住院病历号 = STR_住院病历号
         AND TO_CHAR(记账时间, 'yyyy-mm-dd') = STR_费用日期;

    INT_返回值   := 0;
    STR_返回信息 := '成功!';

    -- 【保存日志】
    PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
                 STR_客户端标识 => STR_客户端标识,
                 STR_医院编码   => STR_医院编码,
                 STR_功能编码   => STR_功能编码,
                 STR_请求参数   => STR_请求参数,
                 DAT_请求时间   => DAT_系统时间,
                 STR_请求结果   => STR_返回信息,
                 STR_关联编码   => STR_住院病历号,
                 STR_执行人     => STR_平台标识,
                 DAT_执行时间   => SYSDATE,
                 STR_执行状态   => INT_返回值);

    RETURN;

  EXCEPTION
    -- 未检测的系统异常
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := SQLERRM;
      GOTO 退出;
  END;

  -- 【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  RETURN;

END PR_平台接口_住院病人费用日清单;
/

prompt
prompt Creating procedure PR_平台接口_住院病人信息查询
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_住院病人信息查询(STR_请求参数   IN VARCHAR2,
                                             CUR_返回结果集 OUT SYS_REFCURSOR,
                                             INT_返回值     OUT INTEGER,
                                             STR_返回信息   OUT VARCHAR2) IS
  -- 固定参数
  DAT_系统时间 DATE;

  -- 请求参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_病人ID     VARCHAR2(50);
  STR_住院病历号 VARCHAR2(50);
  STR_住院状态   VARCHAR2(50);

BEGIN
  BEGIN

    -- 请求功能有效性验证
    IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '非法请求！';
      GOTO 退出;
    END IF;

    -- 就诊人有效性验证
    IF FU_平台接口_验证就诊人信息(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '就诊人信息无效！';
      GOTO 退出;
    END IF;

    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;

    -- 【请求参数解析】
    STR_平台标识   := FU_平台接口_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_平台接口_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_平台接口_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 5);

    -- 【功能参数解析】
    STR_病人ID     := FU_平台接口_截取字符串值(STR_请求参数, '|', 6);
    STR_住院病历号 := FU_平台接口_截取字符串值(STR_请求参数, '|', 7);
    STR_住院状态   := FU_平台接口_截取字符串值(STR_请求参数, '|', 8);

    -- 数据验证
    IF STR_病人ID IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的病人ID！';
      GOTO 退出;
    END IF;

    IF STR_住院病历号 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的病历号！';
      GOTO 退出;
    END IF;

    IF STR_住院状态 IS NULL
       OR (STR_住院状态 <> '全部' AND STR_住院状态 <> '在院' AND STR_住院状态 <> '出院') THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的住院状态！';
      GOTO 退出;
    END IF;

    /*
    说明：
        1）只显示1年内的记录
    */
    OPEN CUR_返回结果集 FOR
      SELECT G.病人ID       AS 病人ID,
             G.住院病历号   AS 住院病历号,
             G.病人科室编码 AS 科室编码,
             K.科室名称     AS 科室名称,
             G.住院医生编码 AS 医生编码,
             R.人员姓名     AS 医生姓名,
             C.床位名称     AS 床号,
             G.入院时间     AS 入院时间,
             G.出院时间     AS 出院时间,
             G.费用总额     AS 费用总额,
             G.押金余额     AS 押金余额,
             G.住院状态     AS 住院状态
        FROM (SELECT 机构编码,
                     病人ID,
                     住院病历号,
                     病人科室编码,
                     住院医生编码,
                     床位,
                     入院时间,
                     NULL AS 出院时间,
                     FU_费用_总费用_在院病人(STR_医院编码, 住院病历号) AS 费用总额,
                     FU_费用_剩余金额_在院病人(STR_医院编码, 住院病历号) AS 押金余额,
                     '在院' AS 住院状态
                FROM 住院管理_在院病人信息
               WHERE 机构编码 = STR_医院编码
                 AND 病人ID = STR_病人ID
                 AND 住院病历号 =
                     DECODE(STR_住院病历号, '-1', 住院病历号, STR_住院病历号)
              UNION ALL
              SELECT 机构编码,
                     病人ID,
                     住院病历号,
                     病人科室编码,
                     住院医生编码,
                     '' AS 床位,
                     入院时间,
                     出院时间,
                     0 AS 费用总额,
                     0 AS 押金余额,
                     '出院' AS 住院状态
                FROM 住院管理_出院病人信息
               WHERE 机构编码 = STR_医院编码
                 AND 病人ID = STR_病人ID
                 AND 住院病历号 =
                     DECODE(STR_住院病历号, '-1', 住院病历号, STR_住院病历号)
                 AND 出院时间 > ADD_MONTHS(SYSDATE, -12)) G
        LEFT JOIN 基础项目_人员资料 R
          ON G.机构编码 = R.机构编码
         AND G.住院医生编码 = R.人员编码
        LEFT JOIN 基础项目_科室资料 K
          ON G.机构编码 = K.机构编码
         AND G.病人科室编码 = K.科室编码
        LEFT JOIN 住院管理_科室床位 C
          ON G.机构编码 = C.机构编码
         AND G.床位 = C.床位编码
       WHERE G.住院状态 = DECODE(STR_住院状态, '全部', G.住院状态, STR_住院状态);

    INT_返回值   := 0;
    STR_返回信息 := '成功!';

    -- 【保存日志】
    PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
                 STR_客户端标识 => STR_客户端标识,
                 STR_医院编码   => STR_医院编码,
                 STR_功能编码   => STR_功能编码,
                 STR_请求参数   => STR_请求参数,
                 DAT_请求时间   => DAT_系统时间,
                 STR_请求结果   => STR_返回信息,
                 STR_关联编码   => STR_病人ID,
                 STR_执行人     => STR_平台标识,
                 DAT_执行时间   => SYSDATE,
                 STR_执行状态   => INT_返回值);

    RETURN;

  EXCEPTION
    -- 未检测的系统异常
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := SQLERRM;
      GOTO 退出;
  END;

  -- 【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  RETURN;

END PR_平台接口_住院病人信息查询;
/

prompt
prompt Creating procedure PR_平台接口_住院费用汇总清单
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_住院费用汇总清单(STR_请求参数   IN VARCHAR2,
                                             CUR_返回结果集 OUT SYS_REFCURSOR,
                                             INT_返回值     OUT INTEGER,
                                             STR_返回信息   OUT VARCHAR2) IS
  -- 固定参数
  DAT_系统时间 DATE;

  -- 请求参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_病人ID     VARCHAR2(50);
  STR_住院病历号 VARCHAR2(50);

  -- 过程内参数
  NUM_清单总额 NUMBER(18, 4);

  STR_母婴一体化 VARCHAR2(50);

BEGIN
  BEGIN
  
    -- 请求功能有效性验证
    IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '非法请求！';
      GOTO 退出;
    END IF;
  
    -- 就诊人有效性验证
    IF FU_平台接口_验证就诊人信息(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '就诊人信息无效！';
      GOTO 退出;
    END IF;
  
    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
  
    -- 【请求参数解析】
    STR_平台标识   := FU_平台接口_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_平台接口_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_平台接口_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 5);
  
    -- 【功能参数解析】
    STR_病人ID     := FU_平台接口_截取字符串值(STR_请求参数, '|', 6);
    STR_住院病历号 := FU_平台接口_截取字符串值(STR_请求参数, '|', 7);
  
    -- 数据验证
    IF STR_病人ID IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的病人ID！';
      GOTO 退出;
    END IF;
  
    IF STR_住院病历号 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的病历号！';
      GOTO 退出;
    END IF;
  
    -- 读取系统参数
  
    BEGIN
      SELECT 值
        INTO STR_母婴一体化
        FROM 基础项目_机构参数列表
       WHERE 参数编码 = '274'
         AND 机构编码 = STR_医院编码;
    EXCEPTION
      WHEN OTHERS THEN
        STR_母婴一体化 := '否';
    END;
  
    STR_返回信息 := FU_转换_住院病历号(STR_医院编码,
                            STR_住院病历号,
                            '否',
                            STR_母婴一体化);
  
    /*
    说明：
        1）只显示出院病人的费用清单
    */
  
    -- 取清单总额
    SELECT NVL(SUM(总金额), 0)
      INTO NUM_清单总额
      FROM 住院管理_出院病人信息 A,
           住院管理_出院病人处方 B,
           临时表_病历号         C
     WHERE A.机构编码 = B.机构编码
       AND A.住院病历号 = B.住院病历号
       AND A.机构编码 = STR_医院编码
       AND A.住院病历号 = (CASE STR_母婴一体化
             WHEN '是' THEN
              C.病历号
             ELSE
              STR_住院病历号
           END);
  
    -- 返回结果
    OPEN CUR_返回结果集 FOR
      SELECT 病人ID AS 病人ID,
             住院病历号 AS 住院病历号,
             M.名称 AS 费用归类,
             SUM(总金额) AS 金额,
             NUM_清单总额 AS 清单总额
        FROM (SELECT A.病人ID, A.住院病历号, B.归类编码, B.总金额
                FROM 住院管理_出院病人信息 A,
                     住院管理_出院病人处方 B,
                     临时表_病历号         C
               WHERE A.机构编码 = B.机构编码
                 AND A.住院病历号 = B.住院病历号
                 AND A.机构编码 = STR_医院编码
                 AND A.住院病历号 = (CASE STR_母婴一体化
                       WHEN '是' THEN
                        C.病历号
                       ELSE
                        STR_住院病历号
                     END)) Z
        LEFT JOIN 基础项目_字典明细 M
          ON Z.归类编码 = M.编码
         AND 分类编码 = 'GB_009001'
         AND 删除标志 = '0'
       GROUP BY 病人ID, 住院病历号, M.名称;
  
    INT_返回值   := 0;
    STR_返回信息 := '成功!';
  
    -- 【保存日志】
    PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
                 STR_客户端标识 => STR_客户端标识,
                 STR_医院编码   => STR_医院编码,
                 STR_功能编码   => STR_功能编码,
                 STR_请求参数   => STR_请求参数,
                 DAT_请求时间   => DAT_系统时间,
                 STR_请求结果   => STR_返回信息,
                 STR_关联编码   => STR_住院病历号,
                 STR_执行人     => STR_平台标识,
                 DAT_执行时间   => SYSDATE,
                 STR_执行状态   => INT_返回值);
  
    RETURN;
  
  EXCEPTION
    -- 未检测的系统异常
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := SQLERRM;
      GOTO 退出;
  END;

  -- 【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  RETURN;

END PR_平台接口_住院费用汇总清单;
/

prompt
prompt Creating procedure PR_平台接口_住院押金余额查询
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_住院押金余额查询(STR_请求参数   IN VARCHAR2,
                                             CUR_返回结果集 OUT SYS_REFCURSOR,
                                             INT_返回值     OUT INTEGER,
                                             STR_返回信息   OUT VARCHAR2) IS
  -- 固定参数
  DAT_系统时间 DATE;

  -- 请求参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_病人ID     VARCHAR2(50);
  STR_住院病历号 VARCHAR2(50);

BEGIN
  BEGIN

    -- 请求功能有效性验证
    IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '非法请求！';
      GOTO 退出;
    END IF;

    -- 就诊人有效性验证
    IF FU_平台接口_验证就诊人信息(STR_请求参数) <> 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '就诊人信息无效！';
      GOTO 退出;
    END IF;

    -- 【数据初始化】
    SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;

    -- 【请求参数解析】
    STR_平台标识   := FU_平台接口_截取字符串值(STR_请求参数, '|', 1);
    STR_认证密匙   := FU_平台接口_截取字符串值(STR_请求参数, '|', 2);
    STR_客户端标识 := FU_平台接口_截取字符串值(STR_请求参数, '|', 3);
    STR_功能编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 4);
    STR_医院编码   := FU_平台接口_截取字符串值(STR_请求参数, '|', 5);

    -- 【功能参数解析】
    STR_病人ID     := FU_平台接口_截取字符串值(STR_请求参数, '|', 6);
    STR_住院病历号 := FU_平台接口_截取字符串值(STR_请求参数, '|', 7);

    -- 数据验证
    IF STR_病人ID IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的病人ID！';
      GOTO 退出;
    END IF;

    IF STR_住院病历号 IS NULL THEN
      INT_返回值   := -1;
      STR_返回信息 := '无效的病历号！';
      GOTO 退出;
    END IF;

    /*
    说明：
        1）只显示在院病人的余额信息
    */
    OPEN CUR_返回结果集 FOR
      SELECT 病人ID AS 病人ID,
             住院病历号 AS 住院病历号,
             FU_费用_剩余金额_在院病人(STR_医院编码, 住院病历号) AS 押金余额,
             DAT_系统时间 AS 查询时间
        FROM 住院管理_在院病人信息
       WHERE 机构编码 = STR_医院编码
         AND 病人ID = STR_病人ID
         AND 住院病历号 = STR_住院病历号;

    INT_返回值   := 0;
    STR_返回信息 := '成功!';

    -- 【保存日志】
    PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
                 STR_客户端标识 => STR_客户端标识,
                 STR_医院编码   => STR_医院编码,
                 STR_功能编码   => STR_功能编码,
                 STR_请求参数   => STR_请求参数,
                 DAT_请求时间   => DAT_系统时间,
                 STR_请求结果   => STR_返回信息,
                 STR_关联编码   => STR_病人ID,
                 STR_执行人     => STR_平台标识,
                 DAT_执行时间   => SYSDATE,
                 STR_执行状态   => INT_返回值);

    RETURN;

  EXCEPTION
    -- 未检测的系统异常
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := SQLERRM;
      GOTO 退出;
  END;

  -- 【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  RETURN;

END PR_平台接口_住院押金余额查询;
/

prompt
prompt Creating procedure PR_平台接口_住院押金支付接口
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE PR_平台接口_住院押金支付接口(STR_请求参数   IN VARCHAR2,
                                           CUR_返回结果集 OUT SYS_REFCURSOR,
                                           INT_返回值     OUT INTEGER,
                                           STR_返回信息   OUT VARCHAR2) IS

  DAT_系统时间 DATE;

  -- 固定参数
  STR_平台标识   VARCHAR2(50);
  STR_认证密匙   VARCHAR2(50);
  STR_客户端标识 VARCHAR2(50);
  STR_功能编码   VARCHAR2(50);
  STR_医院编码   VARCHAR2(50);

  -- 功能参数
  STR_病人ID       VARCHAR2(50);
  STR_住院病历号   VARCHAR2(50);
  STR_平台订单号   VARCHAR2(50);
  STR_平台交易号   VARCHAR2(50);
  STR_平台订单时间 VARCHAR2(50);
  STR_平台交易时间 VARCHAR2(50);
  STR_预交金额     VARCHAR2(50);

  -- 处理参数
  STR_订单类型 VARCHAR2(50);
  STR_订单号   VARCHAR2(50);
  STR_流水码   VARCHAR2(50);
  STR_预交单号 VARCHAR2(50);
  NUM_预交金额 NUMBER(18, 4);

  STR_平台名称 VARCHAR2(50);
  STR_支付方式 VARCHAR2(50);

BEGIN

  -- 【请求功能有效性验证】
  IF FU_平台接口_验证网络请求(STR_请求参数) <> 0 THEN
    INT_返回值   := -1;
    STR_返回信息 := '非法请求！';
    GOTO 退出;
  END IF;

  -- 【就诊人有效性验证】
  IF FU_平台接口_验证就诊人信息(STR_请求参数) <> 0 THEN
    INT_返回值   := -1;
    STR_返回信息 := '就诊人信息无效！';
    GOTO 退出;
  END IF;

  -- 【数据初始化】
  SELECT SYSDATE INTO DAT_系统时间 FROM DUAL;
  STR_订单类型 := '预缴押金';

  -- 【固定参数解析】

  STR_平台标识   := FU_通用_截取字符串值(STR_请求参数, '|', 1);
  STR_认证密匙   := FU_通用_截取字符串值(STR_请求参数, '|', 2);
  STR_客户端标识 := FU_通用_截取字符串值(STR_请求参数, '|', 3);
  STR_功能编码   := FU_通用_截取字符串值(STR_请求参数, '|', 4);
  STR_医院编码   := FU_通用_截取字符串值(STR_请求参数, '|', 5);

  -- 【功能参数解析】

  STR_病人ID       := FU_通用_截取字符串值(STR_请求参数, '|', 6);
  STR_住院病历号   := FU_通用_截取字符串值(STR_请求参数, '|', 7);
  STR_平台订单号   := FU_通用_截取字符串值(STR_请求参数, '|', 8);
  STR_平台订单时间 := FU_通用_截取字符串值(STR_请求参数, '|', 9);
  STR_平台交易号   := FU_通用_截取字符串值(STR_请求参数, '|', 10);
  STR_平台交易时间 := FU_通用_截取字符串值(STR_请求参数, '|', 11);
  STR_预交金额     := FU_通用_截取字符串值(STR_请求参数, '|', 12);

  -- 【读取平台信息】
  BEGIN
    SELECT P.支付方式, P.平台名称
      INTO STR_支付方式, STR_平台名称
      FROM 平台接口_平台配置 P
     WHERE P.平台标识 = STR_平台标识;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INT_返回值   := -1;
      STR_返回信息 := '未找到有效的平台信息！';
      GOTO 退出;
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '系统异常：' || SQLERRM;
      GOTO 退出;
  END;

  -- 【参数有期性验证】
  IF STR_病人ID IS NULL THEN
    INT_返回值   := -1;
    STR_返回信息 := '请输入有效的病人ID！';
    GOTO 退出;
  END IF;
  IF STR_住院病历号 IS NULL THEN
    INT_返回值   := -1;
    STR_返回信息 := '请输入有效的住院病历号！';
    GOTO 退出;
  END IF;
  IF STR_平台订单号 IS NULL THEN
    INT_返回值   := -1;
    STR_返回信息 := '请输入有效的平台订单号！';
    GOTO 退出;
  END IF;
  IF STR_平台交易号 IS NULL THEN
    INT_返回值   := -1;
    STR_返回信息 := '请输入有效的平台交易号！';
    GOTO 退出;
  END IF;
  IF STR_平台订单时间 IS NULL
     OR FU_尝试转日期(STR_平台订单时间) IS NULL THEN
    INT_返回值   := -1;
    STR_返回信息 := '请输入有效的订单时间！';
    GOTO 退出;
  END IF;
  IF STR_平台交易时间 IS NULL
     OR FU_尝试转日期(STR_平台交易时间) IS NULL THEN
    INT_返回值   := -1;
    STR_返回信息 := '请输入有效的交易时间！';
    GOTO 退出;
  END IF;
  IF STR_预交金额 IS NULL THEN
    INT_返回值   := -1;
    STR_返回信息 := '请输入有效的预交金额！';
    GOTO 退出;
  END IF;

  -- 验证预交金额
  BEGIN
    SELECT TO_NUMBER(STR_预交金额) INTO NUM_预交金额 FROM DUAL;
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := '请输入有效的预交金额';
      GOTO 退出;
  END;
  IF NUM_预交金额 <= 0 THEN
    INT_返回值   := -1;
    STR_返回信息 := '预交金额不能少于等于0！';
    GOTO 退出;
  END IF;

  -- 验证住院病人
  SELECT COUNT(1)
    INTO INT_返回值
    FROM 住院管理_在院病人信息
   WHERE 机构编码 = STR_医院编码
     AND 住院病历号 = STR_住院病历号;

  IF INT_返回值 <= 0 THEN
    INT_返回值   := -1;
    STR_返回信息 := '病人已经不为在院状态,不能缴预交金!！';
    GOTO 退出;
  END IF;

  -- 生成预交单号
  SELECT FU_公用_获取当前票据号(STR_医院编码, STR_平台标识, '3')
    INTO STR_预交单号
    FROM DUAL;

  IF STR_预交单号 = '请到财务先领用票据' THEN
    STR_返回信息 := '请通知财务先领用票据!';
    GOTO 退出;
  END IF;

  -- 生成订单号
  PR_获取_系统唯一号(PRM_唯一号编码 => '6001',
              PRM_机构编码   => STR_医院编码,
              PRM_事物类型   => '1',
              PRM_返回唯一号 => STR_订单号,
              PRM_执行结果   => INT_返回值,
              PRM_错误信息   => STR_返回信息);
  IF INT_返回值 <> 0 THEN
    INT_返回值   := -1;
    STR_返回信息 := '产生订单号失败!';
    GOTO 退出;
  END IF;

  -- 生成流水号
  PR_获取_系统唯一号(PRM_唯一号编码 => '29',
              PRM_机构编码   => STR_医院编码,
              PRM_事物类型   => '1',
              PRM_返回唯一号 => STR_流水码,
              PRM_执行结果   => INT_返回值,
              PRM_错误信息   => STR_返回信息);
  IF INT_返回值 <> 0 THEN
    STR_返回信息 := '产生流水号失败!';
    GOTO 退出;
  END IF;

  -- 【功能处理】
  BEGIN
  
    -- 生成预交金记录
    INSERT INTO 住院管理_在院病人预交金
      (机构编码,
       病人ID,
       住院病历号,
       预交单号,
       缴费金额,
       缴费时间,
       预交类型,
       担保人姓名,
       备注,
       操作员编码,
       操作员姓名,
       撤销标志,
       流水码,
       支付方式)
    VALUES
      (STR_医院编码,
       STR_病人ID,
       STR_住院病历号,
       STR_预交单号,
       NUM_预交金额,
       DAT_系统时间,
       'POS缴费',
       NULL,
       NULL,
       STR_平台标识,
       STR_平台名称,
       '否',
       STR_流水码,
       STR_支付方式);
  
    INT_返回值 := SQL%ROWCOUNT;
    IF INT_返回值 = 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '保存缴费数据失败！';
      GOTO 退出;
    END IF;
  
    -- 插入订单
    INSERT INTO 平台接口_订单
      (流水码,
       平台标识,
       客户端标识,
       医院编码,
       病人ID,
       就诊病历号,
       关联编码,
       订单号,
       订单类型,
       订单时间,
       应付金额,
       优惠金额,
       实收金额,
       过期时间,
       订单状态,
       平台订单号,
       平台订单时间,
       平台交易号,
       平台交易时间,
       创建人,
       创建时间)
    VALUES
      (SEQ_平台接口_订单_流水码.NEXTVAL,
       STR_平台标识,
       STR_客户端标识,
       STR_医院编码,
       STR_病人ID,
       STR_住院病历号,
       STR_预交单号,
       STR_订单号,
       STR_订单类型,
       DAT_系统时间,
       NUM_预交金额,
       0,
       NUM_预交金额,
       NULL,
       '已支付',
       STR_平台订单号,
       TO_DATE(STR_平台订单时间, 'yyyy/mm/dd hh24:mi:ss'),
       STR_平台交易号,
       TO_DATE(STR_平台交易时间, 'yyyy/mm/dd hh24:mi:ss'),
       STR_平台标识,
       DAT_系统时间);
  
    INT_返回值 := SQL%ROWCOUNT;
    IF INT_返回值 = 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '保存订单失败！';
      GOTO 退出;
    END IF;
  
    -- 插入订单明细
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
      (SEQ_平台接口_订单明细_流水码.NEXTVAL,
       STR_订单号,
       '预缴押金',
       '预缴押金',
       1,
       '笔',
       NUM_预交金额,
       NUM_预交金额,
       NULL);
  
    INT_返回值 := SQL%ROWCOUNT;
    IF INT_返回值 = 0 THEN
      INT_返回值   := -1;
      STR_返回信息 := '保存订单失败！';
      GOTO 退出;
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      INT_返回值   := -1;
      STR_返回信息 := STR_返回信息 || SQLERRM;
      GOTO 退出;
  END;

  -- 【返回结果】
  OPEN CUR_返回结果集 FOR
    SELECT STR_病人ID AS 病人ID,
           STR_住院病历号 AS 住院病历号,
           STR_订单号 AS 订单号,
           STR_预交单号 AS 票据号,
           '' AS 备注
      FROM DUAL;

  INT_返回值   := 0;
  STR_返回信息 := '处理成功!';

  -- 【保存日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => STR_预交单号,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  COMMIT;
  RETURN;

  --【异常退出】
  <<退出>>
  INT_返回值   := INT_返回值;
  STR_返回信息 := STR_返回信息;
  OPEN CUR_返回结果集 FOR
    SELECT NULL FROM DUAL;

  --【错误日志】
  PR_平台接口_操作日志(STR_平台标识   => STR_平台标识,
               STR_客户端标识 => STR_客户端标识,
               STR_医院编码   => STR_医院编码,
               STR_功能编码   => STR_功能编码,
               STR_请求参数   => STR_请求参数,
               DAT_请求时间   => DAT_系统时间,
               STR_请求结果   => STR_返回信息,
               STR_关联编码   => NULL,
               STR_执行人     => STR_平台标识,
               DAT_执行时间   => SYSDATE,
               STR_执行状态   => INT_返回值);
  ROLLBACK;
  RETURN;

END PR_平台接口_住院押金支付接口;
/


prompt Done
spool off
set define on
