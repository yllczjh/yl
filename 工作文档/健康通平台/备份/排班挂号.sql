prompt PL/SQL Developer Export User Objects for user CLOUDHIS@47.104.4.221:9900/YKEY
prompt Created by syyyhl on 2020-06-12
set define off
spool 排班挂号.log

prompt
prompt Creating procedure PRC_门诊管理_生成门诊排班记录
prompt ====================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PRC_门诊管理_生成门诊排班记录(STR_机构编码 IN VARCHAR2,
                                              STR_星期     IN VARCHAR2,
                                              STR_日期     IN VARCHAR2,
                                              INT_返回值   OUT INTEGER,
                                              STR_返回信息 OUT VARCHAR2) IS
  STR_记录ID VARCHAR2(50);

  STR_排班序号 VARCHAR2(4000);

  CURSOR CUR_排班序号 IS
    SELECT A.排班序号
      FROM 门诊管理_门诊一周排班表 A
     WHERE A.机构编码 = STR_机构编码
       AND A.星期 = STR_星期
       AND A.排班序号 NOT IN
           (SELECT B.排班序号
              FROM 门诊管理_当天排班记录 B
             WHERE B.机构编码 = STR_机构编码
               AND B.星期 = STR_星期
               AND B.排班日期 = TO_DATE(STR_日期, 'yyyy-MM-dd'));

BEGIN

  --判断是否存在当天星期的排班
  SELECT COUNT(*)
    INTO INT_返回值
    FROM 门诊管理_门诊一周排班表
   WHERE 机构编码 = STR_机构编码
     AND 星期 = STR_星期;
  IF INT_返回值 = 0 THEN
    INT_返回值   := 0;
    STR_返回信息 := '请在周排班中添加【' || STR_星期 || '】的排班记录！';
    RETURN;
  END IF;

  --获取记录ID
  SELECT SYS_GUID() INTO STR_记录ID FROM DUAL;

  --获取需要生成的排班序号
  FOR CUR_RESULT IN CUR_排班序号 LOOP
    STR_排班序号 := STR_排班序号 || CUR_RESULT.排班序号 || ',';
  END LOOP;
  STR_排班序号 := SUBSTR(STR_排班序号, 0, LENGTH(STR_排班序号) - 1);

  --插入 门诊管理_当天排班记录
  INSERT INTO 门诊管理_当天排班记录
    (机构编码,
     记录ID,
     排班日期,
     排班序号,
     挂号类型名称,
     星期,
     科室编码,
     科室名称,
     医生编码,
     医生姓名,
     --上午限号,
     --上午最大限号,
     --上午已挂号数,
     --下午限号,
     --下午最大限号,
     --下午已挂号数,
     诊室名称,
     诊室位置,
     生成时间,
     生成方式,
     挂号类型编码)
    SELECT A.机构编码,
           STR_记录ID,
           TO_DATE(STR_日期, 'yyyy-MM-dd'),
           A.排班序号,
           A.挂号类型名称,
           A.星期,
           A.科室编码,
           A.科室名称,
           A.医生编码,
           A.医生姓名,
           -- A.上午限号,
           -- A.上午最大限号,
           -- 0,
           --A.下午限号,
           --A.下午最大限号,
           --0,
           A.诊室名称,
           A.诊室位置,
           SYSDATE,
           '手动生成',
           A.挂号类型编码
      FROM 门诊管理_门诊一周排班表 A
     WHERE A.机构编码 = STR_机构编码
       AND A.星期 = STR_星期
       AND A.排班序号 IN
           (SELECT REGEXP_SUBSTR(STR_排班序号, '[^,]+', 1, LEVEL)
              FROM DUAL
            CONNECT BY REGEXP_SUBSTR(STR_排班序号, '[^,]+', 1, LEVEL) IS NOT NULL);

  --插入 门诊管理_日排班时段表
  INSERT INTO 门诊管理_日排班时段表
    (日班次标识,
     机构编码,
     排班序号,
     记录ID,
     限号类型编码,
     时段分组编码,
     时段编码,
     开始时间,
     结束时间,
     限号数,
     顺序号,
     有效状态,
     已挂号数,
     支持共享)
    SELECT SEQ_门诊管理_日排班_排班标识.NEXTVAL,
           A.机构编码,
           A.排班序号,
           STR_记录ID,
           A.限号类型编码,
           A.时段分组编码,
           A.时段编码,
           A.开始时间,
           A.结束时间,
           A.限号数,
           A.顺序号,
           A.有效状态,
           0,
           '否'
      FROM 门诊管理_周排班时段表 A
     WHERE A.机构编码 = STR_机构编码
       AND A.排班序号 IN
           (SELECT REGEXP_SUBSTR(STR_排班序号, '[^,]+', 1, LEVEL)
              FROM DUAL
            CONNECT BY REGEXP_SUBSTR(STR_排班序号, '[^,]+', 1, LEVEL) IS NOT NULL);

  INT_返回值   := 1;
  STR_返回信息 := 'ok';
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    INT_返回值   := 0;
    STR_返回信息 := STR_排班序号 || SQLERRM;
    ROLLBACK;
  
