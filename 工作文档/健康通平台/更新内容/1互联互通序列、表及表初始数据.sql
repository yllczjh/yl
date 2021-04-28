create sequence SEQ_互联互通_操作日志_流水码
minvalue 1
maxvalue 9999999999
start with 1
increment by 1
cache 10;


create sequence SEQ_互联互通_订单_流水码
minvalue 1
maxvalue 9999999999
start with 1
increment by 1
cache 10;


create sequence SEQ_互联互通_订单明细_流水码
minvalue 1
maxvalue 9999999999
start with 1
increment by 1
cache 10;


create sequence SEQ_互联互通_用户信息_流水码
minvalue 1
maxvalue 9999999999
start with 1
increment by 1
cache 10;



CREATE TABLE 互联互通_订单(
    流水码 NUMBER NOT NULL,
    平台标识 VARCHAR2(50),
    医院编码 VARCHAR2(50),
    病人ID VARCHAR2(50),
    就诊病历号 VARCHAR2(50),
    关联编码 VARCHAR2(50),
    订单状态 VARCHAR2(50),
    医院订单号 VARCHAR2(50),
    平台订单号 VARCHAR2(50),
    订单时间 DATE,
    挂号费用 NUMBER(18,3),
    诊疗费用 NUMBER(18,3),
    挂号类型 VARCHAR2(50),
    挂号渠道 VARCHAR2(50),
    预约挂号类型 VARCHAR2(50),
    医院支付号 VARCHAR2(50),
    平台支付号 VARCHAR2(50),
    支付时间 DATE,
    平台交易流水号 VARCHAR2(50),
    支付渠道 VARCHAR2(50),
    总金额 NUMBER(18,3),
    应付金额 NUMBER(18,3),
    实付金额 NUMBER(18,3),
    医疗统筹支付金额 NUMBER(18,3),
    医院退款号 VARCHAR2(50),
    平台退款号 VARCHAR2(50),
    退款时间 DATE,
    平台退款流水号 VARCHAR2(50),
    退款金额 NUMBER(18,3),
    退款原因 VARCHAR2(100),
    退款标志 VARCHAR2(50),
    订单类型 VARCHAR2(50),
    过期时间 DATE,
    取消时间 DATE,
    取消原因 VARCHAR2(100),
    医院候诊号 VARCHAR2(50),
    创建人 VARCHAR2(50),
    创建时间 DATE,
    更新人 VARCHAR2(50),
    更新时间 DATE,
    排序号 INTEGER,
    备注 VARCHAR2(1000),
    状态 VARCHAR2(50),
    CONSTRAINT PK_互联互通_订单 PRIMARY KEY (流水码)
);

