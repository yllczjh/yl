prompt PL/SQL Developer Export User Objects for user CLOUDHIS@47.104.4.221:9900/YKEY
prompt Created by syyyhl on 2020-09-18
set define off
spool 数据上报存储过程.log

prompt
prompt Creating procedure PR_数据上报_发热门诊病例信息
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE PR_数据上报_发热门诊病例信息(STR_参数          IN VARCHAR2,
                                             CUR_导出_列表信息 OUT SYS_REFCURSOR) IS

  STR_机构编码 VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 1);
  /*DAT_出院时间起始 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 2),
                             'yyyy-MM-dd hh24:mi:ss');
  DAT_出院时间截止 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 3),
                             'yyyy-MM-dd hh24:mi:ss');
  STR_过滤数据     VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 4);*/
  STR_项目编码 VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 5);
  STR_流水码   VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 6);
BEGIN
  BEGIN
    IF STR_流水码 IS NULL THEN
      SELECT MAX(流水码)
        INTO STR_流水码
        FROM 病案管理_导出列表
       WHERE 机构编码 = STR_机构编码
         AND 项目编码 = STR_项目编码;
    END IF;
  
    --更新在院基本信息
    INSERT INTO 临时表_数据上报_在院流感费用
      (病历号, 费用总额, 费用名称, 单项总额, 自付总额)
      SELECT B.门诊病历号,
             C.费用总额,
             (CASE
               WHEN D.大类编码 = 2 AND D.小类编码 IN ('1', '2', '3', '12') THEN
                '药品费'
               WHEN D.大类编码 = '1' AND D.小类编码 IN ('1', '2', '7') THEN
                '检查费'
               ELSE
                '其他费'
             END) AS 费用名称,
             D.总金额,
             (C.费用总额 - C.补偿总额) AS 参考自付金额
        FROM 门诊管理_挂号登记     B,
             门诊管理_门诊发票登记 C,
             门诊管理_门诊处方     D
       WHERE B.机构编码 = C.机构编码
         AND C.机构编码 = D.机构编码
         AND B.门诊病历号 = C.门诊病历号
         AND C.门诊病历号 = D.门诊病历号
         AND C.发票序号 = D.发票序号
         AND C.收费时间 >= B.挂号时间
         AND D.收费时间 >= B.挂号时间
         AND B.机构编码 = STR_机构编码
         AND EXISTS (SELECT 1
                FROM 病案管理_导出列表 A
               WHERE A.机构编码 = B.机构编码
                 AND A.病历号 = B.门诊病历号
                 AND A.就诊类别 = '门诊'
                 AND A.项目编码 = STR_项目编码
                 AND A.流水码 = STR_流水码);
  
    OPEN CUR_导出_列表信息 FOR
    
      SELECT G.门诊病历号 AS 病历号,
             G.机构编码 AS P900,
             '营口经济技术开发区第二人民医院' AS P6891,
             NULL AS P686, --医疗保险手册号,
             XX.健康卡号 AS P800,
             '01' AS P7501, -- 就诊类型,
             G.门诊病历号 AS P7502, -- 就诊卡号,
             G.门诊病历号 AS P7000, -- 门诊就诊流水号,
             XX.姓名 AS P4,
             NVL(XX.性别, '0') AS P5,
             XX.出生日期 AS P6,
             TO_NUMBER(REGEXP_REPLACE(XX.年龄, '[^-0-9.]', '')) P7,
             null AS P12, --国籍,
             XX.民族ID AS P11,
             DECODE(XX.婚姻状况, '4', '9', XX.婚姻状况) AS P8,
             XX.职业 AS P9, --B.职业
             '01' AS P7503, -- 注册证件类型代码,
             XX.身份证号 AS P13,
             NVL(XX.现住_地址, XX.家庭地址) AS P801, --B.现住_地址
             XX.手机号码 AS P802,
             XX.现住_邮编 AS P803, --B.现住_邮编
             NVL(XX.工作单位及地址, XX.工作单位) AS P14, --B.工作单位及地址
             XX.单位电话 AS P15, --B.单位电话
             NULL AS P16, --工作单位邮政编码
             XX.联系人_姓名 AS P18, --B.联系人_姓名
             XX.联系人_关系 AS P19, --B.联系人_关系
             XX.联系人_地址 AS P20, --B.联系人_地址
             XX.联系人_电话 AS P21, --B.联系人_电话
             '1' AS P7505, --就诊次数
             DECODE(G.是否急诊, '复诊', '否', '是') AS P7520, --是否出诊
             NULL AS P7521, --是否转诊
             (SELECT A.科室类别
                FROM 基础项目_科室补充资料 A
               WHERE A.机构编码 = G.机构编码
                 AND A.科室编码 = G.就诊科室编码) P7504,
             (SELECT A.科室名称
                FROM 基础项目_科室资料 A
               WHERE A.机构编码 = G.机构编码
                 AND A.科室编码 = G.就诊科室编码) AS P7522, --就诊科室代码
             G.挂号时间 AS P7506, --就诊日期
             NULL AS P7507, --主诉
             NULL AS P7523, --现病史
             NULL AS P7524, --体格检查
             
             NULL AS P7525, --症状代码
             NULL AS P7526, --症状名称
             NULL AS P7527, --症状描述
             NULL AS P7528, --发病日期
             (CASE
               WHEN (SELECT COUNT(1)
                       FROM 门诊护士_留观登记
                      WHERE 机构编码 = G.机构编码
                        AND 门诊病历号 = G.门诊病历号) > 0 THEN
                '1'
               ELSE
                '2'
             END) AS P7529, --是否留观
             G.疾病编码 AS P28,
             G.疾病名称 AS P281,
             NULL AS P7530,
             '9' AS P1, --确诊标记
             (SELECT SUM(B.单项总额)
                FROM 临时表_数据上报_在院流感费用 B
               WHERE B.病历号 = G.门诊病历号) AS P7508, --总费用
             '0' AS P7509, --挂号费
             (SELECT SUM(B.单项总额)
                FROM 临时表_数据上报_在院流感费用 B
               WHERE B.病历号 = G.门诊病历号
                 AND B.费用名称 = '药品费') AS P7510, --药品费
             (SELECT SUM(B.单项总额)
                FROM 临时表_数据上报_在院流感费用 B
               WHERE B.病历号 = G.门诊病历号
                 AND B.费用名称 = '检查费') AS P7511, --检查费
             (SELECT SUM(B.自付总额)
                FROM 临时表_数据上报_在院流感费用 B
               WHERE B.病历号 = G.门诊病历号) AS P7512 --自付总额
      
        FROM 门诊管理_挂号登记 G,
             (SELECT X.机构编码,
                     X.病人ID,
                     X.姓名,
                     X.性别,
                     X.出生日期,
                     X.年龄,
                     X.家庭地址,
                     X.工作单位,
                     X.身份证号,
                     X.民族ID,
                     X.婚姻状况,
                     X.健康卡号,
                     X.手机号码,
                     X1.职业,
                     X1.现住_地址,
                     X1.现住_邮编,
                     X1.工作单位及地址,
                     X1.单位电话,
                     X1.联系人_姓名,
                     X1.联系人_关系,
                     X1.联系人_地址,
                     X1.联系人_电话
                FROM 基础项目_病人信息 X
                LEFT JOIN 基础项目_病人病案信息 X1
                  ON X.病人ID = X1.病人ID) XX
       WHERE G.机构编码 = XX.机构编码
         AND G.病人ID = XX.病人ID
         AND G.机构编码 = STR_机构编码
         AND EXISTS (SELECT 1
                FROM 病案管理_导出列表 A
               WHERE A.机构编码 = G.机构编码
                 AND A.病历号 = G.门诊病历号
                 AND A.就诊类别 = '门诊'
                 AND A.项目编码 = STR_项目编码
                 AND A.流水码 = STR_流水码);
  
  END;

END PR_数据上报_发热门诊病例信息;

/

prompt
prompt Creating procedure PR_数据上报_发热门诊病人集合
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_数据上报_发热门诊病人集合(STR_参数          IN VARCHAR2,
                                           CUR_导出_列表信息 OUT SYS_REFCURSOR) IS

  STR_机构编码     VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 1);
  DAT_出院时间起始 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 2),
                             'yyyy-MM-dd hh24:mi:ss');
  DAT_出院时间截止 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 3),
                             'yyyy-MM-dd hh24:mi:ss');
  STR_过滤数据     VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 4);
  STR_项目编码     VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 5);
  STR_流水码       VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 6);

  DAT_导出时间 DATE;
  NUM_流水码   NUMBER;
  STR_是否回传数据 VARCHAR2(50);

BEGIN

  BEGIN
  
    SELECT SYSDATE INTO DAT_导出时间 FROM DUAL;
  BEGIN
      SELECT X.是否回传数据
        INTO STR_是否回传数据
        FROM 病案管理_项目信息 X
       WHERE X.机构编码 = STR_机构编码
         AND X.项目编码 = STR_项目编码;
    EXCEPTION
      WHEN OTHERS THEN
        STR_是否回传数据 := '否';
    END;
  
    IF STR_是否回传数据 = '否' THEN
      DELETE FROM 病案管理_导出列表
       WHERE 机构编码 = STR_机构编码
         AND 项目编码 = STR_项目编码;
    END IF;
    --DELETE FROM 病案管理_导出列表;
    IF STR_流水码 IS NULL THEN
      SELECT NVL(MAX(流水码), 0) + 1
        INTO NUM_流水码
        FROM 病案管理_导出列表;
    
      INSERT INTO 病案管理_导出列表
        (机构编码,
         病历号,
         起始时间,
         截止时间,
         导出时间,
         流水码,
         就诊类别,
         项目编码)
        SELECT STR_机构编码,
               Z.门诊病历号,
               DAT_出院时间起始,
               DAT_出院时间截止,
               DAT_导出时间,
               NUM_流水码,
               '门诊' AS 就诊类别,
               STR_项目编码
          FROM 门诊管理_挂号登记 Z, 基础项目_病人信息 T
         WHERE Z.机构编码 = T.机构编码
           AND Z.病人ID = T.病人ID
           AND Z.机构编码 = STR_机构编码
		   AND (Z.挂号科室编码 ='000053' OR Z.就诊科室编码='000053')--发热急诊
           AND NOT EXISTS (SELECT 1
                  FROM 病案管理_导出列表 A
                 WHERE A.机构编码 = Z.机构编码
                   AND A.病历号 = Z.门诊病历号
                   AND A.项目编码 = STR_项目编码)
           AND Z.挂号时间 BETWEEN DAT_出院时间起始 AND DAT_出院时间截止
           AND (Z.门诊病历号 LIKE '%' || STR_过滤数据 || '%' OR
               T.姓名 LIKE '%' || STR_过滤数据 || '%');
    ELSE
      NUM_流水码 := STR_流水码;
    END IF;
  
    --返回数据集
    OPEN CUR_导出_列表信息 FOR
    
      SELECT Z.门诊病历号 AS 病历号,
             T.姓名,
             DECODE(T.性别, '1', '男', '2', '女', '未知') AS 性别,
             T.年龄,
             Z.挂号时间 AS 就诊时间,
             NULL AS 出院时间,
             '门诊' AS 就诊类别
        FROM 门诊管理_挂号登记 Z, 基础项目_病人信息 T, 病案管理_导出列表 D
       WHERE Z.机构编码 = T.机构编码
         AND T.机构编码 = D.机构编码
         AND Z.门诊病历号 = D.病历号
         AND Z.病人ID = T.病人ID
         AND Z.机构编码 = STR_机构编码
         AND D.流水码 = NUM_流水码
         AND D.就诊类别 = '门诊';
  
  END;

END PR_数据上报_发热门诊病人集合;
/

prompt
prompt Creating procedure PR_数据上报_发热门诊处方记录
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_数据上报_发热门诊处方记录(STR_参数          IN VARCHAR2,
                                             CUR_导出_列表信息 OUT SYS_REFCURSOR) IS

  STR_机构编码 VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 1);
  /*DAT_出院时间起始 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 2),
                             'yyyy-MM-dd hh24:mi:ss');
  DAT_出院时间截止 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 3),
                             'yyyy-MM-dd hh24:mi:ss');
  STR_过滤数据     VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 4);*/
  STR_项目编码 VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 5);
  STR_流水码   VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 6);
