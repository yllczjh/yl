CREATE OR REPLACE PROCEDURE PR_病案首页西医_绩效考核(STR_参数          IN VARCHAR2,
                                           CUR_导出_列表信息 OUT SYS_REFCURSOR) IS
  STR_SQL  VARCHAR2(1000);
  STR_编号 VARCHAR2(20);

  STR_机构编码     VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 1);
  DAT_出院时间起始 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 2),
                             'yyyy-MM-dd hh24:mi:ss');
  DAT_出院时间截止 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 3),
                             'yyyy-MM-dd hh24:mi:ss');
  STR_过滤数据     VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 4);

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
                   T.诊断类型
              FROM 住院管理_在院病人诊断 T,
                   住院管理_出院病人信息 TT,
                   住院管理_病案首页     TTT
             WHERE T.住院病历号 = TT.住院病历号
               AND T.住院病历号 = TTT.住院病历号
               AND T.机构编码 = STR_机构编码
               AND TTT.治疗类别 = '3' --西医
               AND TTT.归档人编码 IS NOT NULL
               AND TT.出院时间 BETWEEN DAT_出院时间起始 AND DAT_出院时间截止
               AND T.诊断分类 = '1'
               AND T.诊断类型 IN
                   ('出院诊断', '其他诊断', '损伤和中毒外部原因', '病理诊断')
               AND T.创建时间 >= TT.入院时间
               AND (TT.住院病历号 LIKE '%' || STR_过滤数据 || '%' OR
                   TT.病案号 LIKE '%' || STR_过滤数据 || '%' OR
                   TT.病人姓名 LIKE '%' || STR_过滤数据 || '%')) G
     WHERE (G.诊断类型 = '其他诊断' AND G.RN <= 15)
        OR (G.诊断类型 <> '其他诊断' AND G.RN = 1);
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
                   T.切口愈合等级编码,
                   T.麻醉方式编码,
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
               AND TTT.治疗类别 = '3' --西医
               AND TTT.归档人编码 IS NOT NULL
               AND TT.出院时间 BETWEEN DAT_出院时间起始 AND DAT_出院时间截止
               AND T.创建时间 >= TT.入院时间
               AND (TT.住院病历号 LIKE '%' || STR_过滤数据 || '%' OR
                   TT.病案号 LIKE '%' || STR_过滤数据 || '%' OR
                   TT.病人姓名 LIKE '%' || STR_过滤数据 || '%')) G
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
       AND TTT.治疗类别 = '3' --西医
       AND TTT.归档人编码 IS NOT NULL
       AND TT.出院时间 BETWEEN DAT_出院时间起始 AND DAT_出院时间截止
       AND T.记账时间 >= TT.入院时间
       AND (TT.住院病历号 LIKE '%' || STR_过滤数据 || '%' OR
           TT.病案号 LIKE '%' || STR_过滤数据 || '%' OR
           TT.病人姓名 LIKE '%' || STR_过滤数据 || '%')
     GROUP BY T.机构编码, T.住院病历号;

  ROW_费用记录 CUR_费用记录%ROWTYPE;

  --获取重症监护记录CURSOR
  CURSOR CUR_重症监护记录 IS
    SELECT *
      FROM (SELECT ROW_NUMBER() OVER(PARTITION BY T.住院病历号 ORDER BY T.流水码 DESC) RN,
                   T.科室编码,
                   T.进入时间,
                   T.退出时间,
                   T.住院病历号
              FROM 住院管理_病案首页_重症监护 T,
                   住院管理_出院病人信息      TT,
                   住院管理_病案首页          TTT
             WHERE T.住院病历号 = TT.住院病历号
               AND T.住院病历号 = TTT.住院病历号
               AND TTT.治疗类别 = '3' --西医
               AND TTT.归档人编码 IS NOT NULL
               AND TT.出院时间 BETWEEN DAT_出院时间起始 AND DAT_出院时间截止
               AND T.更新时间 >= TT.入院时间
               AND (TT.住院病历号 LIKE '%' || STR_过滤数据 || '%' OR
                   TT.病案号 LIKE '%' || STR_过滤数据 || '%' OR
                   TT.病人姓名 LIKE '%' || STR_过滤数据 || '%')) G
     WHERE G.RN <= 5;

  ROW_重症监护记录 CUR_重症监护记录%ROWTYPE;