COMMENT ON TABLE 互联互通_订单 IS '互联互通_订单';
COMMENT ON COLUMN 互联互通_订单.流水码 IS '流水码';
COMMENT ON COLUMN 互联互通_订单.平台标识 IS '平台标识';
COMMENT ON COLUMN 互联互通_订单.医院编码 IS '医院编码';
COMMENT ON COLUMN 互联互通_订单.病人ID IS '病人ID';
COMMENT ON COLUMN 互联互通_订单.就诊病历号 IS '就诊病历号';
COMMENT ON COLUMN 互联互通_订单.关联编码 IS '预约挂号表的主键值；或遗嘱明细的收费序号';
COMMENT ON COLUMN 互联互通_订单.订单状态 IS '已锁号；待支付；已支付；已退款；已取消；已删除；';
COMMENT ON COLUMN 互联互通_订单.医院订单号 IS '医院订单号';
COMMENT ON COLUMN 互联互通_订单.平台订单号 IS '平台订单号';
COMMENT ON COLUMN 互联互通_订单.订单时间 IS '订单时间';
COMMENT ON COLUMN 互联互通_订单.挂号费用 IS '挂号费用';
COMMENT ON COLUMN 互联互通_订单.诊疗费用 IS '诊疗费用';
COMMENT ON COLUMN 互联互通_订单.挂号类型 IS '1本人；2子女；3他人';
COMMENT ON COLUMN 互联互通_订单.挂号渠道 IS '挂号渠道';
COMMENT ON COLUMN 互联互通_订单.预约挂号类型 IS '1当天挂号；2预约挂号；3锁号挂号';
COMMENT ON COLUMN 互联互通_订单.医院支付号 IS '发票序号';
COMMENT ON COLUMN 互联互通_订单.平台支付号 IS '平台支付号';
COMMENT ON COLUMN 互联互通_订单.支付时间 IS '支付时间';
COMMENT ON COLUMN 互联互通_订单.平台交易流水号 IS '平台交易流水号';
COMMENT ON COLUMN 互联互通_订单.支付渠道 IS '1-5平台；6窗口';
COMMENT ON COLUMN 互联互通_订单.总金额 IS '总金额';
COMMENT ON COLUMN 互联互通_订单.应付金额 IS '应付金额';
COMMENT ON COLUMN 互联互通_订单.实付金额 IS '实付金额';
COMMENT ON COLUMN 互联互通_订单.医疗统筹支付金额 IS '医疗统筹支付金额';
COMMENT ON COLUMN 互联互通_订单.医院退款号 IS '医院退款号';
COMMENT ON COLUMN 互联互通_订单.平台退款号 IS '平台退款号';
COMMENT ON COLUMN 互联互通_订单.退款时间 IS '退款时间';
COMMENT ON COLUMN 互联互通_订单.平台退款流水号 IS '平台退款流水号';
COMMENT ON COLUMN 互联互通_订单.退款金额 IS '退款金额';
COMMENT ON COLUMN 互联互通_订单.退款原因 IS '退款原因';
COMMENT ON COLUMN 互联互通_订单.退款标志 IS '0失败，1我方退款，2院内退款';
COMMENT ON COLUMN 互联互通_订单.订单类型 IS '预约挂号；预约退号；门诊收费；预缴押金；出院结算';
COMMENT ON COLUMN 互联互通_订单.过期时间 IS '过期时间';
COMMENT ON COLUMN 互联互通_订单.取消时间 IS '取消时间';
COMMENT ON COLUMN 互联互通_订单.取消原因 IS '取消原因';
COMMENT ON COLUMN 互联互通_订单.医院候诊号 IS '医院候诊号';
COMMENT ON COLUMN 互联互通_订单.创建人 IS '创建人';
COMMENT ON COLUMN 互联互通_订单.创建时间 IS '创建时间';
COMMENT ON COLUMN 互联互通_订单.更新人 IS '更新人';
COMMENT ON COLUMN 互联互通_订单.更新时间 IS '更新时间';
COMMENT ON COLUMN 互联互通_订单.排序号 IS '排序号';
COMMENT ON COLUMN 互联互通_订单.备注 IS '备注';
COMMENT ON COLUMN 互联互通_订单.状态 IS '状态';






CREATE TABLE 互联互通_订单明细(
    流水码 NUMBER NOT NULL,
    订单号 VARCHAR2(50),
    大类编码 VARCHAR2(50),
    小类编码 VARCHAR2(50),
    项目编码 VARCHAR2(50),
    项目名称 VARCHAR2(100),
    规格 VARCHAR2(100),
    批次号 VARCHAR2(50),
    数量 NUMBER(10,4),
    单位 VARCHAR2(50),
    单价 NUMBER(10,4),
    总金额 NUMBER(10,4),
    归类编码 VARCHAR2(50),
    唯一编码 VARCHAR2(50),
    CONSTRAINT PK_互联互通_订单明细 PRIMARY KEY (流水码)
);

