
insert into ZFGL_CSZL (JKMC, CSBM, CSMC, MRZ, BZ, GXSJ, SCBZ, ZFLX)
values ('其他支付', 1, '接口地址', null, null, to_date('05-12-2018', 'dd-mm-yyyy'), 0, 4);

insert into ZFGL_CSZL (JKMC, CSBM, CSMC, MRZ, BZ, GXSJ, SCBZ, ZFLX)
values ('其他支付', 2, '是否打印凭证', null, null, to_date('05-12-2018', 'dd-mm-yyyy'), 0, 4);

insert into ZFGL_CSZL (JKMC, CSBM, CSMC, MRZ, BZ, GXSJ, SCBZ, ZFLX)
values ('网上支付', 1, '接口地址', null, null, to_date('05-12-2018', 'dd-mm-yyyy'), 0, 100);

insert into ZFGL_CSZL (JKMC, CSBM, CSMC, MRZ, BZ, GXSJ, SCBZ, ZFLX)
values ('网上支付', 2, '是否打印凭证', null, null, to_date('05-12-2018', 'dd-mm-yyyy'), 0, 100);






CREATE TABLE 支付管理_参数总类(
    支付类型 VARCHAR2(50) NOT NULL,
    接口名称 VARCHAR2(50) NOT NULL,
    参数编码 INTEGER NOT NULL,
    参数名称 VARCHAR2(50) NOT NULL,
    默认值 VARCHAR2(255),
    备注 VARCHAR2(100),
    更新时间 DATE,
    删除标志 VARCHAR2(50),
    CONSTRAINT PK_支付管理_参数总类 PRIMARY KEY (支付类型,接口名称,参数编码)
);

COMMENT ON COLUMN 支付管理_参数总类.支付类型 IS '支付类型';
COMMENT ON COLUMN 支付管理_参数总类.接口名称 IS '接口名称';
COMMENT ON COLUMN 支付管理_参数总类.参数编码 IS '参数编码';
COMMENT ON COLUMN 支付管理_参数总类.参数名称 IS '参数名称';
COMMENT ON COLUMN 支付管理_参数总类.默认值 IS '默认值';
COMMENT ON COLUMN 支付管理_参数总类.备注 IS '备注';
COMMENT ON COLUMN 支付管理_参数总类.更新时间 IS '更新时间';
COMMENT ON COLUMN 支付管理_参数总类.删除标志 IS '删除标志';




INSERT INTO 支付管理_参数总类
  (支付类型,
   接口名称,
   参数编码,
   参数名称,
   默认值,
   备注,
   更新时间,
   删除标志)
  SELECT T.ZFLX, T.JKMC, T.CSBM, T.CSMC, T.MRZ, T.BZ, T.GXSJ, T.SCBZ
    FROM ZFGL_CSZL T;
  


  
  
  
  
  
  
  
  
  
  
  
  

insert into ZFGL_CSPZ (JGBM, ZFLX, JKMC, CSBM, CSMC, CSZ, BZ, GXSJ, SCBZ)
values ('522633020000001', 4, '其他支付', 1, '接口地址', null, null, to_date('15-10-2019 16:28:43', 'dd-mm-yyyy hh24:mi:ss'), 0);

insert into ZFGL_CSPZ (JGBM, ZFLX, JKMC, CSBM, CSMC, CSZ, BZ, GXSJ, SCBZ)
values ('522633020000001', 4, '其他支付', 2, '是否打印凭证', null, null, to_date('15-10-2019 16:28:43', 'dd-mm-yyyy hh24:mi:ss'), 0);

insert into ZFGL_CSPZ (JGBM, ZFLX, JKMC, CSBM, CSMC, CSZ, BZ, GXSJ, SCBZ)
values ('522633020000001', 100, '网上支付', 1, '接口地址', null, null, to_date('15-10-2019 16:28:43', 'dd-mm-yyyy hh24:mi:ss'), 0);

insert into ZFGL_CSPZ (JGBM, ZFLX, JKMC, CSBM, CSMC, CSZ, BZ, GXSJ, SCBZ)
values ('522633020000001', 100, '网上支付', 2, '是否打印凭证', null, null, to_date('15-10-2019 16:28:43', 'dd-mm-yyyy hh24:mi:ss'), 0);





CREATE TABLE 支付管理_参数配置(
    机构编码 VARCHAR2(50) NOT NULL,
    支付类型 VARCHAR2(50) NOT NULL,
    接口名称 VARCHAR2(50) NOT NULL,
    参数编码 INTEGER NOT NULL,
    参数名称 VARCHAR2(50) NOT NULL,
    参数值 VARCHAR2(255),
    备注 VARCHAR2(100),
    更新时间 DATE,
    删除标志 VARCHAR2(50),
    CONSTRAINT PK_支付管理_参数配置 PRIMARY KEY (机构编码,支付类型,接口名称,参数编码)
);