BEGIN
  BEGIN
   IF STR_流水码 IS NULL THEN
      SELECT MAX(流水码)
        INTO STR_流水码
        FROM 病案管理_导出列表
       WHERE 机构编码 = STR_机构编码
         AND 项目编码 = STR_项目编码;
    END IF;  
  
    OPEN CUR_导出_列表信息 FOR
      WITH W_流感检测代码 AS
       (SELECT TT.接口对照信息编码,
               TT.接口对照信息名称,
               TTT.系统对照信息编码
          FROM 病案管理_项目接口对照分类 T,
               病案管理_项目接口对照明细 TT,
               病案管理_项目系统对照明细 TTT
         WHERE T.流水码 = TT.外键ID
           AND TT.流水码 = TTT.外键ID
           AND T.机构编码 = STR_机构编码
           AND T.项目编码 = STR_项目编码
           AND T.分类编码 = 'CV06.00.102')
      
      SELECT G.门诊病历号 AS 病历号,
             G.门诊病历号 AS P7502, --就诊卡号
             G.挂号时间   AS P7506, --就诊日期
             G.门诊病历号 P7000, --门诊就诊流水号
             X.姓名       AS P4,
             Y.处方序号   AS P7800,
             Y.录入时间   AS P7801, --处方开具时间
             -----------------------------处方类别代码开始--------------------
             (CASE
               WHEN (SELECT 毒理分类
                       FROM 基础项目_药品字典
                      WHERE 药品编码 = C.项目编码) IN ('1', '2') THEN
                '7' --'精一'
               WHEN (SELECT 毒理分类
                       FROM 基础项目_药品字典
                      WHERE 药品编码 = C.项目编码) = 3 THEN
                '8' --'精二'
               ELSE
                CASE
                  WHEN G.挂号科室编码 IN (SELECT 科室编码
                                      FROM 基础项目_科室类型列表
                                     WHERE 机构编码 = G.机构编码
                                       AND 删除标志 = '0'
                                       AND 类型编码 = '14') THEN
                   CASE
                     WHEN C.大类编码 = '2' AND C.小类编码 = '1' THEN
                      '5' --'儿科西药'
                     WHEN C.大类编码 = '2' AND C.小类编码 = '3' THEN
                      '6' --'儿科中草药'
                     WHEN C.大类编码 = '2' AND C.小类编码 = '12' THEN
                      '9' --'中药饮片'
                     WHEN C.大类编码 = '2' AND C.小类编码 = '2' THEN
                      '10' --'中成药'
                     ELSE
                      '99' --'其他'
                   END
                  WHEN G.挂号科室编码 IN (SELECT 科室编码
                                      FROM 基础项目_科室类型列表
                                     WHERE 机构编码 = G.机构编码
                                       AND 删除标志 = '0'
                                       AND 类型编码 = '13') THEN
                   CASE
                     WHEN C.大类编码 = '2' AND C.小类编码 = '1' THEN
                      '3' --'急诊西药'
                     WHEN C.大类编码 = '2' AND C.小类编码 = '3' THEN
                      '4' --'急诊中草药'
                     WHEN C.大类编码 = '2' AND C.小类编码 = '12' THEN
                      '9' --'中药饮片'
                     WHEN C.大类编码 = '2' AND C.小类编码 = '2' THEN
                      '10' --'中成药'
                     ELSE
                      '99' --'其他'
                   END
                  ELSE
                   CASE
                     WHEN C.大类编码 = '2' AND C.小类编码 = '1' THEN
                      '1' --'门诊西药'
                     WHEN C.大类编码 = '2' AND C.小类编码 = '3' THEN
                      '2' --'门诊中草药'
                     WHEN C.大类编码 = '2' AND C.小类编码 = '12' THEN
                      '9' --'中药饮片'
                     WHEN C.大类编码 = '2' AND C.小类编码 = '2' THEN
                      '10' --'中成药'
                     ELSE
                      '99' --'其他'
                   END
                END
             END) AS P7802,
             -----------------------------处方类别代码结束--------------------
             
             -----------------------------处方项目分类开始--------------------
             (CASE
               WHEN Y.大类编码 = '2' AND Y.小类编码 = '1' THEN
                '11' --西药
               WHEN Y.大类编码 = '2' AND Y.小类编码 = '2' THEN
                '12' --中成药
               WHEN Y.大类编码 = '2' AND Y.小类编码 = '3' THEN
                '13' --中成药
               WHEN Y.大类编码 = '1' AND Y.小类编码 = '9' THEN
                '21' --治疗
               WHEN Y.大类编码 = '1' AND Y.小类编码 = '1' THEN
                '22' --检验
               WHEN Y.大类编码 = '1' AND Y.小类编码 = '2' THEN
                '23' --检查
               WHEN Y.大类编码 = '1' AND Y.小类编码 = '3' THEN
                '24' --手术
               WHEN Y.大类编码 = '1' AND Y.小类编码 = '18' THEN
                '25' --麻醉
               WHEN Y.大类编码 = '1' AND Y.小类编码 = '8' THEN
                '26' --护理
               WHEN Y.大类编码 = '1' AND Y.小类编码 = '16' THEN
                '28' --输血
               ELSE
                '31' --其他
             END) AS P7803, --处方项目分类代码
             (CASE
               WHEN Y.大类编码 = '2' AND Y.小类编码 = '1' THEN
                '西药' --西药
               WHEN Y.大类编码 = '2' AND Y.小类编码 = '2' THEN
                '中成药' --中成药
               WHEN Y.大类编码 = '2' AND Y.小类编码 = '3' THEN
                '中成药' --中成药
               WHEN Y.大类编码 = '1' AND Y.小类编码 = '9' THEN
                '治疗' --治疗
               WHEN Y.大类编码 = '1' AND Y.小类编码 = '1' THEN
                '检验' --检验
               WHEN Y.大类编码 = '1' AND Y.小类编码 = '2' THEN
                '检查' --检查
               WHEN Y.大类编码 = '1' AND Y.小类编码 = '3' THEN
                '手术' --手术
               WHEN Y.大类编码 = '1' AND Y.小类编码 = '18' THEN
                '麻醉' --麻醉
               WHEN Y.大类编码 = '1' AND Y.小类编码 = '8' THEN
                '护理' --护理
               WHEN Y.大类编码 = '1' AND Y.小类编码 = '16' THEN
                '输血' --输血
               ELSE
                '其他' --其他
             END) AS P7804, --处方项目分类名称
             -----------------------------处方项目分类结束--------------------
             
             C.项目编码 AS P7805,
             C.项目名称 AS P7806,
             (CASE
               WHEN C.大类编码 = '2' AND C.小类编码 = '2' THEN
                '中成药'
               WHEN C.大类编码 = '2' AND C.小类编码 = '3' THEN
                '中草药'
               WHEN C.大类编码 = '2' AND C.小类编码 = '12' THEN
                '其他中药'
               ELSE
                '未使用'
             END) AS P7807, --中药类别名称
             (CASE
               WHEN C.大类编码 = '2' AND C.小类编码 = '2' THEN
                '2'
               WHEN C.大类编码 = '2' AND C.小类编码 = '3' THEN
                '3'
               WHEN C.大类编码 = '2' AND C.小类编码 = '12' THEN
                '9'
               ELSE
                '1'
             END) AS P7808, --中药类别代码
             
             NULL AS P7809, --草药脚注
             NULL AS P7810, --药物类型代码
             NULL AS P7811, --药物类型名称
             C.剂型编码 AS P7812, --药物剂型代码
             C.剂型名称 AS P7813, --药物剂型名称
             C.规格 AS P7814,
             C.频率名称 AS P7815,
             (SELECT A.次数
                FROM 基础项目_频率字典 A
               WHERE A.机构编码 = C.机构编码
                 AND A.频率编码 = C.频率编码) * C.用量 AS P7816,
             C.用量 AS P7817,
             C.剂量名称 AS P7818,
             (SELECT 接口对照信息编码
                FROM W_流感检测代码
               WHERE 系统对照信息编码 = C.用法编码
                 AND ROWNUM = 1) AS P7819, --药物使用-途径代码
             (SELECT 接口对照信息名称
                FROM W_流感检测代码
               WHERE 系统对照信息编码 = C.用法名称
                 AND ROWNUM = 1) AS P7820, --药物使用-途径
             DECODE(Y.皮试标志, '2', '2', '3', '1', '') AS P7821, --皮试判别是否过敏            
             Y.开始时间 AS P7822, --用药开始时间
             NULL AS P7823, --用药截止时间
             Y.天数 AS P7824, --用药天数
             NULL AS P7825, --是否主药
             decode(Y.紧急, '是', '1', '2') AS P7826, --是否加急
             (SELECT A.科室类别
                FROM 基础项目_科室补充资料 A
               WHERE A.机构编码 = y.机构编码
                 AND A.科室编码 = y.开方科室编码) P7827,
             (SELECT A.科室名称
                FROM 基础项目_科室资料 A
               WHERE A.机构编码 = Y.机构编码
                 AND A.科室编码 = Y.开方科室编码) AS P7828, --科室名称
             NULL AS P7829, --是否统一采购药品
             NULL AS P7830, --药品采购吗
             NULL AS P7831, --要管平台吗
             NULL AS P7832 --是否基本用药
        FROM 门诊管理_挂号登记     G,
             基础项目_病人信息     X,
             门诊管理_门诊医嘱     Y,
             门诊管理_门诊医嘱项目 Y1,
             门诊管理_门诊处方     C
       WHERE G.机构编码 = C.机构编码
         AND X.机构编码 = C.机构编码
         AND X.机构编码 = Y.机构编码
         AND Y.机构编码 = Y1.机构编码
         AND G.门诊病历号 = C.门诊病历号
         AND C.门诊病历号 = Y.门诊病历号
         AND Y.项目ID = Y1.项目ID
         AND Y1.计价ID = C.计价ID
         AND G.病人ID = X.病人ID
         AND G.机构编码 = STR_机构编码
         AND EXISTS (SELECT 1
                FROM 病案管理_导出列表 A
               WHERE A.机构编码 = G.机构编码
                 AND A.病历号 = G.门诊病历号
                 AND A.就诊类别 = '门诊'
                 AND A.项目编码 = STR_项目编码
                 AND A.流水码 = STR_流水码);
  
  END;

END PR_数据上报_发热门诊处方记录;
/

prompt
prompt Creating procedure PR_数据上报_发热门诊检查记录
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_数据上报_发热门诊检查记录(STR_参数          IN VARCHAR2,
                                             CUR_导出_列表信息 OUT SYS_REFCURSOR) IS

  STR_机构编码 VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 1);
  /*DAT_出院时间起始 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 2),
                             'yyyy-MM-dd hh24:mi:ss');
  DAT_出院时间截止 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 3),
                             'yyyy-MM-dd hh24:mi:ss');
  STR_过滤数据     VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 4);*/
  STR_项目编码 VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 5);
  STR_流水码   VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 6);
BEGIN
  BEGIN
    IF STR_流水码 IS NULL THEN
      SELECT MAX(流水码)
        INTO STR_流水码
        FROM 病案管理_导出列表
       WHERE 机构编码 = STR_机构编码
         AND 项目编码 = STR_项目编码;
    END IF;
  
    OPEN CUR_导出_列表信息 FOR
      SELECT G.门诊病历号 AS 病历号,
             G.门诊病历号 AS P7502, --就诊卡号
             G.挂号时间 AS P7506, --就诊日期
             G.门诊病历号 P7000, --门诊就诊流水号
             X.姓名 AS P4,
             G.机构编码 AS P7701, --检验机构代码
             '营口经济技术开发区第二人民医院' AS P7702, --检验机构名称
             S.申请单ID AS P7703,
             J.报告单号 AS P7704, --报告单号
             NULL AS P7705, --报告单名称
             J.录入时间 AS P7706, --检验日期
             
             NULL AS P7707, --类别代码
             S.项目编码 AS P7708,
             NULL AS P7709, --类别名称
             S.项目名称 AS P7710,
             M.细项编码 AS P7711,
             M.细项名称 AS P7712,
             NULL AS P7713, --检查部位
             DECODE(M.细项值, '阳性', '1', '2') AS P7714, --结果是否阳性
             J.检查所见 AS P7715,
             decode(M.结论,'L','22','H','21','M','1','') AS P7716, --检查结果异常标识
             J.检查结论 AS P7717
      
        FROM 门诊管理_挂号登记  G,
             基础项目_病人信息  X,
             检验检查_申请      S,
             检验检查_结果      J,
             检验检查_结果_明细 M
       WHERE G.机构编码 = X.机构编码
         AND X.机构编码 = S.机构编码
         AND S.机构编码 = J.机构编码
         AND G.病人ID = X.病人ID
         AND G.门诊病历号 = S.病历号
         AND S.申请单ID = J.申请单ID
         AND J.唯一ID = M.报告单ID
         AND G.机构编码 = STR_机构编码
         AND S.ID类型 = '门诊'
         AND S.类型 = '检查'
         AND EXISTS (SELECT 1
                FROM 病案管理_导出列表 A
               WHERE A.机构编码 = G.机构编码
                 AND A.病历号 = G.门诊病历号
                 AND A.项目编码 = STR_项目编码
                 AND A.流水码 = STR_流水码);
  
  END;

END PR_数据上报_发热门诊检查记录;
/

