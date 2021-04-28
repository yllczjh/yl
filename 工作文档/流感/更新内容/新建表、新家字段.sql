alter table 病案管理_项目信息 add 上级项目编码 varchar2(50);
alter table 病案管理_项目信息 add 是否回传数据 varchar2(10);
alter table 病案管理_项目信息 add 文件名格式 varchar2(50);

alter table 病案管理_项目信息 add 是否自动导出 varchar2(50);
alter table 病案管理_项目信息 add 导出时间 varchar2(10);
alter table 病案管理_项目信息 add 导出路径 varchar2(1000);
update 病案管理_项目信息 set 是否自动导出='否';


alter table 病案管理_项目字段对照 add 是否取自病历 varchar2(50);
alter table 病案管理_项目字段对照 add 元素或文档名 varchar2(50);
update 病案管理_项目字段对照 set 是否取自病历='False';

alter table 病案管理_项目字段对照 add 是否编码转名称 varchar2(50);
alter table 病案管理_项目字段对照 add 转换表 varchar2(50);
alter table 病案管理_项目字段对照 add 转换字典 varchar2(50);
update 病案管理_项目字段对照 set 是否编码转名称='False';


CREATE TABLE 病案管理_导出列表(
    机构编码 VARCHAR2(50) NOT NULL,
    病历号 VARCHAR2(50) NOT NULL,
	项目编码 VARCHAR2(50) NOT NULL,
    起始时间 DATE,
    截止时间 DATE,
    导出时间 DATE,
    流水码 VARCHAR2(50),
	就诊类别 VARCHAR2(50), 
   CONSTRAINT PK_病案管理_导出列表  PRIMARY KEY (项目编码,病历号,就诊类别)
);

COMMENT ON COLUMN 病案管理_导出列表.机构编码 IS '机构编码';
COMMENT ON COLUMN 病案管理_导出列表.病历号 IS '病历号';
COMMENT ON COLUMN 病案管理_导出列表.起始时间 IS '导出时搜索条件的起始时间';
COMMENT ON COLUMN 病案管理_导出列表.截止时间 IS '导出时搜索条件的截止时间';
COMMENT ON COLUMN 病案管理_导出列表.导出时间 IS '导出时间';
COMMENT ON COLUMN 病案管理_导出列表.流水码 IS '每批导出数据流水码相同';
COMMENT ON COLUMN 病案管理_导出列表.就诊类别 IS '门诊；在院；出院';





CREATE TABLE 病案管理_项目接口对照分类(
    机构编码 VARCHAR2(50) NOT NULL,
    项目编码 VARCHAR2(50) NOT NULL,
    流水码 VARCHAR2(50) NOT NULL,
    分类编码 VARCHAR2(50) NOT NULL,
    分类名称 VARCHAR2(50) NOT NULL,
    对照类型 VARCHAR2(50) NOT NULL,
    过滤条件 VARCHAR2(50)
);

COMMENT ON TABLE 病案管理_项目接口对照分类 IS '病案管理_项目接口对照分类';
COMMENT ON COLUMN 病案管理_项目接口对照分类.机构编码 IS '机构编码';
COMMENT ON COLUMN 病案管理_项目接口对照分类.项目编码 IS '项目编码';
COMMENT ON COLUMN 病案管理_项目接口对照分类.流水码 IS '流水码';
COMMENT ON COLUMN 病案管理_项目接口对照分类.分类编码 IS '分类编码';
COMMENT ON COLUMN 病案管理_项目接口对照分类.分类名称 IS '分类名称';
COMMENT ON COLUMN 病案管理_项目接口对照分类.对照类型 IS '对照类型';
COMMENT ON COLUMN 病案管理_项目接口对照分类.过滤条件 IS '过滤条件';




CREATE TABLE 病案管理_项目接口对照明细(
    流水码 VARCHAR2(50) NOT NULL,
    外键ID VARCHAR2(50) NOT NULL,
    接口对照信息编码 VARCHAR2(50) NOT NULL,
    接口对照信息名称 VARCHAR2(100) NOT NULL
);

COMMENT ON TABLE 病案管理_项目接口对照明细 IS '病案管理_项目接口对照明细';
COMMENT ON COLUMN 病案管理_项目接口对照明细.流水码 IS '流水码';
COMMENT ON COLUMN 病案管理_项目接口对照明细.外键ID IS '病案管理_项目接口对照信息分类的流水码';
COMMENT ON COLUMN 病案管理_项目接口对照明细.接口对照信息编码 IS '接口对照信息编码';
COMMENT ON COLUMN 病案管理_项目接口对照明细.接口对照信息名称 IS '接口对照信息名称';




CREATE TABLE 病案管理_项目系统对照明细(
    外键ID VARCHAR2(50) NOT NULL,
    系统对照信息编码 VARCHAR2(50) NOT NULL,
    系统对照信息名称 VARCHAR2(50)
);

COMMENT ON TABLE 病案管理_项目系统对照明细 IS '病案管理_项目系统对照明细';
COMMENT ON COLUMN 病案管理_项目系统对照明细.外键ID IS '病案管理_项目接口对照信息的流水码';
COMMENT ON COLUMN 病案管理_项目系统对照明细.系统对照信息编码 IS '系统对照信息编码';
COMMENT ON COLUMN 病案管理_项目系统对照明细.系统对照信息名称 IS '系统对照信息名称';




