-- Create table 病案管理_项目信息
CREATE TABLE 病案管理_项目信息(
    机构编码 VARCHAR2(50) NOT NULL,
    项目编码 VARCHAR2(50) NOT NULL,
    项目名称 VARCHAR2(100),
    导出文件类型 VARCHAR2(50),
    存储过程名 VARCHAR2(50),
    拼音码 VARCHAR2(50),
    五笔码 VARCHAR2(50),
    有效状态 VARCHAR2(50),
    删除标志 VARCHAR2(2) DEFAULT '0',
    更新时间 DATE,
    更新人员 VARCHAR2(50),
    CONSTRAINT PK_病案管理_项目信息 PRIMARY KEY (机构编码,项目编码)
);

COMMENT ON TABLE 病案管理_项目信息 IS '上报信息类型表';
COMMENT ON COLUMN 病案管理_项目信息.机构编码 IS '机构编码';
COMMENT ON COLUMN 病案管理_项目信息.项目编码 IS '项目编码';
COMMENT ON COLUMN 病案管理_项目信息.项目名称 IS '项目名称';
COMMENT ON COLUMN 病案管理_项目信息.导出文件类型 IS '导出文件类型';
COMMENT ON COLUMN 病案管理_项目信息.存储过程名 IS '存储过程名';
COMMENT ON COLUMN 病案管理_项目信息.拼音码 IS '拼音码';
COMMENT ON COLUMN 病案管理_项目信息.五笔码 IS '五笔码';
COMMENT ON COLUMN 病案管理_项目信息.有效状态 IS '有效状态';
COMMENT ON COLUMN 病案管理_项目信息.删除标志 IS '删除标志';
COMMENT ON COLUMN 病案管理_项目信息.更新时间 IS '更新时间';
COMMENT ON COLUMN 病案管理_项目信息.更新人员 IS '更新人员';





-- Create table 病案管理_项目字典分类
CREATE TABLE 病案管理_项目字典分类(
    机构编码 VARCHAR2(50) NOT NULL,
    项目编码 VARCHAR2(50) NOT NULL,
    字典分类编码 VARCHAR2(50) NOT NULL,
    字典分类名称 VARCHAR2(100),
    拼音码 VARCHAR2(50),
    五笔码 VARCHAR2(50),
    有效状态 VARCHAR2(50),
    删除标志 VARCHAR2(2) DEFAULT '0',
    更新时间 DATE,
    更新人员 VARCHAR2(50),
    CONSTRAINT PK_病案管理_项目字典分类 PRIMARY KEY (机构编码,项目编码,字典分类编码)
);

COMMENT ON TABLE 病案管理_项目字典分类 IS '病案管理_项目字典分类';
COMMENT ON COLUMN 病案管理_项目字典分类.机构编码 IS '机构编码';
COMMENT ON COLUMN 病案管理_项目字典分类.项目编码 IS '项目编码';
COMMENT ON COLUMN 病案管理_项目字典分类.字典分类编码 IS '字典分类编码';
COMMENT ON COLUMN 病案管理_项目字典分类.字典分类名称 IS '字典分类名称';
COMMENT ON COLUMN 病案管理_项目字典分类.拼音码 IS '拼音码';
COMMENT ON COLUMN 病案管理_项目字典分类.五笔码 IS '五笔码';
COMMENT ON COLUMN 病案管理_项目字典分类.有效状态 IS '有效状态';
COMMENT ON COLUMN 病案管理_项目字典分类.删除标志 IS '删除标志';
COMMENT ON COLUMN 病案管理_项目字典分类.更新时间 IS '更新时间';
COMMENT ON COLUMN 病案管理_项目字典分类.更新人员 IS '更新人员';





-- Create table 病案管理_项目字典明细
CREATE TABLE 病案管理_项目字典明细(
    机构编码 VARCHAR2(50) NOT NULL,
    项目编码 VARCHAR2(50) NOT NULL,
    字典分类编码 VARCHAR2(50) NOT NULL,
    字典明细编码 VARCHAR2(50) NOT NULL,
    字典明细名称 VARCHAR2(100),
    拼音码 VARCHAR2(50),
    五笔码 VARCHAR2(50),
    有效状态 VARCHAR2(50),
    删除标志 VARCHAR2(2) DEFAULT '0',
    更新时间 DATE,
    更新人员 VARCHAR2(50),
    CONSTRAINT PK_病案管理_项目字典明细 PRIMARY KEY (机构编码,项目编码,字典分类编码,字典明细编码)
);

