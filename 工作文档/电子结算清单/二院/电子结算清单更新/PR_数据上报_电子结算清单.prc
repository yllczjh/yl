CREATE OR REPLACE PROCEDURE PR_数据上报_电子结算清单(STR_参数          IN VARCHAR2,
                                           CUR_导出_列表信息 OUT SYS_REFCURSOR) IS
  STR_SQL VARCHAR2(1000);

  STR_机构编码     VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 1);
  DAT_出院时间起始 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 2),
                             'yyyy-MM-dd hh24:mi:ss');
  DAT_出院时间截止 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 3),
                             'yyyy-MM-dd hh24:mi:ss');
  STR_过滤数据     VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 4);

  --获取诊断记录CURSOR
  CURSOR CUR_诊断记录_西医 IS
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
             WHERE T.机构编码 = TT.机构编码
               AND T.机构编码 = TTT.机构编码
               AND T.住院病历号 = TT.住院病历号
               AND T.住院病历号 = TTT.住院病历号
               AND T.机构编码 = STR_机构编码
               AND T.诊断分类 = '1'
               AND T.诊断类型 IN ('出院诊断', '其他诊断')
               AND TTT.归档人编码 IS NOT NULL
               AND TT.病人类型编码 = '2'
               AND TT.出院时间 BETWEEN DAT_出院时间起始 AND DAT_出院时间截止
               AND T.创建时间 >= TT.入院时间
               AND (TT.住院病历号 LIKE '%' || STR_过滤数据 || '%' OR
                   TT.病案号 LIKE '%' || STR_过滤数据 || '%' OR
                   TT.病人姓名 LIKE '%' || STR_过滤数据 || '%')) G
     WHERE (G.诊断类型 = '其他诊断' AND G.RN <= 9)
        OR (G.诊断类型 = '出院诊断' AND G.RN = 1);
  ROW_诊断记录_西医 CUR_诊断记录_西医%ROWTYPE;

  CURSOR CUR_诊断记录_中医 IS
    SELECT *
      FROM (SELECT ROW_NUMBER() OVER(PARTITION BY T.住院病历号 ORDER BY T.是否主诊断 DESC) RN,
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
                   
                   (CASE
                     WHEN T.ICD码1 = T.疾病编码1 THEN
                      (SELECT B.ICD码
                         FROM 基础项目_疾病字典 B
                        WHERE B.疾病编码 = T.疾病编码1)
                     ELSE
                      T.ICD码1
                   END) ICD码1,
                   T.疾病名称1,
                   T.入院病情1,
                   
                   (CASE
                     WHEN T.ICD码2 = T.疾病编码2 THEN
                      (SELECT B.ICD码
                         FROM 基础项目_疾病字典 B
                        WHERE B.疾病编码 = T.疾病编码2)
                     ELSE
                      T.ICD码2
                   END) ICD码2,
                   T.疾病名称2,
                   T.入院病情2,
                   
                   (CASE
                     WHEN T.ICD码3 = T.疾病编码3 THEN
                      (SELECT B.ICD码
                         FROM 基础项目_疾病字典 B
                        WHERE B.疾病编码 = T.疾病编码3)
                     ELSE
                      T.ICD码3
                   END) ICD码3,
                   T.疾病名称3,
                   T.入院病情3,
                   
                   (CASE
                     WHEN T.ICD码4 = T.疾病编码4 THEN
                      (SELECT B.ICD码
                         FROM 基础项目_疾病字典 B
                        WHERE B.疾病编码 = T.疾病编码4)
                     ELSE
                      T.ICD码4
                   END) ICD码4,
                   T.疾病名称4,
                   T.入院病情4,
                   
                   (CASE
                     WHEN T.ICD码5 = T.疾病编码5 THEN
                      (SELECT B.ICD码
                         FROM 基础项目_疾病字典 B
                        WHERE B.疾病编码 = T.疾病编码5)
                     ELSE
                      T.ICD码5
                   END) ICD码5,
                   T.疾病名称5,
                   T.入院病情5,
                   
                   (CASE
                     WHEN T.ICD码6 = T.疾病编码6 THEN
                      (SELECT B.ICD码
                         FROM 基础项目_疾病字典 B
                        WHERE B.疾病编码 = T.疾病编码6)
                     ELSE
                      T.ICD码6
                   END) ICD码6,
                   T.疾病名称6,
                   T.入院病情6,
                   
                   (CASE
                     WHEN T.ICD码7 = T.疾病编码7 THEN
                      (SELECT B.ICD码
                         FROM 基础项目_疾病字典 B
                        WHERE B.疾病编码 = T.疾病编码7)
                     ELSE
                      T.ICD码7
                   END) ICD码7,
                   T.疾病名称7,
                   T.入院病情7,
                   
                   (CASE
                     WHEN T.ICD码8 = T.疾病编码8 THEN
                      (SELECT B.ICD码
                         FROM 基础项目_疾病字典 B
                        WHERE B.疾病编码 = T.疾病编码8)
                     ELSE
                      T.ICD码8
                   END) ICD码8,
                   T.疾病名称8,
                   T.入院病情8,
                   
                   (CASE
                     WHEN T.ICD码9 = T.疾病编码9 THEN
                      (SELECT B.ICD码
                         FROM 基础项目_疾病字典 B
                        WHERE B.疾病编码 = T.疾病编码9)
                     ELSE
                      T.ICD码9
                   END) ICD码9,
                   T.疾病名称9,
                   T.入院病情9
              FROM 住院管理_在院病人诊断 T,
                   住院管理_出院病人信息 TT,
                   住院管理_病案首页     TTT
             WHERE T.住院病历号 = TT.住院病历号
               AND T.住院病历号 = TTT.住院病历号
               AND T.机构编码 = STR_机构编码
               AND T.诊断分类 = '2'
               AND TT.病人类型编码 = '2' --医保
               AND TTT.归档人编码 IS NOT NULL
               AND TT.出院时间 BETWEEN DAT_出院时间起始 AND DAT_出院时间截止
               AND T.创建时间 >= TT.入院时间
               AND (TT.住院病历号 LIKE '%' || STR_过滤数据 || '%' OR
                   TT.病案号 LIKE '%' || STR_过滤数据 || '%' OR
                   TT.病人姓名 LIKE '%' || STR_过滤数据 || '%')) G
     WHERE G.RN = 1;
  ROW_诊断记录_中医 CUR_诊断记录_中医%ROWTYPE;

  --获取手术记录CURSOR
  CURSOR CUR_手术记录 IS
    SELECT *
      FROM (SELECT ROW_NUMBER() OVER(PARTITION BY T.住院病历号 ORDER BY T.流水码 DESC) RN,
                   T.住院病历号,
                   T.手术操作名称,
                   T.国标码,
                   T.手术操作日期,
                   T.麻醉方式编码,
                   (SELECT A.人员姓名
                      FROM 基础项目_人员资料 A
                     WHERE A.机构编码 = T.机构编码
                       AND A.删除标志 = '0'
                       AND A.人员编码 = T.术者) AS 术者姓名,
                   T.术者,
                   (SELECT A.人员姓名
                      FROM 基础项目_人员资料 A
                     WHERE A.机构编码 = T.机构编码
                       AND A.删除标志 = '0'
                       AND A.人员编码 = T.麻醉医师) AS 麻醉医师姓名,
                   T.麻醉医师
              FROM 住院管理_病案首页手术表 T,
                   住院管理_出院病人信息   TT,
                   住院管理_病案首页       TTT
             WHERE T.机构编码 = TT.机构编码
               AND T.机构编码 = TTT.机构编码
               AND T.住院病历号 = TT.住院病历号
               AND T.住院病历号 = TTT.住院病历号
               AND T.机构编码 = STR_机构编码
               AND TT.病人类型编码 = '2'
               AND TTT.归档人编码 IS NOT NULL
               AND TT.出院时间 BETWEEN DAT_出院时间起始 AND DAT_出院时间截止
               AND T.创建时间 >= TT.入院时间
               AND (TT.住院病历号 LIKE '%' || STR_过滤数据 || '%' OR
                   TT.病案号 LIKE '%' || STR_过滤数据 || '%' OR
                   TT.病人姓名 LIKE '%' || STR_过滤数据 || '%')) G
     WHERE G.RN <= 10;

  ROW_手术记录 CUR_手术记录%ROWTYPE;

  /*--获取费用记录CURSOR
  CURSOR CUR_费用记录 IS
    SELECT T.机构编码,
           T.住院病历号,
           SUM(T.总金额) AS 总金额,
           NVL(SUM(CASE T.费用名称
                     WHEN '床位费' THEN
                      T.总金额
                   END),
               0) AS 床位费,
           NVL(SUM(CASE T.费用名称
                     WHEN '诊察费' THEN
                      T.总金额
                   END),
               0) AS 诊察费,
           NVL(SUM(CASE T.费用名称
                     WHEN '检查费' THEN
                      T.总金额
                   END),
               0) AS 检查费,
           NVL(SUM(CASE T.费用名称
                     WHEN '化验费' THEN
                      T.总金额
                   END),
               0) AS 化验费,
           NVL(SUM(CASE T.费用名称
                     WHEN '治疗费' THEN
                      T.总金额
                   END),
               0) AS 治疗费,
           NVL(SUM(CASE T.费用名称
                     WHEN '手术费' THEN
                      T.总金额
                   END),
               0) AS 手术费,
           NVL(SUM(CASE T.费用名称
                     WHEN '护理费' THEN
                      T.总金额
                   END),
               0) AS 护理费,
           NVL(SUM(CASE T.费用名称
                     WHEN '卫生材料费' THEN
                      T.总金额
                   END),
               0) AS 卫生材料费,
           NVL(SUM(CASE T.费用名称
                     WHEN '西药费' THEN
                      T.总金额
                   END),
               0) AS 西药费,
           NVL(SUM(CASE T.费用名称
                     WHEN '中药饮片费' THEN
                      T.总金额
                   END),
               0) AS 中药饮片费,
           NVL(SUM(CASE T.费用名称
                     WHEN '中成药费' THEN
                      T.总金额
                   END),
               0) AS 中成药费,
           NVL(SUM(CASE T.费用名称
                     WHEN '一般诊疗费' THEN
                      T.总金额
                   END),
               0) AS 一般诊疗费,
           NVL(SUM(CASE T.费用名称
                     WHEN '挂号费' THEN
                      T.总金额
                   END),
               0) AS 挂号费,
           NVL(SUM(CASE T.费用名称
                     WHEN '其他费' THEN
                      T.总金额
                   END),
               0) AS 其他费
      FROM (SELECT C.机构编码,
                   C.住院病历号,
                   C.记账时间,
                   NVL((SELECT CASE
                                WHEN X.名称 IN ('床位费',
                                              '诊查费',
                                              '检查费',
                                              '治疗费',
                                              '手术费',
                                              '护理费',
                                              '卫生材料费',
                                              '西药费' ， '中成药费',
                                              '挂号费') THEN
                                 X.名称
                                WHEN X.名称 = '检验费' THEN
                                 '化验费'
                                WHEN X.名称 = '中草药费' THEN
                                 '中药饮片费'
                                ELSE
                                 '其他费'
                              END AS 名称
                         FROM 基础项目_费用归类 G, 基础项目_字典明细 X
                        WHERE G.机构编码 = C.机构编码
                          AND G.删除标志 = '0'
                          AND G.类别 = '住院发票项目归类'
                          AND X.分类编码 = 'GB_009001'
                          AND G.费用编码 = C.归类编码
                          AND G.隶属编码 = X.编码),
                       '') AS 费用名称,
                   C.总金额
              FROM 住院管理_出院病人处方 C) T,
           住院管理_出院病人信息 TT,
           住院管理_病案首页 TTT
     WHERE T.机构编码 = TT.机构编码
       AND T.机构编码 = TTT.机构编码
       AND T.住院病历号 = TT.住院病历号
       AND T.住院病历号 = TTT.住院病历号
       AND T.机构编码 = STR_机构编码
       AND TTT.归档人编码 IS NOT NULL
       AND TT.病人类型编码 = '2'
       AND TT.出院时间 BETWEEN DAT_出院时间起始 AND DAT_出院时间截止
       AND T.记账时间 >= TT.入院时间
       AND (TT.住院病历号 LIKE '%' || STR_过滤数据 || '%' OR
           TT.病案号 LIKE '%' || STR_过滤数据 || '%' OR
           TT.病人姓名 LIKE '%' || STR_过滤数据 || '%')
     GROUP BY T.机构编码, T.住院病历号;
  
  ROW_费用记录 CUR_费用记录%ROWTYPE;*/

  --获取重症监护记录CURSOR
  CURSOR CUR_重症监护记录 IS
    SELECT *
      FROM (SELECT ROW_NUMBER() OVER(PARTITION BY T.住院病历号 ORDER BY T.流水码 DESC) RN,
                   '9' AS 科室名称,
                   T.进入时间,
                   T.退出时间,
                   (T.退出时间 - T.进入时间) * 24 AS 合计时间,
                   T.住院病历号
              FROM 住院管理_病案首页_重症监护 T,
                   住院管理_出院病人信息      TT,
                   住院管理_病案首页          TTT
             WHERE T.机构编码 = TT.机构编码
               AND T.机构编码 = TTT.机构编码
               AND T.住院病历号 = TT.住院病历号
               AND T.住院病历号 = TTT.住院病历号
               AND T.机构编码 = STR_机构编码
               AND TT.病人类型编码 = '2'
               AND TTT.归档人编码 IS NOT NULL
               AND TT.出院时间 BETWEEN DAT_出院时间起始 AND DAT_出院时间截止
               AND T.更新时间 >= TT.入院时间
               AND (TT.住院病历号 LIKE '%' || STR_过滤数据 || '%' OR
                   TT.病案号 LIKE '%' || STR_过滤数据 || '%' OR
                   TT.病人姓名 LIKE '%' || STR_过滤数据 || '%')) G
     WHERE G.RN <= 6;

  ROW_重症监护记录 CUR_重症监护记录%ROWTYPE;