BEGIN

  BEGIN
  
    DELETE FROM 临时表_病案首页西医_绩效考核;
  
    --更新基本信息
    INSERT INTO 临时表_病案首页西医_绩效考核
      (住院病历号,
       A01, --组织机构代码
       A02, --医疗机构名称
       A48, --病案号
       A49, --住院次数
       B12, --入院时间
       B15, --出院时间
       A47, --健康卡号
       A46C, --医疗付费方式
       A11, --姓名
       A12C, --性别
       A13, --出生日期
       A14, --年龄（岁）
       A15C, --国籍
       A21C, --婚姻
       A38C, --职业
       A19C, --民族
       A20N, --证件类别
       A20, --证件号码
       A22, --出生地址
       A23C, --籍贯省（自治区、直辖市）
       A24, --户口地址
       A25C, --户口地址邮政编码
       A26, --现住址
       A27, --现住址电话,
       A28C, --现住址邮政编码
       A29, --工作单位及地址
       A30, --工作单位电话
       A31C, --工作单位邮政编码
       A32, --联系人姓名
       A33C, --联系人关系
       A34, --联系人地址
       A35, --联系人电话
       B38, --是否为日间手术
       B11C, --入院途径
       B13C, --入院科别
       B14, --入院病房
       B21C, --转科科别
       B16C, --出院科别
       B17, --出院病房
       B20, --实际住院（天）
       C01C, --门（急）诊诊断编码
       C02N, --门（急）诊诊断名称
       
       --省略若干诊断
       C11, --病理号
       C24C, --有无药物过敏
       C25, --过敏药物名称
       B22C, --科主任执业证书编码
       B22, --科主任
       B23C, --主任（副主任）医师执业证书编码
       B23, --主任（副主任）医师
       B24C, --主治医师执业证书编码
       B24, --主治医师
       B25C, --住院医师执业证书编码
       B25, --住院医师
       B26C, --责任护士执业证书编码
       B26, --责任护士
       B27, --进修医师
       B28, --实习医师
       B29, --编码员
       B30C, --病案质量
       B31, --质控医师
       B32, --质控护士
       B33, --质控日期
       C34C, --死亡患者尸检
       C26C, --ABO血型
       C27C, --RH血型
       
       --省略手术相关
       A16, --年龄不足1周岁的年龄（天）
       A18X01, --新生儿出生体重(克)
       A17, --新生儿入院体重（克）
       C28, --颅脑损伤患者昏迷入院前时间天
       C29, --小时
       C30, --分钟
       C31, --颅脑损伤患者昏迷入院后时间天
       C32, --小时
       C33, --分钟
       C47, --有创呼吸机使用时间
       B36C, --是否有出院31日内再住院计划
       B37, --出院31天再住院计划目的
       B34C, --离院方式
       B35 --医嘱转院、转社区卫生服务机构/乡镇卫生院名称
       
       --省略费用若干
       )
      SELECT T.住院病历号,
             T.机构编码,
             '营口经济技术开发区第二人民医院' 机构名称,
             T.病案号,
             TO_NUMBER(T.住院次数),
             T.入院日期,
             T.出院日期,
             T.健康卡号,
             T.医疗付费方式,
             T.病人姓名,
             TO_NUMBER(NVL(T.性别, '0')),
             trunc(T.出生日期) 出生日期,
             TO_NUMBER(REGEXP_REPLACE(T.年龄, '[^-0-9.]', '')) 年龄,
             T.国籍,
             T.婚姻,
             T.职业,
             T.民族,
             T.证件类别,
             SUBSTR(T.身份证号, 0, 18),
             T.出生地址,
             T.籍贯省,
             T.户口地址,
             SUBSTR(T.户口邮政编码, 0, 6),
             T.现住址,
             SUBSTR(T.户口电话, 0, 20),
             SUBSTR(T.现住址邮编, 0, 6),
             T.工作单位 || T.工作单位地址,
             SUBSTR(T.工作电话, 0, 20),
             SUBSTR(T.工作邮政编码, 0, 6),
             T.联系人姓名,
             T.关系,
             T.联系人地址,
             SUBSTR(T.联系人电话, 0, 20),
             T.是否为日间手术,
             T.入院途径,
             (SELECT A.科室类别
                FROM 基础项目_科室补充资料 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.科室编码 = T.入院科室编码) 入院科室编码,
             T.入院病室,
             (SELECT LISTAGG(转出科室编码, '→') WITHIN GROUP(ORDER BY 转科时间) AS 转科科别
                FROM 住院管理_在院病人转科记录
               WHERE 机构编码 = STR_机构编码
                 AND 住院病历号 = T.住院病历号
                 AND ROWNUM <= 3) 转科科别,
             (SELECT A.科室类别
                FROM 基础项目_科室补充资料 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.科室编码 = T.出院科室编码) 出院科室编码,
             T.出院病室,
             TO_NUMBER(T.住院天数),
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
             (SELECT SUBSTR(A.疾病名称, 0, 50)
                FROM 住院管理_在院病人诊断 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.住院病历号 = T.住院病历号
                 AND A.诊断类型 = '门诊诊断'
                 AND A.诊断分类 = '1'
                 AND ROWNUM = 1) AS 门诊诊断名称,
             
             --省略若干诊断
             T.病理号,
             T.药物过敏,
             T.过敏药物,
             (SELECT 医师执业证书编码
                FROM 基础项目_人员资料
               WHERE 机构编码 = T.机构编码
                 AND 删除标志 = '0'
                 AND 人员编码 = T.科主任) AS 科主任职业证书,
             (SELECT 人员姓名
                FROM 基础项目_人员资料
               WHERE 机构编码 = T.机构编码
                 AND 删除标志 = '0'
                 AND 人员编码 = T.科主任) AS 科主任,
             (SELECT 医师执业证书编码
                FROM 基础项目_人员资料
               WHERE 机构编码 = T.机构编码
                 AND 删除标志 = '0'
                 AND 人员编码 = T.主任医师) AS 主任医师职业证书,
             (SELECT 人员姓名
                FROM 基础项目_人员资料
               WHERE 机构编码 = T.机构编码
                 AND 删除标志 = '0'
                 AND 人员编码 = T.主任医师) AS 主任医师,
             (SELECT 医师执业证书编码
                FROM 基础项目_人员资料
               WHERE 机构编码 = T.机构编码
                 AND 删除标志 = '0'
                 AND 人员编码 = T.主治医师) AS 主治医师职业证书,
             (SELECT 人员姓名
                FROM 基础项目_人员资料
               WHERE 机构编码 = T.机构编码
                 AND 删除标志 = '0'
                 AND 人员编码 = T.主治医师) AS 主治医师,
             (SELECT 医师执业证书编码
                FROM 基础项目_人员资料
               WHERE 机构编码 = T.机构编码
                 AND 删除标志 = '0'
                 AND 人员编码 = T.住院医师) AS 住院医师职业证书,
             (SELECT 人员姓名
                FROM 基础项目_人员资料
               WHERE 机构编码 = T.机构编码
                 AND 删除标志 = '0'
                 AND 人员编码 = T.住院医师) AS 住院医师,
             (SELECT 医师执业证书编码
                FROM 基础项目_人员资料
               WHERE 机构编码 = T.机构编码
                 AND 删除标志 = '0'
                 AND 人员编码 = T.责任护士) AS 责任护士职业证书,
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
             DECODE(T.尸检, '是', '1', '2'),
             T.血型,
             T.RH,
             --省略若干手术
             
             TO_NUMBER(REGEXP_REPLACE(T.年龄不足1周岁, '[^-0-9.]', '')) 年龄不足1周岁,
             (CASE
               WHEN TO_NUMBER(T.入院日期 - T.出生日期) < 28 THEN
                TO_NUMBER(REGEXP_REPLACE(T.新生儿出生体重, '[^-0-9.]', ''))
               ELSE
                null
             END) AS 新生儿出生体重,
             (CASE
               WHEN TO_NUMBER(T.入院日期 - T.出生日期) < 28 THEN
                TO_NUMBER(REGEXP_REPLACE(T.新生儿入院体重, '[^-0-9.]', ''))
               ELSE
                null
             END) AS 新生儿入院体重,
             
             TO_NUMBER(REGEXP_REPLACE(颅脑损伤患者昏迷时间入院前天,
                                      '[^-0-9.]',
                                      '')) 颅脑损伤患者昏迷时间入院前天,
             TO_NUMBER(REGEXP_REPLACE(颅脑损伤患者昏迷时间入院前小时,
                                      '[^-0-9.]',
                                      '')) 颅脑损伤患者昏迷时间入院前小时,
             TO_NUMBER(REGEXP_REPLACE(颅脑损伤患者昏迷时间入院前分钟,
                                      '[^-0-9.]',
                                      '')) 颅脑损伤患者昏迷时间入院前分钟,
             TO_NUMBER(REGEXP_REPLACE(颅脑损伤患者昏迷时间入院后天,
                                      '[^-0-9.]',
                                      '')) 颅脑损伤患者昏迷时间入院后天,
             TO_NUMBER(REGEXP_REPLACE(颅脑损伤患者昏迷时间入院后小时,
                                      '[^-0-9.]',
                                      '')) 颅脑损伤患者昏迷时间入院后小时,
             TO_NUMBER(REGEXP_REPLACE(颅脑损伤患者昏迷时间入院分钟,
                                      '[^-0-9.]',
                                      '')) 颅脑损伤患者昏迷时间入院分钟,
             
             T.有创呼吸机使用时间,
             TO_NUMBER(T.是否有出院31天在住院计划),
             T.目的,
             T.离院方式,
             T.医嘱转卫生服务机构
        FROM 住院管理_病案首页 T, 住院管理_出院病人信息 TT
       WHERE T.住院病历号 = TT.住院病历号
         AND T.机构编码 = STR_机构编码
         AND T.治疗类别 = '3' --西医
         AND T.出院日期 BETWEEN DAT_出院时间起始 AND DAT_出院时间截止
         AND T.归档人编码 IS NOT NULL
         AND (T.住院病历号 LIKE '%' || STR_过滤数据 || '%' OR
             T.病案号 LIKE '%' || STR_过滤数据 || '%' OR
             T.病人姓名 LIKE '%' || STR_过滤数据 || '%');
  END;

  --更新诊断记录信息
  FOR ROW_诊断记录 IN CUR_诊断记录 LOOP
    EXIT WHEN CUR_诊断记录%NOTFOUND;
    IF ROW_诊断记录.诊断类型 = '出院诊断' THEN
      STR_SQL := 'UPDATE 临时表_病案首页西医_绩效考核 SET C03C=:1,C04N=:2,C05C=:3 WHERE 住院病历号=:4';
      EXECUTE IMMEDIATE STR_SQL
        USING ROW_诊断记录.ICD码, SUBSTR(ROW_诊断记录.疾病名称, 0, 50), ROW_诊断记录.入院病情, ROW_诊断记录.住院病历号;
    ELSIF ROW_诊断记录.诊断类型 = '其他诊断' THEN
      IF ROW_诊断记录.RN < 10 THEN
        STR_编号 := '0' || ROW_诊断记录.RN;
      ELSE
        STR_编号 := ROW_诊断记录.RN;
      END IF;
      STR_SQL := 'UPDATE 临时表_病案首页西医_绩效考核 SET C06x' || STR_编号 || 'C=:1,C07x' ||
                 STR_编号 || 'N=:2,C08x' || STR_编号 || 'C=:3 WHERE 住院病历号=:4';
      EXECUTE IMMEDIATE STR_SQL
        USING ROW_诊断记录.ICD码, SUBSTR(ROW_诊断记录.疾病名称, 0, 50), ROW_诊断记录.入院病情, ROW_诊断记录.住院病历号;
    ELSIF ROW_诊断记录.诊断类型 = '损伤和中毒外部原因' THEN
      STR_SQL := 'UPDATE 临时表_病案首页西医_绩效考核 SET C12C=:1,C13N=:2 WHERE 住院病历号=:3';
      EXECUTE IMMEDIATE STR_SQL
        USING ROW_诊断记录.ICD码, SUBSTR(ROW_诊断记录.疾病名称, 0, 50), ROW_诊断记录.住院病历号;
    ELSIF ROW_诊断记录.诊断类型 = '病理诊断' THEN
      STR_SQL := 'UPDATE 临时表_病案首页西医_绩效考核 SET C09C=:1,C10N=:2 WHERE 住院病历号=:3';
      EXECUTE IMMEDIATE STR_SQL
        USING ROW_诊断记录.ICD码, SUBSTR(ROW_诊断记录.疾病名称, 0, 50), ROW_诊断记录.住院病历号;
    END IF;
  END LOOP;

  --更新费用记录信息
  FOR ROW_费用记录 IN CUR_费用记录 LOOP
    EXIT WHEN CUR_费用记录%NOTFOUND;
    UPDATE 临时表_病案首页西医_绩效考核 T
       SET T.D01    = ROW_费用记录.总金额,
           T.D09    = ROW_费用记录.自付金额,
           T.D11    = ROW_费用记录.一般医疗服务费总,
           T.D12    = ROW_费用记录.一般治疗操作费,
           T.D13    = ROW_费用记录.护理费,
           T.D14    = ROW_费用记录.综合医疗服务类其他费用,
           T.D15    = ROW_费用记录.病理诊断费,
           T.D16    = ROW_费用记录.实验室诊断费,
           T.D17    = ROW_费用记录.影像学诊断费,
           T.D18    = ROW_费用记录.临床诊断项目费,
           T.D19    = ROW_费用记录.非手术治疗项目费,
           T.D19X01 = ROW_费用记录.其中_临床物理治疗费,
           T.D20    = ROW_费用记录.手术治疗费,
           T.D20X01 = ROW_费用记录.其中_麻醉费,
           T.D20X02 = ROW_费用记录.其中_手术费,
           T.D21    = ROW_费用记录.康复费,
           T.D22    = ROW_费用记录.中医治疗费,
           T.D23    = ROW_费用记录.西药费,
           T.D23X01 = ROW_费用记录.其中_抗菌药物费,
           T.D24    = ROW_费用记录.中成药费,
           T.D25    = ROW_费用记录.中草药费,
           T.D26    = ROW_费用记录.血费,
           T.D27    = ROW_费用记录.白蛋白类制品费,
           T.D28    = ROW_费用记录.球蛋白类制品费,
           T.D29    = ROW_费用记录.凝血因子类制品费,
           T.D30    = ROW_费用记录.细胞因子类制品费,
           T.D31    = ROW_费用记录.检查用一次性医用材料费,
           T.D32    = ROW_费用记录.治疗用一次性医用材料费,
           T.D33    = ROW_费用记录.手术用一次性医用材料费,
           T.D34    = ROW_费用记录.其他费
    
     WHERE T.住院病历号 = ROW_费用记录.住院病历号;
  END LOOP;

  --更新手术记录信息
  FOR ROW_手术记录 IN CUR_手术记录 LOOP
    EXIT WHEN CUR_手术记录%NOTFOUND;
  
    IF ROW_手术记录.RN <= 10 THEN
      STR_编号 := '0' || (ROW_手术记录.RN - 1);
    ELSE
      STR_编号 := (ROW_手术记录.RN - 1);
    END IF;
    IF STR_编号 = '00' THEN
      STR_SQL := 'UPDATE 临时表_病案首页西医_绩效考核 SET C14x01C=:1, C16x01=:2, C17x01= :3
               , C15x01N=:4, C18x01=:5, C19x01=:6, C20x01=:7, C21x01C=:8, C22x01C=:9, C23x01=:10 WHERE 住院病历号=:11';
    ELSE
      STR_SQL := 'UPDATE 临时表_病案首页西医_绩效考核 SET C35x' || STR_编号 ||
                 'C=:1, C37x' || STR_编号 || '=:2, C38x' || STR_编号 ||
                 '= :3, C36x' || STR_编号 || 'N=:4, C39x' || STR_编号 ||
                 '=:5, C40x' || STR_编号 || '=:6, C41x' || STR_编号 ||
                 '=:7, C42x' || STR_编号 || 'C=:8, C43x' || STR_编号 ||
                 'C=:9, C44x' || STR_编号 || '=:10  WHERE 住院病历号=:11';
    END IF;
  
    EXECUTE IMMEDIATE STR_SQL
      USING ROW_手术记录.国标码, ROW_手术记录.手术操作日期, ROW_手术记录.手术级别编码, ROW_手术记录.手术操作名称, ROW_手术记录.术者, ROW_手术记录.I助, ROW_手术记录.II助, ROW_手术记录.切口愈合等级编码, ROW_手术记录.麻醉方式编码, ROW_手术记录.麻醉医师, ROW_手术记录.住院病历号;
  
  END LOOP;

  --更新重症监护记录信息
  FOR ROW_重症监护记录 IN CUR_重症监护记录 LOOP
    EXIT WHEN CUR_重症监护记录%NOTFOUND;
  
    STR_编号 := '0' || ROW_重症监护记录.RN; 
    STR_SQL := 'UPDATE 临时表_病案首页西医_绩效考核 SET C48x' || STR_编号 || 'C=:1, C49x' ||
               STR_编号 || '=:2, C50x' || STR_编号 || '= :3 WHERE 住院病历号=:4';
  
    EXECUTE IMMEDIATE STR_SQL
      USING ROW_重症监护记录.科室编码, ROW_重症监护记录.进入时间, ROW_重症监护记录.退出时间, ROW_重症监护记录.住院病历号;
  
  END LOOP;
  --返回数据集
  OPEN CUR_导出_列表信息 FOR
    SELECT T.*
      FROM 临时表_病案首页西医_绩效考核 T
     WHERE T.C04N != '无费退院';

END PR_病案首页西医_绩效考核;
/