COMMENT ON TABLE 病案管理_项目字典明细 IS '病案管理_项目字典明细';
COMMENT ON COLUMN 病案管理_项目字典明细.机构编码 IS '机构编码';
COMMENT ON COLUMN 病案管理_项目字典明细.项目编码 IS '项目编码';
COMMENT ON COLUMN 病案管理_项目字典明细.字典分类编码 IS '字典分类编码';
COMMENT ON COLUMN 病案管理_项目字典明细.字典明细编码 IS '字典明细编码';
COMMENT ON COLUMN 病案管理_项目字典明细.字典明细名称 IS '字典明细名称';
COMMENT ON COLUMN 病案管理_项目字典明细.拼音码 IS '拼音码';
COMMENT ON COLUMN 病案管理_项目字典明细.五笔码 IS '五笔码';
COMMENT ON COLUMN 病案管理_项目字典明细.有效状态 IS '有效状态';
COMMENT ON COLUMN 病案管理_项目字典明细.删除标志 IS '删除标志';
COMMENT ON COLUMN 病案管理_项目字典明细.更新时间 IS '更新时间';
COMMENT ON COLUMN 病案管理_项目字典明细.更新人员 IS '更新人员';





-- Create table 病案管理_项目字典对应关系
CREATE TABLE 病案管理_项目字典对应关系(
    机构编码 VARCHAR2(50) NOT NULL,
    项目编码 VARCHAR2(50) NOT NULL,
    系统字典分类编码 VARCHAR2(50) NOT NULL,
    系统字典明细编码 VARCHAR2(50) NOT NULL,
    接口字典分类编码 VARCHAR2(50),
    接口字典明细编码 VARCHAR2(50),
    删除标志 VARCHAR2(2) DEFAULT '0',
    更新时间 DATE,
    更新人员 VARCHAR2(50),
    CONSTRAINT PK_病案管理_项目字典对应关系 PRIMARY KEY (机构编码,项目编码,系统字典分类编码,系统字典明细编码)
);

COMMENT ON TABLE 病案管理_项目字典对应关系 IS '病案管理_项目字典对应关系';
COMMENT ON COLUMN 病案管理_项目字典对应关系.机构编码 IS '机构编码';
COMMENT ON COLUMN 病案管理_项目字典对应关系.项目编码 IS '项目编码';
COMMENT ON COLUMN 病案管理_项目字典对应关系.系统字典分类编码 IS '系统字典分类编码';
COMMENT ON COLUMN 病案管理_项目字典对应关系.系统字典明细编码 IS '系统字典明细编码';
COMMENT ON COLUMN 病案管理_项目字典对应关系.接口字典分类编码 IS '接口字典分类编码';
COMMENT ON COLUMN 病案管理_项目字典对应关系.接口字典明细编码 IS '接口字典明细编码';
COMMENT ON COLUMN 病案管理_项目字典对应关系.删除标志 IS '删除标志';
COMMENT ON COLUMN 病案管理_项目字典对应关系.更新时间 IS '更新时间';
COMMENT ON COLUMN 病案管理_项目字典对应关系.更新人员 IS '更新人员';





-- Create table 病案管理_项目字段对照
CREATE TABLE 病案管理_项目字段对照(
    机构编码 VARCHAR2(50) NOT NULL,
    项目编码 VARCHAR2(50) NOT NULL,
    序号 NUMBER NOT NULL,
    项目字段名 VARCHAR2(50),
    系统字段名 VARCHAR2(50),
    字段说明 VARCHAR2(100),
    是否显示 VARCHAR2(50),
    显示名称 VARCHAR2(50),
    显示顺序 NUMBER,
    是否为字典 VARCHAR2(50),
    字典分类 VARCHAR2(50),
    有效状态 VARCHAR2(50),
    删除标志 VARCHAR2(2) DEFAULT '0',
    更新时间 DATE,
    更新人员 VARCHAR2(50),
    确认标志 VARCHAR2(50),
    CONSTRAINT PK_病案管理_项目字段对照 PRIMARY KEY (机构编码,项目编码,序号)
);

COMMENT ON TABLE 病案管理_项目字段对照 IS '病案管理_项目字段对照';
COMMENT ON COLUMN 病案管理_项目字段对照.机构编码 IS '机构编码';
COMMENT ON COLUMN 病案管理_项目字段对照.项目编码 IS '项目编码';
COMMENT ON COLUMN 病案管理_项目字段对照.序号 IS '序号';
COMMENT ON COLUMN 病案管理_项目字段对照.项目字段名 IS '导出数据时显示的字段名';
COMMENT ON COLUMN 病案管理_项目字段对照.系统字段名 IS '本地表中对应的字段名';
COMMENT ON COLUMN 病案管理_项目字段对照.字段说明 IS '字段说明';
COMMENT ON COLUMN 病案管理_项目字段对照.是否显示 IS '是否显示';
COMMENT ON COLUMN 病案管理_项目字段对照.显示名称 IS '显示名称';
COMMENT ON COLUMN 病案管理_项目字段对照.显示顺序 IS '显示顺序';
COMMENT ON COLUMN 病案管理_项目字段对照.是否为字典 IS '是否为字典';
COMMENT ON COLUMN 病案管理_项目字段对照.字典分类 IS '字典分类';
COMMENT ON COLUMN 病案管理_项目字段对照.有效状态 IS '有效状态';
COMMENT ON COLUMN 病案管理_项目字段对照.删除标志 IS '删除标志';
COMMENT ON COLUMN 病案管理_项目字段对照.更新时间 IS '更新时间';
COMMENT ON COLUMN 病案管理_项目字段对照.更新人员 IS '更新人员';
COMMENT ON COLUMN 病案管理_项目字段对照.确认标志 IS '确认后项目字段名与系统字段名不能修改';





