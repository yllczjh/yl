CREATE OR REPLACE PROCEDURE PR_病案首页_获取导出数据(STR_参数          IN VARCHAR2,
                                           CUR_导出_列表信息 OUT SYS_REFCURSOR) IS
  STR_机构名称 VARCHAR2(100);
  STR_SQL      VARCHAR2(1000);

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
                   TO_CHAR(T.手术操作日期, 'yyyy-MM-dd') 手术操作日期,
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
                   DECODE(FU_通用_截取字符串值(T.切口愈合等级, '/', 1),
                          'Ⅰ',
                          '2',
                          'Ⅱ',
                          '3',
                          'Ⅲ',
                          '4',
                          '') 切口等级,
                   DECODE(FU_通用_截取字符串值(T.切口愈合等级, '/', 2),
                          '甲',
                          '1',
                          '乙',
                          '2',
                          '丙',
                          '3',
                          '9',
                          '') 切口愈合等级,
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
       AND TTT.归档人编码 IS NOT NULL
       AND TT.出院时间 BETWEEN DAT_出院时间起始 AND DAT_出院时间截止
       AND T.记账时间 >= TT.入院时间
       AND (TT.住院病历号 LIKE '%' || STR_过滤数据 || '%' OR
           TT.病案号 LIKE '%' || STR_过滤数据 || '%' OR
           TT.病人姓名 LIKE '%' || STR_过滤数据 || '%')
     GROUP BY T.机构编码, T.住院病历号;

  ROW_费用记录 CUR_费用记录%ROWTYPE;

