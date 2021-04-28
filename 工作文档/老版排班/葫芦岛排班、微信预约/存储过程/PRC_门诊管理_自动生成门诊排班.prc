CREATE OR REPLACE PROCEDURE PRC_门诊管理_自动生成门诊排班 IS

  STR_机构编码         VARCHAR2(20) := '222403100001';
  STR_是否启动排班     VARCHAR2(10);
  INT_最大预约天数     INTEGER;
  INT_天数             INTEGER;
  STR_星期             VARCHAR2(10);
  STR_排班日期         VARCHAR2(20);
  INT_当前已存在排班数 INTEGER;


  CURSOR CUR_排班记录 IS
    SELECT A.排班序号, sys_guid() as 记录ID
      FROM 门诊管理_门诊一周排班表 A
     WHERE A.机构编码 = STR_机构编码
       AND A.星期 = STR_星期
       AND A.排班序号 NOT IN
           (SELECT B.排班序号
              FROM 门诊管理_当天排班记录 B
             WHERE B.机构编码 = STR_机构编码
               AND B.星期 = STR_星期
               AND B.排班日期 = TO_DATE(STR_排班日期, 'yyyy-MM-dd'));

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
      
        --IF INT_当前已存在排班数 = 0 THEN
      
        FOR CUR_RESULT IN CUR_排班记录 LOOP
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
             出诊状态,
             挂号类型编码)
            SELECT A.机构编码,
                   CUR_RESULT.记录ID,
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
                   '1',
                   A.挂号类型编码
              FROM 门诊管理_门诊一周排班表 A
             WHERE A.机构编码 = STR_机构编码
               AND A.星期 = STR_星期
               AND A.排班序号 = CUR_RESULT.排班序号;
        
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
                   CUR_RESULT.记录ID,
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
               AND A.排班序号 = CUR_RESULT.排班序号;
        
        --END IF;
        END LOOP;
        INT_天数 := INT_天数 + 1;
      END LOOP;
      COMMIT;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line(sqlerrm);
      ROLLBACK;
  END;
END PRC_门诊管理_自动生成门诊排班;
/
