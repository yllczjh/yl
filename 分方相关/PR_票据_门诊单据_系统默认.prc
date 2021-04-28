CREATE OR REPLACE PROCEDURE PR_票据_门诊单据_系统默认(STR_打印类型       IN VARCHAR2,
                                            STR_机构编码       IN VARCHAR2,
                                            STR_医嘱号         IN VARCHAR2,
                                            STR_处方序号       IN VARCHAR2,
                                            STR_小类编码       IN VARCHAR2, --处方单传处方单据类型，其他传小类编码
                                            STR_挂号序号       IN VARCHAR2,
                                            STR_病人ID         IN VARCHAR2,
                                            CUR_数据集         OUT SYS_REFCURSOR,
                                            CUR_西药数据集     OUT SYS_REFCURSOR,
                                            CUR_中药数据集     OUT SYS_REFCURSOR,
                                            CUR_病历诊断数据集 OUT SYS_REFCURSOR,
                                            CUR_辅助诊疗数据集 OUT SYS_REFCURSOR) AS

  STR_诊断集合               VARCHAR2(1000);
  STR_非主诊断               VARCHAR2(1000);
  DAE_挂号时间               DATE;
  STR_机构级别               VARCHAR2(10);
  STR_卫材和诊疗是否可共处方 VARCHAR2(10);

