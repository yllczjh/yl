CREATE OR REPLACE PROCEDURE PRC_门诊管理_生成门诊排班记录(STR_机构编码 IN VARCHAR2,
                                              STR_星期     IN VARCHAR2,
                                              STR_日期     IN VARCHAR2,
                                              INT_返回值   OUT INTEGER,
                                              STR_返回信息 OUT VARCHAR2) IS
  INT_数量         INTEGER;
  STR_科室名称     VARCHAR2(50);
  STR_医生姓名     VARCHAR2(50);
  STR_挂号类型名称 VARCHAR2(50);
  STR_科室编码     VARCHAR2(50);
  STR_医生编码     VARCHAR2(50);
  STR_挂号类型编码 VARCHAR2(50);

  CURSOR CUR_排班记录 IS
    SELECT A.排班序号, SYS_GUID() AS 记录ID
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

  INT_返回值 := 0;
  --获取需要生成的排班序号
  FOR CUR_RESULT IN CUR_排班记录 LOOP
  
    SELECT 科室名称,
           科室编码,
           医生姓名,
           医生编码,
           挂号类型名称,
           挂号类型编码
      INTO STR_科室名称,
           STR_科室编码,
           STR_医生姓名,
           STR_医生编码,
           STR_挂号类型名称,
           STR_挂号类型编码
      FROM 门诊管理_门诊一周排班表
     WHERE 机构编码 = STR_机构编码
       AND 星期 = STR_星期
       AND 排班序号 = CUR_RESULT.排班序号;
  
    SELECT COUNT(1)
      INTO INT_数量
      FROM 门诊管理_当天排班记录
     WHERE 机构编码 = STR_机构编码
       AND 星期 = STR_星期
       AND 排班日期 = TO_DATE(STR_日期, 'yyyy-MM-dd')
       AND 科室编码 = STR_科室编码
       AND 医生编码 = STR_医生编码
       AND 挂号类型编码 = STR_挂号类型编码;
    IF INT_数量 > 0 THEN
      INT_返回值   := 0;
      STR_返回信息 := '当日排班已存在手动添加的[' || STR_科室名称 || ']下[' || STR_医生姓名 ||']挂号类型为['|| STR_挂号类型名称 ||
                  ']的排班,与周排班中记录冲突，请先处理！';
      ROLLBACK;
      RETURN;
    END IF;
  
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
             TO_DATE(STR_日期, 'yyyy-MM-dd'),
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
             '手动生成',
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
  
    INT_返回值 := INT_返回值 + 1;
  END LOOP;
  IF INT_返回值 = 0 THEN
    STR_返回信息 := '当天没有需要生成的排班记录';
    RETURN;
  END IF;
  INT_返回值   := 1;
  STR_返回信息 := 'ok';
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    INT_返回值   := 0;
    STR_返回信息 := SQLERRM;
    ROLLBACK;
  
END PRC_门诊管理_生成门诊排班记录;
/
