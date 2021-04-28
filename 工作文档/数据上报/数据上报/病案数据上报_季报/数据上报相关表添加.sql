
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