-- Create table 病案管理_项目导出记录
CREATE TABLE 病案管理_项目导出记录(
    机构编码 VARCHAR2(50),
    项目编码 VARCHAR2(50),
    搜索条件 VARCHAR2(100),
    导出人员 VARCHAR2(50),
    导出时间 DATE
);

COMMENT ON TABLE 病案管理_项目导出记录 IS '病案管理_项目导出记录';
COMMENT ON COLUMN 病案管理_项目导出记录.机构编码 IS '机构编码';
COMMENT ON COLUMN 病案管理_项目导出记录.项目编码 IS '项目编码';
COMMENT ON COLUMN 病案管理_项目导出记录.搜索条件 IS '搜索条件';
COMMENT ON COLUMN 病案管理_项目导出记录.导出人员 IS '导出人员';
COMMENT ON COLUMN 病案管理_项目导出记录.导出时间 IS '导出时间';






-- Create table 临时表_病案首页新
create global temporary table 临时表_病案首页新
(
  username  VARCHAR2(60),
  ylfkfs    VARCHAR2(100),
  jkkh      VARCHAR2(100),
  zycs      VARCHAR2(100),
  bah       VARCHAR2(100),
  xm        VARCHAR2(100),
  xb        VARCHAR2(100),
  csrq      VARCHAR2(12),
  nl        NUMBER(10),
  gj        VARCHAR2(100),
  bzyzsnl   NUMBER(4),
  xsecstz   NUMBER(12,2),
  xserytz   NUMBER(12,2),
  csd       VARCHAR2(200),
  gg        VARCHAR2(200),
  mz        VARCHAR2(100),
  sfzh      VARCHAR2(100),
  zy        VARCHAR2(100),
  hy        VARCHAR2(100),
  xzz       VARCHAR2(100),
  dh        VARCHAR2(100),
  yb1       VARCHAR2(100),
  hkdz      VARCHAR2(100),
  yb2       VARCHAR2(100),
  gzdwjdz   VARCHAR2(100),
  dwdh      VARCHAR2(100),
  yb3       VARCHAR2(100),
  lxrxm     VARCHAR2(100),
  gx        VARCHAR2(100),
  dz        VARCHAR2(100),
  dh2       VARCHAR2(100),
  rytj      VARCHAR2(100),
  rysj      VARCHAR2(12),
  rysjs     NUMBER(24),
  rykb      VARCHAR2(100),
  rybf      VARCHAR2(100),
  zkkb      VARCHAR2(100),
  cysj      VARCHAR2(12),
  cysjs     NUMBER(24),
  cykb      VARCHAR2(100),
  cybf      VARCHAR2(100),
  sjzyts    VARCHAR2(100),
  mzzd      VARCHAR2(200),
  jbbm      VARCHAR2(100),
  zyzd      VARCHAR2(200),
  jbdm      VARCHAR2(100),
  rybq      VARCHAR2(100),
  qtzd8     VARCHAR2(200),
  jbdm8     VARCHAR2(100),
  rybq8     VARCHAR2(100),
  qtzd1     VARCHAR2(200),
  jbdm1     VARCHAR2(100),
  rybq1     VARCHAR2(100),
  qtzd9     VARCHAR2(200),
  jbdm9     VARCHAR2(100),
  rybq9     VARCHAR2(100),
  qtzd2     VARCHAR2(200),
  jbdm2     VARCHAR2(100),
  rybq2     VARCHAR2(100),
  qtzd10    VARCHAR2(200),
  jbdm10    VARCHAR2(100),
  rybq10    VARCHAR2(100),
  qtzd3     VARCHAR2(200),
  jbdm3     VARCHAR2(100),
  rybq3     VARCHAR2(100),
  qtzd11    VARCHAR2(200),
  jbdm11    VARCHAR2(100),
  rybq11    VARCHAR2(100),
  qtzd4     VARCHAR2(200),
  jbdm4     VARCHAR2(100),
  rybq4     VARCHAR2(100),
  qtzd12    VARCHAR2(200),
  jbdm12    VARCHAR2(100),
  rybq12    VARCHAR2(100),
  qtzd5     VARCHAR2(200),
  jbdm5     VARCHAR2(100),
  rybq5     VARCHAR2(100),
  qtzd13    VARCHAR2(200),
  jbdm13    VARCHAR2(100),
  rybq13    VARCHAR2(100),
  qtzd6     VARCHAR2(200),
  jbdm6     VARCHAR2(100),
  rybq6     VARCHAR2(100),
  qtzd14    VARCHAR2(200),
  jbdm14    VARCHAR2(100),
  rybq14    VARCHAR2(100),
  qtzd7     VARCHAR2(200),
  jbdm7     VARCHAR2(100),
  rybq7     VARCHAR2(100),
  qtzd15    VARCHAR2(200),
  jbdm15    VARCHAR2(100),
  rybq15    VARCHAR2(100),
  wbyy      VARCHAR2(254),
  h23       VARCHAR2(100),
  blzd      VARCHAR2(100),
  jbmm      VARCHAR2(100),
  blh       VARCHAR2(100),
  ywgm      VARCHAR2(254),
  gmyw      VARCHAR2(100),
  swhzsj    VARCHAR2(100),
  xx        VARCHAR2(100),
  rh        VARCHAR2(100),
  kzr       VARCHAR2(100),
  zrys      VARCHAR2(100),
  zzys      VARCHAR2(100),
  zyys      VARCHAR2(100),
  zrhs      VARCHAR2(100),
  jxys      VARCHAR2(100),
  sxys      VARCHAR2(100),
  bmy       VARCHAR2(100),
  bazl      VARCHAR2(100),
  zkys      VARCHAR2(100),
  zkhs      VARCHAR2(100),
  zkrq      VARCHAR2(12),
  ssjczbm1  VARCHAR2(100),
  ssjczrq1  VARCHAR2(12),
  ssjb1     VARCHAR2(100),
  ssjczmc1  VARCHAR2(200),
  sz1       VARCHAR2(100),
  yz1       VARCHAR2(100),
  ez1       VARCHAR2(100),
  qkdj1     VARCHAR2(100),
  qkyhlb1   VARCHAR2(100),
  mzfs1     VARCHAR2(100),
  mzys1     VARCHAR2(100),
  ssjczbm2  VARCHAR2(100),
  ssjczrq2  VARCHAR2(12),
  ssjb2     VARCHAR2(100),
  ssjczmc2  VARCHAR2(200),
  sz2       VARCHAR2(100),
  yz2       VARCHAR2(100),
  ez2       VARCHAR2(100),
  qkdj2     VARCHAR2(100),
  qkyhlb2   VARCHAR2(100),
  mzfs2     VARCHAR2(100),
  mzys2     VARCHAR2(100),
  ssjczbm3  VARCHAR2(100),
  ssjczrq3  VARCHAR2(12),
  ssjb3     VARCHAR2(100),
  ssjczmc3  VARCHAR2(200),
  sz3       VARCHAR2(100),
  yz3       VARCHAR2(100),
  ez3       VARCHAR2(100),
  qkdj3     VARCHAR2(100),
  qkyhlb3   VARCHAR2(100),
  mzfs3     VARCHAR2(100),
  mzys3     VARCHAR2(100),
  ssjczbm4  VARCHAR2(100),
  ssjczrq4  VARCHAR2(12),
  ssjb4     VARCHAR2(100),
  ssjczmc4  VARCHAR2(200),
  sz4       VARCHAR2(100),
  yz4       VARCHAR2(100),
  ez4       VARCHAR2(100),
  qkdj4     VARCHAR2(100),
  qkyhlb4   VARCHAR2(100),
  mzfs4     VARCHAR2(100),
  mzys4     VARCHAR2(100),
  ssjczbm5  VARCHAR2(100),
  ssjczrq5  VARCHAR2(12),
  ssjb5     VARCHAR2(100),
  ssjczmc5  VARCHAR2(200),
  sz5       VARCHAR2(100),
  yz5       VARCHAR2(100),
  ez5       VARCHAR2(100),
  qkdj5     VARCHAR2(100),
  qkyhlb5   VARCHAR2(100),
  mzfs5     VARCHAR2(100),
  mzys5     VARCHAR2(100),
  ssjczbm6  VARCHAR2(100),
  ssjczrq6  VARCHAR2(12),
  ssjb6     VARCHAR2(100),
  ssjczmc6  VARCHAR2(200),
  sz6       VARCHAR2(100),
  yz6       VARCHAR2(100),
  ez6       VARCHAR2(100),
  qkdj6     VARCHAR2(100),
  qkyhlb6   VARCHAR2(100),
  mzfs6     VARCHAR2(100),
  mzys6     VARCHAR2(100),
  ssjczbm7  VARCHAR2(100),
  ssjczrq7  VARCHAR2(12),
  ssjb7     VARCHAR2(100),
  ssjczmc7  VARCHAR2(200),
  sz7       VARCHAR2(100),
  yz7       VARCHAR2(100),
  ez7       VARCHAR2(100),
  qkdj7     VARCHAR2(100),
  qkyhlb7   VARCHAR2(100),
  mzfs7     VARCHAR2(100),
  mzys7     VARCHAR2(100),
  lyfs      VARCHAR2(100),
  yzzy_yljg VARCHAR2(200),
  wsy_yljg  VARCHAR2(200),
  sfzzyjh   VARCHAR2(100),
  md        VARCHAR2(100),
  ryq_t     NUMBER(12),
  ryq_xs    NUMBER(24),
  ryq_f     NUMBER(12),
  ryh_t     NUMBER(12),
  ryh_xs    NUMBER(24),
  ryh_f     NUMBER(12),
  zfy       NUMBER(12,2),
  zfje      NUMBER(12,2),
  ylfuf     NUMBER(12,2),
  zlczf     NUMBER(12,2),
  hlf       NUMBER(12,2),
  qtfy      NUMBER(12,2),
  blzdf     NUMBER(12,2),
  syszdf    NUMBER(12,2),
  yxxzdf    NUMBER(12,2),
  lczdxmf   NUMBER(12,2),
  fsszlxmf  NUMBER(12,2),
  wlzlf     NUMBER(12,2),
  sszlf     NUMBER(12,2),
  maf       NUMBER(12,2),
  ssf       NUMBER(12,2),
  kff       NUMBER(12,2),
  zyzlf     NUMBER(12,2),
  xyf       NUMBER(12,2),
  kjywf     NUMBER(12,2),
  zcyf      NUMBER(12,2),
  zcyf1     NUMBER(12,2),
  xf        NUMBER(12,2),
  bdblzpf   NUMBER(12,2),
  qdblzpf   NUMBER(12,2),
  nxyzlzpf  NUMBER(12,2),
  xbyzlzpf  NUMBER(12,2),
  hcyyclf   NUMBER(12,2),
  yyclf     NUMBER(12,2),
  ycxyyclf  NUMBER(12,2),
  qtf       NUMBER(12,2),
  住院病历号     VARCHAR2(100)
)
on commit preserve rows;
-- Add comments to the columns 
comment on column 临时表_病案首页新.username
  is '机构名称';