-- Create table
create global temporary table 临时表_数据上报_出院流感病例
(
  病历号        VARCHAR2(50),
  p900       VARCHAR2(40),
  p6891      VARCHAR2(80),
  p686       VARCHAR2(50),
  p800       VARCHAR2(50),
  p1         VARCHAR2(20),
  p2         NUMBER(4),
  p3         VARCHAR2(20),
  p4         VARCHAR2(40),
  p5         VARCHAR2(2),
  p6         DATE,
  p7         NUMBER(3),
  p8         VARCHAR2(2),
  p9         VARCHAR2(2),
  p101       VARCHAR2(30),
  p102       VARCHAR2(30),
  p103       VARCHAR2(30),
  p11        VARCHAR2(20),
  p12        VARCHAR2(40),
  p13        VARCHAR2(80),
  p801       VARCHAR2(200),
  p802       VARCHAR2(40),
  p803       VARCHAR2(6),
  p14        VARCHAR2(200),
  p15        VARCHAR2(40),
  p16        VARCHAR2(6),
  p17        VARCHAR2(200),
  p171       VARCHAR2(6),
  p18        VARCHAR2(40),
  p19        VARCHAR2(40),
  p20        VARCHAR2(200),
  p804       VARCHAR2(2),
  p21        VARCHAR2(40),
  p22        DATE,
  p23        VARCHAR2(6),
  p231       VARCHAR2(30),
  p24        VARCHAR2(6),
  p25        DATE,
  p26        VARCHAR2(6),
  p261       VARCHAR2(30),
  p27        NUMBER(6),
  p28        VARCHAR2(20),
  p281       VARCHAR2(100),
  p29        VARCHAR2(2),
  p30        VARCHAR2(30),
  p301       VARCHAR2(100),
  p31        DATE,
  p321       VARCHAR2(20),
  p322       VARCHAR2(100),
  p805       VARCHAR2(10),
  p323       VARCHAR2(2),
  qtzdbm1    VARCHAR2(20),
  qtzdms1    VARCHAR2(100),
  qtzdrybq1  VARCHAR2(10),
  qtzdcyqk1  VARCHAR2(2),
  qtzdbm2    VARCHAR2(20),
  qtzdms2    VARCHAR2(100),
  qtzdrybq2  VARCHAR2(10),
  qtzdcyqk2  VARCHAR2(2),
  qtzdbm3    VARCHAR2(20),
  qtzdms3    VARCHAR2(100),
  qtzdrybq3  VARCHAR2(10),
  qtzdcyqk3  VARCHAR2(2),
  qtzdbm4    VARCHAR2(20),
  qtzdms4    VARCHAR2(100),
  qtzdrybq4  VARCHAR2(10),
  qtzdcyqk4  VARCHAR2(2),
  qtzdbm5    VARCHAR2(20),
  qtzdms5    VARCHAR2(100),
  qtzdrybq5  VARCHAR2(10),
  qtzdcyqk5  VARCHAR2(2),
  qtzdbm6    VARCHAR2(20),
  qtzdms6    VARCHAR2(100),
  qtzdrybq6  VARCHAR2(10),
  qtzdcyqk6  VARCHAR2(2),
  qtzdbm7    VARCHAR2(20),
  qtzdms7    VARCHAR2(100),
  qtzdrybq7  VARCHAR2(10),
  qtzdcyqk7  VARCHAR2(2),
  qtzdbm8    VARCHAR2(20),
  qtzdms8    VARCHAR2(100),
  qtzdrybq8  VARCHAR2(10),
  qtzdcyqk8  VARCHAR2(2),
  qtzdbm9    VARCHAR2(20),
  qtzdms9    VARCHAR2(100),
  qtzdrybq9  VARCHAR2(10),
  qtzdcyqk9  VARCHAR2(2),
  qtzdbm10   VARCHAR2(20),
  qtzdms10   VARCHAR2(100),
  qtzdrybq10 VARCHAR2(10),
  qtzdcyqk10 VARCHAR2(2),
  p689       NUMBER(5),
  blzdbm1    VARCHAR2(20),
  blzdmc1    VARCHAR2(100),
  blh1       VARCHAR2(50),
  blzdbm2    VARCHAR2(20),
  blzdmc2    VARCHAR2(100),
  blh2       VARCHAR2(50),
  blzdbm3    VARCHAR2(20),
  blzdmc3    VARCHAR2(100),
  blh3       VARCHAR2(50),
  wbysbm1    VARCHAR2(20),
  wbysmc1    VARCHAR2(100),
  wbysbm2    VARCHAR2(20),
  wbysmc2    VARCHAR2(100),
  wbysbm3    VARCHAR2(20),
  wbysmc3    VARCHAR2(100),
  p371       VARCHAR2(200),
  p372       VARCHAR2(100),
  p38        VARCHAR2(2),
  p39        VARCHAR2(2),
  p40        VARCHAR2(2),
  p411       VARCHAR2(2),
  p412       VARCHAR2(2),
  p413       VARCHAR2(2),
  p414       VARCHAR2(2),
  p415       VARCHAR2(2),
  p421       NUMBER(3),
  p422       NUMBER(3),
  p687       VARCHAR2(2),
  p688       VARCHAR2(2),
  p431       VARCHAR2(40),
  p432       VARCHAR2(40),
  p433       VARCHAR2(40),
  p434       VARCHAR2(40),
  p819       VARCHAR2(40),
  p435       VARCHAR2(40),
  p436       VARCHAR2(40),
  p437       VARCHAR2(40),
  p438       VARCHAR2(40),
  p44        VARCHAR2(2),
  p45        VARCHAR2(40),
  p46        VARCHAR2(40),
  p47        DATE,
  ssbm1      VARCHAR2(20),
  ssrq1      DATE,
  ssjb1      VARCHAR2(10),
  ssmc1      VARCHAR2(100),
  ssbw1      VARCHAR2(100),
  sscxsj1    NUMBER(7,2),
  sz1        VARCHAR2(40),
  yz1        VARCHAR2(40),
  ez1        VARCHAR2(40),
  mzfs1      VARCHAR2(10),
  mzfj1      VARCHAR2(2),
  qkyhdj1    VARCHAR2(10),
  mzys1      VARCHAR2(40),
  ssbm2      VARCHAR2(20),
  ssrq2      DATE,
  ssjb2      VARCHAR2(10),
  ssmc2      VARCHAR2(100),
  ssbw2      VARCHAR2(100),
  sscxsj2    NUMBER(7,2),
  sz2        VARCHAR2(40),
  yz2        VARCHAR2(40),
  ez2        VARCHAR2(40),
  mzfs2      VARCHAR2(10),
  mzfj2      VARCHAR2(2),
  qkyhdj2    VARCHAR2(10),
  mzys2      VARCHAR2(40),
  ssbm3      VARCHAR2(20),
  ssrq3      DATE,
  ssjb3      VARCHAR2(10),
  ssmc3      VARCHAR2(100),
  ssbw3      VARCHAR2(100),
  sscxsj3    NUMBER(7,2),
  sz3        VARCHAR2(40),
  yz3        VARCHAR2(40),
  ez3        VARCHAR2(40),
  mzfs3      VARCHAR2(10),
  mzfj3      VARCHAR2(2),
  qkyhdj3    VARCHAR2(10),
  mzys3      VARCHAR2(40),
  ssbm4      VARCHAR2(20),
  ssrq4      DATE,
  ssjb4      VARCHAR2(10),
  ssmc4      VARCHAR2(100),
  ssbw4      VARCHAR2(100),
  sscxsj4    NUMBER(7,2),
  sz4        VARCHAR2(40),
  yz4        VARCHAR2(40),
  ez4        VARCHAR2(40),
  mzfs4      VARCHAR2(10),
  mzfj4      VARCHAR2(2),
  qkyhdj4    VARCHAR2(10),
  mzys4      VARCHAR2(40),
  ssbm5      VARCHAR2(20),
  ssrq5      DATE,
  ssjb5      VARCHAR2(10),
  ssmc5      VARCHAR2(100),
  ssbw5      VARCHAR2(100),
  sscxsj5    NUMBER(7,2),
  sz5        VARCHAR2(40),
  yz5        VARCHAR2(40),
  ez5        VARCHAR2(40),
  mzfs5      VARCHAR2(10),
  mzfj5      VARCHAR2(2),
  qkyhdj5    VARCHAR2(10),
  mzys5      VARCHAR2(40),
  ssbm6      VARCHAR2(20),
  ssrq6      DATE,
  ssjb6      VARCHAR2(10),
  ssmc6      VARCHAR2(100),
  ssbw6      VARCHAR2(100),
  sscxsj6    NUMBER(7,2),
  sz6        VARCHAR2(40),
  yz6        VARCHAR2(40),
  ez6        VARCHAR2(40),
  mzfs6      VARCHAR2(10),
  mzfj6      VARCHAR2(2),
  qkyhdj6    VARCHAR2(10),
  mzys6      VARCHAR2(40),
  ssbm7      VARCHAR2(20),
  ssrq7      DATE,
  ssjb7      VARCHAR2(10),
  ssmc7      VARCHAR2(100),
  ssbw7      VARCHAR2(100),
  sscxsj7    NUMBER(7,2),
  sz7        VARCHAR2(40),
  yz7        VARCHAR2(40),
  ez7        VARCHAR2(40),
  mzfs7      VARCHAR2(10),
  mzfj7      VARCHAR2(2),
  qkyhdj7    VARCHAR2(10),
  mzys7      VARCHAR2(40),
  ssbm8      VARCHAR2(20),
  ssrq8      DATE,
  ssjb8      VARCHAR2(10),
  ssmc8      VARCHAR2(100),
  ssbw8      VARCHAR2(100),
  sscxsj8    NUMBER(7,2),
  sz8        VARCHAR2(40),
  yz8        VARCHAR2(40),
  ez8        VARCHAR2(40),
  mzfs8      VARCHAR2(10),
  mzfj8      VARCHAR2(2),
  qkyhdj8    VARCHAR2(10),
  mzys8      VARCHAR2(40),
  ssbm9      VARCHAR2(20),
  ssrq9      DATE,
  ssjb9      VARCHAR2(10),
  ssmc9      VARCHAR2(100),
  ssbw9      VARCHAR2(100),
  sscxsj9    NUMBER(7,2),
  sz9        VARCHAR2(40),
  yz9        VARCHAR2(40),
  ez9        VARCHAR2(40),
  mzfs9      VARCHAR2(10),
  mzfj9      VARCHAR2(2),
  qkyhdj9    VARCHAR2(10),
  mzys9      VARCHAR2(40),
  ssbm10     VARCHAR2(20),
  ssrq10     DATE,
  ssjb10     VARCHAR2(10),
  ssmc10     VARCHAR2(100),
  ssbw10     VARCHAR2(100),
  sscxsj10   NUMBER(7,2),
  sz10       VARCHAR2(40),
  yz10       VARCHAR2(40),
  ez10       VARCHAR2(40),
  mzfs10     VARCHAR2(10),
  mzfj10     VARCHAR2(2),
  qkyhdj10   VARCHAR2(10),
  mzys10     VARCHAR2(40),
  p561       NUMBER(6),
  p562       NUMBER(6),
  p563       NUMBER(6),
  p564       NUMBER(6),
  jhsmc1     VARCHAR2(4),
  jrsj1      DATE,
  tcsj1      DATE,
  jhsmc2     VARCHAR2(4),
  jrsj2      DATE,
  tcsj2      DATE,
  jhsmc3     VARCHAR2(4),
  jrsj3      DATE,
  tcsj3      DATE,
  jhsmc4     VARCHAR2(4),
  jrsj4      DATE,
  tcsj4      DATE,
  jhsmc5     VARCHAR2(4),
  jrsj5      DATE,
  tcsj5      DATE,
  p57        VARCHAR2(2),
  p58        VARCHAR2(2),
  p581       VARCHAR2(10),
  p60        VARCHAR2(2),
  p611       NUMBER(4,2),
  p612       NUMBER(4,2),
  p613       NUMBER(4,2),
  p59        VARCHAR2(2),
  p62        VARCHAR2(2),
  p63        VARCHAR2(2),
  p64        VARCHAR2(2),
  p651       NUMBER(8,2),
  p652       NUMBER(8,2),
  p653       NUMBER(11),
  p654       NUMBER(11),
  p655       NUMBER(11),
  p656       NUMBER(11),
  p66        NUMBER(4,2),
  p681       NUMBER(11),
  p682       NUMBER(11),
  p683       NUMBER(11),
  p684       NUMBER(11),
  p685       NUMBER(11),
  p67        NUMBER(11),
  p731       NUMBER(11),
  p732       NUMBER(11),
  p733       NUMBER(11),
  p734       NUMBER(11),
  p72        NUMBER(11),
  p830       VARCHAR2(2),
  p831       VARCHAR2(100),
  p741       VARCHAR2(2),
  p742       VARCHAR2(100),
  p743       VARCHAR2(100),
  p782       NUMBER(10,2),
  p751       NUMBER(10,2),
  p752       NUMBER(10,2),
  p754       NUMBER(10,2),
  p755       NUMBER(10,2),
  p756       NUMBER(10,2),
  p757       NUMBER(10,2),
  p758       NUMBER(10,2),
  p759       NUMBER(10,2),
  p760       NUMBER(10,2),
  p761       NUMBER(10,2),
  p762       NUMBER(10,2),
  p763       NUMBER(10,2),
  p764       NUMBER(10,2),
  p765       NUMBER(10,2),
  p767       NUMBER(10,2),
  p768       NUMBER(10,2),
  p769       NUMBER(10,2),
  p770       NUMBER(10,2),
  p771       NUMBER(10,2),
  p772       NUMBER(10,2),
  p773       NUMBER(10,2),
  p774       NUMBER(10,2),
  p775       NUMBER(10,2),
  p776       NUMBER(10,2),
  p777       NUMBER(10,2),
  p778       NUMBER(10,2),
  p779       NUMBER(10,2),
  p780       NUMBER(10,2),
  p781       NUMBER(10,2)
)
on commit delete rows;
-- Add comments to the columns 
comment on column 临时表_数据上报_出院流感病例.p900
  is '医疗机构代码';