COMMENT ON COLUMN 支付管理_参数配置.机构编码 IS '机构编码';
COMMENT ON COLUMN 支付管理_参数配置.支付类型 IS '支付类型';
COMMENT ON COLUMN 支付管理_参数配置.接口名称 IS '接口名称';
COMMENT ON COLUMN 支付管理_参数配置.参数编码 IS '参数编码';
COMMENT ON COLUMN 支付管理_参数配置.参数名称 IS '参数名称';
COMMENT ON COLUMN 支付管理_参数配置.参数值 IS '参数值';
COMMENT ON COLUMN 支付管理_参数配置.备注 IS '备注';
COMMENT ON COLUMN 支付管理_参数配置.更新时间 IS '更新时间';
COMMENT ON COLUMN 支付管理_参数配置.删除标志 IS '删除标志';



INSERT INTO 支付管理_参数配置
  (机构编码,支付类型,
   接口名称,
   参数编码,
   参数名称,
   参数值,
   备注,
   更新时间,
   删除标志)
  SELECT T.JGBM,
         T.ZFLX,
         T.JKMC,
         T.CSBM,
         T.CSMC,
         T.CSZ,
         T.BZ,
         T.GXSJ,
         T.SCBZ
    FROM ZFGL_CSPZ T;






CREATE TABLE 支付管理_支付类型配置(
    机构编码 VARCHAR2(50) NOT NULL,
    支付类型 VARCHAR2(50) NOT NULL,
    接口名称 VARCHAR2(50) NOT NULL,
    启用标志 VARCHAR2(50) NOT NULL,
    启用时间 DATE NOT NULL,
    操作员 VARCHAR2(50) NOT NULL,
    更新时间 DATE,
    删除标志 VARCHAR2(50)
);

COMMENT ON COLUMN 支付管理_支付类型配置.机构编码 IS '机构编码';
COMMENT ON COLUMN 支付管理_支付类型配置.支付类型 IS '支付类型';
COMMENT ON COLUMN 支付管理_支付类型配置.接口名称 IS '接口名称';
COMMENT ON COLUMN 支付管理_支付类型配置.启用标志 IS '0为启用；1启用';
COMMENT ON COLUMN 支付管理_支付类型配置.启用时间 IS '启用时间';
COMMENT ON COLUMN 支付管理_支付类型配置.操作员 IS '操作员';
COMMENT ON COLUMN 支付管理_支付类型配置.更新时间 IS '更新时间';
COMMENT ON COLUMN 支付管理_支付类型配置.删除标志 IS '删除标志';


INSERT INTO 支付管理_支付类型配置
  (机构编码,支付类型,
   接口名称,
   启用标志,
   启用时间,
   操作员,
   更新时间,
   删除标志)
  SELECT T.JGBM,
         T.ZFLX,
         T.JKMC,
         T.qybz,
         T.qysj,
         T.czybm,
         T.GXSJ,
         T.SCBZ
    FROM ZFGL_zflxPZ T;
	
	
	
	
	
update 支付管理_参数总类 set 支付类型='微信' where 支付类型='1';
update 支付管理_参数总类 set 支付类型='支付宝' where 支付类型='2';
update 支付管理_参数总类 set 支付类型='银联' where 支付类型='3';
update 支付管理_参数总类 set 支付类型='其他' where 支付类型='4';
update 支付管理_参数总类 set 支付类型='网上支付' where 支付类型='100';

update 支付管理_参数配置 set 支付类型='微信' where 支付类型='1';
update 支付管理_参数配置 set 支付类型='支付宝' where 支付类型='2';
update 支付管理_参数配置 set 支付类型='银联' where 支付类型='3';
update 支付管理_参数配置 set 支付类型='其他' where 支付类型='4';
update 支付管理_参数配置 set 支付类型='网上支付' where 支付类型='100';

update 支付管理_支付类型配置 set 支付类型='微信' where 支付类型='1';
update 支付管理_支付类型配置 set 支付类型='支付宝' where 支付类型='2';
update 支付管理_支付类型配置 set 支付类型='银联' where 支付类型='3';
update 支付管理_支付类型配置 set 支付类型='其他' where 支付类型='4';
update 支付管理_支付类型配置 set 支付类型='网上支付' where 支付类型='100';

COMMIT;