comment on column 临时表_病案首页新.ylfkfs
  is '医疗付款方式';
comment on column 临时表_病案首页新.jkkh
  is '健康卡号';
comment on column 临时表_病案首页新.zycs
  is '住院次数';
comment on column 临时表_病案首页新.bah
  is '病案号';
comment on column 临时表_病案首页新.xm
  is '姓名';
comment on column 临时表_病案首页新.xb
  is '性别';
comment on column 临时表_病案首页新.csrq
  is '出生日期';
comment on column 临时表_病案首页新.nl
  is '年龄';
comment on column 临时表_病案首页新.gj
  is '国籍';
comment on column 临时表_病案首页新.bzyzsnl
  is '(年龄不足1周岁的)年龄(月)';
comment on column 临时表_病案首页新.xsecstz
  is '新生儿出生体重(克)';
comment on column 临时表_病案首页新.xserytz
  is '新生儿入院体重(克）';
comment on column 临时表_病案首页新.csd
  is '出生地';
comment on column 临时表_病案首页新.gg
  is '籍贯';
comment on column 临时表_病案首页新.mz
  is '民族';
comment on column 临时表_病案首页新.sfzh
  is '身份证号';
comment on column 临时表_病案首页新.zy
  is '职业';
comment on column 临时表_病案首页新.hy
  is '婚姻';