COMMENT ON TABLE 互联互通_订单明细 IS '互联互通_订单明细';
COMMENT ON COLUMN 互联互通_订单明细.流水码 IS '流水码';
COMMENT ON COLUMN 互联互通_订单明细.订单号 IS '订单号';
COMMENT ON COLUMN 互联互通_订单明细.大类编码 IS '大类编码';
COMMENT ON COLUMN 互联互通_订单明细.小类编码 IS '小类编码';
COMMENT ON COLUMN 互联互通_订单明细.项目编码 IS '项目编码';
COMMENT ON COLUMN 互联互通_订单明细.项目名称 IS '项目名称';
COMMENT ON COLUMN 互联互通_订单明细.规格 IS '规格';
COMMENT ON COLUMN 互联互通_订单明细.批次号 IS '批次号';
COMMENT ON COLUMN 互联互通_订单明细.数量 IS '数量';
COMMENT ON COLUMN 互联互通_订单明细.单位 IS '单位';
COMMENT ON COLUMN 互联互通_订单明细.单价 IS '单价';
COMMENT ON COLUMN 互联互通_订单明细.总金额 IS '总金额';
COMMENT ON COLUMN 互联互通_订单明细.归类编码 IS '归类编码';
COMMENT ON COLUMN 互联互通_订单明细.唯一编码 IS '唯一编码';





CREATE TABLE 互联互通_操作日志(
    流水码 VARCHAR2(50) NOT NULL,
    平台标识 VARCHAR2(50),
    医院编码 VARCHAR2(50),
    功能编码 VARCHAR2(50),
    请求参数 VARCHAR2(4000),
    请求时间 DATE,
    返回值 NUMBER,
    返回信息 VARCHAR2(1000),
    执行时间 DATE,
    CONSTRAINT PK_互联互通_操作日志 PRIMARY KEY (流水码)
);

COMMENT ON TABLE 互联互通_操作日志 IS '互联互通_操作日志';
COMMENT ON COLUMN 互联互通_操作日志.流水码 IS '流水码';
COMMENT ON COLUMN 互联互通_操作日志.平台标识 IS '平台标识';
COMMENT ON COLUMN 互联互通_操作日志.医院编码 IS '医院编码';
COMMENT ON COLUMN 互联互通_操作日志.功能编码 IS '功能编码';
COMMENT ON COLUMN 互联互通_操作日志.请求参数 IS '请求参数';
COMMENT ON COLUMN 互联互通_操作日志.请求时间 IS '请求时间';
COMMENT ON COLUMN 互联互通_操作日志.返回值 IS '返回值';
COMMENT ON COLUMN 互联互通_操作日志.返回信息 IS '返回信息';
COMMENT ON COLUMN 互联互通_操作日志.执行时间 IS '执行时间';








CREATE TABLE 互联互通_用户信息(
    流水码 VARCHAR2(50) NOT NULL,
    医院编码 VARCHAR2(50),
    平台标识 VARCHAR2(50),
    病人ID VARCHAR2(50),
    用户类别 VARCHAR2(50),
    姓名 VARCHAR2(50),
    性别 VARCHAR2(50),
    出生日期 DATE,
    证件类型 VARCHAR2(50),
    证件号码 VARCHAR2(50),
    证件发证日期 VARCHAR2(50),
    证件有效日期 VARCHAR2(50),
    手机号码 VARCHAR2(50),
    联系地址 VARCHAR2(100),
    监护人证件类型 VARCHAR2(50),
    监护人证件号码 VARCHAR2(50),
    监护人姓名 VARCHAR2(50),
    用户卡类型 VARCHAR2(50),
    用户卡号 VARCHAR2(50),
    创建人 VARCHAR2(50),
    创建时间 DATE,
    CONSTRAINT PK_互联互通_用户信息 PRIMARY KEY (流水码)
);