BEGIN

  SELECT 机构级别
    INTO STR_机构级别
    FROM 基础项目_机构资料
   WHERE 机构编码 = STR_机构编码;

  BEGIN
    --查询主诊断
    SELECT 疾病名称, 挂号时间
      INTO STR_诊断集合, DAE_挂号时间
      FROM 门诊管理_挂号登记
     WHERE 机构编码 = STR_机构编码
       AND 挂号序号 = STR_挂号序号;
  
    SELECT WMSYS.WM_CONCAT(疾病名称)
      INTO STR_非主诊断
      FROM 门诊管理_病历诊断
     WHERE 机构编码 = STR_机构编码
       AND 挂号序号 = STR_挂号序号
       AND 是否主诊断 <> 'True';
  
    STR_诊断集合 := STR_诊断集合 || ',' || STR_非主诊断;
  
  EXCEPTION
    WHEN OTHERS THEN
      STR_诊断集合 := '';
  END;

  IF STR_打印类型 = '门诊病历' THEN
    OPEN CUR_数据集 FOR
      SELECT A.门诊病历号,
             主诉,
             现病史,
             既往史,
             过敏史,
             体温,
             呼吸,
             脉搏,
             (收缩血压 || '/' || 舒张血压) AS 血压,
             心率,
             (SELECT 机构名称
                FROM 基础项目_机构资料
               WHERE 机构编码 = A.机构编码
                 AND 删除标志 = '0') AS 机构名称,
             B.姓名 AS 病人姓名,
             (SELECT 名称
                FROM 基础项目_字典明细
               WHERE 分类编码 = 'GB_0001'
                 AND 编码 = B.性别
                 AND 删除标志 = '0') AS 性别,
             (SELECT 名称
                FROM 基础项目_字典明细
               WHERE 分类编码 = 'GB_0007'
                 AND 编码 = B.婚姻状况
                 AND 删除标志 = '0') AS 婚姻状况,
             FU_得到_年龄(B.出生日期) AS 年龄,
             B.家庭地址,
             (SELECT 科室名称
                FROM 基础项目_科室资料
               WHERE 机构编码 = A.机构编码
                 AND 科室编码 = C.就诊科室编码
                 AND 删除标志 = '0') AS 科室名称,
             STR_诊断集合 AS 诊断,
             体查,
             处理意见,
             录入时间 AS 就诊时间,
             录入人 AS 开方医生,
             (SELECT 家长姓名
                FROM 基础项目_病人信息_其他
               WHERE 机构编码 = B.机构编码
                 AND 病人ID = B.病人ID) AS 家长姓名
        FROM 门诊管理_病历 A, 基础项目_病人信息 B, 门诊管理_挂号登记 C
       WHERE A.机构编码 = B.机构编码
         AND A.病人ID = B.病人ID
         AND A.机构编码 = C.机构编码
         AND A.挂号序号 = C.挂号序号
         AND A.机构编码 = STR_机构编码
         AND A.挂号序号 = STR_挂号序号;
  
    OPEN CUR_西药数据集 FOR
      SELECT (项目名称 || 规格 || ' ' || 用量 || 剂量名称 || ' ' || 总量 || 单位名称) AS 医嘱项目信息,
             剂量名称,
             频率名称,
             用法名称,
             单位名称,
             '' AS 组线,
             医嘱号,
             组号,
             处方序号,
             用量,
             天数
        FROM 门诊管理_门诊医嘱
       WHERE 挂号序号 = STR_挂号序号
         AND 机构编码 = STR_机构编码
         AND 大类编码 = '2'
         AND 收费状态 != '已退费'
         AND 医嘱状态 = '有效'
       ORDER BY 医嘱号 ASC, 处方序号 ASC, 组号 ASC, 排序号 ASC;
  
    OPEN CUR_中药数据集 FOR
      SELECT 1 FROM DUAL;
  
    OPEN CUR_病历诊断数据集 FOR
      SELECT 1 FROM DUAL;
  
    OPEN CUR_辅助诊疗数据集 FOR
      SELECT 1 FROM DUAL;
  END IF;

  IF STR_打印类型 = '门诊留观病历' THEN
    OPEN CUR_数据集 FOR
      SELECT DISTINCT ('    主　诉：' || 主诉 || CHR(10) || '    现病史：' || 现病史 ||
                      CHR(10) || '    既往史：' || 既往史 || CHR(10) ||
                      '    过敏史：' || 过敏史 || CHR(10) || '    体格检查：' ||
                      ('T:' || 体温 || '℃ R:' || 呼吸 || '次/分 P:' || 脉搏 ||
                      '次/分 BP:' || 收缩血压 || '/' || 舒张血压) || 'mmHg' ||
                      CHR(10) || 体查 || CHR(10) || '    辅助检查结果：' || '') AS 病史情况,
                      A.门诊病历号,
                      B. 姓名 AS 病人姓名,
                      (SELECT 名称
                         FROM 基础项目_字典明细
                        WHERE 分类编码 = 'GB_0001'
                          AND 编码 = B.性别
                          AND 删除标志 = '0') AS 性别,
                      FU_得到_年龄(B.出生日期) AS 年龄,
                      B.家庭地址,
                      T.家长姓名,
                      B.手机号码,
                      T.职业,
                      (CASE B.婚姻状况
                        WHEN '1' THEN
                         '未婚'
                        WHEN '2' THEN
                         '已婚'
                        WHEN '3' THEN
                         '丧偶'
                        WHEN '4' THEN
                         '离婚'
                        ELSE
                         '位置'
                      END) AS 婚姻状况,
                      (SELECT 科室名称
                         FROM 基础项目_科室资料
                        WHERE 机构编码 = A.机构编码
                          AND 科室编码 = C.就诊科室编码
                          AND 删除标志 = '0') AS 科室名称,
                      FUN_门诊日志_病人病历诊断汇总(C.挂号序号, C.疾病名称) AS 诊断,
                      ('   ' || 体查) AS 体查,
                      处理意见,
                      录入时间 AS 就诊时间,
                      录入人 AS 开方医生,
                      就诊模式
        FROM 门诊管理_病历 A, 门诊管理_挂号登记 C, 基础项目_病人信息 B
        LEFT JOIN 基础项目_病人信息_其他 T
          ON B.机构编码 = T.机构编码
         AND B.病人ID = T.病人ID
       WHERE A.机构编码 = B.机构编码
         AND A.病人ID = B.病人ID
         AND A.机构编码 = C.机构编码
         AND A.挂号序号 = C.挂号序号
         AND A.机构编码 = STR_机构编码
         AND A.挂号序号 = STR_挂号序号;
  
    --所有的医嘱情况
    OPEN CUR_西药数据集 FOR
      SELECT (ROWNUM || ')' || 项目名称) AS 项目名称,
             (ROWNUM || ')' || 医嘱内容) AS 医嘱内容,
             (CASE
               WHEN 规格 IS NULL THEN
                ''
               ELSE
                ('(' || 规格 || ')')
             END) AS 规格,
             总量,
             剂量名称,
             频率名称,
             用法名称,
             单位名称,
             '' AS 组线,
             医嘱号,
             组号,
             处方序号,
             用量,
             天数
        FROM 门诊管理_门诊医嘱
       WHERE 挂号序号 = STR_挂号序号
         AND 机构编码 = STR_机构编码
         AND 大类编码 = '2'
         AND 收费状态 != '已退费'
         AND 医嘱状态 = '有效'
       ORDER BY 医嘱号 ASC, 处方序号 ASC, 组号 ASC, 排序号 ASC;
  
    OPEN CUR_中药数据集 FOR
      SELECT 1 FROM DUAL;
  
    --医生的处理措施
    OPEN CUR_病历诊断数据集 FOR
      SELECT *
        FROM 门诊管理_留观观察处理记录
       WHERE 挂号序号 = STR_挂号序号
         AND 机构编码 = STR_机构编码
         AND 记录类型 = '处理措施';
    --护士病情观察
    OPEN CUR_辅助诊疗数据集 FOR
      SELECT *
        FROM 门诊管理_留观观察处理记录
       WHERE 挂号序号 = STR_挂号序号
         AND 机构编码 = STR_机构编码
         AND 记录类型 = '病情观察';
  END IF;

  IF STR_打印类型 = '处方单' THEN
  
    BEGIN
      SELECT 值
        INTO STR_卫材和诊疗是否可共处方
        FROM 基础项目_机构参数列表
       WHERE 参数编码 = '910643'
         AND 机构编码 = STR_机构编码
         AND 删除标志 = '0';
    EXCEPTION
      WHEN OTHERS THEN
        STR_卫材和诊疗是否可共处方 := '否';
    END;
  
    IF STR_小类编码 = '中药处方单' THEN
      OPEN CUR_数据集 FOR
        SELECT (SELECT 机构名称
                  FROM 基础项目_机构资料
                 WHERE 机构编码 = A.机构编码
                   AND 删除标志 = '0') AS 机构名称,
               A.门诊病历号,
               A.医嘱号,
               (SELECT 科室名称
                  FROM 基础项目_科室资料
                 WHERE 机构编码 = A.机构编码
                   AND 科室编码 = A.病人科室编码
                   AND 删除标志 = '0') AS 科室名称,
               (SELECT 人员姓名
                  FROM 基础项目_人员资料
                 WHERE 机构编码 = A.机构编码
                   AND 人员编码 = A.开方医生编码
                   AND 删除标志 = '0') AS 开方医生,
               T.姓名 AS 病人姓名,
               FU_得到_年龄(T.出生日期) AS 病人年龄,
               (CASE
                 WHEN T.性别 = '1' THEN
                  '男'
                 WHEN T.性别 = '2' THEN
                  '女'
                 ELSE
                  '未知'
               END) AS 病人性别,
               (SELECT 名称
                  FROM 基础项目_字典明细
                 WHERE 分类编码 = 'GB_009000'
                   AND 编码 = C.病人类型编码) AS 病人类型,
               (SELECT 医保卡号
                  FROM 基础项目_病人信息_其他
                 WHERE 机构编码 = A.机构编码
                   AND 病人ID = A.病人ID) AS 医保卡号,
               STR_诊断集合 AS 诊断,
               --T.家庭地址 AS 地址,
               (CASE
                 WHEN NVL(T.家庭地址, '不详') = '不详' THEN
                  NVL(T.工作单位, '不详')
                 ELSE
                  T.家庭地址
               END) AS 地址,
               (B.项目名称 || ' ' || (B.用法名称) || '  ' || B.总量 || B.单位名称) AS 项目信息,
               B.项目名称,
               A.总量,
               A.单位名称,
               (A.剂数 || '付') AS 剂数,
               B.用法名称,
               A.频率名称,
               A.组号,
               A.医生嘱托 AS 加水量,
               A.处方序号,
               A.录入时间 AS 处方时间,
               '' AS 组线,
               B.煎法名称,
               B.总金额　AS　项目总金额,
               A.ROWID AS 唯一号,
               (CASE
                 WHEN C.挂号科室编码 IN (SELECT 科室编码
                                     FROM 基础项目_科室类型列表
                                    WHERE 机构编码 = A.机构编码
                                      AND 删除标志 = '0'
                                      AND 类型编码 = '14') THEN
                  '儿童'
                 WHEN C.挂号科室编码 IN (SELECT 科室编码
                                     FROM 基础项目_科室类型列表
                                    WHERE 机构编码 = A.机构编码
                                      AND 删除标志 = '0'
                                      AND 类型编码 = '13') THEN
                  '急诊'
                 ELSE
                  '普通'
               END) AS 处方显示类型,
               (CASE
                 WHEN A.病人科室编码 IN ('0201') THEN
                  '备注:1,请遵医嘱服药;2,请在窗口点清药品;3,处方当日有效;4,发出药品不予退换'
                 ELSE
                  '备注:1,请遵医嘱服药;2,请在窗口点清药品;3,发出药品不予退换'
               END) AS 处方说明,
               (SELECT 身份证号
                  FROM 基础项目_病人信息
                 WHERE 机构编码 = A.机构编码
                   AND 病人ID = A.病人ID) AS 身份证号
          FROM 门诊管理_门诊医嘱     A,
               门诊管理_门诊医嘱项目 B,
               基础项目_病人信息     T,
               门诊管理_挂号登记     C
         WHERE A.机构编码 = STR_机构编码
           AND A.医嘱号 = STR_医嘱号
           AND A.处方序号 = STR_处方序号
           AND A.机构编码 = B.机构编码
           AND A.医嘱号 = B.医嘱号
           AND A.项目ID = B.项目ID
           AND A.机构编码 = T.机构编码
           AND A.病人ID = T.病人ID
           AND A.机构编码 = C.机构编码
           AND A.挂号序号 = C.挂号序号
           AND A.门诊病历号 = C.门诊病历号
        --AND A.大类编码 = '2'
        --AND (A.小类编码 = '3' OR A.小类编码 = '12')
         ORDER BY B.序号 ASC;
    ELSIF STR_小类编码 = '西成药处方' THEN
      OPEN CUR_数据集 FOR
        SELECT A.门诊病历号,
               (SELECT 机构名称
                  FROM 基础项目_机构资料
                 WHERE 机构编码 = A.机构编码
                   AND 删除标志 = '0') AS 机构名称,
               A.医嘱号,
               (SELECT 科室名称
                  FROM 基础项目_科室资料
                 WHERE 机构编码 = A.机构编码
                   AND 科室编码 = A.病人科室编码
                   AND 删除标志 = '0') AS 科室名称,
               (SELECT 姓名
                  FROM 基础项目_病人信息
                 WHERE 机构编码 = A.机构编码
                   AND 病人ID = A.病人ID) AS 病人姓名,
               (TO_CHAR(录入时间, 'yyyy') || '年' || TO_CHAR(录入时间, 'MM') || '月' ||
               TO_CHAR(录入时间, 'dd') || '日' || TO_CHAR(录入时间, 'hh24') || '时' ||
               TO_CHAR(录入时间, 'mi') || '分') AS 打印时间,
               (SELECT FU_得到_年龄(出生日期)
                  FROM 基础项目_病人信息
                 WHERE 机构编码 = A.机构编码
                   AND 病人ID = A.病人ID) AS 病人年龄,
               (SELECT 名称
                  FROM 基础项目_字典明细
                 WHERE 分类编码 = 'GB_009000'
                   AND 删除标志 = '0'
                   AND 编码 = C.病人类型编码) AS 病人类型,
               (SELECT 医保卡号
                  FROM 基础项目_病人信息_其他
                 WHERE 机构编码 = A.机构编码
                   AND 病人ID = A.病人ID) AS 医保卡号,
               STR_诊断集合 AS 诊断,
               (SELECT (CASE
                         WHEN NVL(家庭地址, '不详') = '不详' THEN
                          NVL(工作单位, '不详')
                         ELSE
                          家庭地址
                       END) AS 家庭地址
                  FROM 基础项目_病人信息
                 WHERE 机构编码 = A.机构编码
                   AND 病人ID = A.病人ID) AS 地址,
               (SELECT 手机号码
                  FROM 基础项目_病人信息
                 WHERE 机构编码 = A.机构编码
                   AND 病人ID = A.病人ID) AS 手机号码,
               A.项目名称,
               A.医嘱内容,
               A.规格,
               (A.规格 || '(取' || TO_CHAR(A.总量, 'FM9999999990.0999') ||
               A.单位名称 || ')') AS 规格及总量,
               (TO_CHAR(A.用量, 'FM9999999990.0999') || A.剂量名称) AS 用量,
               A.频率名称 AS 频率,
               REPLACE(A.用法名称, '皮试', '皮试(      )') AS 用法名称,
               A.操作员姓名,
               A.单价,
               A.总量,
               A.单位名称,
               A.总金额,
               (SELECT 人员姓名
                  FROM 基础项目_人员资料
                 WHERE 机构编码 = A.机构编码
                   AND 人员编码 = A.开方医生编码
                   AND 删除标志 = '0') AS 开发医生姓名,
               (SELECT 名称
                  FROM 基础项目_字典明细
                 WHERE 分类编码 = 'GB_0001'
                   AND 删除标志 = '0'
                   AND 编码 = (SELECT 性别
                               FROM 基础项目_病人信息
                              WHERE 机构编码 = A.机构编码
                                AND 病人ID = A.病人ID)) AS 病人性别,
               TO_CHAR(A.总量, 'FM9999999990.0999') AS 总数量,
               '' AS 组线,
               (A.处方序号 || ':') AS 处方序号,
               A.小类编码,
               A.医生嘱托,
               组号,
               (SELECT SUM(总金额)
                  FROM 门诊管理_门诊医嘱项目
                 WHERE 机构编码 = A.机构编码　 AND　医嘱号 = A.医嘱号
                   AND 项目ID = A.项目ID
                   AND 生成时间 >= A.录入时间 - 3) 　AS　总费用,
               A.ROWID AS 唯一号,
               天数,               
               (CASE
                 WHEN C.挂号科室编码 IN (SELECT 科室编码
                                     FROM 基础项目_科室类型列表
                                    WHERE 机构编码 = A.机构编码
                                      AND 删除标志 = '0'
                                      AND 类型编码 = '14') THEN
                  '儿童'
                 WHEN C.挂号科室编码 IN (SELECT 科室编码
                                     FROM 基础项目_科室类型列表
                                    WHERE 机构编码 = A.机构编码
                                      AND 删除标志 = '0'
                                      AND 类型编码 = '13') THEN
                  '急诊'
                 ELSE
                  '普通'
               END) AS 处方显示类型,
               (CASE
                 WHEN A.病人科室编码 IN ('0201') THEN
                  '备注:1,请遵医嘱服药;2,请在窗口点清药品;3,处方当日有效;4,发出药品不予退换'
                 ELSE
                  '备注:1,请遵医嘱服药;2,请在窗口点清药品;3,发出药品不予退换'
               END) AS 处方说明,
               (SELECT 身份证号
                  FROM 基础项目_病人信息
                 WHERE 机构编码 = A.机构编码
                   AND 病人ID = A.病人ID) AS 身份证号,
               (CASE
                 WHEN A.病人科室编码 IN ('217A', '0202', '0214') AND A.用法名称 = '口服' THEN
                  'A' || A.组号
                 ELSE
                  'B' || A.序号
               END) AS 特殊组号
          FROM 门诊管理_门诊医嘱 A,
               门诊管理_挂号登记 C,
               基础项目_病人信息 T
         WHERE A.机构编码 = STR_机构编码
           AND A.机构编码 = T.机构编码
           AND A.病人ID = T.病人ID
           AND A.医嘱号 = STR_医嘱号
           AND A.处方序号 = STR_处方序号
           AND A.机构编码 = C.机构编码
           AND A.挂号序号 = C.挂号序号
           AND A.门诊病历号 = C.门诊病历号
           AND A.收费状态 NOT IN ('已退费', '已退药')
        --AND A.大类编码 = '2'
        --AND A.小类编码 IN ('1', '2','4')
         ORDER BY 医嘱号 ASC, A.排序号 ASC;
    ELSE
      OPEN CUR_数据集 FOR
        SELECT A.门诊病历号,
               (SELECT 机构名称
                  FROM 基础项目_机构资料
                 WHERE 机构编码 = A.机构编码
                   AND 删除标志 = '0') AS 机构名称,
               A.医嘱号,
               (SELECT 科室名称
                  FROM 基础项目_科室资料
                 WHERE 机构编码 = A.机构编码
                   AND 科室编码 = A.病人科室编码
                   AND 删除标志 = '0') AS 科室名称,
               (SELECT 姓名
                  FROM 基础项目_病人信息
                 WHERE 机构编码 = A.机构编码
                   AND 病人ID = A.病人ID) AS 病人姓名,
               (TO_CHAR(录入时间, 'yyyy') || '年' || TO_CHAR(录入时间, 'MM') || '月' ||
               TO_CHAR(录入时间, 'dd') || '日' || TO_CHAR(录入时间, 'hh24') || '时' ||
               TO_CHAR(录入时间, 'mi') || '分') AS 打印时间,
               (SELECT FU_得到_年龄(出生日期)
                  FROM 基础项目_病人信息
                 WHERE 机构编码 = A.机构编码
                   AND 病人ID = A.病人ID) AS 病人年龄,
               (SELECT 名称
                  FROM 基础项目_字典明细
                 WHERE 分类编码 = 'GB_009000'
                   AND 删除标志 = '0'
                   AND 编码 = C.病人类型编码) AS 病人类型,
               (SELECT 医保卡号
                  FROM 基础项目_病人信息_其他
                 WHERE 机构编码 = A.机构编码
                   AND 病人ID = A.病人ID) AS 医保卡号,
               STR_诊断集合 AS 诊断,
               (SELECT (CASE
                         WHEN NVL(家庭地址, '不详') = '不详' THEN
                          NVL(工作单位, '不详')
                         ELSE
                          家庭地址
                       END) AS 家庭地址
                  FROM 基础项目_病人信息
                 WHERE 机构编码 = A.机构编码
                   AND 病人ID = A.病人ID) AS 地址,
               (SELECT 手机号码
                  FROM 基础项目_病人信息
                 WHERE 机构编码 = A.机构编码
                   AND 病人ID = A.病人ID) AS 手机号码,
               A.项目名称,
               A.医嘱内容,
               A.规格,
               (A.规格 || '(取' || TO_CHAR(A.总量, 'FM9999999990.0999') ||
               A.单位名称 || ')') AS 规格及总量,
               TO_CHAR(A.用量, 'FM9999999990.0999') AS 用量,
               A.频率名称 AS 频率,
               REPLACE(A.用法名称, '皮试', '皮试(   )') AS 用法名称,
               A.操作员姓名,
               A.单价,
               A.总量,
               A.单位名称,
               A.总金额,
               (SELECT 人员姓名
                  FROM 基础项目_人员资料
                 WHERE 机构编码 = A.机构编码
                   AND 人员编码 = A.开方医生编码
                   AND 删除标志 = '0') AS 开发医生姓名,
               (SELECT 名称
                  FROM 基础项目_字典明细
                 WHERE 分类编码 = 'GB_0001'
                   AND 删除标志 = '0'
                   AND 编码 = (SELECT 性别
                               FROM 基础项目_病人信息
                              WHERE 机构编码 = A.机构编码
                                AND 病人ID = A.病人ID)) AS 病人性别,
               TO_CHAR(A.总量, 'FM9999999990.0999') AS 总数量,
               '' AS 组线,
               (A.处方序号 || ':') AS 处方序号,
               A.小类编码,
               A.医生嘱托,
               组号,
               (SELECT SUM(总金额)
                  FROM 门诊管理_门诊医嘱项目
                 WHERE 机构编码 = A.机构编码　 AND　医嘱号 = A.医嘱号
                   AND 项目ID = A.项目ID
                   AND 生成时间 >= A.录入时间 - 3) 　AS　总费用,
               A.ROWID AS 唯一号,
               天数,
               (CASE
                 WHEN C.挂号科室编码 IN (SELECT 科室编码
                                     FROM 基础项目_科室类型列表
                                    WHERE 机构编码 = A.机构编码
                                      AND 删除标志 = '0'
                                      AND 类型编码 = '14') THEN
                  '儿童'
                 WHEN C.挂号科室编码 IN (SELECT 科室编码
                                     FROM 基础项目_科室类型列表
                                    WHERE 机构编码 = A.机构编码
                                      AND 删除标志 = '0'
                                      AND 类型编码 = '13') THEN
                  '急诊'
                 ELSE
                  '普通'
               END) AS 处方显示类型,
               (CASE
                 WHEN A.病人科室编码 IN ('0201') THEN
                  '备注:1,请遵医嘱服药;2,请在窗口点清药品;3,处方当日有效;4,发出药品不予退换'
                 ELSE
                  '备注:1,请遵医嘱服药;2,请在窗口点清药品;3,发出药品不予退换'
               END) AS 处方说明,
               (SELECT 身份证号
                  FROM 基础项目_病人信息
                 WHERE 机构编码 = A.机构编码
                   AND 病人ID = A.病人ID) AS 身份证号
          FROM 门诊管理_门诊医嘱 A,
               门诊管理_挂号登记 C,
               基础项目_病人信息 T
         WHERE A.机构编码 = STR_机构编码
           AND A.机构编码 = T.机构编码
           AND A.病人ID = T.病人ID
           AND A.医嘱号 = STR_医嘱号
           AND A.机构编码 = C.机构编码
           AND A.挂号序号 = C.挂号序号
           AND A.门诊病历号 = C.门诊病历号
           AND A.收费状态 NOT IN ('已退费', '已退药', '发送已收费')
              --AND A.处方序号 = STR_处方序号
           AND (A.大类编码 = '1' OR
               (A.大类编码 = '2' AND 小类编码 = '4' AND STR_卫材和诊疗是否可共处方 = '是') OR
               (SELECT 处方单据类型
                   FROM 基础项目_小类字典
                  WHERE 机构编码 = A.机构编码
                    AND 大类编码 = A.大类编码
                    AND 小类编码 = A.小类编码) = '诊疗划价单')
         ORDER BY 处方序号 ASC, 组号 ASC, A.排序号 ASC;
    
    END IF;
    OPEN CUR_西药数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  
    OPEN CUR_中药数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  
    OPEN CUR_病历诊断数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  
    OPEN CUR_辅助诊疗数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  END IF;

  IF STR_打印类型 = '医嘱单' THEN
    OPEN CUR_数据集 FOR
      SELECT A.门诊病历号,
             (SELECT 机构名称
                FROM 基础项目_机构资料
               WHERE 机构编码 = A.机构编码
                 AND 删除标志 = '0') AS 机构名称,
             A.医嘱号,
             (SELECT 科室名称
                FROM 基础项目_科室资料
               WHERE 机构编码 = A.机构编码
                 AND 科室编码 = A.病人科室编码
                 AND 删除标志 = '0') AS 科室名称,
             (SELECT 姓名
                FROM 基础项目_病人信息
               WHERE 机构编码 = A.机构编码
                 AND 病人ID = A.病人ID) AS 病人姓名,
             (TO_CHAR(录入时间, 'yyyy') || '年' || TO_CHAR(录入时间, 'MM') || '月' ||
             TO_CHAR(录入时间, 'dd') || '日' || TO_CHAR(录入时间, 'hh24') || '时' ||
             TO_CHAR(录入时间, 'mi') || '分') AS 打印时间,
             (SELECT FU_得到_年龄(出生日期)
                FROM 基础项目_病人信息
               WHERE 机构编码 = A.机构编码
                 AND 病人ID = A.病人ID) AS 病人年龄,
             (SELECT 名称
                FROM 基础项目_字典明细
               WHERE 分类编码 = 'GB_009000'
                 AND 删除标志 = '0'
                 AND 编码 = (SELECT 病人类型编码
                             FROM 门诊管理_挂号登记
                            WHERE 机构编码 = A.机构编码
                              AND 挂号序号 = A.挂号序号
                              AND 门诊病历号 = A.门诊病历号
                              AND ROWNUM = 1)) AS 病人类型,
             (SELECT 医保卡号
                FROM 基础项目_病人信息_其他
               WHERE 机构编码 = A.机构编码
                 AND 病人ID = A.病人ID) AS 医保卡号,
             STR_诊断集合 AS 诊断,
             (SELECT 家庭地址
                FROM 基础项目_病人信息
               WHERE 机构编码 = A.机构编码
                 AND 病人ID = A.病人ID) AS 地址,
             (SELECT 手机号码
                FROM 基础项目_病人信息
               WHERE 机构编码 = A.机构编码
                 AND 病人ID = A.病人ID) AS 手机号码,
             A.项目名称,
             A.医嘱内容,
             A.规格,
             (A.规格 || '(取' || TO_CHAR(A.总量, 'FM9999999990.0999') || A.单位名称 || ')') AS 规格及总量,
             TO_CHAR(A.用量, 'FM9999999990.0999') AS 用量,
             A.频率名称 AS 频率,
             A.用法名称,
             A.操作员姓名,
             A.单价,
             A.总量,
             A.单位名称,
             A.总金额,
             (SELECT 人员姓名
                FROM 基础项目_人员资料
               WHERE 机构编码 = A.机构编码
                 AND 人员编码 = A.开方医生编码
                 AND 删除标志 = '0') AS 开发医生姓名,
             (SELECT 名称
                FROM 基础项目_字典明细
               WHERE 分类编码 = 'GB_0001'
                 AND 删除标志 = '0'
                 AND 编码 = (SELECT 性别
                             FROM 基础项目_病人信息
                            WHERE 机构编码 = A.机构编码
                              AND 病人ID = A.病人ID)) AS 病人性别,
             TO_CHAR(A.总量, 'FM9999999990.0999') AS 总数量,
             '' AS 组线,
             (A.处方序号 || ':') AS 处方序号,
             A.小类编码,
             A.医生嘱托,
             组号,
             (SELECT SUM(总金额)
                FROM 门诊管理_门诊医嘱项目
               WHERE 机构编码 = A.机构编码　 AND　医嘱号 = A.医嘱号
                 AND 项目ID = A.项目ID
                 AND 生成时间 >= A.录入时间 - 3) 　AS　总费用,
             ROWID AS 唯一号,
             天数
        FROM 门诊管理_门诊医嘱 A
       WHERE A.机构编码 = STR_机构编码
         AND A.医嘱号 = STR_医嘱号
         AND A.收费状态 NOT IN ('已退费', '已退药')
       ORDER BY 处方序号 ASC, 组号 ASC, A.排序号 ASC;
  
    OPEN CUR_西药数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  
    OPEN CUR_中药数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  
    OPEN CUR_病历诊断数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  
    OPEN CUR_辅助诊疗数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  END IF;

  IF STR_打印类型 = '注射单' THEN
    OPEN CUR_数据集 FOR
      SELECT (SELECT 机构名称
                FROM 基础项目_机构资料
               WHERE 机构编码 = A.机构编码
                 AND 删除标志 = '0') AS 机构名称,
             STR_诊断集合 AS 诊断集合,
             A.门诊病历号,
             (SELECT 科室名称
                FROM 基础项目_科室资料
               WHERE 机构编码 = A.机构编码
                 AND 科室编码 = A.病人科室编码
                 AND 删除标志 = '0') AS 科室名称,
             (SELECT 姓名
                FROM 基础项目_病人信息
               WHERE 机构编码 = A.机构编码
                 AND 病人ID = A.病人ID) AS 病人姓名,
             (TO_CHAR(录入时间, 'yyyy') || '年' || TO_CHAR(录入时间, 'MM') || '月' ||
             TO_CHAR(录入时间, 'dd') || '日' || TO_CHAR(录入时间, 'hh24') || '时' ||
             TO_CHAR(录入时间, 'mi') || '分') AS 打印时间,
             (SELECT FU_得到_年龄(出生日期)
                FROM 基础项目_病人信息
               WHERE 机构编码 = A.机构编码
                 AND 病人ID = A.病人ID) AS 病人年龄,
             (SELECT 名称
                FROM 基础项目_字典明细
               WHERE 分类编码 = 'GB_0001'
                 AND 删除标志 = '0'
                 AND 编码 = (SELECT 性别
                             FROM 基础项目_病人信息
                            WHERE 机构编码 = A.机构编码
                              AND 病人ID = A.病人ID)) AS 病人性别,
             (SELECT 名称
                FROM 基础项目_字典明细
               WHERE 分类编码 = 'GB_009000'
                 AND 删除标志 = '0'
                 AND 编码 = (SELECT 病人类型编码
                             FROM 门诊管理_挂号登记
                            WHERE 机构编码 = A.机构编码
                              AND 挂号序号 = A.挂号序号
                              AND 门诊病历号 = A.门诊病历号)) AS 病人类型,
             A.处方序号,
             (A.项目名称 || (CASE
               WHEN 规格 IS NULL THEN
                ''
               ELSE
                ('(' || A.规格 || ')')
             END)) AS 项目名称及规格,
             A.医嘱内容,
             (TO_CHAR(A.用量, 'FM9999999990.0999') || A.剂量名称 || ' X ' || A.总量) AS 医嘱信息,
             (A.天数 || '天') AS 天数,
             (A.总量 || A.单位名称) AS 总量信息,
             A.用法名称,
             A.用法名称 AS 医嘱用法名称,
             (TO_CHAR(A.用量, 'FM9999999990.0999') || A.剂量名称) AS 用量信息,
             NVL((SELECT 次数
                   FROM 基础项目_频率字典
                  WHERE 机构编码 = A.机构编码
                    AND 有效状态 = '有效'
                    AND 频率编码 = A.频率编码),
                 '1') AS 次数,
             A.频率名称,
             A.频率名称 AS 医嘱频率名称,
             '' AS 组线,
             A.组号,
             A.医嘱号,
             A.滴速,
             (SELECT 人员姓名
                FROM 基础项目_人员资料
               WHERE 机构编码 = A.机构编码
                 AND 人员编码 = A.开方医生编码
                 AND 删除标志 = '0') AS 开方医生
        FROM 门诊管理_门诊医嘱 A
       WHERE 机构编码 = STR_机构编码
         AND 医嘱号 = STR_医嘱号
         AND 处方序号 = STR_处方序号
         AND A.收费状态 NOT IN ('已退费', '已退药')
         AND 大类编码 != '1'
         AND 小类编码 != '3'
         AND (用法编码 IN (SELECT 用法编码
                         FROM 基础项目_用法对应打印
                        WHERE 打印对象编码 = '0000000121'
                          AND 机构编码 = STR_机构编码
                          AND 删除标志 = '0') OR
             (NVL(用法编码, '-1') = '-1' AND 皮试序号 LIKE '%-'))
       ORDER BY A.医嘱号 ASC, A.处方序号 ASC, A.组号 ASC, A.排序号 ASC;
    OPEN CUR_西药数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  
    OPEN CUR_中药数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  
    OPEN CUR_病历诊断数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  
    OPEN CUR_辅助诊疗数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  END IF;

  IF STR_打印类型 = '雾化单' THEN
    OPEN CUR_数据集 FOR
      SELECT (SELECT 机构名称
                FROM 基础项目_机构资料
               WHERE 机构编码 = A.机构编码
                 AND 删除标志 = '0') AS 机构名称,
             A.门诊病历号,
             (SELECT 科室名称
                FROM 基础项目_科室资料
               WHERE 机构编码 = A.机构编码
                 AND 科室编码 = A.病人科室编码
                 AND 删除标志 = '0') AS 科室名称,
             (SELECT 姓名
                FROM 基础项目_病人信息
               WHERE 机构编码 = A.机构编码
                 AND 病人ID = A.病人ID) AS 病人姓名,
             (TO_CHAR(录入时间, 'yyyy') || '年' || TO_CHAR(录入时间, 'MM') || '月' ||
             TO_CHAR(录入时间, 'dd') || '日' || TO_CHAR(录入时间, 'hh24') || '时' ||
             TO_CHAR(录入时间, 'mi') || '分') AS 打印时间,
             (SELECT FU_得到_年龄(出生日期)
                FROM 基础项目_病人信息
               WHERE 机构编码 = A.机构编码
                 AND 病人ID = A.病人ID) AS 病人年龄,
             (SELECT 名称
                FROM 基础项目_字典明细
               WHERE 分类编码 = 'GB_0001'
                 AND 删除标志 = '0'
                 AND 编码 = (SELECT 性别
                             FROM 基础项目_病人信息
                            WHERE 机构编码 = A.机构编码
                              AND 病人ID = A.病人ID)) AS 病人性别,
             (SELECT 名称
                FROM 基础项目_字典明细
               WHERE 分类编码 = 'GB_009000'
                 AND 删除标志 = '0'
                 AND 编码 = (SELECT 病人类型编码
                             FROM 门诊管理_挂号登记
                            WHERE 机构编码 = A.机构编码
                              AND 挂号序号 = A.挂号序号
                              AND 门诊病历号 = A.门诊病历号)) AS 病人类型,
             A.处方序号,
             (A.项目名称 || (CASE
               WHEN 规格 IS NULL THEN
                ''
               ELSE
                ('(' || A.规格 || ')')
             END)) AS 项目名称及规格,
             A.医嘱内容,
             (TO_CHAR(A.用量, 'FM9999999990.0999') || A.剂量名称 || ' X ' || A.总量) AS 医嘱信息,
             (A.天数 || '天') AS 天数,
             (A.总量 || A.单位名称) AS 总量信息,
             A.用法名称,
             (TO_CHAR(A.用量, 'FM9999999990.0999') || A.剂量名称 || ' X ') AS 用量信息,
             NVL((SELECT 次数
                   FROM 基础项目_频率字典
                  WHERE 机构编码 = A.机构编码
                    AND 有效状态 = '有效'
                    AND 删除标志 = '0'
                    AND 频率编码 = A.频率编码),
                 '1') AS 次数,
             A.频率名称,
             '' AS 组线,
             A.组号,
             A.医嘱号,
             A.滴速,
             (SELECT 人员姓名
                FROM 基础项目_人员资料
               WHERE 机构编码 = A.机构编码
                 AND 删除标志 = '0'
                 AND 人员编码 = A.开方医生编码) AS 开方医生
        FROM 门诊管理_门诊医嘱 A
       WHERE 机构编码 = STR_机构编码
         AND 医嘱号 = STR_医嘱号
         AND 处方序号 = STR_处方序号
         AND A.收费状态 NOT IN ('已退费', '已退药')
         AND 大类编码 != '1'
         AND 小类编码 != '3'
         AND 用法编码 IN (SELECT 用法编码
                        FROM 基础项目_用法对应打印
                       WHERE 打印对象编码 = '5'
                         AND 机构编码 = STR_机构编码
                         AND 删除标志 = '0')
       ORDER BY A.医嘱号 ASC, A.处方序号 ASC, A.组号 ASC, A.排序号 ASC;
    OPEN CUR_西药数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  
    OPEN CUR_中药数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  
    OPEN CUR_病历诊断数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  
    OPEN CUR_辅助诊疗数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  END IF;

  IF STR_打印类型 = '治疗单' THEN
    OPEN CUR_数据集 FOR
      SELECT (SELECT 机构名称
                FROM 基础项目_机构资料
               WHERE 机构编码 = A.机构编码
                 AND 删除标志 = '0') AS 机构名称,
             STR_诊断集合 AS 诊断集合,
             A.门诊病历号,
             (SELECT 科室名称
                FROM 基础项目_科室资料
               WHERE 机构编码 = A.机构编码
                 AND 科室编码 = A.病人科室编码
                 AND 删除标志 = '0') AS 科室名称,
             (SELECT 姓名
                FROM 基础项目_病人信息
               WHERE 机构编码 = A.机构编码
                 AND 病人ID = A.病人ID) AS 病人姓名,
             (TO_CHAR(录入时间, 'yyyy') || '年' || TO_CHAR(录入时间, 'MM') || '月' ||
             TO_CHAR(录入时间, 'dd') || '日' || TO_CHAR(录入时间, 'hh24') || '时' ||
             TO_CHAR(录入时间, 'mi') || '分') AS 打印时间,
             (SELECT FU_得到_年龄(出生日期)
                FROM 基础项目_病人信息
               WHERE 机构编码 = A.机构编码
                 AND 病人ID = A.病人ID) AS 病人年龄,
             (SELECT 名称
                FROM 基础项目_字典明细
               WHERE 分类编码 = 'GB_0001'
                 AND 删除标志 = '0'
                 AND 编码 = (SELECT 性别
                             FROM 基础项目_病人信息
                            WHERE 机构编码 = A.机构编码
                              AND 病人ID = A.病人ID)) AS 病人性别,
             (SELECT 名称
                FROM 基础项目_字典明细
               WHERE 分类编码 = 'GB_009000'
                 AND 删除标志 = '0'
                 AND 编码 = (SELECT 病人类型编码
                             FROM 门诊管理_挂号登记
                            WHERE 机构编码 = A.机构编码
                              AND 挂号序号 = A.挂号序号
                              AND 门诊病历号 = A.门诊病历号)) AS 病人类型,
             A.处方序号,
             (A.项目名称 || (CASE
               WHEN 规格 IS NULL THEN
                ''
               ELSE
                ('(' || A.规格 || ')')
             END)) AS 项目名称及规格,
             A.医嘱内容,
             (TO_CHAR(A.用量, 'FM9999999990.0999') || A.剂量名称 || ' X ' || A.总量) AS 医嘱信息,
             (A.天数 || '天') AS 天数,
             (A.总量 || A.单位名称) AS 总量信息,
             A.用法名称,
             (TO_CHAR(A.用量, 'FM9999999990.0999') || A.剂量名称) AS 用量信息,
             NVL((SELECT 次数
                   FROM 基础项目_频率字典
                  WHERE 机构编码 = A.机构编码
                    AND 有效状态 = '有效'
                    AND 删除标志 = '0'
                    AND 频率编码 = A.频率编码),
                 '1') AS 次数,
             A.频率名称,
             '' AS 组线,
             A.组号,
             A.医嘱号,
             A.滴速,
             (SELECT 人员姓名
                FROM 基础项目_人员资料
               WHERE 机构编码 = A.机构编码
                 AND 删除标志 = '0'
                 AND 人员编码 = A.开方医生编码) AS 开方医生,
             排序号
        FROM 门诊管理_门诊医嘱 A
       WHERE 机构编码 = STR_机构编码
         AND 医嘱号 = STR_医嘱号
            --AND 处方序号 = STR_处方序号
         AND 大类编码 = '2'
         AND A.收费状态 NOT IN ('已退费', '已退药')
         AND 小类编码 NOT IN ('3', '4')
         AND (用法编码 IN (SELECT 用法编码
                         FROM 基础项目_用法对应打印
                        WHERE 打印对象编码 = '4'
                          AND 机构编码 = STR_机构编码
                          AND 删除标志 = '0') OR (皮试序号 LIKE '%-'))
       ORDER BY A.医嘱号 ASC, A.处方序号 ASC, A.组号 ASC, A.排序号 ASC;
    OPEN CUR_西药数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  
    OPEN CUR_中药数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  
    OPEN CUR_病历诊断数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  
    OPEN CUR_辅助诊疗数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  END IF;

  IF STR_打印类型 = '诊断证明' THEN
    OPEN CUR_数据集 FOR
      SELECT ROWNUM AS 序号,
             FU_取得_机构名称(T.机构编码) AS 机构名称,
             B.姓名,
             (CASE B.性别
               WHEN '1' THEN
                '男'
               WHEN '2' THEN
                '女'
               ELSE
                '未知'
             END) AS 性别,
             FU_得到_年龄(B.出生日期) AS 年龄,
             T.门诊病历号,
             T.疾病编码,
             T.疾病名称,
             NVL((SELECT 人员姓名
                   FROM 基础项目_人员资料 R,
                        (SELECT NVL(就诊医生编码, 挂号医生编码) AS 开方医生编码,
                                机构编码
                           FROM 门诊管理_挂号登记
                          WHERE 挂号序号 = STR_挂号序号
                            AND 机构编码 = STR_机构编码
                            AND 病人ID = STR_病人ID
                            AND ROWNUM = 1) G
                  WHERE R.机构编码 = G.机构编码
                    AND R.人员编码 = G.开方医生编码),
                 '未知医生') AS 开方医生姓名,
             SYSDATE AS 打印日期,
             NVL((SELECT 处理意见
                   FROM 门诊管理_病历
                  WHERE 机构编码 = STR_机构编码
                    AND 挂号序号 = STR_挂号序号
                    AND 病人ID = STR_病人ID
                    AND ROWNUM = 1),
                 '') AS 处理意见
        FROM 基础项目_病人信息 B, 门诊管理_病历诊断 T
       WHERE B.机构编码 = T.机构编码
         AND B.病人ID = T.病人ID
         AND B.机构编码 = STR_机构编码
         AND T.挂号序号 = STR_挂号序号
         AND T.是否主诊断 = 'True';
  
    OPEN CUR_病历诊断数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  
    OPEN CUR_西药数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  
    OPEN CUR_中药数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  
    OPEN CUR_辅助诊疗数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  END IF;

  IF STR_打印类型 = '输液卡' THEN
    OPEN CUR_数据集 FOR
      SELECT (SELECT 机构名称
                FROM 基础项目_机构资料
               WHERE 机构编码 = A.机构编码
                 AND 删除标志 = '0') AS 机构名称,
             STR_诊断集合 AS 诊断集合,
             A.门诊病历号,
             (SELECT 科室名称
                FROM 基础项目_科室资料
               WHERE 机构编码 = A.机构编码
                 AND 科室编码 = A.病人科室编码
                 AND 删除标志 = '0') AS 科室名称,
             (SELECT 姓名
                FROM 基础项目_病人信息
               WHERE 机构编码 = A.机构编码
                 AND 病人ID = A.病人ID) AS 病人姓名,
             (TO_CHAR(录入时间, 'yyyy') || '年' || TO_CHAR(录入时间, 'MM') || '月' ||
             TO_CHAR(录入时间, 'dd') || '日' || TO_CHAR(录入时间, 'hh24') || '时' ||
             TO_CHAR(录入时间, 'mi') || '分') AS 打印时间,
             (SELECT FU_得到_年龄(出生日期)
                FROM 基础项目_病人信息
               WHERE 机构编码 = A.机构编码
                 AND 病人ID = A.病人ID) AS 病人年龄,
             (SELECT 名称
                FROM 基础项目_字典明细
               WHERE 分类编码 = 'GB_0001'
                 AND 删除标志 = '0'
                 AND 编码 = (SELECT 性别
                             FROM 基础项目_病人信息
                            WHERE 机构编码 = A.机构编码
                              AND 病人ID = A.病人ID)) AS 病人性别,
             (SELECT 名称
                FROM 基础项目_字典明细
               WHERE 分类编码 = 'GB_009000'
                 AND 删除标志 = '0'
                 AND 编码 = (SELECT 病人类型编码
                             FROM 门诊管理_挂号登记
                            WHERE 机构编码 = A.机构编码
                              AND 挂号序号 = A.挂号序号
                              AND 门诊病历号 = A.门诊病历号)) AS 病人类型,
             A.处方序号,
             (A.项目名称 || (CASE
               WHEN 规格 IS NULL THEN
                ''
               ELSE
                ('(' || A.规格 || ')')
             END)) AS 项目名称及规格,
             A.医嘱内容,
             (TO_CHAR(A.用量, 'FM9999999990.0999') || A.剂量名称 || ' X ' || A.总量) AS 医嘱信息,
             (A.天数 || '天') AS 天数,
             (A.总量 || A.单位名称) AS 总量信息,
             A.用法名称,
             A.用法名称 AS 医嘱用法名称,
             (TO_CHAR(A.用量, 'FM9999999990.0999') || A.剂量名称) AS 用量信息,
             NVL((SELECT 次数
                   FROM 基础项目_频率字典
                  WHERE 机构编码 = A.机构编码
                    AND 有效状态 = '有效'
                    AND 频率编码 = A.频率编码),
                 '1') AS 次数,
             (SELECT 频率中文名
                FROM 基础项目_频率字典
               WHERE 机构编码 = A.机构编码
                 AND 有效状态 = '有效'
                 AND 频率编码 = A.频率编码) AS 频率名称,
             A.频率名称 AS 医嘱频率名称,
             '' AS 组线,
             A.组号,
             TO_CHAR(A.组号) AS 组号信息,
             A.医嘱号,
             A.滴速,
             (SELECT 人员姓名
                FROM 基础项目_人员资料
               WHERE 机构编码 = A.机构编码
                 AND 人员编码 = A.开方医生编码
                 AND 删除标志 = '0') AS 开方医生
        FROM 门诊管理_门诊医嘱 A
       WHERE 机构编码 = STR_机构编码
         AND 医嘱号 = STR_医嘱号
         AND 处方序号 = STR_处方序号
         AND A.收费状态 NOT IN ('已退费', '已退药')
         AND 大类编码 = '2'
         AND 小类编码 NOT IN ('3', '4')
         AND (用法编码 IN (SELECT 用法编码
                         FROM 基础项目_用法对应打印
                        WHERE 打印对象编码 = '1'
                          AND 机构编码 = STR_机构编码
                          AND 删除标志 = '0') OR (皮试序号 LIKE '%-'))
       ORDER BY A.医嘱号 ASC, A.处方序号 ASC, A.组号 ASC, A.排序号 ASC;
    OPEN CUR_西药数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  
    OPEN CUR_中药数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  
    OPEN CUR_病历诊断数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  
    OPEN CUR_辅助诊疗数据集 FOR
      SELECT 1 FROM DUAL WHERE 1 = 0;
  END IF;

END;
/