comment on column 临时表_数据上报_出院流感病例.p6891
  is '机构名称';
comment on column 临时表_数据上报_出院流感病例.p686
  is '医疗保险手册（卡）号';
comment on column 临时表_数据上报_出院流感病例.p800
  is '健康卡号';
comment on column 临时表_数据上报_出院流感病例.p1
  is '医疗付款方式';
comment on column 临时表_数据上报_出院流感病例.p2
  is '住院次数';
comment on column 临时表_数据上报_出院流感病例.p3
  is '病案号';
comment on column 临时表_数据上报_出院流感病例.p4
  is '姓名';
comment on column 临时表_数据上报_出院流感病例.p5
  is '性别';
comment on column 临时表_数据上报_出院流感病例.p6
  is '出生日期';
comment on column 临时表_数据上报_出院流感病例.p7
  is '年龄';
comment on column 临时表_数据上报_出院流感病例.p8
  is '婚姻状况';
comment on column 临时表_数据上报_出院流感病例.p9
  is '职业';
comment on column 临时表_数据上报_出院流感病例.p101
  is '出生省份';
comment on column 临时表_数据上报_出院流感病例.p102
  is '出生地市';
comment on column 临时表_数据上报_出院流感病例.p103
  is '出生地县';
comment on column 临时表_数据上报_出院流感病例.p11
  is '民族';
comment on column 临时表_数据上报_出院流感病例.p12
  is '国籍';
comment on column 临时表_数据上报_出院流感病例.p13
  is '身份证号';
comment on column 临时表_数据上报_出院流感病例.p801
  is '现住址';
comment on column 临时表_数据上报_出院流感病例.p802
  is '住宅电话';
comment on column 临时表_数据上报_出院流感病例.p803
  is '现住址邮政编码';
comment on column 临时表_数据上报_出院流感病例.p14
  is '工作单位及地址';
comment on column 临时表_数据上报_出院流感病例.p15
  is '电话';
comment on column 临时表_数据上报_出院流感病例.p16
  is '工作单位邮政编码';
comment on column 临时表_数据上报_出院流感病例.p17
  is '户口地址';
comment on column 临时表_数据上报_出院流感病例.p171
  is '户口所在地邮政编码';
comment on column 临时表_数据上报_出院流感病例.p18
  is '联系人姓名';
comment on column 临时表_数据上报_出院流感病例.p19
  is '关系';
comment on column 临时表_数据上报_出院流感病例.p20
  is '联系人地址';
comment on column 临时表_数据上报_出院流感病例.p804
  is '入院途径';
comment on column 临时表_数据上报_出院流感病例.p21
  is '联系人电话';
comment on column 临时表_数据上报_出院流感病例.p22
  is '入院日期';
comment on column 临时表_数据上报_出院流感病例.p23
  is '入院科别';
comment on column 临时表_数据上报_出院流感病例.p231
  is '入院病室';
comment on column 临时表_数据上报_出院流感病例.p24
  is '转科科别';
comment on column 临时表_数据上报_出院流感病例.p25
  is '出院日期';
comment on column 临时表_数据上报_出院流感病例.p26
  is '出院科别';
comment on column 临时表_数据上报_出院流感病例.p261
  is '出院病室';
comment on column 临时表_数据上报_出院流感病例.p27
  is '实际住院天数';
comment on column 临时表_数据上报_出院流感病例.p28
  is '门（急）诊诊断编码';
comment on column 临时表_数据上报_出院流感病例.p281
  is '门（急）诊诊断描述';
comment on column 临时表_数据上报_出院流感病例.p29
  is '入院时情况';
comment on column 临时表_数据上报_出院流感病例.p30
  is '入院诊断编码';
comment on column 临时表_数据上报_出院流感病例.p301
  is '入院诊断描述';
comment on column 临时表_数据上报_出院流感病例.p31
  is '入院后确诊日期';
comment on column 临时表_数据上报_出院流感病例.p321
  is '主要诊断编码';
comment on column 临时表_数据上报_出院流感病例.p322
  is '主要诊断疾病描述';
comment on column 临时表_数据上报_出院流感病例.p805
  is '主要诊断入院病情';
comment on column 临时表_数据上报_出院流感病例.p323
  is '主要诊断出院情况';
comment on column 临时表_数据上报_出院流感病例.qtzdbm1
  is '其他诊断编码1 P324';