COMMENT ON TABLE 互联互通_用户信息 IS '互联互通_用户信息';
COMMENT ON COLUMN 互联互通_用户信息.流水码 IS '流水码';
COMMENT ON COLUMN 互联互通_用户信息.医院编码 IS '医院编码';
COMMENT ON COLUMN 互联互通_用户信息.平台标识 IS '平台标识';
COMMENT ON COLUMN 互联互通_用户信息.病人ID IS '病人ID';
COMMENT ON COLUMN 互联互通_用户信息.用户类别 IS '用户类别';
COMMENT ON COLUMN 互联互通_用户信息.姓名 IS '姓名';
COMMENT ON COLUMN 互联互通_用户信息.性别 IS '性别';
COMMENT ON COLUMN 互联互通_用户信息.出生日期 IS '出生日期';
COMMENT ON COLUMN 互联互通_用户信息.证件类型 IS '证件类型';
COMMENT ON COLUMN 互联互通_用户信息.证件号码 IS '证件号码';
COMMENT ON COLUMN 互联互通_用户信息.证件发证日期 IS '证件发证日期';
COMMENT ON COLUMN 互联互通_用户信息.证件有效日期 IS '证件有效日期';
COMMENT ON COLUMN 互联互通_用户信息.手机号码 IS '手机号码';
COMMENT ON COLUMN 互联互通_用户信息.联系地址 IS '联系地址';
COMMENT ON COLUMN 互联互通_用户信息.监护人证件类型 IS '监护人证件类型';
COMMENT ON COLUMN 互联互通_用户信息.监护人证件号码 IS '监护人证件号码';
COMMENT ON COLUMN 互联互通_用户信息.监护人姓名 IS '监护人姓名';
COMMENT ON COLUMN 互联互通_用户信息.用户卡类型 IS '用户卡类型';
COMMENT ON COLUMN 互联互通_用户信息.用户卡号 IS '用户卡号';
COMMENT ON COLUMN 互联互通_用户信息.创建人 IS '创建人';
COMMENT ON COLUMN 互联互通_用户信息.创建时间 IS '创建时间';








CREATE TABLE 互联互通_平台参数配置(
    流水码 VARCHAR2(50) NOT NULL,
    平台标识 VARCHAR2(50),
    平台名称 VARCHAR2(50),
    用户ID VARCHAR2(50),
    认证密钥 VARCHAR2(50),
    医院ID VARCHAR2(50),
    机构编码 VARCHAR2(50),
    url地址 VARCHAR2(50),
    类名 VARCHAR2(50),
    方法名 VARCHAR2(50),
    支付方式 VARCHAR2(50),
    换算比例 NUMBER(18,3),
    不可预约科室 VARCHAR2(1000),
    有效状态 VARCHAR2(50),
    创建人 VARCHAR2(50),
    创建时间 DATE,
    更新人 VARCHAR2(50),
    更新时间 DATE,
    CONSTRAINT PK_互联互通_平台参数配置 PRIMARY KEY (流水码)
);

COMMENT ON TABLE 互联互通_平台参数配置 IS '互联互通_平台参数配置';
COMMENT ON COLUMN 互联互通_平台参数配置.流水码 IS '流水码';
COMMENT ON COLUMN 互联互通_平台参数配置.平台标识 IS '平台标识';
COMMENT ON COLUMN 互联互通_平台参数配置.平台名称 IS '平台名称';
COMMENT ON COLUMN 互联互通_平台参数配置.用户ID IS '用户ID';
COMMENT ON COLUMN 互联互通_平台参数配置.认证密钥 IS '认证密钥';
COMMENT ON COLUMN 互联互通_平台参数配置.医院ID IS '平台中医院的唯一标识';
COMMENT ON COLUMN 互联互通_平台参数配置.机构编码 IS 'his中医院的唯一标识';
COMMENT ON COLUMN 互联互通_平台参数配置.url地址 IS 'url地址';
COMMENT ON COLUMN 互联互通_平台参数配置.类名 IS '类名';
COMMENT ON COLUMN 互联互通_平台参数配置.方法名 IS '方法名';
COMMENT ON COLUMN 互联互通_平台参数配置.支付方式 IS '支付方式';
COMMENT ON COLUMN 互联互通_平台参数配置.换算比例 IS 'his与平台间金额的换算比例';
COMMENT ON COLUMN 互联互通_平台参数配置.不可预约科室 IS '不可以在平台预约的科室';
COMMENT ON COLUMN 互联互通_平台参数配置.有效状态 IS '1有效；0无效';
COMMENT ON COLUMN 互联互通_平台参数配置.创建人 IS '创建人';
COMMENT ON COLUMN 互联互通_平台参数配置.创建时间 IS '创建时间';
COMMENT ON COLUMN 互联互通_平台参数配置.更新人 IS '更新人';
COMMENT ON COLUMN 互联互通_平台参数配置.更新时间 IS '更新时间';