prompt
prompt Creating procedure PR_数据上报_发热门诊检验记录
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_数据上报_发热门诊检验记录(STR_参数          IN VARCHAR2,
                                             CUR_导出_列表信息 OUT SYS_REFCURSOR) IS

  STR_机构编码 VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 1);
  /*DAT_出院时间起始 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 2),
                             'yyyy-MM-dd hh24:mi:ss');
  DAT_出院时间截止 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 3),
                             'yyyy-MM-dd hh24:mi:ss');
  STR_过滤数据     VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 4);*/
  STR_项目编码 VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 5);
  STR_流水码   VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 6);
BEGIN
  BEGIN
  
    IF STR_流水码 IS NULL THEN
      SELECT MAX(流水码)
        INTO STR_流水码
        FROM 病案管理_导出列表
       WHERE 机构编码 = STR_机构编码
         AND 项目编码 = STR_项目编码;
    END IF;
  
    OPEN CUR_导出_列表信息 FOR
      SELECT G.门诊病历号 as 病历号,
             G.门诊病历号 AS P7502, --就诊卡号
             G.挂号时间 AS P7506, --就诊日期
             G.门诊病历号 P7000, --门诊就诊流水号
             X.姓名 AS P4,
             G.机构编码 AS P7601, --检验机构代码
             '营口经济技术开发区第二人民医院' AS P7602, --检验机构名称
             NULL AS P7603, --检验报告单类别名称
             NULL AS P7604, --检验报告单类别代码
             S.申请单ID AS P7605,
             NULL AS P7606, --检验申请单据名称
             J.录入时间 AS P7607, --检验日期
             J.报告时间 AS P7608, --检验报告日期
             NULL AS P7609, --检验送检日期
             NULL AS P7610, --检验采样日期
             J.样本号 AS P7611,
             J.标本类型 AS P7612,
             S.项目编码 AS P7613,
             S.项目名称 AS P7614,
             
             S.项目编码 AS P7515,
             S.项目名称 AS P7516,
             NULL AS P7617, --检验方法
             M.参考值上限 AS P7618,
             M.单位 AS P7619,
             M.细项值 AS P7620,
             M.结论 AS P7621,
             M.报告单ID AS P7622,
             M.细项编码 AS P7623,
             M.细项名称 AS P7624,
             DECODE(M.结论, 'H', '21', 'L', '22', 'M', '1', '23') AS P7625
      
        FROM 门诊管理_挂号登记  G,
             基础项目_病人信息  X,
             检验检查_申请      S,
             检验检查_结果      J,
             检验检查_结果_明细 M
       WHERE G.机构编码 = X.机构编码
         AND X.机构编码 = S.机构编码
         AND S.机构编码 = J.机构编码
         AND G.病人ID = X.病人ID
         AND G.门诊病历号 = S.病历号
         AND S.申请单ID = J.申请单ID
         AND J.唯一ID = M.报告单ID
         AND G.机构编码 = STR_机构编码
         AND S.ID类型 = '门诊'
         AND S.类型 = '检验'
         AND EXISTS (SELECT 1
                FROM 病案管理_导出列表 A
               WHERE A.机构编码 = G.机构编码
                 AND A.病历号 = G.门诊病历号
                 AND A.项目编码 = STR_项目编码
                 AND A.流水码 = STR_流水码);
  
  END;

END PR_数据上报_发热门诊检验记录;
/

prompt
prompt Creating procedure PR_数据上报_流感病人集合
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE PR_数据上报_流感病人集合(STR_参数          IN VARCHAR2,
                                           CUR_导出_列表信息 OUT SYS_REFCURSOR) IS

  STR_机构编码     VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 1);
  DAT_出院时间起始 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 2),
                             'yyyy-MM-dd hh24:mi:ss');
  DAT_出院时间截止 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 3),
                             'yyyy-MM-dd hh24:mi:ss');
  STR_过滤数据     VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 4);
  STR_项目编码     VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 5);
  STR_流水码       VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 6);

  DAT_导出时间 DATE;
  NUM_流水码   NUMBER;

  STR_是否回传数据 VARCHAR2(50);

BEGIN

  BEGIN
  
    SELECT SYSDATE INTO DAT_导出时间 FROM DUAL;
  
    BEGIN
      SELECT X.是否回传数据
        INTO STR_是否回传数据
        FROM 病案管理_项目信息 X
       WHERE X.机构编码 = STR_机构编码
         AND X.项目编码 = STR_项目编码;
    EXCEPTION
      WHEN OTHERS THEN
        STR_是否回传数据 := '否';
    END;
  
    IF STR_是否回传数据 = '否' THEN
      DELETE FROM 病案管理_导出列表
       WHERE 机构编码 = STR_机构编码
         AND 项目编码 = STR_项目编码;
    END IF;
  
    IF STR_流水码 IS NULL THEN
      SELECT NVL(MAX(流水码), 0) + 1
        INTO NUM_流水码
        FROM 病案管理_导出列表;
    
      INSERT INTO 病案管理_导出列表
        (机构编码,
         病历号,
         起始时间,
         截止时间,
         导出时间,
         流水码,
         就诊类别,
         项目编码)
        SELECT STR_机构编码,
               Z.门诊病历号,
               DAT_出院时间起始,
               DAT_出院时间截止,
               DAT_导出时间,
               NUM_流水码,
               '门诊' AS 就诊类别,
               STR_项目编码
          FROM 门诊管理_挂号登记 Z, 基础项目_病人信息 T
         WHERE Z.机构编码 = T.机构编码
           AND Z.病人ID = T.病人ID
           AND Z.机构编码 = STR_机构编码
           AND NOT EXISTS (SELECT 1
                  FROM 病案管理_导出列表 A
                 WHERE A.机构编码 = Z.机构编码
                   AND A.病历号 = Z.门诊病历号
                   AND A.项目编码 = STR_项目编码)
           AND Z.挂号时间 BETWEEN DAT_出院时间起始 AND DAT_出院时间截止
           AND (Z.门诊病历号 LIKE '%' || STR_过滤数据 || '%' OR
               T.姓名 LIKE '%' || STR_过滤数据 || '%')
           AND (REGEXP_LIKE((SELECT B.ICD码
                              FROM 基础项目_疾病字典 B
                             WHERE B.疾病编码 = Z.疾病编码),
                            '^(J[0-9]{2})') OR EXISTS
                (SELECT 1
                   FROM 门诊管理_门诊医嘱项目 C
                  WHERE C.机构编码 = Z.机构编码
                    AND C.门诊病历号 = Z.门诊病历号
                    AND C.大类编码 = '2'
                    AND REGEXP_LIKE(C.项目名称,
                                    '(奥司他韦|扎那米韦|帕拉米韦|阿比朵尔|阿比多尔|金刚烷胺|金刚乙胺|利巴韦林)'))
               
               )
        
        UNION
        
        SELECT STR_机构编码,
               Z.住院病历号,
               DAT_出院时间起始,
               DAT_出院时间截止,
               DAT_导出时间,
               NUM_流水码,
               '在院' AS 就诊类别,
               STR_项目编码
          FROM 住院管理_在院病人信息 Z, 住院管理_病案首页 T
         WHERE Z.机构编码 = T.机构编码
           AND Z.住院病历号 = T.住院病历号
           AND Z.机构编码 = STR_机构编码
           AND NOT EXISTS
         (SELECT 1
                  FROM 病案管理_导出列表 A
                 WHERE A.机构编码 = Z.机构编码
                   AND A.病历号 = Z.住院病历号
                   AND A.项目编码 = STR_项目编码)
           AND T.入院日期 BETWEEN DAT_出院时间起始 AND DAT_出院时间截止
           AND (T.住院病历号 LIKE '%' || STR_过滤数据 || '%' OR
               T.病案号 LIKE '%' || STR_过滤数据 || '%' OR
               T.病人姓名 LIKE '%' || STR_过滤数据 || '%')
           AND (EXISTS (SELECT 1
                          FROM 住院管理_在院病人诊断 A
                         WHERE REGEXP_LIKE((CASE
                                             WHEN A.ICD码 = A.疾病编码 THEN
                                              (SELECT B.ICD码
                                                 FROM 基础项目_疾病字典 B
                                                WHERE B.疾病编码 = A.疾病编码)
                                             ELSE
                                              A.ICD码
                                           END),
                                           '^(J[0-9]{2})')
                           AND A.机构编码 = T.机构编码
                           AND A.住院病历号 = Z.住院病历号) OR EXISTS
                (SELECT 1
                   FROM 门诊管理_门诊医嘱项目 C
                  WHERE C.机构编码 = Z.机构编码
                    AND C.门诊病历号 = Z.住院病历号
                    AND C.大类编码 = '2'
                    AND REGEXP_LIKE(C.项目名称,
                                    '(奥司他韦|扎那米韦|帕拉米韦|阿比朵尔|阿比多尔|金刚烷胺|金刚乙胺|利巴韦林)')))
        
        UNION
        
        SELECT STR_机构编码,
               Z.住院病历号,
               DAT_出院时间起始,
               DAT_出院时间截止,
               DAT_导出时间,
               NUM_流水码,
               '出院' AS 就诊类别,
               STR_项目编码
          FROM 住院管理_出院病人信息 Z, 住院管理_病案首页 T
         WHERE Z.机构编码 = T.机构编码
           AND Z.住院病历号 = T.住院病历号
           AND Z.机构编码 = STR_机构编码
           AND NOT EXISTS
         (SELECT 1
                  FROM 病案管理_导出列表 A
                 WHERE A.机构编码 = Z.机构编码
                   AND A.病历号 = Z.住院病历号
                   AND A.项目编码 = STR_项目编码)
           AND T.出院日期 BETWEEN DAT_出院时间起始 AND DAT_出院时间截止
           AND (T.住院病历号 LIKE '%' || STR_过滤数据 || '%' OR
               T.病案号 LIKE '%' || STR_过滤数据 || '%' OR
               T.病人姓名 LIKE '%' || STR_过滤数据 || '%')
           AND (EXISTS (SELECT 1
                          FROM 住院管理_在院病人诊断 A
                         WHERE REGEXP_LIKE((CASE
                                             WHEN A.ICD码 = A.疾病编码 THEN
                                              (SELECT B.ICD码
                                                 FROM 基础项目_疾病字典 B
                                                WHERE B.疾病编码 = A.疾病编码)
                                             ELSE
                                              A.ICD码
                                           END),
                                           '^(J[0-9]{2})')
                           AND A.机构编码 = T.机构编码
                           AND A.住院病历号 = Z.住院病历号) OR EXISTS
                (SELECT 1
                   FROM 门诊管理_门诊医嘱项目 C
                  WHERE C.机构编码 = Z.机构编码
                    AND C.门诊病历号 = Z.住院病历号
                    AND C.大类编码 = '2'
                    AND REGEXP_LIKE(C.项目名称,
                                    '(奥司他韦|扎那米韦|帕拉米韦|阿比朵尔|阿比多尔|金刚烷胺|金刚乙胺|利巴韦林)')));
    ELSE
      NUM_流水码 := STR_流水码;
    END IF;
  
    --返回数据集
    OPEN CUR_导出_列表信息 FOR
    
      SELECT Z.门诊病历号 AS 病历号,
             T.姓名,
             DECODE(T.性别, '1', '男', '2', '女', '未知') AS 性别,
             T.年龄,
             Z.挂号时间 AS 就诊时间,
             NULL AS 出院时间,
             '门诊' AS 就诊类别
        FROM 门诊管理_挂号登记 Z, 基础项目_病人信息 T, 病案管理_导出列表 D
       WHERE Z.机构编码 = T.机构编码
         AND T.机构编码 = D.机构编码
         AND Z.门诊病历号 = D.病历号
         AND Z.病人ID = T.病人ID
         AND Z.机构编码 = STR_机构编码
         AND D.流水码 = NUM_流水码
         AND D.就诊类别 = '门诊'
      
      UNION
      
      SELECT Z.住院病历号 AS 病历号,
             Z.病人姓名 AS 姓名,
             DECODE(Z.性别, '1', '男', '2', '女', '未知') AS 性别,
             Z.年龄,
             Z.入院时间 AS 就诊时间,
             NULL AS 出院时间,
             '在院' AS 就诊类别
        FROM 住院管理_在院病人信息 Z,
             住院管理_病案首页     T,
             病案管理_导出列表     D
       WHERE Z.机构编码 = T.机构编码
         AND T.机构编码 = D.机构编码
         AND Z.住院病历号 = D.病历号
         AND Z.住院病历号 = T.住院病历号
         AND Z.机构编码 = STR_机构编码
         AND D.流水码 = NUM_流水码
         AND D.就诊类别 = '在院'
      
      UNION
      
      SELECT Z.住院病历号 AS 病历号,
             Z.病人姓名 AS 姓名,
             DECODE(Z.性别, '1', '男', '2', '女', '未知') AS 性别,
             Z.年龄,
             Z.入院时间 AS 就诊时间,
             Z.出院时间 AS 出院时间,
             '出院' AS 就诊类别
        FROM 住院管理_出院病人信息 Z,
             住院管理_病案首页     T,
             病案管理_导出列表     D
       WHERE Z.机构编码 = T.机构编码
         AND T.机构编码 = D.机构编码
         AND Z.住院病历号 = D.病历号
         AND Z.住院病历号 = T.住院病历号
         AND Z.机构编码 = STR_机构编码
         AND D.流水码 = NUM_流水码
         AND D.就诊类别 = '出院';
  
  END;