comment on column 临时表_病案首页新.xzz
  is '现住址';
comment on column 临时表_病案首页新.dh
  is '电话';
comment on column 临时表_病案首页新.yb1
  is '邮编';
comment on column 临时表_病案首页新.hkdz
  is '户口地址';
comment on column 临时表_病案首页新.yb2
  is '邮编';
comment on column 临时表_病案首页新.gzdwjdz
  is '工作单位及地址';
comment on column 临时表_病案首页新.dwdh
  is '单位电话';
comment on column 临时表_病案首页新.yb3
  is '邮编';
comment on column 临时表_病案首页新.lxrxm
  is '联系人姓名';
comment on column 临时表_病案首页新.gx
  is '关系';
comment on column 临时表_病案首页新.dz
  is '地址';
comment on column 临时表_病案首页新.dh2
  is '电话';
comment on column 临时表_病案首页新.rytj
  is '入院途径';
comment on column 临时表_病案首页新.rysj
  is '入院时间';
comment on column 临时表_病案首页新.rysjs
  is '时';
comment on column 临时表_病案首页新.rykb
  is '入院科别';
comment on column 临时表_病案首页新.rybf
  is '入院病房';
comment on column 临时表_病案首页新.zkkb
  is '转科科别';
comment on column 临时表_病案首页新.cysj
  is '出院时间';
comment on column 临时表_病案首页新.cysjs
  is '时';
comment on column 临时表_病案首页新.cykb
  is '出院科别';
comment on column 临时表_病案首页新.cybf
  is '出院病房';
comment on column 临时表_病案首页新.sjzyts
  is '实际住院(天)';
comment on column 临时表_病案首页新.mzzd
  is '门(急)诊诊断';
comment on column 临时表_病案首页新.jbbm
  is '疾病编码';
comment on column 临时表_病案首页新.zyzd
  is '主要诊断';
comment on column 临时表_病案首页新.jbdm
  is '疾病编码';