BEGIN

  --获取机构名称
  BEGIN
    SELECT A.机构名称
      INTO STR_机构名称
      FROM 基础项目_机构资料 A
     WHERE A.机构编码 = STR_机构编码
       AND ROWNUM = 1;
  EXCEPTION
    WHEN OTHERS THEN
      STR_机构名称 := '';
  END;

  BEGIN
  
    DELETE FROM 临时表_病案首页新;
  
    --更新基本信息
    INSERT INTO 临时表_病案首页新
      (住院病历号,
       USERNAME, --机构名称
       YLFKFS, --付款方式
       JKKH, --健康卡号
       ZYCS, --住院次数
       BAH, --病案号
       XM, --病人姓名
       XB, --性别
       CSRQ, --出生日期
       NL, --年龄
       GJ, --国籍
       BZYZSNL, --年龄不足1周岁
       XSECSTZ, --新生儿出生体重
       XSERYTZ, --新生儿入院体重
       CSD, --出生地
       GG, --籍贯
       MZ, --民族
       SFZH, --身份证号
       ZY, --职业
       HY, --婚姻
       XZZ, --现住址
       DH, --电话
       YB1, --邮编
       HKDZ, --户口地址,
       YB2, --邮编
       GZDWJDZ, --工作单位及地址
       DWDH, --单位电话
       YB3, --邮编
       LXRXM, --联系人姓名
       GX, --关系
       DZ, --地址
       DH2, --电话
       RYTJ, --入院途径
       RYSJ, --入院时间
       RYSJS, --时
       RYKB, --入院科别
       RYBF, --入院病房
       ZKKB, --转科科别
       CYSJ, --出院时间
       CYSJS, --时
       CYKB, --出院科别
       CYBF, --出院病房
       SJZYTS, --实际住院(天)
       MZZD, --门(急)诊诊断
       JBBM, --疾病编码   
       --省略若干诊断
       BLH, --病理号
       YWGM, --药物过敏
       GMYW, --过敏药物
       SWHZSJ, --死亡患者尸检
       XX, --血型
       RH,
       KZR, --科主任
       ZRYS, --主任（副主任）医师
       ZZYS, --主治医师
       ZYYS, --住院医师
       ZRHS, --责任护士
       JXYS, --进修医师住
       SXYS, --实习医师
       BMY, --编码员
       BAZL, --病案质量
       ZKYS, --质控医师
       ZKHS, --质控护士
       ZKRQ, --质控日期   
       --省略手术相关
       LYFS, --离院方式
       YZZY_YLJG, --医嘱转院，拟接收医疗机构名称
       WSY_YLJG, --医嘱转社区卫生服务机构/乡镇卫生院，拟接收医疗机构名称
       SFZZYJH, --是否有出院31天内再住院计划手术情况
       MD, --目的
       RYQ_T, --颅脑损伤患者昏迷入院前时间天
       RYQ_XS, --小时
       RYQ_F, --分钟
       RYH_T, --颅脑损伤患者昏迷入院后时间天
       RYH_XS, --小时
       RYH_F --分钟  
       --省略费用若干
       )
      SELECT T.住院病历号,
             STR_机构名称,
             T.医疗付费方式,
             T.健康卡号,
             T.住院次数,
             T.病案号,
             T.病人姓名,
             NVL(T.性别, '0'),
             TO_CHAR(T.出生日期, 'yyyy-MM-dd') 出生日期,
             TO_NUMBER(REGEXP_REPLACE(T.年龄, '[^-0-9.]', '')) 年龄,
             T.国籍,
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
             ((SELECT 名称
                 FROM 基础项目_字典明细
                WHERE 分类编码 = 'RC036'
                  AND 删除标志 = '0'
                  AND 编码 = T.出生地省) || T.出生地市 || T.出生地县) AS 出生地,
             ((SELECT 名称
                 FROM 基础项目_字典明细
                WHERE 分类编码 = 'RC036'
                  AND 删除标志 = '0'
                  AND 编码 = T.籍贯省) || T.籍贯市 || T.出生地县) AS 籍贯,
             T.民族,
             T.身份证号,
             T.职业,
             T.婚姻,
             T.现住址,
             T.户口电话,
             T.现住址邮编,
             T.户口地址,
             T.户口邮政编码,
             T.工作单位地址,
             T.工作电话,
             T.工作邮政编码,
             T.联系人姓名,
             T.关系,
             T.联系人地址,
             T.联系人电话,
             T.入院途径,
             TO_CHAR(T.入院日期, 'yyyy-MM-dd') AS 入院日期,
             TO_CHAR(T.入院日期, 'HH') 时,
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
             TO_CHAR(T.出院日期, 'yyyy-MM-dd') AS 出院日期,
             TO_CHAR(T.出院日期, 'HH') 时,
             (SELECT A.科室类别
                FROM 基础项目_科室补充资料 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.科室编码 = T.出院科室编码) 出院科室编码,
             T.出院病室,
             T.住院天数,
             (SELECT A.疾病名称
                FROM 住院管理_在院病人诊断 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.住院病历号 = T.住院病历号
                 AND A.诊断类型 = '门诊诊断'
                 AND A.诊断分类 = '1'
                 AND ROWNUM = 1) AS 门诊诊断名称,
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
             --省略若干诊断        
             T.病理号,
             DECODE(T.药物过敏, '1', '无', '2', '有'),
             T.过敏药物,
             NVL(T.尸检, '否'),
             T.血型,
             T.RH,
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
             TO_CHAR(TO_DATE(T.质控日期, 'yyyy-MM-dd hh24:mi:ss'),
                     'yyyy-MM-dd') 质控日期,
             --省略若干手术          
             T.离院方式,
             T.医嘱转院,
             T.医嘱转卫生服务机构,
             T.是否有出院31天在住院计划,
             T.目的,
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
                                      '')) 颅脑损伤患者昏迷时间入院分钟
        FROM 住院管理_病案首页 T, 住院管理_出院病人信息 TT
       WHERE T.住院病历号 = TT.住院病历号
         AND T.机构编码 = STR_机构编码
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
      STR_SQL := 'UPDATE 临时表_病案首页新 SET ZYZD=:1,JBDM=:2,RYBQ=:3 WHERE 住院病历号=:4';
      EXECUTE IMMEDIATE STR_SQL
        USING ROW_诊断记录.疾病名称, ROW_诊断记录.ICD码, ROW_诊断记录.入院病情, ROW_诊断记录.住院病历号;
    ELSIF ROW_诊断记录.诊断类型 = '其他诊断' THEN
      STR_SQL := 'UPDATE 临时表_病案首页新 SET QTZD' || ROW_诊断记录.RN || '=:1,JBDM' ||
                 ROW_诊断记录.RN || '=:2,RYBQ' || ROW_诊断记录.RN ||
                 '=:3 WHERE 住院病历号=:4';
      EXECUTE IMMEDIATE STR_SQL
        USING ROW_诊断记录.疾病名称, ROW_诊断记录.ICD码, ROW_诊断记录.入院病情, ROW_诊断记录.住院病历号;
    ELSIF ROW_诊断记录.诊断类型 = '损伤和中毒外部原因' THEN
      STR_SQL := 'UPDATE 临时表_病案首页新 SET WBYY=:1,H23=:2 WHERE 住院病历号=:3';
      EXECUTE IMMEDIATE STR_SQL
        USING ROW_诊断记录.疾病名称, ROW_诊断记录.ICD码, ROW_诊断记录.住院病历号;
    ELSIF ROW_诊断记录.诊断类型 = '病理诊断' THEN
      STR_SQL := 'UPDATE 临时表_病案首页新 SET BLZD=:1,JBMM=:2 WHERE 住院病历号=:3';
      EXECUTE IMMEDIATE STR_SQL
        USING ROW_诊断记录.疾病名称, ROW_诊断记录.ICD码, ROW_诊断记录.住院病历号;
    END IF;
  END LOOP;

  --更新费用记录信息
  FOR ROW_费用记录 IN CUR_费用记录 LOOP
    EXIT WHEN CUR_费用记录%NOTFOUND;
    UPDATE 临时表_病案首页新 T
       SET T.ZFY      = ROW_费用记录.总金额,
           T.ZFJE     = ROW_费用记录.自付金额,
           T.YLFUF    = ROW_费用记录.一般医疗服务费总,
           T.ZLCZF    = ROW_费用记录.一般治疗操作费,
           T.HLF      = ROW_费用记录.护理费,
           T.QTFY     = ROW_费用记录.综合医疗服务类其他费用,
           T.BLZDF    = ROW_费用记录.病理诊断费,
           T.SYSZDF   = ROW_费用记录.实验室诊断费,
           T.YXXZDF   = ROW_费用记录.影像学诊断费,
           T.LCZDXMF  = ROW_费用记录.临床诊断项目费,
           T.FSSZLXMF = ROW_费用记录.非手术治疗项目费,
           T.WLZLF    = ROW_费用记录.其中_临床物理治疗费,
           T.SSZLF    = ROW_费用记录.手术治疗费,
           T.MAF      = ROW_费用记录.其中_麻醉费,
           T.SSF      = ROW_费用记录.其中_手术费,
           T.KFF      = ROW_费用记录.康复费,
           T.ZYZLF    = ROW_费用记录.中医治疗费,
           T.XYF      = ROW_费用记录.西药费,
           T.KJYWF    = ROW_费用记录.其中_抗菌药物费,
           T.ZCYF     = ROW_费用记录.中成药费,
           T.ZCYF1    = ROW_费用记录.中草药费,
           T.XF       = ROW_费用记录.血费,
           T.BDBLZPF  = ROW_费用记录.白蛋白类制品费,
           T.QDBLZPF  = ROW_费用记录.球蛋白类制品费,
           T.NXYZLZPF = ROW_费用记录.凝血因子类制品费,
           T.XBYZLZPF = ROW_费用记录.细胞因子类制品费,
           T.HCYYCLF  = ROW_费用记录.检查用一次性医用材料费,
           T.YYCLF    = ROW_费用记录.治疗用一次性医用材料费,
           T.YCXYYCLF = ROW_费用记录.手术用一次性医用材料费,
           T.QTF      = ROW_费用记录.其他费
    
     WHERE T.住院病历号 = ROW_费用记录.住院病历号;
  END LOOP;

  --更新手术记录信息
  FOR ROW_手术记录 IN CUR_手术记录 LOOP
    EXIT WHEN CUR_手术记录%NOTFOUND;
  
    STR_SQL := 'UPDATE 临时表_病案首页新 SET SSJCZBM' || ROW_手术记录.RN ||
               '=:1, SSJCZRQ' || ROW_手术记录.RN || '=:2, SSJB' || ROW_手术记录.RN ||
               '= :3
               , SSJCZMC' || ROW_手术记录.RN || '=:4, SZ' ||
               ROW_手术记录.RN || '=:5, YZ' || ROW_手术记录.RN || '=:6, EZ' ||
               ROW_手术记录.RN || '=:7, QKDJ' || ROW_手术记录.RN || '=:8, QKYHLB' ||
               ROW_手术记录.RN || '=:9, MZFS' || ROW_手术记录.RN || '=:10, MZYS' ||
               ROW_手术记录.RN || '=:11 WHERE 住院病历号=:12';
    EXECUTE IMMEDIATE STR_SQL
      USING ROW_手术记录.国标码, ROW_手术记录.手术操作日期, ROW_手术记录.手术级别编码, ROW_手术记录.手术操作名称, ROW_手术记录.术者, ROW_手术记录.I助, ROW_手术记录.II助, ROW_手术记录.切口等级, ROW_手术记录.切口愈合等级, ROW_手术记录.麻醉方式编码, ROW_手术记录.麻醉医师, ROW_手术记录.住院病历号;
  
  END LOOP;

  --返回数据集
  OPEN CUR_导出_列表信息 FOR
    SELECT T.* FROM 临时表_病案首页新 T;

END PR_病案首页_获取导出数据;
/