comment on column 临时表_数据上报_出院流感病例.qtzdms1
  is '其他诊断疾病描述1 P325';
comment on column 临时表_数据上报_出院流感病例.qtzdrybq1
  is '其他诊断入院病情1 P806';
comment on column 临时表_数据上报_出院流感病例.qtzdcyqk1
  is '其他诊断出院情况1 P326';
comment on column 临时表_数据上报_出院流感病例.qtzdbm2
  is '其他诊断编码2 P327';
comment on column 临时表_数据上报_出院流感病例.qtzdms2
  is '其他诊断疾病描述2 P328';
comment on column 临时表_数据上报_出院流感病例.qtzdrybq2
  is '其他诊断入院病情2 P807';
comment on column 临时表_数据上报_出院流感病例.qtzdcyqk2
  is '其他诊断出院情况2 P329';
comment on column 临时表_数据上报_出院流感病例.qtzdbm3
  is '其他诊断编码3 P3291';
comment on column 临时表_数据上报_出院流感病例.qtzdms3
  is '其他诊断疾病描述3 P3292';
comment on column 临时表_数据上报_出院流感病例.qtzdrybq3
  is '其他诊断入院病情3 P808';
comment on column 临时表_数据上报_出院流感病例.qtzdcyqk3
  is '其他诊断出院情况3 P3293';
comment on column 临时表_数据上报_出院流感病例.qtzdbm4
  is '其他诊断编码4 P3294';
comment on column 临时表_数据上报_出院流感病例.qtzdms4
  is '其他诊断疾病描述4 P3295';
comment on column 临时表_数据上报_出院流感病例.qtzdrybq4
  is '其他诊断入院病情4 P809';
comment on column 临时表_数据上报_出院流感病例.qtzdcyqk4
  is '其他诊断出院情况4 P3296';
comment on column 临时表_数据上报_出院流感病例.qtzdbm5
  is '其他诊断编码5 P3297';
comment on column 临时表_数据上报_出院流感病例.qtzdms5
  is '其他诊断疾病描述5 P3298';
comment on column 临时表_数据上报_出院流感病例.qtzdrybq5
  is '其他诊断入院病情5 P810';
comment on column 临时表_数据上报_出院流感病例.qtzdcyqk5
  is '其他诊断出院情况5 P3299';
comment on column 临时表_数据上报_出院流感病例.qtzdbm6
  is '其他诊断编码6 P3281';
comment on column 临时表_数据上报_出院流感病例.qtzdms6
  is '其他诊断疾病描述6 P3282';
comment on column 临时表_数据上报_出院流感病例.qtzdrybq6
  is '其他诊断入院病情6 P811';
comment on column 临时表_数据上报_出院流感病例.qtzdcyqk6
  is '其他诊断出院情况6 P3283';
comment on column 临时表_数据上报_出院流感病例.qtzdbm7
  is '其他诊断编码7 P3284';
comment on column 临时表_数据上报_出院流感病例.qtzdms7
  is '其他诊断疾病描述7 P3285';
comment on column 临时表_数据上报_出院流感病例.qtzdrybq7
  is '其他诊断入院病情7 P812';
comment on column 临时表_数据上报_出院流感病例.qtzdcyqk7
  is '其他诊断出院情况7 P3286';
comment on column 临时表_数据上报_出院流感病例.qtzdbm8
  is '其他诊断编码8 P3287';
comment on column 临时表_数据上报_出院流感病例.qtzdms8
  is '其他诊断疾病描述8 P3288';
comment on column 临时表_数据上报_出院流感病例.qtzdrybq8
  is '其他诊断入院病情8 P813';
comment on column 临时表_数据上报_出院流感病例.qtzdcyqk8
  is '其他诊断出院情况8 P3289';
comment on column 临时表_数据上报_出院流感病例.qtzdbm9
  is '其他诊断编码9 P3271';
comment on column 临时表_数据上报_出院流感病例.qtzdms9
  is '其他诊断疾病描述9 P3272';
comment on column 临时表_数据上报_出院流感病例.qtzdrybq9
  is '其他诊断入院病情9 P814';
comment on column 临时表_数据上报_出院流感病例.qtzdcyqk9
  is '其他诊断出院情况9 P3273';
comment on column 临时表_数据上报_出院流感病例.qtzdbm10
  is '其他诊断编码10 P3274';
comment on column 临时表_数据上报_出院流感病例.qtzdms10
  is '其他诊断疾病描述10 P3275';
comment on column 临时表_数据上报_出院流感病例.qtzdrybq10
  is '其他诊断入院病情10 P815';
comment on column 临时表_数据上报_出院流感病例.qtzdcyqk10
  is '其他诊断出院情况10 P3276';
comment on column 临时表_数据上报_出院流感病例.p689
  is '医院感染总次数';
comment on column 临时表_数据上报_出院流感病例.blzdbm1
  is '病理诊断编码1 P351';
comment on column 临时表_数据上报_出院流感病例.blzdmc1
  is '病理诊断名称1 P352';
comment on column 临时表_数据上报_出院流感病例.blh1
  is '病理号1 P816';
comment on column 临时表_数据上报_出院流感病例.blzdbm2
  is '病理诊断编码2 P353';
comment on column 临时表_数据上报_出院流感病例.blzdmc2
  is '病理诊断名称2 P354';
comment on column 临时表_数据上报_出院流感病例.blh2
  is '病理号2 P817';
comment on column 临时表_数据上报_出院流感病例.blzdbm3
  is '病理诊断编码3 P355';
comment on column 临时表_数据上报_出院流感病例.blzdmc3
  is '病理诊断名称3 P356';
comment on column 临时表_数据上报_出院流感病例.blh3
  is '病理号3 P818';
comment on column 临时表_数据上报_出院流感病例.wbysbm1
  is '损伤、中毒的外部因素编码1 P361';
comment on column 临时表_数据上报_出院流感病例.wbysmc1
  is '损伤、中毒的外部因素名称1 P362';
comment on column 临时表_数据上报_出院流感病例.wbysbm2
  is '损伤、中毒的外部因素编码2 P363';
comment on column 临时表_数据上报_出院流感病例.wbysmc2
  is '损伤、中毒的外部因素名称2 P364';
comment on column 临时表_数据上报_出院流感病例.wbysbm3
  is '损伤、中毒的外部因素编码3 P365';
comment on column 临时表_数据上报_出院流感病例.wbysmc3
  is '损伤、中毒的外部因素名称3 P366';
comment on column 临时表_数据上报_出院流感病例.p371
  is '过敏源';
comment on column 临时表_数据上报_出院流感病例.p372
  is '过敏药物名称';
comment on column 临时表_数据上报_出院流感病例.p38
  is 'HBsAg';
comment on column 临时表_数据上报_出院流感病例.p39
  is 'HCV-Ab';
comment on column 临时表_数据上报_出院流感病例.p40
  is 'HIV-Ab';
comment on column 临时表_数据上报_出院流感病例.p411
  is '门诊与出院诊断符合情况';
comment on column 临时表_数据上报_出院流感病例.p412
  is '入院与出院诊断符合情况';
comment on column 临时表_数据上报_出院流感病例.p413
  is '术前与术后诊断符合情况';
comment on column 临时表_数据上报_出院流感病例.p414
  is '临床与病理诊断符合情况';
comment on column 临时表_数据上报_出院流感病例.p415
  is '放射与病理诊断符合情况';
comment on column 临时表_数据上报_出院流感病例.p421
  is '抢救次数';
comment on column 临时表_数据上报_出院流感病例.p422
  is '抢救成功次数';
comment on column 临时表_数据上报_出院流感病例.p687
  is '最高诊断依据';
comment on column 临时表_数据上报_出院流感病例.p688
  is '分化程度';
comment on column 临时表_数据上报_出院流感病例.p431
  is '科主任';
comment on column 临时表_数据上报_出院流感病例.p432
  is '主(副主)任医师';
comment on column 临时表_数据上报_出院流感病例.p433
  is '主治医师';