comment on column 临时表_病案首页新.rybq
  is '入院病情';
comment on column 临时表_病案首页新.qtzd8
  is '其他诊断';
comment on column 临时表_病案首页新.jbdm8
  is '疾病编码';
comment on column 临时表_病案首页新.rybq8
  is '入院病情';
comment on column 临时表_病案首页新.qtzd1
  is '其他诊断';
comment on column 临时表_病案首页新.jbdm1
  is '疾病编码';
comment on column 临时表_病案首页新.rybq1
  is '入院病情';
comment on column 临时表_病案首页新.qtzd9
  is '其他诊断';
comment on column 临时表_病案首页新.jbdm9
  is '疾病编码';
comment on column 临时表_病案首页新.rybq9
  is '入院病情';
comment on column 临时表_病案首页新.qtzd2
  is '其他诊断';
comment on column 临时表_病案首页新.jbdm2
  is '疾病编码';
comment on column 临时表_病案首页新.rybq2
  is '入院病情';
comment on column 临时表_病案首页新.qtzd10
  is '其他诊断';
comment on column 临时表_病案首页新.jbdm10
  is '疾病编码';
comment on column 临时表_病案首页新.rybq10
  is '入院病情';
comment on column 临时表_病案首页新.qtzd3
  is '其他诊断';
comment on column 临时表_病案首页新.jbdm3
  is '疾病编码';
comment on column 临时表_病案首页新.rybq3
  is '入院病情';
comment on column 临时表_病案首页新.qtzd11
  is '其他诊断';
comment on column 临时表_病案首页新.jbdm11
  is '疾病编码';
comment on column 临时表_病案首页新.rybq11
  is '入院病情';
comment on column 临时表_病案首页新.qtzd4
  is '其他诊断';
comment on column 临时表_病案首页新.jbdm4
  is '疾病编码';
comment on column 临时表_病案首页新.rybq4
  is '入院病情';
comment on column 临时表_病案首页新.qtzd12
  is '其他诊断';
comment on column 临时表_病案首页新.jbdm12
  is '疾病编码';
comment on column 临时表_病案首页新.rybq12
  is '入院病情';
comment on column 临时表_病案首页新.qtzd5
  is '其他诊断';
comment on column 临时表_病案首页新.jbdm5
  is '疾病编码';
comment on column 临时表_病案首页新.rybq5
  is '入院病情';
comment on column 临时表_病案首页新.qtzd13
  is '其他诊断';
comment on column 临时表_病案首页新.jbdm13
  is '疾病编码';
comment on column 临时表_病案首页新.rybq13
  is '入院病情';
comment on column 临时表_病案首页新.qtzd6
  is '其他诊断';
comment on column 临时表_病案首页新.jbdm6
  is '疾病编码';
comment on column 临时表_病案首页新.rybq6
  is '入院病情';
comment on column 临时表_病案首页新.qtzd14
  is '其他诊断';
comment on column 临时表_病案首页新.jbdm14
  is '疾病编码';
comment on column 临时表_病案首页新.rybq14
  is '入院病情';
comment on column 临时表_病案首页新.qtzd7
  is '其他诊断';
comment on column 临时表_病案首页新.jbdm7
  is '疾病编码';
comment on column 临时表_病案首页新.rybq7
  is '入院病情';
comment on column 临时表_病案首页新.qtzd15
  is '其他诊断';
comment on column 临时表_病案首页新.jbdm15
  is '疾病编码';
comment on column 临时表_病案首页新.rybq15
  is '入院病情';
comment on column 临时表_病案首页新.wbyy
  is '中毒的外部原因';
comment on column 临时表_病案首页新.h23
  is '疾病编码';
comment on column 临时表_病案首页新.blzd
  is '病理诊断出';
comment on column 临时表_病案首页新.jbmm
  is '疾病编码';
comment on column 临时表_病案首页新.blh
  is '病理号';
comment on column 临时表_病案首页新.ywgm
  is '药物过敏';
comment on column 临时表_病案首页新.gmyw
  is '过敏药物疾病';
comment on column 临时表_病案首页新.swhzsj
  is '死亡患者尸检';
comment on column 临时表_病案首页新.xx
  is '血型';
comment on column 临时表_病案首页新.rh
  is 'Rh';
comment on column 临时表_病案首页新.kzr
  is '科主任';
comment on column 临时表_病案首页新.zrys
  is '主任（副主任）医师';
comment on column 临时表_病案首页新.zzys
  is '主治医师病理号死亡患者尸检';
comment on column 临时表_病案首页新.zyys
  is '住院医师出院情况入院病情';
comment on column 临时表_病案首页新.zrhs
  is '责任护士';
comment on column 临时表_病案首页新.jxys
  is '进修医师住';
comment on column 临时表_病案首页新.sxys
  is '实习医师';
comment on column 临时表_病案首页新.bmy
  is '编码员';
comment on column 临时表_病案首页新.bazl
  is '病案质量';