END PR_数据上报_流感病人集合;

/

prompt
prompt Creating procedure PR_数据上报_流感出院病历
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_数据上报_流感出院病历(STR_参数          IN VARCHAR2,
                                           CUR_导出_列表信息 OUT SYS_REFCURSOR) IS
  STR_SQL VARCHAR2(1000);

  STR_机构编码 VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 1);
  /*DAT_出院时间起始 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 2),
                             'yyyy-MM-dd hh24:mi:ss');
  DAT_出院时间截止 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 3),
                             'yyyy-MM-dd hh24:mi:ss');
  STR_过滤数据     VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 4);*/
  STR_项目编码 VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 5);
  STR_流水码   VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 6);

  --获取诊断记录CURSOR
  CURSOR CUR_诊断记录 IS
    SELECT *
      FROM (SELECT ROW_NUMBER() OVER(PARTITION BY T.住院病历号, T.诊断类型 ORDER BY T.诊断类型, T.是否主诊断 DESC) RN,
                   T.住院病历号,
                   (CASE
                     WHEN T.ICD码 = T.疾病编码 THEN
                      (SELECT B.ICD码
                         FROM 基础项目_疾病字典 B
                        WHERE B.疾病编码 = T.疾病编码)
                     ELSE
                      T.ICD码
                   END) ICD码,
                   T.疾病名称,
                   T.入院病情,
                   T.出院情况,
                   T.病理号,
                   T.入院时情况,
                   T.入院后确诊日期,
                   T.诊断类型
              FROM 住院管理_在院病人诊断 T,
                   住院管理_出院病人信息 TT,
                   住院管理_病案首页     TTT
             WHERE T.住院病历号 = TT.住院病历号
               AND T.住院病历号 = TTT.住院病历号
               AND T.机构编码 = STR_机构编码
               AND EXISTS (SELECT 1
                      FROM 病案管理_导出列表 A
                     WHERE A.机构编码 = T.机构编码
                       AND A.病历号 = T.住院病历号
                       AND A.就诊类别 = '出院'
                       AND A.项目编码 = STR_项目编码
                       AND A.流水码 = STR_流水码)) G
     WHERE (G.诊断类型 = '其他诊断' AND G.RN <= 10)
        OR (G.诊断类型 IN ('损伤和中毒外部原因', '病理诊断') AND G.RN <= 3)
        OR (G.诊断类型 IN ('入院诊断', '出院诊断') AND G.RN = 1);
  ROW_诊断记录 CUR_诊断记录%ROWTYPE;

  --获取手术记录CURSOR
  CURSOR CUR_手术记录 IS
    SELECT *
      FROM (SELECT ROW_NUMBER() OVER(PARTITION BY T.住院病历号 ORDER BY T.流水码 DESC) RN,
                   T.住院病历号,
                   T.国标码,
                   T.手术操作日期,
                   T.手术级别编码,
                   T.手术操作名称,
                   --手术操作部分
                   --手术持续时间
                   (SELECT A.人员姓名
                      FROM 基础项目_人员资料 A
                     WHERE A.机构编码 = T.机构编码
                       AND A.删除标志 = '0'
                       AND A.人员编码 = T.术者) AS 术者,
                   (SELECT A.人员姓名
                      FROM 基础项目_人员资料 A
                     WHERE A.机构编码 = T.机构编码
                       AND A.删除标志 = '0'
                       AND A.人员编码 = T.I助) AS I助,
                   (SELECT A.人员姓名
                      FROM 基础项目_人员资料 A
                     WHERE A.机构编码 = T.机构编码
                       AND A.删除标志 = '0'
                       AND A.人员编码 = T.II助) AS II助,
                   T.麻醉方式编码,
                   T.麻醉分级编码,
                   T.切口愈合等级编码,
                   (SELECT A.人员姓名
                      FROM 基础项目_人员资料 A
                     WHERE A.机构编码 = T.机构编码
                       AND A.删除标志 = '0'
                       AND A.人员编码 = T.麻醉医师) AS 麻醉医师
              FROM 住院管理_病案首页手术表 T,
                   住院管理_出院病人信息   TT,
                   住院管理_病案首页       TTT
             WHERE T.住院病历号 = TT.住院病历号
               AND T.住院病历号 = TTT.住院病历号
               AND T.机构编码 = STR_机构编码
               AND EXISTS (SELECT 1
                      FROM 病案管理_导出列表 A
                     WHERE A.机构编码 = T.机构编码
                       AND A.病历号 = T.住院病历号
                       AND A.就诊类别 = '出院'
                       AND A.项目编码 = STR_项目编码
                       AND A.流水码 = STR_流水码)) G
     WHERE G.RN <= 7;

  ROW_手术记录 CUR_手术记录%ROWTYPE;

  --获取费用记录CURSOR
  CURSOR CUR_费用记录 IS
    SELECT T.机构编码,
           T.住院病历号,
           SUM(T.归类金额) AS 总金额,
           (SELECT (A.实收金额 - A.总补偿金额)
              FROM 住院管理_出院病人发票登记 A
             WHERE A.机构编码 = STR_机构编码
               AND A.住院病历号 = T.住院病历号
               AND A.召回标志 = '否') AS 自付金额,
           NVL(SUM(CASE T.归类编码
                     WHEN '10001' THEN
                      T.归类金额
                   END),
               0) AS 一般医疗服务费总,
           NVL(SUM(CASE T.归类编码
                     WHEN '10002' THEN
                      T.归类金额
                   END),
               0) AS 一般治疗操作费,
           NVL(SUM(CASE T.归类编码
                     WHEN '10003' THEN
                      T.归类金额
                   END),
               0) AS 护理费,
           NVL(SUM(CASE T.归类编码
                     WHEN '10004' THEN
                      T.归类金额
                   END),
               0) AS 综合医疗服务类其他费用,
           NVL(SUM(CASE T.归类编码
                     WHEN '10005' THEN
                      T.归类金额
                   END),
               0) AS 病理诊断费,
           NVL(SUM(CASE T.归类编码
                     WHEN '10006' THEN
                      T.归类金额
                   END),
               0) AS 实验室诊断费,
           NVL(SUM(CASE T.归类编码
                     WHEN '10007' THEN
                      T.归类金额
                   END),
               0) AS 影像学诊断费,
           NVL(SUM(CASE T.归类编码
                     WHEN '10008' THEN
                      T.归类金额
                   END),
               0) AS 临床诊断项目费,
           NVL(SUM(CASE T.归类编码
                     WHEN '10009' THEN
                      T.归类金额
                     WHEN '10010' THEN
                      T.归类金额
                   END),
               0) AS 非手术治疗项目费,
           NVL(SUM(CASE T.归类编码
                     WHEN '10010' THEN
                      T.归类金额
                   END),
               0) AS 其中_临床物理治疗费,
           NVL(SUM(CASE T.归类编码
                     WHEN '10011' THEN
                      T.归类金额
                     WHEN '10012' THEN
                      T.归类金额
                     WHEN '10013' THEN
                      T.归类金额
                   END),
               0) AS 手术治疗费,
           NVL(SUM(CASE T.归类编码
                     WHEN '10012' THEN
                      T.归类金额
                   END),
               0) AS 其中_麻醉费,
           NVL(SUM(CASE T.归类编码
                     WHEN '10013' THEN
                      T.归类金额
                   END),
               0) AS 其中_手术费,
           NVL(SUM(CASE T.归类编码
                     WHEN '10014' THEN
                      T.归类金额
                   END),
               0) AS 康复费,
           NVL(SUM(CASE T.归类编码
                     WHEN '10015' THEN
                      T.归类金额
                   END),
               0) AS 中医治疗费,
           NVL(SUM(CASE T.归类编码
                     WHEN '10016' THEN
                      T.归类金额
                     WHEN '10017' THEN
                      T.归类金额
                   END),
               0) AS 西药费,
           NVL(SUM(CASE T.归类编码
                     WHEN '10017' THEN
                      T.归类金额
                   END),
               0) AS 其中_抗菌药物费,
           NVL(SUM(CASE T.归类编码
                     WHEN '10018' THEN
                      T.归类金额
                   END),
               0) AS 中成药费,
           NVL(SUM(CASE T.归类编码
                     WHEN '10019' THEN
                      T.归类金额
                   END),
               0) AS 中草药费,
           NVL(SUM(CASE T.归类编码
                     WHEN '10020' THEN
                      T.归类金额
                   END),
               0) AS 血费,
           NVL(SUM(CASE T.归类编码
                     WHEN '10021' THEN
                      T.归类金额
                   END),
               0) AS 白蛋白类制品费,
           NVL(SUM(CASE T.归类编码
                     WHEN '10022' THEN
                      T.归类金额
                   END),
               0) AS 球蛋白类制品费,
           NVL(SUM(CASE T.归类编码
                     WHEN '10023' THEN
                      T.归类金额
                   END),
               0) AS 凝血因子类制品费,
           NVL(SUM(CASE T.归类编码
                     WHEN '10024' THEN
                      T.归类金额
                   END),
               0) AS 细胞因子类制品费,
           NVL(SUM(CASE T.归类编码
                     WHEN '10025' THEN
                      T.归类金额
                   END),
               0) AS 检查用一次性医用材料费,
           NVL(SUM(CASE T.归类编码
                     WHEN '10026' THEN
                      T.归类金额
                   END),
               0) AS 治疗用一次性医用材料费,
           NVL(SUM(CASE T.归类编码
                     WHEN '10027' THEN
                      T.归类金额
                   END),
               0) AS 手术用一次性医用材料费,
           NVL(SUM(CASE T.归类编码
                     WHEN '10028' THEN
                      T.归类金额
                   END),
               0) AS 其他费
      FROM (SELECT ZT.编码       AS 归类编码,
                   ZT.名称       AS 归类名称,
                   ZZ.总金额     AS 归类金额,
                   ZZ.机构编码,
                   ZZ.住院病历号,
                   ZZ.记账时间
              FROM 基础项目_字典明细 ZT
              LEFT JOIN (SELECT SUM(总金额) AS 总金额,
                               西医病案编码,
                               机构编码,
                               住院病历号,
                               记账时间
                          FROM (SELECT A.总金额 AS 总金额,
                                       NVL(Z.BAGLBM, '10028') AS 西医病案编码,
                                       A.机构编码,
                                       A.住院病历号,
                                       A.记账时间
                                  FROM 住院管理_出院病人处方 A
                                  LEFT JOIN JCXM_ZLZD_FJXM Z
                                    ON A.机构编码 = Z.JGBM
                                   AND A.项目编码 = Z.XMBM
                                 WHERE A.机构编码 = STR_机构编码
                                   AND A.大类编码 = '1'
                                
                                UNION ALL
                                
                                SELECT A.总金额 AS 总金额,
                                       NVL(Y.BAGLBM, '10028') AS 西医病案编码,
                                       A.机构编码,
                                       A.住院病历号,
                                       A.记账时间
                                  FROM 住院管理_出院病人处方 A
                                  LEFT JOIN JCXM_YPZD_FJSX Y
                                    ON A.机构编码 = Y.JGBM
                                   AND A.项目编码 = Y.YPBM
                                 WHERE A.机构编码 = STR_机构编码
                                   AND A.大类编码 = '2')
                         GROUP BY 机构编码,
                                  住院病历号,
                                  记账时间,
                                  西医病案编码) ZZ
                ON ZT.编码 = ZZ.西医病案编码
             WHERE ZT.分类编码 = 'GB_009001'
               AND ZT.有效状态 = '有效'
               AND ZT.删除标志 = '0'
               AND ZT.名称 LIKE '西医病案_%') T,
           住院管理_出院病人信息 TT,
           住院管理_病案首页 TTT
     WHERE T.住院病历号 = TT.住院病历号
       AND T.住院病历号 = TTT.住院病历号
       AND EXISTS (SELECT 1
              FROM 病案管理_导出列表 A
             WHERE A.机构编码 = T.机构编码
               AND A.病历号 = T.住院病历号
               AND A.就诊类别 = '出院'
               AND A.项目编码 = STR_项目编码
               AND A.流水码 = STR_流水码)
     GROUP BY T.机构编码, T.住院病历号;

  ROW_费用记录 CUR_费用记录%ROWTYPE;

  --获取重症监护记录CURSOR
  CURSOR CUR_重症监护记录 IS
    SELECT *
      FROM (SELECT ROW_NUMBER() OVER(PARTITION BY T.住院病历号 ORDER BY T.流水码 DESC) RN,
                   T.科室名称,
                   T.进入时间,
                   T.退出时间,
                   T.住院病历号
              FROM 住院管理_病案首页_重症监护 T,
                   住院管理_出院病人信息      TT,
                   住院管理_病案首页          TTT
             WHERE T.住院病历号 = TT.住院病历号
               AND T.住院病历号 = TTT.住院病历号
               AND EXISTS (SELECT 1
                      FROM 病案管理_导出列表 A
                     WHERE A.机构编码 = T.机构编码
                       AND A.病历号 = T.住院病历号
                       AND A.就诊类别 = '出院'
                       AND A.项目编码 = STR_项目编码
                       AND A.流水码 = STR_流水码)) G
     WHERE G.RN <= 5;

  ROW_重症监护记录 CUR_重症监护记录%ROWTYPE;