comment on column 临时表_数据上报_出院流感病例.p434
  is '住院医师';
comment on column 临时表_数据上报_出院流感病例.p819
  is '责任护士';
comment on column 临时表_数据上报_出院流感病例.p435
  is '进修医师';
comment on column 临时表_数据上报_出院流感病例.p436
  is '研究生实习医师';
comment on column 临时表_数据上报_出院流感病例.p437
  is '实习医师';
comment on column 临时表_数据上报_出院流感病例.p438
  is '编码员';
comment on column 临时表_数据上报_出院流感病例.p44
  is '病案质量';
comment on column 临时表_数据上报_出院流感病例.p45
  is '质控医师';
comment on column 临时表_数据上报_出院流感病例.p46
  is '质控护师';
comment on column 临时表_数据上报_出院流感病例.p47
  is '质控日期';
comment on column 临时表_数据上报_出院流感病例.ssbm1
  is '手术/操作编码1 P490';
comment on column 临时表_数据上报_出院流感病例.ssrq1
  is '手术/操作日期1 P491';
comment on column 临时表_数据上报_出院流感病例.ssjb1
  is '手术级别1 P820';
comment on column 临时表_数据上报_出院流感病例.ssmc1
  is '手术/操作名称1 P492';
comment on column 临时表_数据上报_出院流感病例.ssbw1
  is '手术/操作部位1 P493';
comment on column 临时表_数据上报_出院流感病例.sscxsj1
  is '手术持续时间1 P494';
comment on column 临时表_数据上报_出院流感病例.sz1
  is '术者1 P495';
comment on column 临时表_数据上报_出院流感病例.yz1
  is 'Ⅰ助1 P496';
comment on column 临时表_数据上报_出院流感病例.ez1
  is 'Ⅱ助1 P497';
comment on column 临时表_数据上报_出院流感病例.mzfs1
  is '麻醉方式1 P498';
comment on column 临时表_数据上报_出院流感病例.mzfj1
  is '麻醉分级1 P4981';
comment on column 临时表_数据上报_出院流感病例.qkyhdj1
  is '切口愈合等级1 P499';
comment on column 临时表_数据上报_出院流感病例.mzys1
  is '麻醉医师1 P4910';
comment on column 临时表_数据上报_出院流感病例.ssbm2
  is '手术/操作编码2 P4911';
comment on column 临时表_数据上报_出院流感病例.ssrq2
  is '手术/操作日期2 P4912';
comment on column 临时表_数据上报_出院流感病例.ssjb2
  is '手术级别2 P821';
comment on column 临时表_数据上报_出院流感病例.ssmc2
  is '手术/操作名称2 P4913';
comment on column 临时表_数据上报_出院流感病例.ssbw2
  is '手术/操作部位2 P4914';
comment on column 临时表_数据上报_出院流感病例.sscxsj2
  is '手术持续时间2 P4915';
comment on column 临时表_数据上报_出院流感病例.sz2
  is '术者2 P4916';
comment on column 临时表_数据上报_出院流感病例.yz2
  is 'Ⅰ助2 P4917';
comment on column 临时表_数据上报_出院流感病例.ez2
  is 'Ⅱ助2 P4918';
comment on column 临时表_数据上报_出院流感病例.mzfs2
  is '麻醉方式2 P4919';
comment on column 临时表_数据上报_出院流感病例.mzfj2
  is '麻醉分级2 P4982';
comment on column 临时表_数据上报_出院流感病例.qkyhdj2
  is '切口愈合等级2 P4920';
comment on column 临时表_数据上报_出院流感病例.mzys2
  is '麻醉医师2 P4921';
comment on column 临时表_数据上报_出院流感病例.ssbm3
  is '手术/操作编码3 P4922';
comment on column 临时表_数据上报_出院流感病例.ssrq3
  is '手术/操作日期3 P4923';
comment on column 临时表_数据上报_出院流感病例.ssjb3
  is '手术级别3 P822';
comment on column 临时表_数据上报_出院流感病例.ssmc3
  is '手术/操作名称3 P4924';
comment on column 临时表_数据上报_出院流感病例.ssbw3
  is '手术/操作部位3 P4925';
comment on column 临时表_数据上报_出院流感病例.sscxsj3
  is '手术持续时间3 P4526';
comment on column 临时表_数据上报_出院流感病例.sz3
  is '术者3 P4527';
comment on column 临时表_数据上报_出院流感病例.yz3
  is 'Ⅰ助3 P4528';
comment on column 临时表_数据上报_出院流感病例.ez3
  is 'Ⅱ助3 P4529';
comment on column 临时表_数据上报_出院流感病例.mzfs3
  is '麻醉方式3 P4530';
comment on column 临时表_数据上报_出院流感病例.mzfj3
  is '麻醉分级3 P4983';
comment on column 临时表_数据上报_出院流感病例.qkyhdj3
  is '切口愈合等级3 P4531';
comment on column 临时表_数据上报_出院流感病例.mzys3
  is '麻醉医师3 P4532';
comment on column 临时表_数据上报_出院流感病例.ssbm4
  is '手术/操作编码4 P4533';
comment on column 临时表_数据上报_出院流感病例.ssrq4
  is '手术/操作日期4 P4534';
comment on column 临时表_数据上报_出院流感病例.ssjb4
  is '手术级别4 P823';
comment on column 临时表_数据上报_出院流感病例.ssmc4
  is '手术/操作名称4 P4535';
comment on column 临时表_数据上报_出院流感病例.ssbw4
  is '手术/操作部位4 P4536';
comment on column 临时表_数据上报_出院流感病例.sscxsj4
  is '手术持续时间4 P4537';
comment on column 临时表_数据上报_出院流感病例.sz4
  is '术者4 P4538';
comment on column 临时表_数据上报_出院流感病例.yz4
  is 'Ⅰ助4 P4539';
comment on column 临时表_数据上报_出院流感病例.ez4
  is 'Ⅱ助4 P4540';
comment on column 临时表_数据上报_出院流感病例.mzfs4
  is '麻醉方式4 P4541';
comment on column 临时表_数据上报_出院流感病例.mzfj4
  is '麻醉分级4 P4984';
comment on column 临时表_数据上报_出院流感病例.qkyhdj4
  is '切口愈合等级4 P4542';
comment on column 临时表_数据上报_出院流感病例.mzys4
  is '麻醉医师4 P4543';
comment on column 临时表_数据上报_出院流感病例.ssbm5
  is '手术/操作编码5 P4544';
comment on column 临时表_数据上报_出院流感病例.ssrq5
  is '手术/操作日期5 P4545';
comment on column 临时表_数据上报_出院流感病例.ssjb5
  is '手术级别5 P824';
comment on column 临时表_数据上报_出院流感病例.ssmc5
  is '手术/操作名称5 P4546';
comment on column 临时表_数据上报_出院流感病例.ssbw5
  is '手术/操作部位5 P4547';
comment on column 临时表_数据上报_出院流感病例.sscxsj5
  is '手术持续时间5 P4548';
comment on column 临时表_数据上报_出院流感病例.sz5
  is '术者5 P4549';
comment on column 临时表_数据上报_出院流感病例.yz5
  is 'Ⅰ助5 P4550';
comment on column 临时表_数据上报_出院流感病例.ez5
  is 'Ⅱ助5 P4551';
comment on column 临时表_数据上报_出院流感病例.mzfs5
  is '麻醉方式5 P4552';
comment on column 临时表_数据上报_出院流感病例.mzfj5
  is '麻醉分级5 P4985';
comment on column 临时表_数据上报_出院流感病例.qkyhdj5
  is '切口愈合等级5 P4553';
comment on column 临时表_数据上报_出院流感病例.mzys5
  is '麻醉医师5 P4554';
comment on column 临时表_数据上报_出院流感病例.ssbm6
  is '手术/操作编码6 P45002';
comment on column 临时表_数据上报_出院流感病例.ssrq6
  is '手术/操作日期6 P45003';