comment on column 临时表_病案首页新.zkys
  is '质控医师';
comment on column 临时表_病案首页新.zkhs
  is '质控护士';
comment on column 临时表_病案首页新.zkrq
  is '质控日期';
comment on column 临时表_病案首页新.ssjczbm1
  is '手术及操作编码';
comment on column 临时表_病案首页新.ssjczrq1
  is '手术及操作日期';
comment on column 临时表_病案首页新.ssjb1
  is '手术级别';
comment on column 临时表_病案首页新.ssjczmc1
  is '手术及操作名称';
comment on column 临时表_病案首页新.sz1
  is '术者';
comment on column 临时表_病案首页新.yz1
  is 'I助';
comment on column 临时表_病案首页新.ez1
  is 'II助';
comment on column 临时表_病案首页新.qkdj1
  is '切口等级';
comment on column 临时表_病案首页新.qkyhlb1
  is '切口愈合类别';
comment on column 临时表_病案首页新.mzfs1
  is '麻醉方式';
comment on column 临时表_病案首页新.mzys1
  is '麻醉医师';
comment on column 临时表_病案首页新.ssjczbm2
  is '手术及操作编码';
comment on column 临时表_病案首页新.ssjczrq2
  is '手术及操作日期';
comment on column 临时表_病案首页新.ssjb2
  is '手术级别';
comment on column 临时表_病案首页新.ssjczmc2
  is '手术及操作名称';
comment on column 临时表_病案首页新.sz2
  is '术者';
comment on column 临时表_病案首页新.yz2
  is 'I助';
comment on column 临时表_病案首页新.ez2
  is 'II助';
comment on column 临时表_病案首页新.qkdj2
  is '切口等级';
comment on column 临时表_病案首页新.qkyhlb2
  is '切口愈合类别';
comment on column 临时表_病案首页新.mzfs2
  is '麻醉方式';
comment on column 临时表_病案首页新.mzys2
  is '麻醉医师';
comment on column 临时表_病案首页新.ssjczbm3
  is '手术及操作编码';
comment on column 临时表_病案首页新.ssjczrq3
  is '手术及操作日期';
comment on column 临时表_病案首页新.ssjb3
  is '手术级别';
comment on column 临时表_病案首页新.ssjczmc3
  is '手术及操作名称';
comment on column 临时表_病案首页新.sz3
  is '术者';
comment on column 临时表_病案首页新.yz3
  is 'I助';
comment on column 临时表_病案首页新.ez3
  is 'II助';
comment on column 临时表_病案首页新.qkdj3
  is '切口等级';
comment on column 临时表_病案首页新.qkyhlb3
  is '切口愈合类别';
comment on column 临时表_病案首页新.mzfs3
  is '麻醉方式';
comment on column 临时表_病案首页新.mzys3
  is '麻醉医师';
comment on column 临时表_病案首页新.ssjczbm4
  is '手术及操作编码';
comment on column 临时表_病案首页新.ssjczrq4
  is '手术及操作日期';
comment on column 临时表_病案首页新.ssjb4
  is '手术级别';
comment on column 临时表_病案首页新.ssjczmc4
  is '手术及操作名称';
comment on column 临时表_病案首页新.sz4
  is '术者';
comment on column 临时表_病案首页新.yz4
  is 'I助';
comment on column 临时表_病案首页新.ez4
  is 'II助';
comment on column 临时表_病案首页新.qkdj4
  is '切口等级';
comment on column 临时表_病案首页新.qkyhlb4
  is '切口愈合类别';
comment on column 临时表_病案首页新.mzfs4
  is '麻醉方式';
comment on column 临时表_病案首页新.mzys4
  is '麻醉医师';
comment on column 临时表_病案首页新.ssjczbm5
  is '手术及操作编码';
comment on column 临时表_病案首页新.ssjczrq5
  is '手术及操作日期';
comment on column 临时表_病案首页新.ssjb5
  is '手术级别';
comment on column 临时表_病案首页新.ssjczmc5
  is '手术及操作名称';
comment on column 临时表_病案首页新.sz5
  is '术者';
comment on column 临时表_病案首页新.yz5
  is 'I助';
comment on column 临时表_病案首页新.ez5
  is 'II助';
comment on column 临时表_病案首页新.qkdj5
  is '切口等级';
comment on column 临时表_病案首页新.qkyhlb5
  is '切口愈合类别';
comment on column 临时表_病案首页新.mzfs5
  is '麻醉方式';
comment on column 临时表_病案首页新.mzys5
  is '麻醉医师';
comment on column 临时表_病案首页新.ssjczbm6
  is '手术及操作编码';
comment on column 临时表_病案首页新.ssjczrq6
  is '手术及操作日期';
comment on column 临时表_病案首页新.ssjb6
  is '手术级别';
comment on column 临时表_病案首页新.ssjczmc6
  is '手术及操作名称';
comment on column 临时表_病案首页新.sz6
  is '术者';
comment on column 临时表_病案首页新.yz6
  is 'I助';
