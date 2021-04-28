
prompt
prompt Creating table 病案管理_导出列表
prompt ========================
prompt
create table 病案管理_导出列表
(
  机构编码 VARCHAR2(50) not null,
  病历号  VARCHAR2(50) not null,
  起始时间 DATE,
  截止时间 DATE,
  导出时间 DATE,
  流水码  VARCHAR2(50),
  项目编码 VARCHAR2(50) not null,
  就诊类别 VARCHAR2(50) not null
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
comment on column 病案管理_导出列表.机构编码
  is '机构编码';
comment on column 病案管理_导出列表.病历号
  is '病历号';
comment on column 病案管理_导出列表.起始时间
  is '导出时搜索条件的起始时间';
comment on column 病案管理_导出列表.截止时间
  is '导出时搜索条件的截止时间';
comment on column 病案管理_导出列表.导出时间
  is '导出时间';
comment on column 病案管理_导出列表.流水码
  is '每批导出数据流水码相同';
comment on column 病案管理_导出列表.项目编码
  is '项目编码';
comment on column 病案管理_导出列表.就诊类别
  is '门诊；在院；住院';
alter table 病案管理_导出列表
  add constraint PK_病案管理_导出列表 primary key (项目编码, 病历号, 就诊类别)
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
prompt Creating table 病案管理_项目导出记录
prompt ==========================
prompt
create table 病案管理_项目导出记录
(
  机构编码 VARCHAR2(50),
  项目编码 VARCHAR2(50),
  搜索条件 VARCHAR2(100),
  导出人员 VARCHAR2(50),
  导出时间 DATE
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
comment on table 病案管理_项目导出记录
  is '病案管理_项目导出记录';
comment on column 病案管理_项目导出记录.机构编码
  is '机构编码';
comment on column 病案管理_项目导出记录.项目编码
  is '项目编码';
comment on column 病案管理_项目导出记录.搜索条件
  is '搜索条件';
comment on column 病案管理_项目导出记录.导出人员
  is '导出人员';
comment on column 病案管理_项目导出记录.导出时间
  is '导出时间';

prompt
prompt Creating table 病案管理_项目接口对照分类
prompt ============================
prompt
create table 病案管理_项目接口对照分类
(
  机构编码 VARCHAR2(50) not null,
  项目编码 VARCHAR2(50) not null,
  流水码  VARCHAR2(50) not null,
  分类编码 VARCHAR2(50) not null,
  分类名称 VARCHAR2(50) not null,
  对照类型 VARCHAR2(50) not null,
  过滤条件 VARCHAR2(100)
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
comment on table 病案管理_项目接口对照分类
  is '病案管理_项目接口对照分类';
comment on column 病案管理_项目接口对照分类.机构编码
  is '机构编码';
comment on column 病案管理_项目接口对照分类.项目编码
  is '项目编码';
comment on column 病案管理_项目接口对照分类.流水码
  is '流水码';
comment on column 病案管理_项目接口对照分类.分类编码
  is '分类编码';
comment on column 病案管理_项目接口对照分类.分类名称
  is '分类名称';
comment on column 病案管理_项目接口对照分类.对照类型
  is '对照类型';
comment on column 病案管理_项目接口对照分类.过滤条件
  is '过滤条件';

prompt
prompt Creating table 病案管理_项目接口对照明细
prompt ============================
prompt
create table 病案管理_项目接口对照明细
(
  流水码      VARCHAR2(50),
  外键id     VARCHAR2(50),
  接口对照信息编码 VARCHAR2(50) not null,
  接口对照信息名称 VARCHAR2(100)
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
comment on table 病案管理_项目接口对照明细
  is '病案管理_项目接口对照明细';
comment on column 病案管理_项目接口对照明细.流水码
  is '流水码';
comment on column 病案管理_项目接口对照明细.外键id
  is '病案管理_项目接口对照信息分类的流水码';
comment on column 病案管理_项目接口对照明细.接口对照信息编码
  is '接口对照信息编码';
comment on column 病案管理_项目接口对照明细.接口对照信息名称
  is '接口对照信息名称';

prompt
prompt Creating table 病案管理_项目系统对照明细
prompt ============================
prompt
create table 病案管理_项目系统对照明细
(
  外键id     VARCHAR2(50) not null,
  系统对照信息编码 VARCHAR2(50) not null,
  系统对照信息名称 VARCHAR2(50)
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
comment on table 病案管理_项目系统对照明细
  is '病案管理_项目系统对照明细';
comment on column 病案管理_项目系统对照明细.外键id
  is '病案管理_项目接口对照信息的流水码';
comment on column 病案管理_项目系统对照明细.系统对照信息编码
  is '系统对照信息编码';
comment on column 病案管理_项目系统对照明细.系统对照信息名称
  is '系统对照信息名称';

prompt
prompt Creating table 病案管理_项目信息
prompt ========================
prompt
create table 病案管理_项目信息
(
  机构编码   VARCHAR2(50) not null,
  项目编码   VARCHAR2(50) not null,
  项目名称   VARCHAR2(100),
  导出文件类型 VARCHAR2(50),
  存储过程名  VARCHAR2(50),
  拼音码    VARCHAR2(50),
  五笔码    VARCHAR2(50),
  有效状态   VARCHAR2(50),
  删除标志   VARCHAR2(2) default '0',
  更新时间   DATE,
  更新人员   VARCHAR2(50),
  上级项目编码 VARCHAR2(50),
  是否回传数据 VARCHAR2(10),
  文件名格式  VARCHAR2(50),
  是否自动导出 VARCHAR2(50),
  导出时间   VARCHAR2(50),
  导出路径   VARCHAR2(1000)
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
comment on table 病案管理_项目信息
  is '上报信息类型表';
comment on column 病案管理_项目信息.机构编码
  is '机构编码';
comment on column 病案管理_项目信息.项目编码
  is '项目编码';
comment on column 病案管理_项目信息.项目名称
  is '项目名称';
comment on column 病案管理_项目信息.导出文件类型
  is '导出文件类型';
comment on column 病案管理_项目信息.存储过程名
  is '存储过程名';
comment on column 病案管理_项目信息.拼音码
  is '拼音码';
comment on column 病案管理_项目信息.五笔码
  is '五笔码';
comment on column 病案管理_项目信息.有效状态
  is '有效状态';
comment on column 病案管理_项目信息.删除标志
  is '删除标志';
comment on column 病案管理_项目信息.更新时间
  is '更新时间';
comment on column 病案管理_项目信息.更新人员
  is '更新人员';
alter table 病案管理_项目信息
  add constraint PK_病案管理_项目信息 primary key (机构编码, 项目编码)
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
prompt Creating table 病案管理_项目自定义属性
prompt ===========================
prompt
create table 病案管理_项目自定义属性
(
  机构编码 VARCHAR2(50) not null,
  项目编码 VARCHAR2(50) not null,
  流水码  VARCHAR2(50) not null,
  属性名  VARCHAR2(50),
  内容   VARCHAR2(255)
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
comment on column 病案管理_项目自定义属性.机构编码
  is '机构编码';
comment on column 病案管理_项目自定义属性.项目编码
  is '项目编码';
comment on column 病案管理_项目自定义属性.流水码
  is '流水码';
comment on column 病案管理_项目自定义属性.属性名
  is '属性名';
comment on column 病案管理_项目自定义属性.内容
  is '内容';
alter table 病案管理_项目自定义属性
  add constraint PK_病案管理_项目自定义属性 primary key (机构编码, 项目编码, 流水码)
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
prompt Creating table 病案管理_项目字典对应关系
prompt ============================
prompt
create table 病案管理_项目字典对应关系
(
  机构编码     VARCHAR2(50) not null,
  项目编码     VARCHAR2(50) not null,
  系统字典分类编码 VARCHAR2(50) not null,
  系统字典明细编码 VARCHAR2(50) not null,
  接口字典分类编码 VARCHAR2(50),
  接口字典明细编码 VARCHAR2(50),
  删除标志     VARCHAR2(2) default '0',
  更新时间     DATE,
  更新人员     VARCHAR2(50)
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
comment on table 病案管理_项目字典对应关系
  is '病案管理_项目字典对应关系';
comment on column 病案管理_项目字典对应关系.机构编码
  is '机构编码';
comment on column 病案管理_项目字典对应关系.项目编码
  is '项目编码';
comment on column 病案管理_项目字典对应关系.系统字典分类编码
  is '系统字典分类编码';
comment on column 病案管理_项目字典对应关系.系统字典明细编码
  is '系统字典明细编码';
comment on column 病案管理_项目字典对应关系.接口字典分类编码
  is '接口字典分类编码';
comment on column 病案管理_项目字典对应关系.接口字典明细编码
  is '接口字典明细编码';
comment on column 病案管理_项目字典对应关系.删除标志
  is '删除标志';
comment on column 病案管理_项目字典对应关系.更新时间
  is '更新时间';
comment on column 病案管理_项目字典对应关系.更新人员
  is '更新人员';
alter table 病案管理_项目字典对应关系
  add constraint PK_病案管理_项目字典对应关系 primary key (机构编码, 项目编码, 系统字典分类编码, 系统字典明细编码)
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
prompt Creating table 病案管理_项目字典分类
prompt ==========================
prompt
create table 病案管理_项目字典分类
(
  机构编码   VARCHAR2(50) not null,
  项目编码   VARCHAR2(50) not null,
  字典分类编码 VARCHAR2(50) not null,
  字典分类名称 VARCHAR2(100),
  拼音码    VARCHAR2(50),
  五笔码    VARCHAR2(50),
  有效状态   VARCHAR2(50),
  删除标志   VARCHAR2(2) default '0',
  更新时间   DATE,
  更新人员   VARCHAR2(50)
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
comment on table 病案管理_项目字典分类
  is '病案管理_项目字典分类';
comment on column 病案管理_项目字典分类.机构编码
  is '机构编码';
comment on column 病案管理_项目字典分类.项目编码
  is '项目编码';
comment on column 病案管理_项目字典分类.字典分类编码
  is '字典分类编码';
comment on column 病案管理_项目字典分类.字典分类名称
  is '字典分类名称';
comment on column 病案管理_项目字典分类.拼音码
  is '拼音码';
comment on column 病案管理_项目字典分类.五笔码
  is '五笔码';
comment on column 病案管理_项目字典分类.有效状态
  is '有效状态';
comment on column 病案管理_项目字典分类.删除标志
  is '删除标志';
comment on column 病案管理_项目字典分类.更新时间
  is '更新时间';
comment on column 病案管理_项目字典分类.更新人员
  is '更新人员';
alter table 病案管理_项目字典分类
  add constraint PK_病案管理_项目字典分类 primary key (机构编码, 项目编码, 字典分类编码)
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
prompt Creating table 病案管理_项目字典明细
prompt ==========================
prompt
create table 病案管理_项目字典明细
(
  机构编码   VARCHAR2(50) not null,
  项目编码   VARCHAR2(50) not null,
  字典分类编码 VARCHAR2(50) not null,
  字典明细编码 VARCHAR2(50) not null,
  字典明细名称 VARCHAR2(100),
  拼音码    VARCHAR2(50),
  五笔码    VARCHAR2(50),
  有效状态   VARCHAR2(50),
  删除标志   VARCHAR2(2) default '0',
  更新时间   DATE,
  更新人员   VARCHAR2(50)
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
comment on table 病案管理_项目字典明细
  is '病案管理_项目字典明细';
comment on column 病案管理_项目字典明细.机构编码
  is '机构编码';
comment on column 病案管理_项目字典明细.项目编码
  is '项目编码';
comment on column 病案管理_项目字典明细.字典分类编码
  is '字典分类编码';
comment on column 病案管理_项目字典明细.字典明细编码
  is '字典明细编码';
comment on column 病案管理_项目字典明细.字典明细名称
  is '字典明细名称';
comment on column 病案管理_项目字典明细.拼音码
  is '拼音码';
comment on column 病案管理_项目字典明细.五笔码
  is '五笔码';
comment on column 病案管理_项目字典明细.有效状态
  is '有效状态';
comment on column 病案管理_项目字典明细.删除标志
  is '删除标志';
comment on column 病案管理_项目字典明细.更新时间
  is '更新时间';
comment on column 病案管理_项目字典明细.更新人员
  is '更新人员';
alter table 病案管理_项目字典明细
  add constraint PK_病案管理_项目字典明细 primary key (机构编码, 项目编码, 字典分类编码, 字典明细编码)
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
prompt Creating table 病案管理_项目字段对照
prompt ==========================
prompt
create table 病案管理_项目字段对照
(
  机构编码    VARCHAR2(50) not null,
  项目编码    VARCHAR2(50) not null,
  序号      NUMBER not null,
  项目字段名   VARCHAR2(50),
  系统字段名   VARCHAR2(50),
  字段说明    VARCHAR2(100),
  是否显示    VARCHAR2(50),
  显示名称    VARCHAR2(50),
  显示顺序    NUMBER,
  是否为字典   VARCHAR2(50),
  字典分类    VARCHAR2(50),
  有效状态    VARCHAR2(50),
  删除标志    VARCHAR2(2) default '0',
  更新时间    DATE,
  更新人员    VARCHAR2(50),
  确认标志    VARCHAR2(50),
  是否默认值   VARCHAR2(50),
  默认值     VARCHAR2(100),
  是否取自病历  VARCHAR2(50),
  元素或文档名  VARCHAR2(50),
  是否编码转名称 VARCHAR2(50),
  转换表     VARCHAR2(50),
  转换字典    VARCHAR2(50)
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
comment on table 病案管理_项目字段对照
  is '病案管理_项目字段对照';
comment on column 病案管理_项目字段对照.机构编码
  is '机构编码';
comment on column 病案管理_项目字段对照.项目编码
  is '项目编码';
comment on column 病案管理_项目字段对照.序号
  is '序号';
comment on column 病案管理_项目字段对照.项目字段名
  is '导出数据时显示的字段名';
comment on column 病案管理_项目字段对照.系统字段名
  is '本地表中对应的字段名';
comment on column 病案管理_项目字段对照.字段说明
  is '字段说明';
comment on column 病案管理_项目字段对照.是否显示
  is '是否显示';
comment on column 病案管理_项目字段对照.显示名称
  is '显示名称';
comment on column 病案管理_项目字段对照.显示顺序
  is '显示顺序';
comment on column 病案管理_项目字段对照.是否为字典
  is '是否为字典';
comment on column 病案管理_项目字段对照.字典分类
  is '字典分类';
comment on column 病案管理_项目字段对照.有效状态
  is '有效状态';
comment on column 病案管理_项目字段对照.删除标志
  is '删除标志';
comment on column 病案管理_项目字段对照.更新时间
  is '更新时间';
comment on column 病案管理_项目字段对照.更新人员
  is '更新人员';
comment on column 病案管理_项目字段对照.确认标志
  is '确认后项目字段名与系统字段名不能修改';
alter table 病案管理_项目字段对照
  add constraint PK_病案管理_项目字段对照 primary key (机构编码, 项目编码, 序号)
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


prompt Done
spool off
set define on