END PRC_门诊管理_生成门诊排班记录;
/

prompt
prompt Creating procedure PRC_门诊管理_自动生成门诊排班
prompt ====================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PRC_门诊管理_自动生成门诊排班 IS

  STR_机构编码         VARCHAR2(20) := '522633020000001';
  STR_是否启动排班     VARCHAR2(10);
  INT_最大预约天数     INTEGER;
  INT_天数             INTEGER;
  STR_星期             VARCHAR2(10);
  STR_排班日期         VARCHAR2(20);
  INT_当前已存在排班数 INTEGER;

  STR_记录ID VARCHAR2(50);

BEGIN

  --门诊是否启用排班管理
  BEGIN
    SELECT 值
      INTO STR_是否启动排班
      FROM 基础项目_机构参数列表
     WHERE 参数编码＝ '910536'
       AND 机构编码 = STR_机构编码;
  EXCEPTION
    WHEN OTHERS THEN
      STR_是否启动排班 := '否';
  END;
  --门诊复诊可预约最大天数
  BEGIN
    SELECT 值
      INTO INT_最大预约天数
      FROM 基础项目_机构参数列表
     WHERE 参数编码＝ '910540'
       AND 机构编码 = STR_机构编码;
  EXCEPTION
    WHEN OTHERS THEN
      INT_最大预约天数 := 15;
  END;

  BEGIN
    IF STR_是否启动排班 = '是' THEN
      INT_天数 := 0;
      LOOP
        EXIT WHEN INT_天数 > INT_最大预约天数;
        INT_当前已存在排班数 := 0;
        SELECT COUNT(1),
               DECODE(TO_CHAR(SYSDATE + INT_天数, 'D'),
                      '1',
                      '星期日',
                      '2',
                      '星期一',
                      '3',
                      '星期二',
                      '4',
                      '星期三',
                      '5',
                      '星期四',
                      '6',
                      '星期五',
                      '7',
                      '星期六'),
               TO_CHAR(SYSDATE + INT_天数, 'yyyy-mm-dd')
          INTO INT_当前已存在排班数, STR_星期, STR_排班日期
          FROM 门诊管理_当天排班记录
         WHERE 机构编码 = STR_机构编码
           AND 排班日期 = TRUNC(SYSDATE + INT_天数);
      
        IF INT_当前已存在排班数 = 0 THEN
          --获取记录ID
          SELECT SYS_GUID() INTO STR_记录ID FROM DUAL;
        
          --插入 门诊管理_当天排班记录
          INSERT INTO 门诊管理_当天排班记录
            (机构编码,
             记录ID,
             排班日期,
             排班序号,
             挂号类型名称,
             星期,
             科室编码,
             科室名称,
             医生编码,
             医生姓名,             
             诊室名称,
             诊室位置,
             生成时间,
             生成方式,
             挂号类型编码)
            SELECT A.机构编码,
                   STR_记录ID,
                   TO_DATE(STR_排班日期, 'yyyy-MM-dd'),
                   A.排班序号,
                   A.挂号类型名称,
                   A.星期,
                   A.科室编码,
                   A.科室名称,
                   A.医生编码,
                   A.医生姓名,                   
                   A.诊室名称,
                   A.诊室位置,
                   SYSDATE,
                   '自动生成',
                   A.挂号类型编码
              FROM 门诊管理_门诊一周排班表 A
             WHERE A.机构编码 = STR_机构编码
               AND A.星期 = STR_星期;
        
          --插入 门诊管理_日排班时段表
          INSERT INTO 门诊管理_日排班时段表
            (日班次标识,
             机构编码,
             排班序号,
             记录ID,
             限号类型编码,
             时段分组编码,
             时段编码,
             开始时间,
             结束时间,
             限号数,
             顺序号,
             有效状态,
             已挂号数,
             支持共享)
            SELECT SEQ_门诊管理_日排班_排班标识.NEXTVAL,
                   A.机构编码,
                   A.排班序号,
                   STR_记录ID,
                   A.限号类型编码,
                   A.时段分组编码,
                   A.时段编码,
                   A.开始时间,
                   A.结束时间,
                   A.限号数,
                   A.顺序号,
                   A.有效状态,
                   0,
                   '否'
              FROM 门诊管理_周排班时段表 A
             WHERE A.机构编码 = STR_机构编码
               AND A.排班序号 IN (SELECT b.排班序号
                                FROM 门诊管理_门诊一周排班表 b
                               WHERE b.机构编码 = STR_机构编码
                                 AND b.星期 = STR_星期);
        
        END IF;
        INT_天数 := INT_天数 + 1;
      END LOOP;
      COMMIT;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
  END;