BEGIN

  BEGIN
    
   IF STR_流水码 IS NULL THEN
      SELECT MAX(流水码)
        INTO STR_流水码
        FROM 病案管理_导出列表
       WHERE 机构编码 = STR_机构编码
         AND 项目编码 = STR_项目编码;
    END IF;
  
    DELETE FROM 临时表_数据上报_出院流感病例;
  
    --更新基本信息
    INSERT INTO 临时表_数据上报_出院流感病例
      (病历号,
       P900, --医疗机构编码
       P6891, --机构名称
       P686, --医疗保险手册（卡）号
       P800, --健康卡号
       P1, --医疗付款方式
       P2, --住院次数
       P3, --病案号
       P4, --姓名
       P5, --性别
       P6, --出生日期
       P7, --年龄
       P8, --婚姻状况
       P9, --职业
       P101, --出生省份
       P102, --出生地市
       P103, --出生地县
       P11, --民族
       P12, --国籍
       P13, --身份证号
       P801, --现住址
       P802, --住宅电话
       P803, --现住址邮政编码
       P14, --工作单位及地址
       P15, --电话
       P16, --工作单位邮政编码
       P17, --户口地址
       P171, --户口所在地邮政编码
       P18, --联系人姓名
       P19, --关系
       P20, --联系人地址
       P804, --入院途径
       P21, --联系人电话
       P22, --入院日期
       P23, --入院科别
       P231, --入院病室
       P24, --转科科别
       P25, --出院日期
       P26, --出院科别
       P261, --出院病室
       P27, --实际住院天数
       P28, --门（急）诊诊断编码
       P281, --门（急）诊诊断描述
       
       --诊断相关
       P372, --过敏药物名称
       P38, --HBSAG
       P39, --HCV-AB
       P40, --HIV-AB
       P411, --门诊与出院诊断符合情况
       P412, --入院与出院诊断符合情况
       P413, --术前与术后诊断符合情况
       P414, --临床与病理诊断符合情况
       P415, --放射与病理诊断符合情况
       P421, --抢救次数
       P422, --抢救成功次数
       P687, --最高诊断依据
       P688, --分化程度
       
        P431, --科主任
       P432, --主(副主)任医师
       P433, --主治医师
       P434, --住院医师
       P819, --责任护士
       P435, --进修医师
       P436, --研究生实习医师
       P437, --实习医师
       P438, --编码员
       P44, --病案质量
       P45, --质控医师
       P46, --质控护师
       P47, --质控日期
       
       --手术
       
       P561, --特级护理天数
       P562, --一级护理天数
       P563, --二级护理天数
       P564, --三级护理天数
       
       --重症监护数据
       P57, --死亡患者尸检
       P58, --手术、治疗、检查、诊断为本院第一例
       P581, --手术患者类型
       P60, --随诊
       P611, --随诊周数
       P612, --随诊月数
       P613, --随诊年数
       P59, --示教病例
       P62, --ABO血型
       P63, --RH血型
       P64, --输血反应
       P651, --红细胞
       P652, --血小板
       P653, --血浆
       P654, --全血
       P655, --自体回收
       P656, --其它
       
       P66, --（婴幼儿）年龄
       P681, --新生儿出生体重1
       P67, --新生儿入院体重
       P731, --入院前多少小时(昏迷时间)
       P732, --入院前多少分钟(昏迷时间)
       P733, --入院后多少小时(昏迷时间)
       P734, --入院后多少分钟(昏迷时间)
       P72, --呼吸机使用时间
       P830, --是否有出院31天内再住院计划
       P831, --出院31天再住院计划目的
       P741, --离院方式
       P742, --转入医院名称
       P743 --社区服务机构名称
       )
      SELECT T.住院病历号,
             T.机构编码,
             '营口经济技术开发区第二人民医院' AS 机构名称,
             NULL,
             T.健康卡号,
             T.医疗付费方式,
             T.住院次数,
             T.病案号,
             T.病人姓名,
             NVL(T.性别, '0'),
             T.出生日期,
             TO_NUMBER(REGEXP_REPLACE(T.年龄, '[^-0-9.]', '')) 年龄,
             decode(T.婚姻,'4','9',T.婚姻),
             T.职业,
             T.出生地省,
             T.出生地市,
             T.出生地县,
             T.民族,
             T.国籍,
             T.身份证号,
             T.现住址,
             T.户口电话,
             SUBSTR(T.现住址邮编, 0, 6),
             T.工作单位地址,
             T.工作电话,
             SUBSTR(T.工作邮政编码, 0, 6),
             T.户口地址,
             SUBSTR(T.户口邮政编码, 0, 6),
             T.联系人姓名,
             T.关系,
             T.联系人地址,
             DECODE(T.入院途径,'9','4',T.入院途径),
             T.联系人电话,
             T.入院日期,
             (SELECT A.科室类别
                FROM 基础项目_科室补充资料 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.科室编码 = T.入院科室编码) 入院科室编码,
             T.入院病室,
             (SELECT 转出科室编码
                FROM 住院管理_在院病人转科记录
               WHERE 机构编码 = STR_机构编码
                 AND 住院病历号 = T.住院病历号
                 AND ROWNUM = 1) 转科科别,
             T.出院日期,
             (SELECT A.科室类别
                FROM 基础项目_科室补充资料 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.科室编码 = T.出院科室编码) 出院科室编码,
             T.出院病室,
             T.住院天数,
             (SELECT (CASE
                       WHEN A.ICD码 = A.疾病编码 THEN
                        (SELECT B.ICD码
                           FROM 基础项目_疾病字典 B
                          WHERE B.疾病编码 = A.疾病编码)
                       ELSE
                        A.ICD码
                     END) ICD码
                FROM 住院管理_在院病人诊断 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.住院病历号 = T.住院病历号
                 AND A.诊断类型 = '门诊诊断'
                 AND A.诊断分类 = '1'
                 AND ROWNUM = 1) AS 疾病编码,
             (SELECT A.疾病名称
                FROM 住院管理_在院病人诊断 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.住院病历号 = T.住院病历号
                 AND A.诊断类型 = '门诊诊断'
                 AND A.诊断分类 = '1'
                 AND ROWNUM = 1) AS 门诊诊断名称,
             
             --省略若干诊断
           
             T.过敏药物,
             T.HBSAG,
             T.HCV_AB,
             T.HIV_AB,
             DECODE(T.门诊与出院, '符合', '1', '不符合', '2', '9'), --门诊与出院诊断符合情况
             DECODE(T.入院与出院, '符合', '1', '不符合', '2', '9'), --入院与出院诊断符合情况
             DECODE(T.术前与术后, '符合', '1', '不符合', '2', '9'), --术前与术后诊断符合情况
             DECODE(T.临床与病理, '符合', '1', '不符合', '2', '9'), --临床与病理诊断符合情况
             DECODE(T.放射与病理, '符合', '1', '不符合', '2', '9'), --放射与病理诊断符合情况
             T.抢救次数,
             T.成功次数,
             NULL, --最高诊断依据
             NULL, --分化程度
             
             (SELECT 人员姓名
                FROM 基础项目_人员资料
               WHERE 机构编码 = T.机构编码
                 AND 删除标志 = '0'
                 AND 人员编码 = T.科主任) AS 科主任,
             (SELECT 人员姓名
                FROM 基础项目_人员资料
               WHERE 机构编码 = T.机构编码
                 AND 删除标志 = '0'
                 AND 人员编码 = T.主任医师) AS 主任医师,
             (SELECT 人员姓名
                FROM 基础项目_人员资料
               WHERE 机构编码 = T.机构编码
                 AND 删除标志 = '0'
                 AND 人员编码 = T.主治医师) AS 主治医师,
             (SELECT 人员姓名
                FROM 基础项目_人员资料
               WHERE 机构编码 = T.机构编码
                 AND 删除标志 = '0'
                 AND 人员编码 = T.住院医师) AS 住院医师,
             (SELECT 人员姓名
                FROM 基础项目_人员资料
               WHERE 机构编码 = T.机构编码
                 AND 删除标志 = '0'
                 AND 人员编码 = T.责任护士) AS 责任护士,
             (SELECT 人员姓名
                FROM 基础项目_人员资料
               WHERE 机构编码 = T.机构编码
                 AND 删除标志 = '0'
                 AND 人员编码 = T.进修医师) AS 进修医师,
             (SELECT 人员姓名
                FROM 基础项目_人员资料
               WHERE 机构编码 = T.机构编码
                 AND 删除标志 = '0'
                 AND 人员编码 = T.研究生实习医师) AS 研究生实习医师,
             (SELECT 人员姓名
                FROM 基础项目_人员资料
               WHERE 机构编码 = T.机构编码
                 AND 删除标志 = '0'
                 AND 人员编码 = T.实习医师) AS 实习医师,
             (SELECT 人员姓名
                FROM 基础项目_人员资料
               WHERE 机构编码 = T.机构编码
                 AND 删除标志 = '0'
                 AND 人员编码 = T.编码员) AS 编码员,
             T.病案质量,
             (SELECT 人员姓名
                FROM 基础项目_人员资料
               WHERE 机构编码 = T.机构编码
                 AND 删除标志 = '0'
                 AND 人员编码 = T.质控医生) AS 质控医生,
             (SELECT 人员姓名
                FROM 基础项目_人员资料
               WHERE 机构编码 = T.机构编码
                 AND 删除标志 = '0'
                 AND 人员编码 = T.质控护士) AS 质控护士,
             
             TRUNC(TO_DATE(T.质控日期, 'yyyy-MM-dd hh24:mi:ss')) 质控日期,
             
             --省略若干手术
             
             T.特级护理天数,
             T.一级护理天数,
             T.二级护理天数,
             T.三级护理天数,
             
             --重症监护数据
             T.尸检,
             T.是否本院第一例,
             NULL, --手术患者类型
             
             T.随诊,
             T.随诊期限周,
             T.随诊期限月,
             T.随诊期限年,
             T.示教病例,
             T.血型,
             T.RH,
             T.输血反应,
             T.红细胞,
             T.血小板,
             T.血浆,
             T.全血,
             T.自体血回输,
             T.其它,
             
             TO_NUMBER(REGEXP_REPLACE(T.年龄不足1周岁, '[^-0-9.]', '')) 年龄不足1周岁,
             (CASE
               WHEN TO_NUMBER(T.入院日期 - T.出生日期) < 28 THEN
                REGEXP_REPLACE(T.新生儿出生体重, '[^-0-9.]', '')
               ELSE
                ''
             END) AS 新生儿出生体重,
             (CASE
               WHEN TO_NUMBER(T.入院日期 - T.出生日期) < 28 THEN
                REGEXP_REPLACE(T.新生儿入院体重, '[^-0-9.]', '')
               ELSE
                ''
             END) AS 新生儿入院体重,
             
             TO_NUMBER(REGEXP_REPLACE(颅脑损伤患者昏迷时间入院前小时,
                                      '[^-0-9.]',
                                      '')) 颅脑损伤患者昏迷时间入院前小时,
             TO_NUMBER(REGEXP_REPLACE(颅脑损伤患者昏迷时间入院前分钟,
                                      '[^-0-9.]',
                                      '')) 颅脑损伤患者昏迷时间入院前分钟,
             TO_NUMBER(REGEXP_REPLACE(颅脑损伤患者昏迷时间入院后小时,
                                      '[^-0-9.]',
                                      '')) 颅脑损伤患者昏迷时间入院后小时,
             TO_NUMBER(REGEXP_REPLACE(颅脑损伤患者昏迷时间入院分钟,
                                      '[^-0-9.]',
                                      '')) 颅脑损伤患者昏迷时间入院分钟,
             T.有创呼吸机使用时间,
             T.是否有出院31天在住院计划,
             T.目的,
             T.离院方式,
             T.医嘱转院,
             T.医嘱转卫生服务机构     
        FROM 住院管理_病案首页 T, 住院管理_出院病人信息 TT
       WHERE T.住院病历号 = TT.住院病历号
         AND T.机构编码 = STR_机构编码
         AND EXISTS (SELECT 1
                FROM 病案管理_导出列表 A
               WHERE A.机构编码 = T.机构编码
                 AND A.病历号 = T.住院病历号
                 AND A.就诊类别 = '出院'
                 AND A.项目编码 = STR_项目编码
                 AND A.流水码 = STR_流水码);
  END;

  --更新诊断记录信息
  FOR ROW_诊断记录 IN CUR_诊断记录 LOOP
    EXIT WHEN CUR_诊断记录%NOTFOUND;
    IF ROW_诊断记录.诊断类型 = '出院诊断' THEN
      STR_SQL := 'UPDATE 临时表_数据上报_出院流感病例 SET P321=:1,P322=:2,P805=:3,P323=:4 WHERE 病历号=:5';
      EXECUTE IMMEDIATE STR_SQL
        USING ROW_诊断记录.ICD码, ROW_诊断记录.疾病名称, ROW_诊断记录.入院病情, ROW_诊断记录.出院情况, ROW_诊断记录.住院病历号;
    ELSIF ROW_诊断记录.诊断类型 = '入院诊断' THEN
      STR_SQL := 'UPDATE 临时表_数据上报_出院流感病例 SET P30=:1,P301=:2,P29=:3,P31=:4 WHERE 病历号=:5';
      EXECUTE IMMEDIATE STR_SQL
        USING ROW_诊断记录.ICD码, ROW_诊断记录.疾病名称, ROW_诊断记录.入院时情况, ROW_诊断记录.入院后确诊日期, ROW_诊断记录.住院病历号;
    ELSIF ROW_诊断记录.诊断类型 = '其他诊断' THEN
      STR_SQL := 'UPDATE 临时表_数据上报_出院流感病例 SET QTZDBM' || ROW_诊断记录.RN ||
                 '=:1,QTZDMS' || ROW_诊断记录.RN || '=:2,QTZDRYBQ' ||
                 ROW_诊断记录.RN || '=:3,QTZDCYQK' || ROW_诊断记录.RN ||
                 '=:4 WHERE 病历号=:5';
      EXECUTE IMMEDIATE STR_SQL
        USING ROW_诊断记录.ICD码, ROW_诊断记录.疾病名称, ROW_诊断记录.入院病情, ROW_诊断记录.出院情况, ROW_诊断记录.住院病历号;
    ELSIF ROW_诊断记录.诊断类型 = '损伤和中毒外部原因' THEN
      STR_SQL := 'UPDATE 临时表_数据上报_出院流感病例 SET WBYSBM' || ROW_诊断记录.RN ||
                 '=:1,WBYSMC' || ROW_诊断记录.RN ||
                 '=:2 WHERE 病历号=:3';
      EXECUTE IMMEDIATE STR_SQL
        USING ROW_诊断记录.ICD码, ROW_诊断记录.疾病名称, ROW_诊断记录.住院病历号;
    ELSIF ROW_诊断记录.诊断类型 = '病理诊断' THEN
      STR_SQL := 'UPDATE 临时表_数据上报_出院流感病例 SET BLZDBM' || ROW_诊断记录.RN ||
                 '=:1,BLZDMC' || ROW_诊断记录.RN ||
                 '=:2,BLH' || ROW_诊断记录.RN ||
                 '=:3 WHERE 病历号=:4';
      EXECUTE IMMEDIATE STR_SQL
        USING ROW_诊断记录.ICD码, ROW_诊断记录.疾病名称, ROW_诊断记录.病理号, ROW_诊断记录.住院病历号;
    END IF;
  END LOOP;

  --更新费用记录信息
  FOR ROW_费用记录 IN CUR_费用记录 LOOP
    EXIT WHEN CUR_费用记录%NOTFOUND;
    UPDATE 临时表_数据上报_出院流感病例 T
       SET T.P782 = ROW_费用记录.总金额,
           T.P751 = ROW_费用记录.自付金额,
           T.P752 = ROW_费用记录.一般医疗服务费总,
           T.P754 = ROW_费用记录.一般治疗操作费,
           T.P755 = ROW_费用记录.护理费,
           T.P756 = ROW_费用记录.综合医疗服务类其他费用,
           T.P757 = ROW_费用记录.病理诊断费,
           T.P758 = ROW_费用记录.实验室诊断费,
           T.P759 = ROW_费用记录.影像学诊断费,
           T.P760 = ROW_费用记录.临床诊断项目费,
           T.P761 = ROW_费用记录.非手术治疗项目费,
           T.P762 = ROW_费用记录.其中_临床物理治疗费,
           T.P763 = ROW_费用记录.手术治疗费,
           T.P764 = ROW_费用记录.其中_麻醉费,
           T.P765 = ROW_费用记录.其中_手术费,
           T.P767 = ROW_费用记录.康复费,
           T.P768 = ROW_费用记录.中医治疗费,
           T.P769 = ROW_费用记录.西药费,
           T.P770 = ROW_费用记录.其中_抗菌药物费,
           T.P771 = ROW_费用记录.中成药费,
           T.P772 = ROW_费用记录.中草药费,
           T.P773 = ROW_费用记录.血费,
           T.P774 = ROW_费用记录.白蛋白类制品费,
           T.P775 = ROW_费用记录.球蛋白类制品费,
           T.P776 = ROW_费用记录.凝血因子类制品费,
           T.P777 = ROW_费用记录.细胞因子类制品费,
           T.P778 = ROW_费用记录.检查用一次性医用材料费,
           T.P779 = ROW_费用记录.治疗用一次性医用材料费,
           T.P780 = ROW_费用记录.手术用一次性医用材料费,
           T.P781 = ROW_费用记录.其他费
    
     WHERE T.病历号 = ROW_费用记录.住院病历号;
  END LOOP;

  --更新手术记录信息
  FOR ROW_手术记录 IN CUR_手术记录 LOOP
    EXIT WHEN CUR_手术记录%NOTFOUND;
  
    STR_SQL := 'UPDATE 临时表_数据上报_出院流感病例 SET SSBM' || ROW_手术记录.RN ||
               '=:1, SSRQ' || ROW_手术记录.RN || '=:2, SSJB' || ROW_手术记录.RN ||
               '= :3
               , SSMC' || ROW_手术记录.RN || '=:4,  SZ' ||
               ROW_手术记录.RN || '=:5, YZ' || ROW_手术记录.RN || '=:6, EZ' ||
               ROW_手术记录.RN || '=:7, MZFS' || ROW_手术记录.RN || '=:8, MZFJ' ||
               ROW_手术记录.RN || '=:9, QKYHDJ' || ROW_手术记录.RN ||
               '=:10 WHERE 病历号=:11';
    EXECUTE IMMEDIATE STR_SQL
      USING ROW_手术记录.国标码, ROW_手术记录.手术操作日期, ROW_手术记录.手术级别编码, ROW_手术记录.手术操作名称, ROW_手术记录.术者, ROW_手术记录.I助, ROW_手术记录.II助, ROW_手术记录.麻醉方式编码, ROW_手术记录.麻醉分级编码, ROW_手术记录.切口愈合等级编码, ROW_手术记录.住院病历号;
  
  END LOOP;

  --更新重症监护记录信息
  FOR ROW_重症监护记录 IN CUR_重症监护记录 LOOP
    EXIT WHEN CUR_重症监护记录%NOTFOUND;
    STR_SQL := 'UPDATE 临时表_数据上报_出院流感病例 SET JHSMC' || ROW_重症监护记录.RN ||
               '=:1, JRSJ' || ROW_重症监护记录.RN || '=:2, TCSJ' || ROW_重症监护记录.RN ||
               '= :3 WHERE 病历号=:4';
  
    EXECUTE IMMEDIATE STR_SQL
      USING ROW_重症监护记录.科室名称, ROW_重症监护记录.进入时间, ROW_重症监护记录.退出时间, ROW_重症监护记录.住院病历号;
  
  END LOOP;

  --返回数据集
  OPEN CUR_导出_列表信息 FOR
    SELECT T.* FROM 临时表_数据上报_出院流感病例 T;