comment on column 临时表_病案首页新.ez6
  is 'II助';
comment on column 临时表_病案首页新.qkdj6
  is '切口等级';
comment on column 临时表_病案首页新.qkyhlb6
  is '切口愈合类别';
comment on column 临时表_病案首页新.mzfs6
  is '麻醉方式';
comment on column 临时表_病案首页新.mzys6
  is '麻醉医师';
comment on column 临时表_病案首页新.ssjczbm7
  is '手术及操作编码';
comment on column 临时表_病案首页新.ssjczrq7
  is '手术及操作日期';
comment on column 临时表_病案首页新.ssjb7
  is '手术级别';
comment on column 临时表_病案首页新.ssjczmc7
  is '手术及操作名称';
comment on column 临时表_病案首页新.sz7
  is '术者';
comment on column 临时表_病案首页新.yz7
  is 'I助';
comment on column 临时表_病案首页新.ez7
  is 'II助';
comment on column 临时表_病案首页新.qkdj7
  is '切口等级';
comment on column 临时表_病案首页新.qkyhlb7
  is '切口愈合类别';
comment on column 临时表_病案首页新.mzfs7
  is '麻醉方式';
comment on column 临时表_病案首页新.mzys7
  is '麻醉医师';
comment on column 临时表_病案首页新.lyfs
  is '离院方式';
comment on column 临时表_病案首页新.yzzy_yljg
  is '医嘱转院，拟接收医疗机构名称';
comment on column 临时表_病案首页新.wsy_yljg
  is '医嘱转社区卫生服务机构/乡镇卫生院，拟接收医疗机构名称';
comment on column 临时表_病案首页新.sfzzyjh
  is '是否有出院31天内再住院计划手术情况';
comment on column 临时表_病案首页新.md
  is '目的';
comment on column 临时表_病案首页新.ryq_t
  is '颅脑损伤患者昏迷入院前时间天';
comment on column 临时表_病案首页新.ryq_xs
  is '小时';
comment on column 临时表_病案首页新.ryq_f
  is '分钟';
comment on column 临时表_病案首页新.ryh_t
  is '颅脑损伤患者昏迷入院后时间天';
comment on column 临时表_病案首页新.ryh_xs
  is '小时';
comment on column 临时表_病案首页新.ryh_f
  is '分钟';
comment on column 临时表_病案首页新.zfy
  is '住院费用(元)：总费用';
comment on column 临时表_病案首页新.zfje
  is '自付金额';
comment on column 临时表_病案首页新.ylfuf
  is '综合医疗服务类：(1)一般医疗服务费';
comment on column 临时表_病案首页新.zlczf
  is '一般治疗操作费';
comment on column 临时表_病案首页新.hlf
  is '护理费住院费';
comment on column 临时表_病案首页新.qtfy
  is '其他费用';
comment on column 临时表_病案首页新.blzdf
  is '诊断类：(5)病理诊断费';
comment on column 临时表_病案首页新.syszdf
  is '实验室诊断费';
comment on column 临时表_病案首页新.yxxzdf
  is '影像学诊断费';
comment on column 临时表_病案首页新.lczdxmf
  is '临床诊断项目费';
comment on column 临时表_病案首页新.fsszlxmf
  is '治疗类：(9)非手术治疗项目费';
comment on column 临时表_病案首页新.wlzlf
  is '临床物理治疗费';
comment on column 临时表_病案首页新.sszlf
  is '手术治疗费';
comment on column 临时表_病案首页新.maf
  is '麻醉费';
comment on column 临时表_病案首页新.ssf
  is '手术费';
comment on column 临时表_病案首页新.kff
  is '康复类：(11)康复费';
comment on column 临时表_病案首页新.zyzlf
  is '中医类:(12)中医治疗费';
comment on column 临时表_病案首页新.xyf
  is '西药类:(13)西药费';
comment on column 临时表_病案首页新.kjywf
  is '抗菌药物费';
comment on column 临时表_病案首页新.zcyf
  is '中药类:(14)中成药费';
comment on column 临时表_病案首页新.zcyf1
  is '中草药费';
comment on column 临时表_病案首页新.xf
  is '血液和血液制品类:(16)血费';
comment on column 临时表_病案首页新.bdblzpf
  is '白蛋白类制品费';
comment on column 临时表_病案首页新.qdblzpf
  is '球蛋白类制品费';
comment on column 临时表_病案首页新.nxyzlzpf
  is '凝血因子类制品费';
comment on column 临时表_病案首页新.xbyzlzpf
  is '细胞因子类制品费';
comment on column 临时表_病案首页新.hcyyclf
  is '耗材类:(21)检查用一次性医用材料费';
comment on column 临时表_病案首页新.yyclf
  is '23治疗用一次性医用材料费';
comment on column 临时表_病案首页新.ycxyyclf
  is '手术用一次性医用材料费';
comment on column 临时表_病案首页新.qtf
  is '其他类：(24)其他费';