END PRC_门诊管理_自动生成门诊排班;
/

prompt
prompt Creating procedure PR_门诊管理_挂号登记
prompt ===============================
prompt
create or replace procedure cloudhis.PR_门诊管理_挂号登记(Str_机构编码   in varchar2,
                                         Str_病人信息   in varchar2,
                                         Str_退号标志   in varchar2,
                                         str_原挂号序号 in varchar2,
                                         str_挂号序号   in varchar2,
                                         str_启用排班   in varchar2,
                                         str_排班信息   in varchar2,
                                         Int_返回值     out integer,
                                         Str_返回信息   out varchar2) is

  str_病人ID                 varchar2(50);
  str_门诊病历号             varchar2(50);
  str_卡号                   varchar2(50);
  str_姓名                   varchar2(50);
  str_性别                   varchar2(50);
  dat_出生日期               date;
  str_年龄                   varchar2(50);
  str_家庭地址               varchar2(300);
  str_工作单位               varchar2(300);
  str_手机号码               varchar2(50);
  str_固定电话               varchar2(50);
  str_邮政编码               varchar2(50);
  str_名族ID                 varchar2(50);
  str_拼音码                 varchar2(50);
  str_五笔码                 varchar2(50);
  str_健康档案编码           varchar2(50);
  str_身份证号               varchar2(50);
  str_婚姻状况               varchar2(50);
  str_挂号科室编码           varchar2(50);
  str_挂号医生编码           varchar2(50);
  str_操作员编码             varchar2(50);
  str_挂号单号               varchar2(50);
  str_业务类型               varchar2(50);
  str_就诊状态               varchar2(50);
  str_挂号科室位置           varchar2(300);
  str_挂号类型编码           varchar2(50);
  str_归类编码               varchar2(50);
  num_挂号费                 number(18, 3);
  num_工本费                 number(18, 3);
  num_诊查费                 number(18, 3);
  num_挂号勾选病历本加收金额 number(18, 3);
  str_是否急诊               varchar2(50);
  str_病人类型编码           varchar2(50);
  str_病人类型名称           varchar2(50);
  str_付款方式               varchar2(50);
  str_操作员姓名             varchar2(50);
  str_居民编码               varchar2(50);
  str_挂号来源               varchar2(50);
  num_挂号补偿金额           number(18, 3);
  num_挂号实收金额           number(18, 3);
  str_补偿方式               varchar(50);
  str_类别编码               varchar(50);

  str_医嘱号 varchar(50);

  str_门诊病历号产生方式 varchar2(50);

  dat_时间 date;
  --str_挂号序号     varchar2(50);
  num_总金额       number(18, 3);
  num_卡支付       number(18, 3);
  num_卡支付余额   number(18, 3);
  str_函数返回信息 varchar2(100);
  int_病人信息行数 integer;

  str_日排班标识 varchar(50);
  str_排班记录ID varchar(50);
  --str_排班时段编码     varchar(50);
  str_排班开始时间 varchar(50);
  str_排班结束时间 varchar(50);
  str_排班已挂号数 varchar(50);

  --str_排班科室编码     varchar(50);
  --str_排班医生编码     varchar(50);
  --str_排班挂号类型编码 varchar(50);
  --str_排班上午挂号数     varchar(50);
  --str_排班下午挂号数     varchar(50);
  str_排班上下午最大序号 varchar(50);
  str_排班上下午标志     varchar(50);

  cursor cur_挂号类别联动信息 Is
    select b.项目编码,
           b.项目名称,
           b.数量,
           c.门诊价,
           c.农合类别,
           c.医保类别,
           c.城居类别,
           c.打折比例,
           c.归类编码,
           c.国标码
      from 基础项目_挂号类别     a,
           基础项目_挂号类别联动 b,
           基础项目_诊疗字典     c
     where a.机构编码 = str_机构编码
       and b.机构编码 = str_机构编码
       and c.机构编码 = str_机构编码
       and a.类型编码 = b.类型编码
       and b.项目编码 = c.项目编码
       and a.有效状态 = '有效'
       and b.有效状态 = '有效'
       and a.删除标志 = '0'
       and b.删除标志 = '0'
       and a.类型编码 = str_类别编码;