END PR_数据上报_流感出院病历;
/

prompt
prompt Creating procedure PR_数据上报_流感出院小结
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_数据上报_流感出院小结(STR_参数          IN VARCHAR2,
                                           CUR_导出_列表信息 OUT SYS_REFCURSOR) IS

  STR_机构编码 VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 1);
  /*DAT_出院时间起始 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 2),
                             'yyyy-MM-dd hh24:mi:ss');
  DAT_出院时间截止 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 3),
                             'yyyy-MM-dd hh24:mi:ss');
  STR_过滤数据     VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 4);*/
  STR_项目编码 VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 5);
  STR_流水码   VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 6);

BEGIN

  BEGIN
   IF STR_流水码 IS NULL THEN
      SELECT MAX(流水码)
        INTO STR_流水码
        FROM 病案管理_导出列表
       WHERE 机构编码 = STR_机构编码
         AND 项目编码 = STR_项目编码;
    END IF;
    
    --返回数据集
    OPEN CUR_导出_列表信息 FOR
    
      SELECT T.住院病历号 AS 病历号,
             T.病案号,
             T.病人姓名 AS 姓名,
             NVL(T.性别, '0') AS 性别,
             TO_NUMBER(REGEXP_REPLACE(T.年龄, '[^-0-9.]', '')) 年龄,
             T.入院日期,
             (SELECT A.科室类别
                FROM 基础项目_科室补充资料 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.科室编码 = T.入院科室编码) 入院科别,             
             (SELECT 转出科室编码
                FROM 住院管理_在院病人转科记录
               WHERE 机构编码 = STR_机构编码
                 AND 住院病历号 = T.住院病历号
                 AND ROWNUM = 1) 转科科别,
             T.出院日期,
             (SELECT A.科室类别
                FROM 基础项目_科室补充资料 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.科室编码 = T.出院科室编码) 出院科别,
             
             T.住院天数 AS 实际住院天数,
             (SELECT A.疾病名称
                FROM 住院管理_在院病人诊断 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.住院病历号 = T.住院病历号
                 AND A.诊断类型 = '门诊诊断'
                 AND A.诊断分类 = '1'
                 AND ROWNUM = 1) AS 入院诊断,
             (SELECT WM_CONCAT(A.疾病名称)
                FROM 住院管理_在院病人诊断 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.住院病历号 = T.住院病历号
                 AND A.诊断类型 = '出院诊断'
                 AND A.诊断分类 = '1') AS 出院诊断,
             NULL AS 入院情况及诊疗经过,
             NULL AS 出院情况及诊疗结果,
             null AS 出院医嘱
             /*(SELECT A.医嘱内容
                FROM 住院管理_出院病人医嘱 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.住院病历号 = T.住院病历号
                 AND A.项目编码 = '出院医嘱') AS 出院医嘱*/
        FROM 住院管理_病案首页 T, 住院管理_出院病人信息 TT
       WHERE T.住院病历号 = TT.住院病历号
         AND T.机构编码 = STR_机构编码
         AND EXISTS (SELECT 1
                FROM 病案管理_导出列表 A
               WHERE A.机构编码 = T.机构编码
                 AND A.病历号 = T.住院病历号
                 AND A.就诊类别 = '出院'
                 AND A.项目编码 = STR_项目编码
                 AND A.流水码 = STR_流水码);
  END;

END PR_数据上报_流感出院小结;
/

prompt
prompt Creating procedure PR_数据上报_流感检验记录
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_数据上报_流感检验记录(STR_参数          IN VARCHAR2,
                                           CUR_导出_列表信息 OUT SYS_REFCURSOR) IS

  STR_机构编码 VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 1);
  /*DAT_出院时间起始 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 2),
                             'yyyy-MM-dd hh24:mi:ss');
  DAT_出院时间截止 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 3),
                             'yyyy-MM-dd hh24:mi:ss');
  STR_过滤数据     VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 4);*/
  STR_项目编码 VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 5);
  STR_流水码   VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 6);