CREATE TABLE 互联互通_平台功能配置(
    流水码 VARCHAR2(50) NOT NULL,
    平台标识 VARCHAR2(50),
    功能编码 VARCHAR2(50),
    功能名称 VARCHAR2(50),
    状态 VARCHAR2(50),
    备注 VARCHAR2(100),
    创建人 VARCHAR2(50),
    创建时间 DATE,
    更新人 VARCHAR2(50),
    更新时间 DATE,
    CONSTRAINT PK_互联互通_平台功能配置 PRIMARY KEY (流水码)
);

COMMENT ON TABLE 互联互通_平台功能配置 IS '互联互通_平台功能配置';
COMMENT ON COLUMN 互联互通_平台功能配置.流水码 IS '流水码';
COMMENT ON COLUMN 互联互通_平台功能配置.平台标识 IS '平台标识';
COMMENT ON COLUMN 互联互通_平台功能配置.功能编码 IS '功能编码';
COMMENT ON COLUMN 互联互通_平台功能配置.功能名称 IS '功能名称';
COMMENT ON COLUMN 互联互通_平台功能配置.状态 IS '状态';
COMMENT ON COLUMN 互联互通_平台功能配置.备注 IS '备注';
COMMENT ON COLUMN 互联互通_平台功能配置.创建人 IS '创建人';
COMMENT ON COLUMN 互联互通_平台功能配置.创建时间 IS '创建时间';
COMMENT ON COLUMN 互联互通_平台功能配置.更新人 IS '更新人';
COMMENT ON COLUMN 互联互通_平台功能配置.更新时间 IS '更新时间';








insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('1', '12320', '1001', '网络通信测试', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('2', '12320', '1002', '用户信息注册', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('3', '12320', '1003', '用户信息查询', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('4', '12320', '1004', '医院信息查询', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('5', '12320', '1005', '用户卡验证', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('6', '12320', '2001', '科室查询', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('7', '12320', '2002', '医生查询', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('8', '12320', '2003', '排班信息查询', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('9', '12320', '2004', '排班分时查询', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('10', '12320', '2005', '号源锁定', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('11', '12320', '2006', '解锁号源锁定', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('12', '12320', '2007', '预约挂号登记', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('13', '12320', '2008', '预约挂号支付', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('14', '12320', '2009', '预约挂号取消', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('15', '12320', '2010', '预约挂号退号', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('16', '12320', '2011', '预约挂号取号', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('17', '12320', '2012', '挂号记录查询', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('18', '12320', '2020', '医生门诊数据查询', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('19', '12320', '3001', '缴费记录查询', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('20', '12320', '3002', '缴费明细查询', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('21', '12320', '3003', '待缴费记录支付', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('22', '12320', '3004', '缴费订单查询', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('23', '12320', '4001', '排队列表查询', '0', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('24', '12320', '8001', '检查/检验列表查询', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('25', '12320', '8002', '检验报告查询(普通检查)', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('26', '12320', '8003', '检验报告查询(药敏检查)', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('27', '12320', '8004', '检查报告查询', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('28', '12320', '9003', '系统订单查询', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);

insert into 互联互通_平台功能配置 (流水码, 平台标识, 功能编码, 功能名称, 状态, 创建人, 创建时间, 更新人, 更新时间)
values ('29', '12320', '5004', '窗口取号', '1', '522633020000001', to_date('07-07-2020 12:12:23', 'dd-mm-yyyy hh24:mi:ss'), null, null);








insert into 互联互通_平台参数配置 (流水码, 平台标识, 平台名称, 用户ID, 认证密钥, 医院ID, 机构编码, URL地址, 类名, 方法名, 支付方式, 换算比例, 不可预约科室, 有效状态, 创建人, 创建时间, 更新人, 更新时间)
values ('1', '12320', '12320测试', 'ln_12320wx', '2098D32C4D1399EC', '1', '522633020000001', 'http://localhost:8001/APIService.asmx', 'APIService', 'PubService', '网上支付', 100.000, '1020,1018', '1', null, null, null, null);

commit;