begin

  if sysdate >= to_date('20200630120000', 'yyyymmddhh24miss') then
    Int_返回值   := 0;
    Str_返回信息 := '  系统已过使用期限,请联系开发商！';
    GOTO 退出;
  end if;

  begin
    select 值
      into str_门诊病历号产生方式
      from 基础项目_机构参数列表
     where 机构编码 = str_机构编码
       and 参数编码 = '178';
  exception
    when others then
      str_门诊病历号产生方式 := '2';
  end;

  str_病人ID := FU_通用_截取字符串值(Str_病人信息, '^', 1);

  str_门诊病历号 := FU_通用_截取字符串值(Str_病人信息, '^', 2);

  str_卡号 := FU_通用_截取字符串值(Str_病人信息, '^', 3);

  str_姓名 := FU_通用_截取字符串值(Str_病人信息, '^', 4);

  str_性别 := FU_通用_截取字符串值(Str_病人信息, '^', 5);

  select to_date(FU_通用_截取字符串值(Str_病人信息, '^', 6),
                 'yyyy-mm-dd hh24:mi:ss')
    into dat_出生日期
    from dual;

  str_年龄 := FU_通用_截取字符串值(Str_病人信息, '^', 7);

  str_家庭地址 := FU_通用_截取字符串值(Str_病人信息, '^', 8);

  str_工作单位 := FU_通用_截取字符串值(Str_病人信息, '^', 9);

  str_手机号码 := FU_通用_截取字符串值(Str_病人信息, '^', 10);

  str_固定电话 := FU_通用_截取字符串值(Str_病人信息, '^', 11);

  str_邮政编码 := FU_通用_截取字符串值(Str_病人信息, '^', 12);

  str_名族ID := FU_通用_截取字符串值(Str_病人信息, '^', 13);

  str_拼音码 := FU_通用_截取字符串值(Str_病人信息, '^', 14);

  str_五笔码 := FU_通用_截取字符串值(Str_病人信息, '^', 15);

  str_健康档案编码 := FU_通用_截取字符串值(Str_病人信息, '^', 16);

  str_身份证号 := FU_通用_截取字符串值(Str_病人信息, '^', 17);

  str_婚姻状况 := FU_通用_截取字符串值(Str_病人信息, '^', 18);

  str_挂号科室编码 := FU_通用_截取字符串值(Str_病人信息, '^', 19);

  str_挂号医生编码 := FU_通用_截取字符串值(Str_病人信息, '^', 20);

  str_操作员编码 := FU_通用_截取字符串值(Str_病人信息, '^', 21);

  str_挂号单号 := FU_通用_截取字符串值(Str_病人信息, '^', 22);

  str_业务类型 := FU_通用_截取字符串值(Str_病人信息, '^', 23);

  str_就诊状态 := FU_通用_截取字符串值(Str_病人信息, '^', 24);

  str_挂号科室位置 := FU_通用_截取字符串值(Str_病人信息, '^', 25);

  str_挂号类型编码 := FU_通用_截取字符串值(Str_病人信息, '^', 26);

  str_归类编码 := FU_通用_截取字符串值(Str_病人信息, '^', 27);

  select to_number(nvl(FU_通用_截取字符串值(Str_病人信息, '^', 28), 0))
    into num_挂号费
    from dual;

  select to_number(nvl(FU_通用_截取字符串值(Str_病人信息, '^', 29), 0))
    into num_工本费
    from dual;

  select to_number(nvl(FU_通用_截取字符串值(Str_病人信息, '^', 30), 0))
    into num_诊查费
    from dual;

  select to_number(nvl(FU_通用_截取字符串值(Str_病人信息, '^', 31), 0))
    into num_挂号勾选病历本加收金额
    from dual;

  str_是否急诊 := FU_通用_截取字符串值(Str_病人信息, '^', 32);

  str_病人类型编码 := FU_通用_截取字符串值(Str_病人信息, '^', 33);

  str_付款方式 := FU_通用_截取字符串值(Str_病人信息, '^', 34);

  str_操作员姓名 := FU_通用_截取字符串值(Str_病人信息, '^', 35);

  str_居民编码 := FU_通用_截取字符串值(Str_病人信息, '^', 36);

  str_挂号来源 := FU_通用_截取字符串值(Str_病人信息, '^', 37);

  select to_number(nvl(FU_通用_截取字符串值(Str_病人信息, '^', 38), 0))
    into num_挂号补偿金额
    from dual;

  select to_number(nvl(FU_通用_截取字符串值(Str_病人信息, '^', 39), 0))
    into num_挂号实收金额
    from dual;

  select to_number(nvl(FU_通用_截取字符串值(Str_病人信息, '^', 41), 0))
    into num_卡支付
    from dual;

  select to_number(nvl(FU_通用_截取字符串值(Str_病人信息, '^', 42), 0))
    into num_卡支付余额
    from dual;

  str_类别编码 := FU_通用_截取字符串值(Str_病人信息, '^', 40);

  dat_时间 := sysdate;

  num_总金额 := num_挂号费 + num_工本费 + num_诊查费 + num_挂号勾选病历本加收金额;

  begin
    select 病人ID
      into int_病人信息行数
      from 基础项目_病人信息
     where 机构编码 = Str_机构编码
       and 病人ID = str_病人ID;
  exception
    when others then
      int_病人信息行数 := 0;
  end;

  begin
    select 名称
      into str_病人类型名称
      from 基础项目_字典明细
     where 编码 = str_病人类型编码
       and 分类编码 = 'GB_009000'
       and 有效状态 = '有效';
  exception
    when others then
      str_病人类型名称 := '现金';
  end;

  begin
    if str_启用排班 = '是' then
      -- str_排班科室编码 := FU_通用_截取字符串值(str_排班信息, '^', 1);
    
      -- str_排班医生编码 := FU_通用_截取字符串值(str_排班信息, '^', 2);
    
      str_日排班标识 := FU_通用_截取字符串值(str_排班信息, '^', 1);
    
      str_排班记录ID := FU_通用_截取字符串值(str_排班信息, '^', 2);
    
      --str_排班时段编码 := FU_通用_截取字符串值(str_排班信息, '^', 3);
    
      str_排班开始时间 := FU_通用_截取字符串值(str_排班信息, '^', 3);
    
      str_排班结束时间 := FU_通用_截取字符串值(str_排班信息, '^', 4);
    
      str_排班已挂号数 := FU_通用_截取字符串值(str_排班信息, '^', 5);
    
      /*str_排班上午挂号数 := FU_通用_截取字符串值(str_排班信息, '^', 5);
      
      str_排班下午挂号数 := FU_通用_截取字符串值(str_排班信息, '^', 6);
      
      str_排班上下午最大序号 := FU_通用_截取字符串值(str_排班信息, '^', 7);
      
      str_排班上下午标志 := FU_通用_截取字符串值(str_排班信息, '^', 8);*/
    else
      --str_排班科室编码     := '';
      --str_排班医生编码     := '';
      str_日排班标识 := '';
      str_排班记录ID := '';
      --str_排班时段编码     := '';
      str_排班开始时间 := '';
      str_排班结束时间 := '';
      str_排班已挂号数 := '';
      /*  str_排班上午挂号数     := '';
      str_排班下午挂号数     := '';
      str_排班上下午最大序号 := '';
      str_排班上下午标志     := '';*/
    end if;
  end;

  begin
  
    if dat_出生日期 <= to_date('1900-01-01', 'yyyy-MM-dd') then
      Str_返回信息 := '患者出生日期错误,非法出生日期,当前出生日期值为[' ||
                  to_char(dat_出生日期, 'yyyy-MM-dd') || ']';
      GOTO 退出;
    end if;
  
    if int_病人信息行数 = 0 then
    
      Pr_获取_系统唯一号(prm_唯一号编码 => '30',
                  prm_机构编码   => str_机构编码,
                  prm_事物类型   => '1',
                  prm_返回唯一号 => str_病人ID,
                  prm_执行结果   => int_返回值,
                  prm_错误信息   => str_返回信息);
    
      if Int_返回值 <> 0 then
        Int_返回值 := 0;
        return;
      end if;
    
      insert into 基础项目_病人信息
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
         录入人编码)
      values
        (str_机构编码,
         str_病人ID,
         str_居民编码,
         str_卡号,
         str_姓名,
         str_性别,
         dat_出生日期,
         FU_得到_年龄(dat_出生日期),
         str_家庭地址,
         str_工作单位,
         str_手机号码,
         str_固定电话,
         str_邮政编码,
         str_名族ID,
         dat_时间,
         str_拼音码,
         str_五笔码,
         str_健康档案编码,
         str_身份证号,
         str_婚姻状况,
         str_操作员编码);
    else
    
      update 基础项目_病人信息
         set 工作单位 = str_工作单位,
             手机号码 = str_手机号码,
             固定电话 = str_固定电话
       where 机构编码 = str_机构编码
         and 病人ID = str_病人ID;
    
    end if;
  
    --产生病历号
    pr_公用_取得业务病历号(str_机构编码   => str_机构编码,
                  str_病历号类型 => '门诊病历号',
                  str_返回病历号 => str_门诊病历号,
                  int_返回值     => Int_返回值,
                  str_返回信息   => str_返回信息);
  
    if Int_返回值 <> 1 then
      Str_返回信息 := '产生门诊病历号失败,原因:' + str_返回信息;
      GOTO 退出;
    end if;
  
    /*    pr_获取_系统唯一号(prm_唯一号编码 => '26',
                prm_机构编码   => str_机构编码,
                prm_事物类型   => '1',
                prm_返回唯一号 => str_挂号序号,
                prm_执行结果   => Int_返回值,
                prm_错误信息   => str_返回信息);
    
    if Int_返回值 <> 0 then
      Str_返回信息 := '产生挂号序号失败!';
      GOTO 退出;
    end if;*/
  
    --str_挂号序号 := SEQ_门诊管理_挂号登记_挂号序号.NEXTVAL;
  
    Str_返回信息 := '插入[门诊管理_挂号登记]表记录失败!';
    if str_启用排班 = '否' then
      insert into 门诊管理_挂号登记
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
         原挂号序号,
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
      values
        (Str_机构编码,
         str_病人ID,
         str_门诊病历号,
         str_挂号序号,
         str_挂号单号,
         str_挂号科室编码,
         str_挂号科室位置,
         str_挂号医生编码,
         str_挂号类型编码,
         str_操作员编码,
         dat_时间,
         str_退号标志,
         str_归类编码,
         str_原挂号序号,
         num_挂号费,
         num_工本费,
         num_诊查费,
         num_挂号勾选病历本加收金额,
         num_总金额,
         str_是否急诊,
         0,
         str_就诊状态,
         str_病人类型编码,
         str_挂号来源,
         str_挂号科室编码,
         str_挂号医生编码,
         num_挂号补偿金额,
         num_挂号实收金额,
         str_类别编码,
         num_卡支付);
    else
      if str_退号标志 = '否' then
        insert into 门诊管理_挂号登记
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
           原挂号序号,
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
           排班ID,
           日班次标识,
           预约开始时间,
           预约结束时间,
           上下午标志,
           上下午序号)
        values
          (Str_机构编码,
           str_病人ID,
           str_门诊病历号,
           str_挂号序号,
           str_挂号单号,
           str_挂号科室编码,
           str_挂号科室位置,
           str_挂号医生编码,
           str_挂号类型编码,
           str_操作员编码,
           dat_时间,
           str_退号标志,
           str_归类编码,
           str_原挂号序号,
           num_挂号费,
           num_工本费,
           num_诊查费,
           num_挂号勾选病历本加收金额,
           num_总金额,
           str_是否急诊,
           0,
           str_就诊状态,
           str_病人类型编码,
           str_挂号来源,
           str_挂号科室编码,
           str_挂号医生编码,
           num_挂号补偿金额,
           num_挂号实收金额,
           str_类别编码,
           num_卡支付,
           str_排班记录ID,
           str_日排班标识,
           to_date(str_排班开始时间, 'yyyy-MM-dd hh24:mi:ss'),
           to_date(str_排班结束时间, 'yyyy-MM-dd hh24:mi:ss'),
           str_排班上下午标志,
           to_number(str_排班上下午最大序号) + 1);
      
        /*if str_排班医生编码 = '' or str_排班医生编码 is null then
          Str_返回信息 := '插入[门诊管理_当天排班记录]科室排班表记录失败!';
          update 门诊管理_当天排班记录
             set 上午已挂号数 = to_number(str_排班上午挂号数),
                 下午已挂号数 = to_number(str_排班下午挂号数)
           where 机构编码 = Str_机构编码
             and 科室编码 = str_排班科室编码
             and 挂号类型编码 = str_排班挂号类型编码
             and 记录ID = str_排班记录ID
             and 医生编码 is null;
        
        else
          Str_返回信息 := '插入[门诊管理_当天排班记录]医生排班表记录失败!';
          update 门诊管理_当天排班记录
             set 上午已挂号数 = to_number(str_排班上午挂号数),
                 下午已挂号数 = to_number(str_排班下午挂号数)
           where 机构编码 = Str_机构编码
             and 科室编码 = str_排班科室编码
             and 挂号类型编码 = str_排班挂号类型编码
             and 记录ID = str_排班记录ID
             and 医生编码 = str_排班医生编码;
        
        end if;*/
      
        Str_返回信息 := '插入[门诊管理_当天排班记录]科室排班表记录失败!';
        update 门诊管理_日排班时段表
           set 已挂号数 = to_number(str_排班已挂号数)
         where 机构编码 = Str_机构编码
           and 日班次标识 = str_日排班标识;
      
      else
        --排班退号
        insert into 门诊管理_挂号登记
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
           原挂号序号,
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
           排班ID,
           日班次标识,
           预约开始时间,
           预约结束时间,
           上下午标志,
           上下午序号)
        values
          (Str_机构编码,
           str_病人ID,
           str_门诊病历号,
           str_挂号序号,
           str_挂号单号,
           str_挂号科室编码,
           str_挂号科室位置,
           str_挂号医生编码,
           str_挂号类型编码,
           str_操作员编码,
           dat_时间,
           str_退号标志,
           str_归类编码,
           str_原挂号序号,
           num_挂号费,
           num_工本费,
           num_诊查费,
           num_挂号勾选病历本加收金额,
           num_总金额,
           str_是否急诊,
           0,
           str_就诊状态,
           str_病人类型编码,
           str_挂号来源,
           str_挂号科室编码,
           str_挂号医生编码,
           num_挂号补偿金额,
           num_挂号实收金额,
           str_类别编码,
           num_卡支付,
           str_排班记录ID,
           str_日排班标识,
           to_date(str_排班开始时间, 'yyyy-MM-dd hh24:mi:ss'),
           to_date(str_排班结束时间, 'yyyy-MM-dd hh24:mi:ss'),
           str_排班上下午标志,
           to_number(str_排班上下午最大序号));
      
        Str_返回信息 := '插入[门诊管理_当天排班记录]科室排班表记录失败!';
        update 门诊管理_日排班时段表
           set 已挂号数 = to_number(已挂号数)-1
         where 机构编码 = Str_机构编码
           and 日班次标识 = str_日排班标识;
      end if;
    end if;
  
    Str_返回信息 := '插入[财务管理_收支款]表记录失败!';
    insert into 财务管理_收支款
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
    values
      (Str_机构编码,
       str_挂号单号,
       num_挂号实收金额,
       str_付款方式,
       str_业务类型,
       str_操作员编码,
       str_操作员姓名,
       dat_时间,
       str_挂号序号,
       str_挂号序号,
       '挂号',
       str_病人类型编码,
       str_病人类型名称);
  
    --向收支款表中写入补偿金额
    if num_挂号补偿金额 <> 0 then
    
      if str_病人类型编码 = '2' then
        str_补偿方式 := '医保补偿';
      end if;
    
      if str_病人类型编码 = '3' then
        str_补偿方式 := '农合补偿';
      end if;
    
      if str_病人类型编码 = '4' then
        str_补偿方式 := '城居补偿';
      end if;
    
      if str_病人类型编码 = '5' then
        str_补偿方式 := '公费补偿';
      end if;
    
      insert into 财务管理_收支款
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
      values
        (str_机构编码,
         str_挂号单号,
         num_挂号补偿金额,
         str_补偿方式,
         '挂号',
         str_操作员编码,
         str_操作员姓名,
         dat_时间,
         str_挂号序号,
         str_挂号序号,
         '挂号',
         str_病人类型编码,
         str_病人类型名称);
    
    end if;
  
    --向收支款表中写入卡支付金额 and 向电子帐户写余额
    if num_卡支付 <> 0 then
      --收支款写支付金额
      insert into 财务管理_收支款
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
      values
        (Str_机构编码,
         str_挂号单号,
         num_卡支付,
         '卡支付',
         str_业务类型,
         str_操作员编码,
         str_操作员姓名,
         dat_时间,
         str_挂号序号,
         str_挂号序号,
         '挂号',
         str_病人类型编码,
         str_病人类型名称);
    
      --电子帐户写余额
      PR_一卡通_更新帐户余额(str_机构编码     => str_机构编码,
                    str_病人ID       => str_病人ID,
                    num_卡余额       => num_卡支付余额,
                    num_本次消费金额 => -num_卡支付,
                    str_业务类型     => '门诊挂号',
                    str_业务单据号   => str_挂号单号,
                    str_操作员编码   => str_操作员编码,
                    dat_消费时间     => dat_时间,
                    str_返回信息     => str_函数返回信息);
    
      if str_函数返回信息 <> '1' then
        Str_返回信息 := str_函数返回信息;
        goto 退出;
      end if;
    
    end if;
  
    if str_退号标志 = '是' then
    
      Str_返回信息 := '更新[门诊管理_挂号登记]表退号标志失败!';
      update 门诊管理_挂号登记
         set 退号标志 = str_退号标志, 原挂号序号 = str_原挂号序号
       where 挂号序号 = str_原挂号序号
         and 机构编码 = Str_机构编码;
    
      if str_启用排班 = '是' then
        if str_排班上下午标志 = '上午' then
          update 门诊管理_当天排班记录
             set 上午已挂号数 = 上午已挂号数 - 1
           where 机构编码 = Str_机构编码
             and 记录ID = str_排班记录ID;
        else
          update 门诊管理_当天排班记录
             set 下午已挂号数 = 下午已挂号数 - 1
           where 机构编码 = Str_机构编码
             and 记录ID = str_排班记录ID;
        end if;
      end if;
    
    else
      if str_类别编码 <> '-1' then
        pr_获取_系统唯一号(prm_唯一号编码 => '8',
                    prm_机构编码   => str_机构编码,
                    prm_事物类型   => '1',
                    prm_返回唯一号 => str_医嘱号,
                    prm_执行结果   => Int_返回值,
                    prm_错误信息   => str_返回信息);
      
        if Int_返回值 <> 0 then
          Str_返回信息 := '产生门诊医嘱号失败!';
          GOTO 退出;
        end if;
      
        insert into 门诊管理_门诊医嘱
          (机构编码,
           序号,
           病人id,
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
           规格,
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
           医生嘱托,
           开始时间,
           执行时间方案,
           紧急,
           医嘱状态,
           合并号,
           原组号,
           排序号,
           是否批次,
           换算比例,
           检验申请id,
           挂号序号,
           处方序号,
           天数,
           皮试标志,
           收费状态,
           划价方式,
           总金额,
           单价,
           皮试序号,
           滴速,
           批次号)
          select str_机构编码,
                 rownum,
                 str_病人ID,
                 str_门诊病历号,
                 str_医嘱号,
                 str_挂号科室编码,
                 str_挂号科室编码,
                 c.门诊执行科室编码,
                 str_挂号科室编码,
                 str_挂号医生编码,
                 str_操作员编码,
                 str_操作员姓名,
                 dat_时间,
                 c.大类编码,
                 c.小类编码,
                 c.项目编码,
                 c.项目名称,
                 '',
                 rownum,
                 1,
                 c.单位编码,
                 c.单位名称,
                 b.数量,
                 1,
                 c.单位编码,
                 c.单位名称,
                 '',
                 '',
                 '',
                 '',
                 '',
                 dat_时间,
                 '',
                 '否',
                 '有效',
                 1,
                 rownum,
                 rownum,
                 '否',
                 1,
                 '',
                 str_挂号序号,
                 1,
                 1,
                 -1,
                 '发送未收费',
                 '门诊划价',
                 b.数量 * c.门诊价,
                 c.门诊价,
                 '',
                 '',
                 ''
            from 基础项目_挂号类别     a,
                 基础项目_挂号类别联动 b,
                 基础项目_诊疗字典     c
           where a.机构编码 = str_机构编码
             and b.机构编码 = str_机构编码
             and c.机构编码 = str_机构编码
             and a.类型编码 = b.类型编码
             and b.项目编码 = c.项目编码
             and a.有效状态 = '有效'
             and b.有效状态 = '有效'
             and a.类型编码 = str_类别编码;
      
      end if;
    
    end if;
  
  exception
    when others then
      GOTO 退出;
  end;

  Int_返回值   := 1;
  Str_返回信息 := str_病人ID || ';' || str_门诊病历号 || ';' || str_挂号序号 || ';' ||
              '操作成功!' || dat_出生日期;
  RETURN;

  <<退出>>
  Int_返回值   := 0;
  Str_返回信息 := Str_返回信息 || SQLERRM;
  RAISE_APPLICATION_ERROR(-20001, str_返回信息);
  RETURN;

end PR_门诊管理_挂号登记;
/


prompt Done
spool off
set define on
