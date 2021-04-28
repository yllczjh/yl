alter table 设备管理_附件领用耗用 add 结账标志 varchar2(20);
alter table 设备管理_附件领用耗用 add 批次 varchar2(50);
alter table 设备管理_附件领用耗用 add 附件记录单号 varchar2(50);

alter table 设备管理_配件出库单明细 add 结账标志 varchar2(20);

alter table 设备管理_入库单 add 结账标志 varchar2(20);

alter table 设备管理_设备成本效益 add 结账标志 varchar2(20);

alter table 设备管理_设备调配 add 结账标志 varchar2(20);

alter table 设备管理_设备付款 add 付款类型 varchar2(50);

alter table 设备管理_设备归还 add 结账标志 varchar2(20);

alter table 设备管理_设备计量 add 结账标志 varchar2(20);

alter table 设备管理_设备维修 add 结账标志 varchar2(20);

alter table 设备管理_设备消减 add 结账标志 varchar2(20);

alter table 设备管理_设备增值 add 结账标志 varchar2(20);

alter table 设备管理_设备折旧变更 add 结账标志 varchar2(20);



alter table 设备管理_主设备附件表 add 记录单号 varchar2(50) not null;

alter table 设备管理_主设备附件表 drop constraint PK_主设备附件表;
DROP INDEX PK_主设备附件表;

alter table 设备管理_主设备附件表
  add constraint PK_主设备附件表 primary key (机构编码, 记录单号,资产编码, 附件编码)
  using index 
  tablespace CLOUDHIS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
  );



update 系统管理_本地数据同步表 set 主键='机构编码,设备编码,批次' where 表名称='设备管理_库存表';




-- Create table  设备管理_退库单
create table 设备管理_退库单
(
  机构编码 VARCHAR2(50) not null,
  退库单号 VARCHAR2(50) not null,
  入库单号 VARCHAR2(50),
  退库日期 DATE,
  录入时间 DATE,
  操作员  VARCHAR2(50),
  备注   VARCHAR2(200),
  结账标志 VARCHAR2(50),
  退库原因 VARCHAR2(50),
  供应商  VARCHAR2(50)
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table 设备管理_退库单
  add constraint PK_设备退库单 primary key (机构编码, 退库单号)
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

  
  
  
  
  
  
  
  
  
  -- Create table  设备管理_退库单明细
create table 设备管理_退库单明细
(
  机构编码     VARCHAR2(50) not null,
  退库单号     VARCHAR2(50),
  设备编码     VARCHAR2(50),
  资产编码     VARCHAR2(50),
  品牌型号     VARCHAR2(50),
  规格       VARCHAR2(50),
  数量       NUMBER(18,3),
  单价       NUMBER(18,3),
  批次       VARCHAR2(50),
  设备附件零件标志 VARCHAR2(50),
  设备名称     VARCHAR2(50)
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