BEGIN

  BEGIN
  
    DELETE FROM 临时表_数据上报_电子结算清单;
  
    --更新基本信息
    INSERT INTO 临时表_数据上报_电子结算清单
      (病历号,
       MS_ID, --结算清单 ID
       BAH, --病案号
       DDYLJGMC, --定点医疗机构名称
       DDYLJGDM, --定点医疗机构代码
       YBJSDJ, --医保结算等级
       YBBH, --医保编号
       SBSJ, --申报时间
       XM, --姓名
       XB, --性别
       CSRQ, --出生日期
       NL, --年龄
       BZZSNL, --不足一周岁年龄
       GJ, --国籍
       MZ, --民族
       ZJLX, --患者证件类型
       ZJHM, --患者证件号码
       ZY, --职业
       XZZ, --现住址
       XZZ_S, --现住址-省
       XZZ_SHI, --现住址-市
       XZZ_X, --现住址-县
       XZZ_Z, --现住址-镇村
       GZDWMC, --工作单位名称
       GZDWDZ, --工作单位地址
       GZDWDH, --工作单位电话
       GZDWYB, --工作单位邮编
       LXRXM, --联系人姓名
       LXRGX, --联系人关系
       LXRDZ, --联系人地址
       LXRDZ_S, --联系人地址-省
       LXRDZ_SHI, --联系人地址-市
       LXRDZ_X, --联系人地址-县
       LXRDZ_Z, --联系人地址-镇村
       LXRDH, --联系人电话
       YBLX, --医保类型
       TSRYLX, --特殊人员类型
       CBD, --参保地
       XSEYYLX, --新生儿入院类型
       XSECSTZ, --新生儿出生体重
       XSERYTZ, --新生儿入院体重       
       
       --门诊慢性病相关
       
       ZYYLLX, --住院医疗类型
       RYTJ, --入院途径
       ZLLB, --治疗类别
       RYSJ, --入院时间
       RYKB, --入院科别代码
       RYKBMC, --入院科别名称
       ZKKB, --转科科别代码
       ZKKBMC, --转科科别名称
       CYSJ, --出院时间
       CYKB, --出院科别代码
       CYKBMC, --出院科别名称
       SJZYTS, --实际住院天数
       mjzzd_xy, --门急诊诊断名称_西医
       mjzzddm_xy, --门急诊诊断代码_西医
       mjzzd_zy, --门急诊诊断名称_中医
       mjzzddm_zy, --门急诊诊断代码_中医
       
       --诊断相关
       
       --手术相关
       
       HXJSYSJ_T, --呼吸机使用时间-天
       HXJSYSJ_XS, --呼吸机使用时间-小时
       HXJSYSJ_F, --呼吸机使用时间-分钟
       RYQ_T, --颅脑损伤患者昏迷入院前时间：天
       RYQ_XS, --颅脑损伤患者昏迷入院前时间：小时
       RYQ_F, --颅脑损伤患者昏迷入院前时间：分
       RYH_T, --颅脑损伤患者昏迷入院后时间：天
       RYH_XS, --颅脑损伤患者昏迷入院后时间：小时
       RYH_F, --颅脑损伤患者昏迷入院后时间：分
       
       --重症监护
       
       SXPZ, --输血品种
       SXL, --输血量
       SXJLDW, --输血计量单位
       TJHLTS, --特级护理天数
       YJHLTS, --一级护理天数
       EJHLTS, --二级护理天数
       SJHLTS, --三级护理天数
       LYFS, -- 离院方式
       NJSJGMC, --医嘱转院拟接收机构名称
       NJSJGDM, --医嘱转院拟接收机构代码
       SFZZYJH, --是否有出院31天再住院计划
       MD, --再住院目的
       ZZYSXM, --主诊医师姓名
       ZZYSDM, --主诊医师代码
       YWLSH, --医疗收费信息业务流水号
       JSSJ_KS, --结算时间_开始
       JSSJ_JS, --结算时间_结束
       
       --费用相关
       YLJGTBBM, --医疗机构填报部门代码
       YLJGTBBMMC, --医疗机构填报部门名称
       YLJGTBR, --医疗机构填报人编号
       YLJGTBRXM, --医疗机构填报人名称
       DMDATE_ID, --上报标识
       QDLSH, -- 清单流水号
       PJDM, --票据代码
       PJHM, --票据号码
       YBJGDM, --医保机构代码
       YBJGJBRDM, --医保机构经办人代码
       ORG_CODE --机构代码
       
       )
      SELECT T.住院病历号,
             T.住院病历号,
             T.病案号,
             '营口市中西医结合医院（营口经济技术开发区第二人民医院）',
             '001026',
             '2',
             T.身份证号,
             SYSDATE,
             T.病人姓名,
             T.性别,
             T.出生日期,
             TO_NUMBER(REGEXP_REPLACE(T.年龄, '[^-0-9.]', '')) 年龄,
             TO_NUMBER(nvl(REGEXP_REPLACE(T.年龄不足1周岁, '[^-0-9.]', ''),
                           '0')),
             '156', --中国
             CASE
               WHEN TO_NUMBER(NVL(T.民族, '1')) < 10 THEN
                '0' || NVL(T.民族, '1')
               ELSE
                T.民族
             END,
             NVL(T.证件类别, '01'),
             T.身份证号,
             T.职业,
             T.现住址,
             NULL,
             NULL,
             NULL,
             NULL,
             T.工作单位,
             T.工作单位地址,
             SUBSTR(T.工作电话, 0, 20),
             T.工作邮政编码,
             T.联系人姓名,
             T.关系,
             T.联系人地址,
             NULL,
             NULL,
             NULL,
             NULL,
             T.联系人电话,
             T.医疗付费方式,
             '9',
             (SELECT J.C_3
                FROM 接口管理_接口补偿信息 J
               WHERE J.机构编码 = T.机构编码
                 AND J.病历号 = T.住院病历号),
             NULL,
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
             
             --门诊慢性病相关
             
             '1',
             T.入院途径,
             T.治疗类别,
             T.入院日期,
             (SELECT A.科室类别
                FROM 基础项目_科室补充资料 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.科室编码 = T.入院科室编码) 入院科别,
             
             (SELECT A.科室类别
                FROM 基础项目_科室补充资料 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.科室编码 = T.入院科室编码) 入院科别,
             NVL((SELECT 转出科室编码
                   FROM 住院管理_在院病人转科记录
                  WHERE 机构编码 = STR_机构编码
                    AND 住院病历号 = T.住院病历号
                    AND ROWNUM = 1),
                 (SELECT A.科室类别
                    FROM 基础项目_科室补充资料 A
                   WHERE A.机构编码 = STR_机构编码
                     AND A.科室编码 = T.入院科室编码)) 转科科别,
             NVL((SELECT 转出科室编码
                   FROM 住院管理_在院病人转科记录
                  WHERE 机构编码 = STR_机构编码
                    AND 住院病历号 = T.住院病历号
                    AND ROWNUM = 1),
                 (SELECT A.科室类别
                    FROM 基础项目_科室补充资料 A
                   WHERE A.机构编码 = STR_机构编码
                     AND A.科室编码 = T.入院科室编码)) 转科科别,
             T.出院日期,
             (SELECT A.科室类别
                FROM 基础项目_科室补充资料 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.科室编码 = T.出院科室编码) 出院科别,
             (SELECT A.科室类别
                FROM 基础项目_科室补充资料 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.科室编码 = T.出院科室编码) 出院科别,
             T.住院天数,
             
             (SELECT A.疾病名称
                FROM 住院管理_在院病人诊断 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.住院病历号 = T.住院病历号
                 AND A.诊断类型 = '门诊诊断'
                 AND A.诊断分类 = '1'
                 AND ROWNUM = 1) AS 门诊诊断名称西医,
             
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
                 AND ROWNUM = 1) AS 疾病编码西医,
             
             (SELECT A.疾病名称
                FROM 住院管理_在院病人诊断 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.住院病历号 = T.住院病历号
                 AND A.诊断类型 = '门诊诊断'
                 AND A.诊断分类 = '2'
                 AND ROWNUM = 1) AS 门诊诊断名称中医,
             
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
                 AND ROWNUM = 2) AS 疾病编码中医,
             --诊断相关
             
             --手术相关
             
             trunc(TO_NUMBER(nvl(REGEXP_REPLACE(T.有创呼吸机使用时间,
                                                '[^0-9.]',
                                                ''),
                                 '0')) / 24),
             
             trunc(mod(TO_NUMBER(nvl(REGEXP_REPLACE(T.有创呼吸机使用时间,
                                                    '[^0-9.]',
                                                    ''),
                                     '0')),
                       24)),
             0,
             TO_NUMBER(REGEXP_REPLACE(T.颅脑损伤患者昏迷时间入院前天,
                                      '[^-0-9.]',
                                      '')) 颅脑损伤患者昏迷时间入院前天,
             TO_NUMBER(REGEXP_REPLACE(T.颅脑损伤患者昏迷时间入院前小时,
                                      '[^-0-9.]',
                                      '')) 颅脑损伤患者昏迷时间入院前小时,
             TO_NUMBER(REGEXP_REPLACE(T.颅脑损伤患者昏迷时间入院前分钟,
                                      '[^-0-9.]',
                                      '')) 颅脑损伤患者昏迷时间入院前分钟,
             TO_NUMBER(REGEXP_REPLACE(T.颅脑损伤患者昏迷时间入院后天,
                                      '[^-0-9.]',
                                      '')) 颅脑损伤患者昏迷时间入院后天,
             TO_NUMBER(REGEXP_REPLACE(T.颅脑损伤患者昏迷时间入院后小时,
                                      '[^-0-9.]',
                                      '')) 颅脑损伤患者昏迷时间入院后小时,
             TO_NUMBER(REGEXP_REPLACE(T.颅脑损伤患者昏迷时间入院分钟,
                                      '[^-0-9.]',
                                      '')) 颅脑损伤患者昏迷时间入院分钟,
             
             --重症监护
             
             NULL,
             NULL,
             NULL,
             T.特级护理天数,
             T.一级护理天数,
             T.二级护理天数,
             T.三级护理天数,
             T.离院方式,
             T.医嘱转院,
             T.医嘱转卫生服务机构,
             T.是否有出院31天在住院计划,
             T.目的,
             (SELECT R.人员姓名
                FROM 基础项目_人员资料 R
               WHERE R.机构编码 = T.机构编码
                 AND R.人员编码 = T.主治医师),
             '',
             NULL,
             (SELECT to_date(J.C_21, 'yyyy-MM-dd hh24:mi:ss')
                FROM 接口管理_接口补偿信息 J
               WHERE J.机构编码 = T.机构编码
                 AND J.病历号 = T.住院病历号),
             (SELECT to_date(J.C_21, 'yyyy-MM-dd hh24:mi:ss')
                FROM 接口管理_接口补偿信息 J
               WHERE J.机构编码 = T.机构编码
                 AND J.病历号 = T.住院病历号),
             
             --费用相关
             
             '001026',
             '营口市中西医结合医院（营口经济技术开发区第二人民医院）',
             '1314',
             '管玉红',
             '001026' || TO_CHAR(SYSDATE, 'yyyyMMddhh24miss'),
             NULL,
             NULL,
             NULL,
             '001026',
             NULL,
             '122108044641640037'
      
        FROM 住院管理_病案首页     T,
             住院管理_出院病人信息 TT,
             接口管理_接口补偿信息 TTT
       WHERE T.机构编码 = TT.机构编码
         and TT.机构编码 = TTT.机构编码
         AND T.住院病历号 = TT.住院病历号
         AND TT.住院病历号 = TTT.病历号
         AND T.机构编码 = STR_机构编码
         AND T.归档人编码 IS NOT NULL
         AND TT.病人类型编码 = '2'
         AND T.出院日期 BETWEEN DAT_出院时间起始 AND DAT_出院时间截止
         AND (T.住院病历号 LIKE '%' || STR_过滤数据 || '%' OR
             T.病案号 LIKE '%' || STR_过滤数据 || '%' OR
             T.病人姓名 LIKE '%' || STR_过滤数据 || '%');
  END;

  --更新西医诊断记录信息
  FOR ROW_诊断记录_西医 IN CUR_诊断记录_西医 LOOP
    EXIT WHEN CUR_诊断记录_西医%NOTFOUND;
    IF ROW_诊断记录_西医.诊断类型 = '出院诊断' THEN
      STR_SQL := 'UPDATE 临时表_数据上报_电子结算清单 SET ZYZD=:1,ZYZDDM=:2,RYBQ=:3 WHERE 病历号=:4';
      EXECUTE IMMEDIATE STR_SQL
        USING ROW_诊断记录_西医.疾病名称, ROW_诊断记录_西医.ICD码, ROW_诊断记录_西医.入院病情, ROW_诊断记录_西医.住院病历号;
    ELSIF ROW_诊断记录_西医.诊断类型 = '其他诊断' THEN
      STR_SQL := 'UPDATE 临时表_数据上报_电子结算清单 SET QTZD' || ROW_诊断记录_西医.RN ||
                 '=:1,QTZDDM' || ROW_诊断记录_西医.RN || '=:2,QTZDRYBQ' ||
                 ROW_诊断记录_西医.RN || '=:3 WHERE 病历号=:4';
      EXECUTE IMMEDIATE STR_SQL
        USING ROW_诊断记录_西医.疾病名称, ROW_诊断记录_西医.ICD码, ROW_诊断记录_西医.入院病情, ROW_诊断记录_西医.住院病历号;
    END IF;
  END LOOP;

  --更新中医诊断记录信息
  FOR ROW_诊断记录_中医 IN CUR_诊断记录_中医 LOOP
    EXIT WHEN CUR_诊断记录_中医%NOTFOUND;
    --中医
    STR_SQL := 'UPDATE 临时表_数据上报_电子结算清单 SET ZBZD=:1,ZBZDDM=:2, ZBZDRYBQ=:3,
                   ZZZD1=:4,ZZZDDM1=:5,ZZZDRYBQ1=:6 ,
                   ZZZD2=:7,ZZZDDM2=:8,ZZZDRYBQ2=:9,
                   ZZZD3=:10,ZZZDDM3=:11,ZZZDRYBQ3=:12,
                   ZZZD4=:13,ZZZDDM4=:14,ZZZDRYBQ4=:15, 
                   ZZZD5=:16,ZZZDDM5=:17,ZZZDRYBQ5=:18, 
                   ZZZD6=:19,ZZZDDM6=:20,ZZZDRYBQ6=:21, 
                   ZZZD7=:22,ZZZDDM7=:23,ZZZDRYBQ7=:24, 
                   ZZZD8=:25,ZZZDDM8=:26,ZZZDRYBQ8=:27, 
                   ZZZD9=:28,ZZZDDM9=:29,ZZZDRYBQ9=:30
                   WHERE 病历号=:31';
  
    EXECUTE IMMEDIATE STR_SQL
      USING ROW_诊断记录_中医.疾病名称, SUBSTR(ROW_诊断记录_中医.ICD码, 0, 6), ROW_诊断记录_中医.入院病情, ROW_诊断记录_中医.疾病名称1, SUBSTR(ROW_诊断记录_中医.ICD码1, 0, 6), ROW_诊断记录_中医.入院病情1, ROW_诊断记录_中医.疾病名称2, SUBSTR(ROW_诊断记录_中医.ICD码2, 0, 6), ROW_诊断记录_中医.入院病情2, ROW_诊断记录_中医.疾病名称3, SUBSTR(ROW_诊断记录_中医.ICD码3, 0, 6), ROW_诊断记录_中医.入院病情3, ROW_诊断记录_中医.疾病名称4, SUBSTR(ROW_诊断记录_中医.ICD码4, 0, 6), ROW_诊断记录_中医.入院病情4, ROW_诊断记录_中医.疾病名称5, SUBSTR(ROW_诊断记录_中医.ICD码5, 0, 6), ROW_诊断记录_中医.入院病情5, ROW_诊断记录_中医.疾病名称6, SUBSTR(ROW_诊断记录_中医.ICD码6, 0, 6), ROW_诊断记录_中医.入院病情6, ROW_诊断记录_中医.疾病名称7, SUBSTR(ROW_诊断记录_中医.ICD码7, 0, 6), ROW_诊断记录_中医.入院病情7, ROW_诊断记录_中医.疾病名称8, SUBSTR(ROW_诊断记录_中医.ICD码8, 0, 6), ROW_诊断记录_中医.入院病情8, ROW_诊断记录_中医.疾病名称9, SUBSTR(ROW_诊断记录_中医.ICD码9, 0, 6), ROW_诊断记录_中医.入院病情9, ROW_诊断记录_中医.住院病历号;
  END LOOP;

  --更新费用记录信息
  /*FOR ROW_费用记录 IN CUR_费用记录 LOOP
    EXIT WHEN CUR_费用记录%NOTFOUND;
    UPDATE 临时表_数据上报_电子结算清单 T
       SET T.CWF_DM     = '01',
           T.CWF_MC     = '床位费',
           T.CWF_XMJE   = ROW_费用记录.床位费,
           T.ZCF_DM     = '02',
           T.ZCF_MC     = '诊察费',
           T.ZCF_XMJE   = ROW_费用记录.诊察费,
           T.JCF_DM     = '03',
           T.JCF_MC     = '检查费',
           T.JCF_XMJE   = ROW_费用记录.检查费,
           T.HYF_DM     = '04',
           T.HYF_MC     = '化验费',
           T.HYF_XMJE   = ROW_费用记录.化验费,
           T.ZLF_DM     = '05',
           T.ZLF_MC     = '治疗费',
           T.ZLF_XMJE   = ROW_费用记录.治疗费,
           T.SSF_DM     = '06',
           T.SSF_MC     = '手术费',
           T.SSF_XMJE   = ROW_费用记录.手术费,
           T.HLF_DM     = '07',
           T.HLF_MC     = '护理费',
           T.HLF_XMJE   = ROW_费用记录.护理费,
           T.WSCLF_DM   = '08',
           T.WSCLF_MC   = '卫生材料费',
           T.WSCLF_XMJE = ROW_费用记录.卫生材料费,
           T.XYF_DM     = '09',
           T.XYF_MC     = '西药费',
           T.XYF_XMJE   = ROW_费用记录.西药费,
           T.ZYYPF_DM   = '10',
           T.ZYYPF_MC   = '中药饮片费',
           T.ZYYPF_XMJE = ROW_费用记录.中药饮片费,
           T.ZCYF_DM    = '11',
           T.ZCYF_MC    = '中成药费',
           T.ZCYF_XMJE  = ROW_费用记录.中成药费,
           T.YBZLF_DM   = '12',
           T.YBZLF_MC   = '一般诊疗费',
           T.YBZLF_XMJE = ROW_费用记录.一般诊疗费,
           T.GHF_DM     = '13',
           T.GHF_MC     = '挂号费',
           T.GHF_XMJE   = ROW_费用记录.挂号费,
           T.QTF_DM     = '14',
           T.QTF_MC     = '其他费',
           T.QTF_XMJE   = ROW_费用记录.其他费,
           T.YLZFY      = ROW_费用记录.总金额
     WHERE T.病历号 = ROW_费用记录.住院病历号;
  END LOOP;*/

  --更新手术记录信息
  FOR ROW_手术记录 IN CUR_手术记录 LOOP
    EXIT WHEN CUR_手术记录%NOTFOUND;
  
    IF ROW_手术记录.RN = 1 THEN
      STR_SQL := 'UPDATE 临时表_数据上报_电子结算清单 SET ZYSSCZMC=:1,ZYSSCZDM=:2,ZYSSCZRQ=:3
               ,ZYMZFS=:4,ZYSZYSXM=:5,ZYSZYSDM=:6,ZYMZYSXM=:7,ZYMZYSDM=:8,SSCZDMJS=:9 WHERE 病历号=:10';
    ELSE
      STR_SQL := 'UPDATE 临时表_数据上报_电子结算清单 SET SSCZMC' || (ROW_手术记录.RN - 1) ||
                 '=:1, SSCZDM' || (ROW_手术记录.RN - 1) || '=:2, SSCZRQ' ||
                 (ROW_手术记录.RN - 1) || '= :3
               , MZFS' || (ROW_手术记录.RN - 1) ||
                 '=:4,   SZYSXM' || (ROW_手术记录.RN - 1) || '=:5, SZYSDM' ||
                 (ROW_手术记录.RN - 1) || '=:6, MZYSXM' || (ROW_手术记录.RN - 1) ||
                 '=:7, MZYSDM' || (ROW_手术记录.RN - 1) ||
                 '=:8,SSCZDMJS=:9 WHERE 病历号=:10';
    END IF;
  
    EXECUTE IMMEDIATE STR_SQL
      USING ROW_手术记录.手术操作名称, ROW_手术记录.国标码, ROW_手术记录.手术操作日期, ROW_手术记录.麻醉方式编码, ROW_手术记录.术者姓名, ROW_手术记录.术者, ROW_手术记录.麻醉医师姓名, ROW_手术记录.麻醉医师, ROW_手术记录.RN, ROW_手术记录.住院病历号;
  END LOOP;

  --更新重症监护记录信息
  FOR ROW_重症监护记录 IN CUR_重症监护记录 LOOP
    EXIT WHEN CUR_重症监护记录%NOTFOUND;
    STR_SQL := 'UPDATE 临时表_数据上报_电子结算清单 SET ZZJHBFLX' || ROW_重症监护记录.RN ||
               '=:1, JZZJHSSJ' || ROW_重症监护记录.RN || '=:2, CZZJHSSJ' ||
               ROW_重症监护记录.RN || '= :3, HJ' || ROW_重症监护记录.RN ||
               '= :4 WHERE 病历号=:5';
  
    EXECUTE IMMEDIATE STR_SQL
      USING ROW_重症监护记录.科室名称, ROW_重症监护记录.进入时间, ROW_重症监护记录.退出时间, ROW_重症监护记录.合计时间, ROW_重症监护记录.住院病历号;
  END LOOP;

  --返回数据集
  OPEN CUR_导出_列表信息 FOR
    SELECT ROW_NUMBER() OVER(ORDER BY T.病历号) 序号, T.*
      FROM 临时表_数据上报_电子结算清单 T;

END PR_数据上报_电子结算清单;
/