comment on column 临时表_数据上报_出院流感病例.ssjb6
  is '手术级别6 P825';
comment on column 临时表_数据上报_出院流感病例.ssmc6
  is '手术/操作名称6 P45004';
comment on column 临时表_数据上报_出院流感病例.ssbw6
  is '手术/操作部位6 P45005';
comment on column 临时表_数据上报_出院流感病例.sscxsj6
  is '手术持续时间6 P45006';
comment on column 临时表_数据上报_出院流感病例.sz6
  is '术者6 P45007';
comment on column 临时表_数据上报_出院流感病例.yz6
  is 'Ⅰ助6 P45008';
comment on column 临时表_数据上报_出院流感病例.ez6
  is 'Ⅱ助6 P45009';
comment on column 临时表_数据上报_出院流感病例.mzfs6
  is '麻醉方式6 P45010';
comment on column 临时表_数据上报_出院流感病例.mzfj6
  is '麻醉分级6 P45011';
comment on column 临时表_数据上报_出院流感病例.qkyhdj6
  is '切口愈合等级6 P45012';
comment on column 临时表_数据上报_出院流感病例.mzys6
  is '麻醉医师6 P45013';
comment on column 临时表_数据上报_出院流感病例.ssbm7
  is '手术/操作编码7 P45014';
comment on column 临时表_数据上报_出院流感病例.ssrq7
  is '手术/操作日期7 P45015';
comment on column 临时表_数据上报_出院流感病例.ssjb7
  is '手术级别7 P826';
comment on column 临时表_数据上报_出院流感病例.ssmc7
  is '手术/操作名称7 P45016';
comment on column 临时表_数据上报_出院流感病例.ssbw7
  is '手术/操作部位7 P45017';
comment on column 临时表_数据上报_出院流感病例.sscxsj7
  is '手术持续时间7 P45018';
comment on column 临时表_数据上报_出院流感病例.sz7
  is '术者7 P45019';
comment on column 临时表_数据上报_出院流感病例.yz7
  is 'Ⅰ助7 P45020';
comment on column 临时表_数据上报_出院流感病例.ez7
  is 'Ⅱ助7 P45021';
comment on column 临时表_数据上报_出院流感病例.mzfs7
  is '麻醉方式7 P45022';
comment on column 临时表_数据上报_出院流感病例.mzfj7
  is '麻醉分级7 P45023';
comment on column 临时表_数据上报_出院流感病例.qkyhdj7
  is '切口愈合等级7 P45024';
comment on column 临时表_数据上报_出院流感病例.mzys7
  is '麻醉医师7 P45025';
comment on column 临时表_数据上报_出院流感病例.ssbm8
  is '手术/操作编码8 P45026';
comment on column 临时表_数据上报_出院流感病例.ssrq8
  is '手术/操作日期8 P45027';
comment on column 临时表_数据上报_出院流感病例.ssjb8
  is '手术级别8 P827';
comment on column 临时表_数据上报_出院流感病例.ssmc8
  is '手术/操作名称8 P45028';
comment on column 临时表_数据上报_出院流感病例.ssbw8
  is '手术/操作部位8 P45029';
comment on column 临时表_数据上报_出院流感病例.sscxsj8
  is '手术持续时间8 P45030';
comment on column 临时表_数据上报_出院流感病例.sz8
  is '术者8 P45031';
comment on column 临时表_数据上报_出院流感病例.yz8
  is 'Ⅰ助8 P45032';
comment on column 临时表_数据上报_出院流感病例.ez8
  is 'Ⅱ助8 P45033';
comment on column 临时表_数据上报_出院流感病例.mzfs8
  is '麻醉方式8 P45034';
comment on column 临时表_数据上报_出院流感病例.mzfj8
  is '麻醉分级8 P45035';
comment on column 临时表_数据上报_出院流感病例.qkyhdj8
  is '切口愈合等级8 P45036';
comment on column 临时表_数据上报_出院流感病例.mzys8
  is '麻醉医师8 P45037';
comment on column 临时表_数据上报_出院流感病例.ssbm9
  is '手术/操作编码9 P45038';
comment on column 临时表_数据上报_出院流感病例.ssrq9
  is '手术/操作日期9 P45039';
comment on column 临时表_数据上报_出院流感病例.ssjb9
  is '手术级别9 P828';
comment on column 临时表_数据上报_出院流感病例.ssmc9
  is '手术/操作名称9 P45040';
comment on column 临时表_数据上报_出院流感病例.ssbw9
  is '手术/操作部位9 P45041';
comment on column 临时表_数据上报_出院流感病例.sscxsj9
  is '手术持续时间9 P45042';
comment on column 临时表_数据上报_出院流感病例.sz9
  is '术者9 P45043';
comment on column 临时表_数据上报_出院流感病例.yz9
  is 'Ⅰ助9 P45044';
comment on column 临时表_数据上报_出院流感病例.ez9
  is 'Ⅱ助9 P45045';
comment on column 临时表_数据上报_出院流感病例.mzfs9
  is '麻醉方式9 P45046';
comment on column 临时表_数据上报_出院流感病例.mzfj9
  is '麻醉分级9 P45047';
comment on column 临时表_数据上报_出院流感病例.qkyhdj9
  is '切口愈合等级9 P45048';
comment on column 临时表_数据上报_出院流感病例.mzys9
  is '麻醉医师9 P45049';
comment on column 临时表_数据上报_出院流感病例.ssbm10
  is '手术/操作编码10 P45050';
comment on column 临时表_数据上报_出院流感病例.ssrq10
  is '手术/操作日期10 P45051';
comment on column 临时表_数据上报_出院流感病例.ssjb10
  is '手术级别10 P829';
comment on column 临时表_数据上报_出院流感病例.ssmc10
  is '手术/操作名称10 P45052';
comment on column 临时表_数据上报_出院流感病例.ssbw10
  is '手术/操作部位10 P45053';
comment on column 临时表_数据上报_出院流感病例.sscxsj10
  is '手术持续时间10 P45054';
comment on column 临时表_数据上报_出院流感病例.sz10
  is '术者10 P45055';
comment on column 临时表_数据上报_出院流感病例.yz10
  is 'Ⅰ助10 P45056';
comment on column 临时表_数据上报_出院流感病例.ez10
  is 'Ⅱ助10 P45057';
comment on column 临时表_数据上报_出院流感病例.mzfs10
  is '麻醉方式10 P45058';
comment on column 临时表_数据上报_出院流感病例.mzfj10
  is '麻醉分级10 P45059';
comment on column 临时表_数据上报_出院流感病例.qkyhdj10
  is '切口愈合等级10 P45060';
comment on column 临时表_数据上报_出院流感病例.mzys10
  is '麻醉医师10 P45061';
comment on column 临时表_数据上报_出院流感病例.p561
  is '特级护理天数';
comment on column 临时表_数据上报_出院流感病例.p562
  is '一级护理天数';
comment on column 临时表_数据上报_出院流感病例.p563
  is '二级护理天数';
comment on column 临时表_数据上报_出院流感病例.p564
  is '三级护理天数';
comment on column 临时表_数据上报_出院流感病例.jhsmc1
  is '重症监护室名称1 P6911';
comment on column 临时表_数据上报_出院流感病例.jrsj1
  is '进入时间1 P6912';
comment on column 临时表_数据上报_出院流感病例.tcsj1
  is '退出时间1 P6913';
comment on column 临时表_数据上报_出院流感病例.jhsmc2
  is '重症监护室名称2 P6914';
comment on column 临时表_数据上报_出院流感病例.jrsj2
  is '进入时间2  P6915';
comment on column 临时表_数据上报_出院流感病例.tcsj2
  is '退出时间2 P6916';
comment on column 临时表_数据上报_出院流感病例.jhsmc3
  is '重症监护室名称3 P6917';
comment on column 临时表_数据上报_出院流感病例.jrsj3
  is '进入时间3 P6918';
comment on column 临时表_数据上报_出院流感病例.tcsj3
  is '退出时间3 P6919';