BEGIN

  BEGIN
  
    IF STR_流水码 IS NULL THEN
      SELECT MAX(流水码)
        INTO STR_流水码
        FROM 病案管理_导出列表
       WHERE 机构编码 = STR_机构编码
         AND 项目编码 = STR_项目编码;
    END IF;
    --返回数据集
    OPEN CUR_导出_列表信息 FOR
      WITH W_流感检测代码 AS
       (SELECT TT.接口对照信息编码, TTT.系统对照信息编码
          FROM 病案管理_项目接口对照分类 T,
               病案管理_项目接口对照明细 TT,
               病案管理_项目系统对照明细 TTT
         WHERE T.流水码 = TT.外键ID
           AND TT.流水码 = TTT.外键ID
           AND T.机构编码 = STR_机构编码
           AND T.项目编码 = STR_项目编码
           and T.分类编码='RC040')
      
      SELECT '01' AS 就诊类型,
             G.门诊病历号 AS 病历号,
             G.挂号时间 AS 就诊日期,
             J.样本号 AS 标本号,
             (SELECT B.接口对照信息编码
                FROM W_流感检测代码 B
               WHERE B.系统对照信息编码 = S.项目编码
                 AND ROWNUM = 1) AS 流感检测代码,
             S.申请时间 AS 送检时间,
             NULL AS 检验结果描述,
             DECODE(M.细项值, '阳性', '1', '2') AS 检验结果是否阳性,
             NULL AS 检验结果阳性类别
        FROM 门诊管理_挂号登记  G,
             检验检查_申请      S,
             检验检查_结果      J,
             检验检查_结果_明细 M
       WHERE G.机构编码 = S.机构编码
         AND S.机构编码 = J.机构编码
         AND G.门诊病历号 = S.病历号
         AND S.申请单ID = J.申请单ID
         AND J.唯一ID = M.细项主键
         AND G.机构编码 = STR_机构编码
         AND S.类型 = '检验'
         AND S.ID类型 = '门诊'
         AND EXISTS (SELECT 1
                FROM 病案管理_导出列表 A
               WHERE A.机构编码 = G.机构编码
                 AND A.病历号 = G.门诊病历号
                 AND A.就诊类别 = '门诊'
                 AND A.项目编码 = STR_项目编码
                 AND A.流水码 = STR_流水码)
         AND EXISTS (SELECT 1
                FROM W_流感检测代码 B
               WHERE B.系统对照信息编码 = S.项目编码)
      
      UNION
      
      SELECT '03' AS 就诊类型,
             G.住院病历号 AS 病历号,
             G.入院时间 AS 就诊日期,
             J.样本号 AS 标本号,
             (SELECT B.接口对照信息编码
                FROM W_流感检测代码 B
               WHERE B.系统对照信息编码 = S.项目编码
                 AND ROWNUM = 1) AS 流感检测代码,
             S.申请时间 AS 送检时间,
             NULL AS 检验结果描述,
             DECODE(M.细项值, '阳性', '1', '2') AS 检验结果是否阳性,
             NULL AS 检验结果阳性类别
        FROM 住院管理_在院病人信息 G,
             检验检查_申请         S,
             检验检查_结果         J,
             检验检查_结果_明细    M
       WHERE G.机构编码 = S.机构编码 AND S.机构编码 = J.机构编码 AND G.住院病历号 = S.病历号 AND
       S.申请单ID = J.申请单ID AND J.唯一ID = M.细项主键 AND G.机构编码 = STR_机构编码 AND
       S.类型 = '检验' AND S.ID类型 = '住院' AND EXISTS
       (SELECT 1
          FROM 病案管理_导出列表 A
         WHERE A.机构编码 = G.机构编码
           AND A.病历号 = G.住院病历号
           AND A.就诊类别 = '在院'
           AND A.项目编码 = STR_项目编码
           AND A.流水码 = STR_流水码) AND EXISTS
       (SELECT 1
          FROM W_流感检测代码 B
         WHERE B.系统对照信息编码 = S.项目编码)
      
      UNION
      
      SELECT '03' AS 就诊类型,
             G.住院病历号 AS 病历号,
             G.入院时间 AS 就诊日期,
             J.样本号 AS 标本号,
             (SELECT B.接口对照信息编码
                FROM W_流感检测代码 B
               WHERE B.系统对照信息编码 = S.项目编码
                 AND ROWNUM = 1) AS 流感检测代码,
             S.申请时间 AS 送检时间,
             NULL AS 检验结果描述,
             DECODE(M.细项值, '阳性', '1', '2') AS 检验结果是否阳性,
             NULL AS 检验结果阳性类别
        FROM 住院管理_出院病人信息 G,
             检验检查_申请         S,
             检验检查_结果         J,
             检验检查_结果_明细    M
       WHERE G.机构编码 = S.机构编码 AND S.机构编码 = J.机构编码 AND G.住院病历号 = S.病历号 AND
       S.申请单ID = J.申请单ID AND J.唯一ID = M.细项主键 AND G.机构编码 = STR_机构编码 AND
       S.类型 = '检验' AND S.ID类型 = '住院' AND EXISTS
       (SELECT 1
          FROM 病案管理_导出列表 A
         WHERE A.机构编码 = G.机构编码
           AND A.病历号 = G.住院病历号
           AND A.就诊类别 = '出院'
           AND A.项目编码 = STR_项目编码
           AND A.流水码 = STR_流水码) AND EXISTS
       (SELECT 1
          FROM W_流感检测代码 B
         WHERE B.系统对照信息编码 = S.项目编码);
  
  END;

END PR_数据上报_流感检验记录;
/

prompt
prompt Creating procedure PR_数据上报_流感门诊及在院病历
prompt ====================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_数据上报_流感门诊及在院病历(STR_参数          IN VARCHAR2,
                                              CUR_导出_列表信息 OUT SYS_REFCURSOR) IS
  STR_SQL VARCHAR2(1000);

  STR_机构编码 VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 1);
  /*DAT_出院时间起始 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 2),
                             'yyyy-MM-dd hh24:mi:ss');
  DAT_出院时间截止 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 3),
                             'yyyy-MM-dd hh24:mi:ss');
  STR_过滤数据     VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 4);*/
  STR_项目编码 VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 5);
  STR_流水码   VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 6);

  --获取诊断记录CURSOR
  CURSOR CUR_诊断记录 IS
    SELECT *
      FROM (SELECT ROW_NUMBER() OVER(PARTITION BY T.住院病历号, T.诊断类型 ORDER BY T.诊断类型, T.是否主诊断 DESC) RN,
                   T.住院病历号,
                   (CASE
                     WHEN T.ICD码 = T.疾病编码 THEN
                      (SELECT B.ICD码
                         FROM 基础项目_疾病字典 B
                        WHERE B.疾病编码 = T.疾病编码)
                     ELSE
                      T.ICD码
                   END) ICD码,
                   T.疾病名称,
                   T.诊断类型
              FROM 住院管理_在院病人诊断 T
             WHERE T.机构编码 = STR_机构编码
               AND T.诊断类型 = '其他诊断'
               AND EXISTS (SELECT 1
                      FROM 病案管理_导出列表 A
                     WHERE A.机构编码 = T.机构编码
                       AND A.病历号 = T.住院病历号
                       AND A.就诊类别 = '在院'
                       AND A.项目编码 = STR_项目编码
                       AND A.流水码 = STR_流水码)) G
     WHERE G.RN <= 10;
  ROW_诊断记录 CUR_诊断记录%ROWTYPE;

  --获取重症监护记录CURSOR
  CURSOR CUR_重症监护记录 IS
    SELECT *
      FROM (SELECT ROW_NUMBER() OVER(PARTITION BY T.住院病历号 ORDER BY T.流水码 DESC) RN,
                   T.科室名称,
                   T.进入时间,
                   T.退出时间,
                   T.住院病历号
              FROM 住院管理_病案首页_重症监护 T
             WHERE T.机构编码 = STR_机构编码
               AND EXISTS (SELECT 1
                      FROM 病案管理_导出列表 A
                     WHERE A.机构编码 = T.机构编码
                       AND A.病历号 = T.住院病历号
                       AND A.就诊类别 = '在院'
                       AND A.项目编码 = STR_项目编码
                       AND A.流水码 = STR_流水码)) G
     WHERE G.RN <= 5;

  ROW_重症监护记录 CUR_重症监护记录%ROWTYPE;

BEGIN

  BEGIN
    IF STR_流水码 IS NULL THEN
      SELECT MAX(流水码)
        INTO STR_流水码
        FROM 病案管理_导出列表
       WHERE 机构编码 = STR_机构编码
         AND 项目编码 = STR_项目编码;
    END IF;
  
    DELETE FROM 临时表_数据上报_在院流感病例;
  
    --更新在院基本信息
    INSERT INTO 临时表_数据上报_在院流感病例
      (病历号,
       P900, --医疗机构编码
       P6891, --机构名称
       P686, --医疗保险手册（卡）号
       P800, --健康卡号
       P7501, --就诊类型
       P7502, --就诊卡号
       
       P4, --姓名
       P5, --性别
       P6, --出生日期
       P7, --年龄
       P7503, --注册证件类型代码
       P13, --注册证件号码
       P7504, --就诊科室代码
       P7505, --就诊次数
       P7506, --就诊日期
       P7507, --主诉
       P321, --主要诊断代码
       P322, --主要诊断描述
       P1,
       P8508 --是否死亡
       
       )
      SELECT T.住院病历号,
             T.机构编码,
             '营口经济技术开发区第二人民医院' 机构名称,
             NULL, --医疗保险手册（卡）号
             T.健康卡号,
             '03', --就诊类型
             T.住院病历号, --就诊卡号
             NVL(T.病人姓名, '_'),
             NVL(T.性别, '0'),
             T.出生日期,
             TO_NUMBER(REGEXP_REPLACE(T.年龄, '[^-0-9.]', '')) 年龄,
             DECODE(T.证件类别, '1', '01', '99'), --注册证件类型代码
             NVL(T.身份证号, '-'), --注册证件号码
             (SELECT A.科室类别
                FROM 基础项目_科室补充资料 A
               WHERE A.机构编码 = T.机构编码
                 AND A.科室编码 = T.入院科室编码) 就诊科室代码, --就诊科室代码
             1, --就诊次数
             T.入院日期, --就诊日期
             NULL, --主诉
             (SELECT (CASE
                       WHEN A.ICD码 = A.疾病编码 THEN
                        (SELECT B.ICD码
                           FROM 基础项目_疾病字典 B
                          WHERE B.疾病编码 = A.疾病编码)
                       ELSE
                        A.ICD码
                     END) ICD码
                FROM 住院管理_在院病人诊断 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.住院病历号 = T.住院病历号
                 AND A.诊断类型 = '门诊诊断'
                 AND A.诊断分类 = '1'
                 AND ROWNUM = 1) AS 疾病编码,
             (SELECT A.疾病名称
                FROM 住院管理_在院病人诊断 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.住院病历号 = T.住院病历号
                 AND A.诊断类型 = '门诊诊断'
                 AND A.诊断分类 = '1'
                 AND ROWNUM = 1) AS 门诊诊断名称,
             T.医疗付费方式,
             '2'
        FROM 住院管理_病案首页 T
       WHERE T.机构编码 = STR_机构编码
         AND EXISTS (SELECT 1
                FROM 病案管理_导出列表 A
               WHERE A.机构编码 = T.机构编码
                 AND A.病历号 = T.住院病历号
                 AND A.就诊类别 = '在院'
                 AND A.项目编码 = STR_项目编码
                 AND A.流水码 = STR_流水码);
  END;

  --更新诊断记录信息
  FOR ROW_诊断记录 IN CUR_诊断记录 LOOP
    EXIT WHEN CUR_诊断记录%NOTFOUND;
    IF ROW_诊断记录.诊断类型 = '其他诊断' THEN
      STR_SQL := 'UPDATE 临时表_数据上报_在院流感病例 SET QTZDBM' || ROW_诊断记录.RN ||
                 '=:1,QTZDMS' || ROW_诊断记录.RN || '=:2 WHERE 病历号=:3';
      EXECUTE IMMEDIATE STR_SQL
        USING ROW_诊断记录.ICD码, ROW_诊断记录.疾病名称, ROW_诊断记录.住院病历号;
    END IF;
  END LOOP;

  --更新重症监护记录信息
  FOR ROW_重症监护记录 IN CUR_重症监护记录 LOOP
    EXIT WHEN CUR_重症监护记录%NOTFOUND;
    STR_SQL := 'UPDATE 临时表_数据上报_在院流感病例 SET JHSMC' || ROW_重症监护记录.RN ||
               '=:1, JRSJ' || ROW_重症监护记录.RN || '=:2, TCSJ' || ROW_重症监护记录.RN ||
               '= :3 WHERE 病历号=:4';
  
    EXECUTE IMMEDIATE STR_SQL
      USING ROW_重症监护记录.科室名称, ROW_重症监护记录.进入时间, ROW_重症监护记录.退出时间, ROW_重症监护记录.住院病历号;
  
  END LOOP;

  DELETE FROM 临时表_数据上报_在院流感费用;

  --更新在院基本信息
  INSERT INTO 临时表_数据上报_在院流感费用
    (病历号, 费用总额, 费用名称, 单项总额, 自付总额)
    SELECT B.门诊病历号,
           C.费用总额,
           (case
             when d.大类编码 = 2 and d.小类编码 in ('1', '2', '3', '12') then
              '药品费'
             when d.大类编码 = '1' and d.小类编码 in ('1', '2', '7') then
              '检查费'
             else
              '其他费'
           end) as 费用名称,
           D.总金额,
           (C.费用总额 - C.补偿总额) AS 参考自付金额
      FROM 门诊管理_挂号登记     B,
           门诊管理_门诊发票登记 C,
           门诊管理_门诊处方     D
     WHERE B.机构编码 = C.机构编码
       AND C.机构编码 = D.机构编码
       AND B.门诊病历号 = C.门诊病历号
       AND C.门诊病历号 = D.门诊病历号
       AND C.发票序号 = D.发票序号
       AND C.收费时间 >= B.挂号时间
       AND D.收费时间 >= B.挂号时间
       AND EXISTS (SELECT 1
              FROM 病案管理_导出列表 A
             WHERE A.机构编码 = B.机构编码
               AND A.病历号 = B.门诊病历号
               AND A.就诊类别 = '门诊'
               AND A.项目编码 = STR_项目编码
               AND A.流水码 = STR_流水码);

  --门诊更新基本信息
  INSERT INTO 临时表_数据上报_在院流感病例
    (病历号,
     P900, --医疗机构编码
     P6891, --机构名称
     P686, --医疗保险手册（卡）号
     P800, --健康卡号
     P7501, --就诊类型
     P7502, --就诊卡号
     
     P4, --姓名
     P5, --性别
     P6, --出生日期
     P7, --年龄
     P7503, --注册证件类型代码
     P13, --注册证件号码
     P7504, --就诊科室代码
     P7505, --就诊次数
     P7506, --就诊日期
     P7507, --主诉
     P321, --主要诊断代码
     P322, --主要诊断描述
     P1, --医疗付费支付方式
     
     P7508, --总费用
     P7509, --挂号费
     P7510, --药品费
     P7511, --检查费
     P7512, --自付费用
     P8508 --是否死亡
     
     )
    SELECT G.门诊病历号,
           G.机构编码,
           '营口经济技术开发区第二人民医院' 机构名称,
           NULL,
           X.健康卡号,
           '01', --就诊类型
           G.门诊病历号, --就诊卡号
           NVL(X.姓名, '_'),
           NVL(X.性别, '0'),
           X.出生日期,
           TO_NUMBER(REGEXP_REPLACE(X.年龄, '[^-0-9.]', '')) 年龄,
           '01', --注册证件类型代码
           NVL(X.身份证号, '_'), --注册证件号码
           (SELECT A.科室类别
              FROM 基础项目_科室补充资料 A
             WHERE A.机构编码 = G.机构编码
               AND A.科室编码 = G.挂号科室编码) 就诊科室代码, --就诊科室代码
           1, --就诊次数
           G.挂号时间, --就诊日期
           NULL, --主诉
           (SELECT A.ICD码
              FROM 基础项目_疾病字典 A
             WHERE A.疾病编码 = G.疾病编码
               AND ROWNUM = 1) 疾病编码,
           G.疾病名称,
           '9', --医疗付费支付方式
           (SELECT SUM(B.单项总额)
              FROM 临时表_数据上报_在院流感费用 B
             WHERE B.病历号 = G.门诊病历号), --总费用
           '0', --挂号费
           (SELECT SUM(B.单项总额)
              FROM 临时表_数据上报_在院流感费用 B
             WHERE B.病历号 = G.门诊病历号
               AND B.费用名称 = '药品费'), --药品费
           (SELECT SUM(B.单项总额)
              FROM 临时表_数据上报_在院流感费用 B
             WHERE B.病历号 = G.门诊病历号
               AND B.费用名称 = '检查费'), --检查费
           (SELECT SUM(B.自付总额)
              FROM 临时表_数据上报_在院流感费用 B
             WHERE B.病历号 = G.门诊病历号), --自付总额
           '2' --是否死亡
    
      FROM 门诊管理_挂号登记 G, 基础项目_病人信息 X
     WHERE G.机构编码 = X.机构编码
       AND G.病人ID = X.病人ID
       AND G.机构编码 = STR_机构编码
       AND G.退号标志 = '否'
       AND EXISTS (SELECT 1
              FROM 病案管理_导出列表 A
             WHERE A.机构编码 = G.机构编码
               AND A.病历号 = G.门诊病历号
               AND A.就诊类别 = '门诊'
               AND A.项目编码 = STR_项目编码
               AND A.流水码 = STR_流水码);

  --返回数据集
  OPEN CUR_导出_列表信息 FOR
    SELECT T.* FROM 临时表_数据上报_在院流感病例 T;