comment on column 临时表_数据上报_出院流感病例.jhsmc4
  is '重症监护室名称4 P6920';
comment on column 临时表_数据上报_出院流感病例.jrsj4
  is '进入时间4 P6921';
comment on column 临时表_数据上报_出院流感病例.tcsj4
  is '退出时间4 P6922';
comment on column 临时表_数据上报_出院流感病例.jhsmc5
  is '重症监护室名称5 P6923';
comment on column 临时表_数据上报_出院流感病例.jrsj5
  is '进入时间5 P6924';
comment on column 临时表_数据上报_出院流感病例.tcsj5
  is '退出时间5 P6925';
comment on column 临时表_数据上报_出院流感病例.p57
  is '死亡患者尸检';
comment on column 临时表_数据上报_出院流感病例.p58
  is '手术、治疗、检查、诊断为本院第一例';
comment on column 临时表_数据上报_出院流感病例.p581
  is '手术患者类型';
comment on column 临时表_数据上报_出院流感病例.p60
  is '随诊';
comment on column 临时表_数据上报_出院流感病例.p611
  is '随诊周数';
comment on column 临时表_数据上报_出院流感病例.p612
  is '随诊月数';
comment on column 临时表_数据上报_出院流感病例.p613
  is '随诊年数';
comment on column 临时表_数据上报_出院流感病例.p59
  is '示教病例';
comment on column 临时表_数据上报_出院流感病例.p62
  is 'ABO血型';
comment on column 临时表_数据上报_出院流感病例.p63
  is 'Rh血型';
comment on column 临时表_数据上报_出院流感病例.p64
  is '输血反应';
comment on column 临时表_数据上报_出院流感病例.p651
  is '红细胞';
comment on column 临时表_数据上报_出院流感病例.p652
  is '血小板';
comment on column 临时表_数据上报_出院流感病例.p653
  is '血浆';
comment on column 临时表_数据上报_出院流感病例.p654
  is '全血';
comment on column 临时表_数据上报_出院流感病例.p655
  is '自体回收';
comment on column 临时表_数据上报_出院流感病例.p656
  is '其它';
comment on column 临时表_数据上报_出院流感病例.p66
  is '（婴幼儿）年龄';
comment on column 临时表_数据上报_出院流感病例.p681
  is '新生儿出生体重1';
comment on column 临时表_数据上报_出院流感病例.p682
  is '新生儿出生体重2';
comment on column 临时表_数据上报_出院流感病例.p683
  is '新生儿出生体重3';
comment on column 临时表_数据上报_出院流感病例.p684
  is '新生儿出生体重4';
comment on column 临时表_数据上报_出院流感病例.p685
  is '新生儿出生体重5';
comment on column 临时表_数据上报_出院流感病例.p67
  is '新生儿入院体重';
comment on column 临时表_数据上报_出院流感病例.p731
  is '入院前多少小时(昏迷时间)';
comment on column 临时表_数据上报_出院流感病例.p732
  is '入院前多少分钟(昏迷时间)';
comment on column 临时表_数据上报_出院流感病例.p733
  is '入院后多少小时(昏迷时间)';
comment on column 临时表_数据上报_出院流感病例.p734
  is '入院后多少分钟(昏迷时间)';
comment on column 临时表_数据上报_出院流感病例.p72
  is '呼吸机使用时间';
comment on column 临时表_数据上报_出院流感病例.p830
  is '是否有出院31天内再住院计划';
comment on column 临时表_数据上报_出院流感病例.p831
  is '出院31天再住院计划目的';
comment on column 临时表_数据上报_出院流感病例.p741
  is '离院方式';
comment on column 临时表_数据上报_出院流感病例.p742
  is '转入医院名称';
comment on column 临时表_数据上报_出院流感病例.p743
  is '社区服务机构名称';
comment on column 临时表_数据上报_出院流感病例.p782
  is '住院总费用';
comment on column 临时表_数据上报_出院流感病例.p751
  is '住院总费用其中自付金额';
comment on column 临时表_数据上报_出院流感病例.p752
  is '一般医疗服务费';
comment on column 临时表_数据上报_出院流感病例.p754
  is '一般治疗操作费';
comment on column 临时表_数据上报_出院流感病例.p755
  is '护理费';
comment on column 临时表_数据上报_出院流感病例.p756
  is '综合医疗服务类其他费用';
comment on column 临时表_数据上报_出院流感病例.p757
  is '病理诊断费';
comment on column 临时表_数据上报_出院流感病例.p758
  is '实验室诊断费';
comment on column 临时表_数据上报_出院流感病例.p759
  is '影像学诊断费';
comment on column 临时表_数据上报_出院流感病例.p760
  is '临床诊断项目费';
comment on column 临时表_数据上报_出院流感病例.p761
  is '非手术治疗项目费';
comment on column 临时表_数据上报_出院流感病例.p762
  is '临床物理治疗费';
comment on column 临时表_数据上报_出院流感病例.p763
  is '手术治疗费';
comment on column 临时表_数据上报_出院流感病例.p764
  is '麻醉费';
comment on column 临时表_数据上报_出院流感病例.p765
  is '手术费';
comment on column 临时表_数据上报_出院流感病例.p767
  is '康复费';
comment on column 临时表_数据上报_出院流感病例.p768
  is '中医治疗费';
comment on column 临时表_数据上报_出院流感病例.p769
  is '西药费';
comment on column 临时表_数据上报_出院流感病例.p770
  is '抗菌药物费用';
comment on column 临时表_数据上报_出院流感病例.p771
  is '中成药费';
comment on column 临时表_数据上报_出院流感病例.p772
  is '中草药费';
comment on column 临时表_数据上报_出院流感病例.p773
  is '血费';
comment on column 临时表_数据上报_出院流感病例.p774
  is '白蛋白类制品费';
comment on column 临时表_数据上报_出院流感病例.p775
  is '球蛋白类制品费';
comment on column 临时表_数据上报_出院流感病例.p776
  is '凝血因子类制品费';
comment on column 临时表_数据上报_出院流感病例.p777
  is '细胞因子类制品费';
comment on column 临时表_数据上报_出院流感病例.p778
  is '检查用一次性医用材料费';
comment on column 临时表_数据上报_出院流感病例.p779
  is '治疗用一次性医用材料费';
comment on column 临时表_数据上报_出院流感病例.p780
  is '手术用一次性医用材料费';
comment on column 临时表_数据上报_出院流感病例.p781
  is '其他费';

  
  
  
  
-- Create table
create global temporary table 临时表_数据上报_在院流感病例
(
  病历号      VARCHAR2(50),
  p900     VARCHAR2(40),
  p6891    VARCHAR2(80),
  p686     VARCHAR2(50),
  p800     VARCHAR2(50),
  p7501    VARCHAR2(60),
  p7502    VARCHAR2(60),
  p4       VARCHAR2(40),
  p5       VARCHAR2(2),
  p6       DATE,
  p7       NUMBER(3),
  p7503    VARCHAR2(60),
  p13      VARCHAR2(80),
  p7504    VARCHAR2(60),
  p7505    VARCHAR2(60),
  p7506    DATE,
  p7507    VARCHAR2(600),
  p321     VARCHAR2(30),
  p322     VARCHAR2(100),
  qtzdbm1  VARCHAR2(30),
  qtzdms1  VARCHAR2(200),
  qtzdbm2  VARCHAR2(30),
  qtzdms2  VARCHAR2(200),
  qtzdbm3  VARCHAR2(30),
  qtzdms3  VARCHAR2(200),
  qtzdbm4  VARCHAR2(30),
  qtzdms4  VARCHAR2(200),
  qtzdbm5  VARCHAR2(30),
  qtzdms5  VARCHAR2(200),
  qtzdbm6  VARCHAR2(30),
  qtzdms6  VARCHAR2(200),
  qtzdbm7  VARCHAR2(30),
  qtzdms7  VARCHAR2(200),
  qtzdbm8  VARCHAR2(30),
  qtzdms8  VARCHAR2(200),
  qtzdbm9  VARCHAR2(30),
  qtzdms9  VARCHAR2(200),
  qtzdbm10 VARCHAR2(30),
  qtzdms10 VARCHAR2(200),
  jhsmc1   VARCHAR2(4),
  jrsj1    DATE,
  tcsj1    DATE,
  jhsmc2   VARCHAR2(4),
  jrsj2    DATE,
  tcsj2    DATE,
  jhsmc3   VARCHAR2(4),
  jrsj3    DATE,
  tcsj3    DATE,
  jhsmc4   VARCHAR2(4),
  jrsj4    DATE,
  tcsj4    DATE,
  jhsmc5   VARCHAR2(4),
  jrsj5    DATE,
  tcsj5    DATE,
  p1       VARCHAR2(3),
  p7508    NUMBER(10,2),
  p7509    NUMBER(10,2),
  p7510    NUMBER(10,2),
  p7511    NUMBER(10,2),
  p7512    NUMBER(10,2),
  p8508    VARCHAR2(2),
  p8509    DATE
)
on commit delete rows;
-- Add comments to the columns 
comment on column 临时表_数据上报_在院流感病例.p900
  is '医疗机构编码';