END PR_数据上报_流感门诊及在院病历;
/

prompt
prompt Creating procedure PR_数据上报_流感死亡记录
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_数据上报_流感死亡记录(STR_参数          IN VARCHAR2,
                                           CUR_导出_列表信息 OUT SYS_REFCURSOR) IS

  STR_机构编码 VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 1);
  /*DAT_出院时间起始 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 2),
                             'yyyy-MM-dd hh24:mi:ss');
  DAT_出院时间截止 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 3),
                             'yyyy-MM-dd hh24:mi:ss');
  STR_过滤数据     VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 4);*/
  STR_项目编码 VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 5);
  STR_流水码   VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 6);

BEGIN

  BEGIN
    IF STR_流水码 IS NULL THEN
      SELECT MAX(流水码)
        INTO STR_流水码
        FROM 病案管理_导出列表
       WHERE 机构编码 = STR_机构编码
         AND 项目编码 = STR_项目编码;
    END IF;
  
    --返回数据集
    OPEN CUR_导出_列表信息 FOR
    
      SELECT T.住院病历号 AS 病历号,
             T.病案号,
             T.病人姓名 AS 姓名,
             NVL(T.性别, '0') AS 性别,
             TO_NUMBER(REGEXP_REPLACE(T.年龄, '[^-0-9.]', '')) 年龄,
             
             T.入院日期,
             (SELECT A.科室类别
                FROM 基础项目_科室补充资料 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.科室编码 = T.入院科室编码) 入院科别,
             
             (SELECT 转出科室编码
                FROM 住院管理_在院病人转科记录
               WHERE 机构编码 = STR_机构编码
                 AND 住院病历号 = T.住院病历号
                 AND ROWNUM = 1) 转科科别,
             T.出院日期,
             (SELECT A.科室类别
                FROM 基础项目_科室补充资料 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.科室编码 = T.出院科室编码) 出院科别,            
             T.住院天数 AS 实际住院天数,            
             (SELECT A.疾病名称
                FROM 住院管理_在院病人诊断 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.住院病历号 = T.住院病历号
                 AND A.诊断类型 = '门诊诊断'
                 AND A.诊断分类 = '1'
                 AND ROWNUM = 1) AS 入院诊断,
             NULL AS 入院情况及诊疗和抢救经过,
             TT.死亡诊断名称 AS 死亡诊断,
             TT.死亡诊断名称 AS 死亡原因,
             TT.死亡时间
      
        FROM 住院管理_病案首页 T, 住院管理_病人死亡记录 TT
       WHERE T.机构编码 = TT.机构编码
         AND T.住院病历号 = TT.住院病历号
         AND T.机构编码 = STR_机构编码
         AND EXISTS (SELECT 1
                FROM 病案管理_导出列表 A
               WHERE A.机构编码 = T.机构编码
                 AND A.病历号 = T.住院病历号
                 AND A.就诊类别 = '出院'
                 AND A.项目编码 = STR_项目编码
                 AND A.流水码 = STR_流水码);
  END;

END PR_数据上报_流感死亡记录;
/

prompt
prompt Creating procedure PR_数据上报_流感用药记录
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE CLOUDHIS.PR_数据上报_流感用药记录(STR_参数          IN VARCHAR2,
                                           CUR_导出_列表信息 OUT SYS_REFCURSOR) IS

  STR_机构编码 VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 1);
  /*DAT_出院时间起始 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 2),
                             'yyyy-MM-dd hh24:mi:ss');
  DAT_出院时间截止 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 3),
                             'yyyy-MM-dd hh24:mi:ss');
  STR_过滤数据     VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 4);*/
  STR_项目编码 VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 5);
  STR_流水码   VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 6);

BEGIN

  BEGIN
    IF STR_流水码 IS NULL THEN
      SELECT MAX(流水码)
        INTO STR_流水码
        FROM 病案管理_导出列表
       WHERE 机构编码 = STR_机构编码
         AND 项目编码 = STR_项目编码;
    END IF;
  
    --返回数据集
    OPEN CUR_导出_列表信息 FOR
    
      SELECT '01' AS 就诊类型,
             G.门诊病历号 AS 病历号,
             G.挂号时间 AS 就诊日期,
             TO_CHAR(Y.序号) AS 顺序号,
             Y.项目名称 AS 药物名称,
             (SELECT A.次数
                FROM 基础项目_频率字典 A
               WHERE A.机构编码 = Y.机构编码
                 AND A.频率编码 = Y.频率编码) AS 药物使用频率,
             (SELECT A.次数
                FROM 基础项目_频率字典 A
               WHERE A.机构编码 = Y.机构编码
                 AND A.频率编码 = Y.频率编码) * Y.用量 AS 药物使用总剂量,
             Y.用量 AS 药物使用次剂量,
             Y.剂量名称 AS 药物使用剂量单位,
             Y.开始时间 AS 药物使用开始时间,
             NULL AS 药物使用结束时间
        FROM 门诊管理_挂号登记     G,
             门诊管理_门诊医嘱     Y,
             门诊管理_门诊医嘱项目 X
       WHERE G.机构编码 = Y.机构编码
         AND Y.机构编码 = X.机构编码
         AND G.门诊病历号 = Y.门诊病历号
         AND Y.门诊病历号 = X.门诊病历号
         AND Y.项目ID = X.项目ID
         AND G.机构编码 = STR_项目编码
         AND Y.收费状态 = '已发药'
         AND Y.大类编码 = '2'
         AND Y.小类编码 IN ('1', '2', '3', '12')
         AND EXISTS (SELECT 1
                FROM 病案管理_导出列表 A
               WHERE A.机构编码 = G.机构编码
                 AND A.病历号 = G.门诊病历号
                 AND A.就诊类别 = '门诊'
                 AND A.项目编码 = STR_项目编码
                 AND A.流水码 = STR_流水码)
      
      UNION
      
      SELECT '03' AS 就诊类型,
             T.住院病历号 AS 病历号,
             T.入院日期 AS 就诊日期,
             TO_CHAR(Y.序号) AS 顺序号,
             Y.项目名称 AS 药物名称,
             (SELECT A.次数
                FROM 基础项目_频率字典 A
               WHERE A.机构编码 = Y.机构编码
                 AND A.频率编码 = Y.频率编码) AS 药物使用频率,
             (SELECT A.次数
                FROM 基础项目_频率字典 A
               WHERE A.机构编码 = Y.机构编码
                 AND A.频率编码 = Y.频率编码) * Y.用量 AS 药物使用总剂量,
             Y.用量 AS 药物使用次剂量,
             Y.剂量名称 AS 药物使用剂量单位,
             Y.开始时间 AS 药物使用开始时间,
             NULL AS 药物使用结束时间
        FROM 住院管理_病案首页         T,
             住院管理_出院病人医嘱     Y,
             住院管理_出院病人医嘱项目 X
       WHERE T.机构编码 = Y.机构编码
         AND Y.机构编码 = X.机构编码
         AND T.住院病历号 = Y.住院病历号
         AND Y.项目ID = X.项目ID
         AND T.机构编码 = STR_机构编码
         AND Y.发送状态 = '发送已收费'
         AND Y.大类编码 = '2'
         AND Y.小类编码 IN ('1', '2', '3', '12')
         AND EXISTS (SELECT 1
                FROM 病案管理_导出列表 A
               WHERE A.机构编码 = T.机构编码
                 AND A.病历号 = T.住院病历号
                 AND A.就诊类别 = '出院'
                 AND A.项目编码 = STR_项目编码
                 AND A.流水码 = STR_流水码)
      
      UNION
      
      SELECT '03' AS 就诊类型,
             T.住院病历号 AS 病历号,
             T.入院日期 AS 就诊日期,
             TO_CHAR(Y.序号) AS 顺序号,
             Y.项目名称 AS 药物名称,
             (SELECT A.次数
                FROM 基础项目_频率字典 A
               WHERE A.机构编码 = Y.机构编码
                 AND A.频率编码 = Y.频率编码) AS 药物使用频率,
             (SELECT A.次数
                FROM 基础项目_频率字典 A
               WHERE A.机构编码 = Y.机构编码
                 AND A.频率编码 = Y.频率编码) * Y.用量 AS 药物使用总剂量,
             Y.用量 AS 药物使用次剂量,
             Y.剂量名称 AS 药物使用剂量单位,
             Y.开始时间 AS 药物使用开始时间,
             NULL AS 药物使用结束时间
        FROM 住院管理_病案首页         T,
             住院管理_在院病人医嘱     Y,
             住院管理_在院病人医嘱项目 X
       WHERE T.机构编码 = Y.机构编码
         AND Y.机构编码 = X.机构编码
         AND T.住院病历号 = Y.住院病历号
         AND Y.项目ID = X.项目ID
         AND T.机构编码 = STR_机构编码
         AND Y.发送状态 = '发送已收费'
         AND Y.大类编码 = '2'
         AND Y.小类编码 IN ('1', '2', '3', '12')
         AND EXISTS (SELECT 1
                FROM 病案管理_导出列表 A
               WHERE A.机构编码 = T.机构编码
                 AND A.病历号 = T.住院病历号
                 AND A.就诊类别 = '在院'
                 AND A.项目编码 = STR_项目编码
                 AND A.流水码 = STR_流水码);
  
  END;

END PR_数据上报_流感用药记录;
/


prompt Done
spool off
set define on