comment on column 临时表_数据上报_在院流感病例.p6891
  is '机构名称';
comment on column 临时表_数据上报_在院流感病例.p686
  is '医疗保险手册卡号 ';
comment on column 临时表_数据上报_在院流感病例.p800
  is '健康卡号';
comment on column 临时表_数据上报_在院流感病例.p7501
  is '就诊类型';
comment on column 临时表_数据上报_在院流感病例.p7502
  is '就诊卡号';
comment on column 临时表_数据上报_在院流感病例.p4
  is '姓名';
comment on column 临时表_数据上报_在院流感病例.p5
  is '性别';
comment on column 临时表_数据上报_在院流感病例.p6
  is '出生日期';
comment on column 临时表_数据上报_在院流感病例.p7
  is '年龄';
comment on column 临时表_数据上报_在院流感病例.p7503
  is '证件类型代码';
comment on column 临时表_数据上报_在院流感病例.p13
  is '证件号码';
comment on column 临时表_数据上报_在院流感病例.p7504
  is '就诊科室代码';
comment on column 临时表_数据上报_在院流感病例.p7505
  is '就诊次数';
comment on column 临时表_数据上报_在院流感病例.p7506
  is '就诊日期';
comment on column 临时表_数据上报_在院流感病例.p7507
  is '主诉';
comment on column 临时表_数据上报_在院流感病例.p321
  is '主要疾病诊断代码';
comment on column 临时表_数据上报_在院流感病例.p322
  is '主要疾病诊断描述';
comment on column 临时表_数据上报_在院流感病例.qtzdbm1
  is '其他疾病诊断代码1 P324';
comment on column 临时表_数据上报_在院流感病例.qtzdms1
  is '其他疾病诊断描述1 P325';
comment on column 临时表_数据上报_在院流感病例.qtzdbm2
  is '其他疾病诊断代码2 P327';
comment on column 临时表_数据上报_在院流感病例.qtzdms2
  is '其他疾病诊断描述2 P328';
comment on column 临时表_数据上报_在院流感病例.qtzdbm3
  is '其他疾病诊断代码3 P3291';
comment on column 临时表_数据上报_在院流感病例.qtzdms3
  is '其他疾病诊断描述3 P3292';
comment on column 临时表_数据上报_在院流感病例.qtzdbm4
  is '其他疾病诊断代码4 P3294';
comment on column 临时表_数据上报_在院流感病例.qtzdms4
  is '其他疾病诊断描述4 P3295';
comment on column 临时表_数据上报_在院流感病例.qtzdbm5
  is '其他疾病诊断代码5 P3297';
comment on column 临时表_数据上报_在院流感病例.qtzdms5
  is '其他疾病诊断描述5 P3298';
comment on column 临时表_数据上报_在院流感病例.qtzdbm6
  is '其他疾病诊断代码6 P3281';
comment on column 临时表_数据上报_在院流感病例.qtzdms6
  is '其他疾病诊断描述6 P3282';
comment on column 临时表_数据上报_在院流感病例.qtzdbm7
  is '其他疾病诊断代码7 P3284';
comment on column 临时表_数据上报_在院流感病例.qtzdms7
  is '其他疾病诊断描述7 P3285';
comment on column 临时表_数据上报_在院流感病例.qtzdbm8
  is '其他疾病诊断代码8 P3287';
comment on column 临时表_数据上报_在院流感病例.qtzdms8
  is '其他疾病诊断描述8 P3288';
comment on column 临时表_数据上报_在院流感病例.qtzdbm9
  is '其他疾病诊断代码9 P3271';
comment on column 临时表_数据上报_在院流感病例.qtzdms9
  is '其他疾病诊断描述9  P3272';
comment on column 临时表_数据上报_在院流感病例.qtzdbm10
  is '其他疾病诊断代码10 P3274';
comment on column 临时表_数据上报_在院流感病例.qtzdms10
  is '其他疾病诊断代码10 P3275';
comment on column 临时表_数据上报_在院流感病例.jhsmc1
  is '重症监护室名称1 P6911';
comment on column 临时表_数据上报_在院流感病例.jrsj1
  is '进入时间1 P6912';
comment on column 临时表_数据上报_在院流感病例.tcsj1
  is '退出时间1 P6913';
comment on column 临时表_数据上报_在院流感病例.jhsmc2
  is '重症监护室名称2 P6914';
comment on column 临时表_数据上报_在院流感病例.jrsj2
  is '进入时间2 P6915';
comment on column 临时表_数据上报_在院流感病例.tcsj2
  is '退出时间2 P6916';
comment on column 临时表_数据上报_在院流感病例.jhsmc3
  is '重症监护室名称3 P6917';
comment on column 临时表_数据上报_在院流感病例.jrsj3
  is '进入时间3 P6918';
comment on column 临时表_数据上报_在院流感病例.tcsj3
  is '退出时间3 P6919';
comment on column 临时表_数据上报_在院流感病例.jhsmc4
  is '重症监护室名称4 P6920';
comment on column 临时表_数据上报_在院流感病例.jrsj4
  is '进入时间4 P6921';
comment on column 临时表_数据上报_在院流感病例.tcsj4
  is '退出时间4 P6922';
comment on column 临时表_数据上报_在院流感病例.jhsmc5
  is '重症监护室名称5 P6923';
comment on column 临时表_数据上报_在院流感病例.jrsj5
  is '进入时间5 P6924';
comment on column 临时表_数据上报_在院流感病例.tcsj5
  is '退出时间5 P6925';
comment on column 临时表_数据上报_在院流感病例.p1
  is '医疗费用支付方式代码';
comment on column 临时表_数据上报_在院流感病例.p7508
  is '总费用，仅门诊病例填写';
comment on column 临时表_数据上报_在院流感病例.p7509
  is '挂号费，仅门诊病例填写';
comment on column 临时表_数据上报_在院流感病例.p7510
  is '药品费，仅门诊病例填写';
comment on column 临时表_数据上报_在院流感病例.p7511
  is '检查费，仅门诊病例填写';
comment on column 临时表_数据上报_在院流感病例.p7512
  is '自付费用，仅门诊病例填写';
comment on column 临时表_数据上报_在院流感病例.p8508
  is '是否 死亡';
comment on column 临时表_数据上报_在院流感病例.p8509
  is '死亡时间';

  
  
  
  
  -- Create table
create global temporary table 临时表_数据上报_在院流感费用
(
  病历号  VARCHAR2(50),
  费用总额 NUMBER(10,2),
  费用名称 VARCHAR2(50),
  单项总额 NUMBER(10,2),
  自付总额 NUMBER(10,2)
)
on commit delete rows;






-- Create sequence 
create sequence 病案管理_项目对照流水码
minvalue 1
maxvalue 9999999999
start with 61
increment by 1
cache 20;
