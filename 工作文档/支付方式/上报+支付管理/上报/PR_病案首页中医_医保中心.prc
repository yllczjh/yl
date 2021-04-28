CREATE OR REPLACE PROCEDURE PR_病案首页中医_医保中心(STR_参数          IN VARCHAR2,
                                           CUR_导出_列表信息 OUT SYS_REFCURSOR) IS
  STR_SQL VARCHAR2(1000);

  STR_机构编码     VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 1);
  DAT_出院时间起始 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 2),
                             'yyyy-MM-dd hh24:mi:ss');
  DAT_出院时间截止 DATE := TO_DATE(FU_通用_截取字符串值(STR_参数, '|', 3),
                             'yyyy-MM-dd hh24:mi:ss');
  STR_过滤数据     VARCHAR2(50) := FU_通用_截取字符串值(STR_参数, '|', 4);

  --获取诊断记录CURSOR
  CURSOR CUR_诊断记录 IS
    SELECT *
      FROM (SELECT ROW_NUMBER() OVER(PARTITION BY T.住院病历号, T.诊断分类, T.诊断类型 ORDER BY T.诊断类型, T.是否主诊断 DESC) RN,
                   T.住院病历号,
                   T.诊断分类,
                   T.诊断类型,
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
               AND TT.病人类型编码 = '2' --医保
               AND TTT.治疗类别 != '3' --西医
               AND TTT.归档人编码 IS NOT NULL
               AND TT.出院时间 BETWEEN DAT_出院时间起始 AND DAT_出院时间截止
               AND ((T.诊断分类 = '2' and T.诊断类型 = '出院诊断') or
                   (T.诊断分类 = '1' and
                   T.诊断类型 IN ('出院诊断',
                                '其他诊断',
                                '损伤和中毒外部原因',
                                '病理诊断')))
               AND T.创建时间 >= TT.入院时间
               AND (TT.住院病历号 LIKE '%' || STR_过滤数据 || '%' OR
                   TT.病案号 LIKE '%' || STR_过滤数据 || '%' OR
                   TT.病人姓名 LIKE '%' || STR_过滤数据 || '%')) G
     WHERE (G.诊断类型 = '其他诊断' AND G.RN <= 15)
        OR G.诊断类型 <> '其他诊断';
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
               AND TT.病人类型编码 = '2'
               AND TTT.治疗类别 != '3' --西医
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
           nvl(SUM(CASE T.归类编码
                     WHEN '10029' THEN
                      T.归类金额
                     WHEN '10030' THEN
                      T.归类金额
                     WHEN '10031' THEN
                      T.归类金额
                   END),
               0) AS 一般医疗服务费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10030' THEN
                      T.归类金额
                   END),
               0) AS 其中_中医辨证论治费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10031' THEN
                      T.归类金额
                   END),
               0) AS 其中_中医辨证论治会诊费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10032' THEN
                      T.归类金额
                   END),
               0) AS 一般治疗操作费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10033' THEN
                      T.归类金额
                   END),
               0) AS 护理费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10034' THEN
                      T.归类金额
                   END),
               0) AS 其他费用,
           nvl(SUM(CASE T.归类编码
                     WHEN '10035' THEN
                      T.归类金额
                   END),
               0) AS 病理诊断费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10036' THEN
                      T.归类金额
                   END),
               0) AS 实验室诊断费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10037' THEN
                      T.归类金额
                   END),
               0) AS 影像学诊断费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10038' THEN
                      T.归类金额
                   END),
               0) AS 临床诊断项目费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10039' THEN
                      T.归类金额
                     WHEN '10040' THEN
                      T.归类金额
                   END),
               0) AS 非手术治疗项目费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10040' THEN
                      T.归类金额
                   END),
               0) AS 其中_临床物理治疗费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10041' THEN
                      T.归类金额
                     WHEN '10042' THEN
                      T.归类金额
                     WHEN '10043' THEN
                      T.归类金额
                   END),
               0) AS 手术治疗费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10042' THEN
                      T.归类金额
                   END),
               0) AS 其中_麻醉费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10043' THEN
                      T.归类金额
                   END),
               0) AS 其中_手术费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10044' THEN
                      T.归类金额
                   END),
               0) AS 康复费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10045' THEN
                      T.归类金额
                   END),
               0) AS 中医诊断,
           nvl(SUM(CASE T.归类编码
                     WHEN '10046' THEN
                      T.归类金额
                     WHEN '10047' THEN
                      T.归类金额
                     WHEN '10048' THEN
                      T.归类金额
                     WHEN '10049' THEN
                      T.归类金额
                     WHEN '10050' THEN
                      T.归类金额
                     WHEN '10051' THEN
                      T.归类金额
                     WHEN '10052' THEN
                      T.归类金额
                   END),
               0) AS 中医治疗,
           nvl(SUM(CASE T.归类编码
                     WHEN '10047' THEN
                      T.归类金额
                   END),
               0) AS 其中_中医外治,
           nvl(SUM(CASE T.归类编码
                     WHEN '10048' THEN
                      T.归类金额
                   END),
               0) AS 其中_中医骨伤,
           nvl(SUM(CASE T.归类编码
                     WHEN '10049' THEN
                      T.归类金额
                   END),
               0) AS 其中_针刺与灸法,
           nvl(SUM(CASE T.归类编码
                     WHEN '10050' THEN
                      T.归类金额
                   END),
               0) AS 其中_中医推拿治疗,
           nvl(SUM(CASE T.归类编码
                     WHEN '10051' THEN
                      T.归类金额
                   END),
               0) AS 其中_中医肛肠治疗,
           nvl(SUM(CASE T.归类编码
                     WHEN '10052' THEN
                      T.归类金额
                   END),
               0) AS 其中_中医特殊治疗,
           nvl(SUM(CASE T.归类编码
                     WHEN '10053' THEN
                      T.归类金额
                     WHEN '10054' THEN
                      T.归类金额
                     WHEN '10055' THEN
                      T.归类金额
                   END),
               0) AS 中医其他,
           nvl(SUM(CASE T.归类编码
                     WHEN '10054' THEN
                      T.归类金额
                   END),
               0) AS 其中_中医特殊调配加工,
           nvl(SUM(CASE T.归类编码
                     WHEN '10055' THEN
                      T.归类金额
                   END),
               0) AS 其中_辨证施膳,
           nvl(SUM(CASE T.归类编码
                     WHEN '10056' THEN
                      T.归类金额
                     WHEN '10057' THEN
                      T.归类金额
                   END),
               0) AS 西药费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10057' THEN
                      T.归类金额
                   END),
               0) AS 其中_抗菌药物费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10058' THEN
                      T.归类金额
                     WHEN '10059' THEN
                      T.归类金额
                   END),
               0) AS 中成药费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10059' THEN
                      T.归类金额
                   END),
               0) AS 其中_医疗机构中药制剂费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10060' THEN
                      T.归类金额
                   END),
               0) AS 中草药费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10061' THEN
                      T.归类金额
                   END),
               0) AS 血费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10062' THEN
                      T.归类金额
                   END),
               0) AS 白蛋白类制品费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10063' THEN
                      T.归类金额
                   END),
               0) AS 球蛋白类制品费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10064' THEN
                      T.归类金额
                   END),
               0) AS 凝血因子类制品费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10065' THEN
                      T.归类金额
                   END),
               0) AS 细胞因子类制品费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10066' THEN
                      T.归类金额
                   END),
               0) AS 检查用一次性医用材料费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10067' THEN
                      T.归类金额
                   END),
               0) AS 治疗用一次性医用材料费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10068' THEN
                      T.归类金额
                   END),
               0) AS 手术用一次性医用材料费,
           nvl(SUM(CASE T.归类编码
                     WHEN '10069' THEN
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
                               中医病案编码,
                               机构编码,
                               住院病历号,
                               记账时间
                          FROM (SELECT A.总金额 AS 总金额,
                                       NVL(Z.BAGLBM1, '10069') AS 中医病案编码,
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
                                       NVL(Y.BAGLBM1, '10069') AS 中医病案编码,
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
                                  中医病案编码) ZZ
                ON ZT.编码 = ZZ.中医病案编码
             WHERE ZT.分类编码 = 'GB_009001'
               AND ZT.有效状态 = '有效'
               AND ZT.删除标志 = '0'
               AND ZT.名称 LIKE '中医病案_%') T,
           住院管理_出院病人信息 TT,
           住院管理_病案首页 TTT
     WHERE T.住院病历号 = TT.住院病历号
       AND T.住院病历号 = TTT.住院病历号
       AND TT.病人类型编码 = '2'
       and TTT.治疗类别 != '3'
       AND TTT.归档人编码 IS NOT NULL
       AND TT.出院时间 BETWEEN DAT_出院时间起始 AND DAT_出院时间截止
       AND T.记账时间 >= TT.入院时间
       AND (TT.住院病历号 LIKE '%' || STR_过滤数据 || '%' OR
           TT.病案号 LIKE '%' || STR_过滤数据 || '%' OR
           TT.病人姓名 LIKE '%' || STR_过滤数据 || '%')
     GROUP BY T.机构编码, T.住院病历号;

  ROW_费用记录 CUR_费用记录%ROWTYPE;

BEGIN

  BEGIN
    --更新基本信息
    INSERT INTO 临时表_病案首页中医_医保中心
      (JYH, --就医号（医院内部生成的唯一编号）
       AAZ107, --医保医疗机构代码
       IDC, --组织机构代码
       YLFKFS, --医疗付费方式
       JKKH, --健康卡号
       ZYCS, --住院次数
       BAH, --病案号
       XM, --姓名
       XB, --性别 1.男 2.女
       CSRQ, --出生日期
       NL, --年龄 
       GJ, --国籍
       BZYZS_NL, --(年龄不足一周岁的)年龄
       XSETZ, --新生儿出生体重
       XSERYTZ, --新生儿入院体重
       CSD, --出生地
       GG, --籍贯
       MZ, --民族
       SFZH, --身份证号
       ZY, --职业
       HY, --婚姻 1.未婚 2.已婚 3.丧偶4.离婚 9.其他
       XZZ, --现住址
       DH, --电话(现住址)
       YB1, --邮编(现住址)
       HKDZ, --户口地址
       YB2, --邮编(户口地址)
       GZDWJDZ, --工作单位及地址
       DWDH, --工作电话(工作单位及地址)
       YB3, --邮编(工作单位及地址)
       LXRXM, --联系人姓名
       GX, --联系人关系
       DZ, --联系人地址
       DH1, --联系人电话
       RYTJ, --入院途径 1.急诊  2.门诊  3.其他医疗机构转入  9.其他
       ZLLB, --治疗类别
       RYSJ, --入院时间
       RYSJ_S, --入院时间(时)
       RYKB, --入院科别
       RYBF, --入院病房
       ZKKB, --转科科别
       CYSJ, --出院时间
       CYSJ_S, --出院时间(时)
       CYKB, --出院科别
       CYBF, --出院病房
       SJZY, --实际住院天数
       MZD_ZYZD, --门(急)诊诊断名称1
       JBDM_S, --门(急)诊诊断1
       MZZD_XYZD, --门(急)诊诊断名称2
       JBBM_S, --门(急)诊诊断2
       SSLCLJ, --实施临床路径
       ZYYJ, --使用医疗机构中药制剂
       ZYZLSB, --使用中医诊疗设备
       ZYZLJS, --使用中医诊疗技术
       BZSH, --辩证施护
       
       --省略诊断记录
       
       BLH, --病理号
       YWGM, --是否药物过敏
       GMYW, --过敏药物
       SJ, --死亡患者尸检
       XX, --血型
       RH, --RH
       QJCS, --抢救次数
       CGCS, --成功次数
       SXFY, --输血反应
       RCMDSC, --妊娠梅毒筛查
       XSRJBSC, --新生儿疾病筛查
       CHCX, --产后出血
       KZR, --科主任
       ZRYS, --主任(副主任)医师
       ZZYS, --主治医师
       ZYYS, --住院医师
       ZRHS, --责任护士
       JXYS, --进修医师
       SXYS, --实习医师
       BMY, --编码员
       BAZL, --病案质量
       ZKYS, --质控医师
       ZKHS, --质控护士
       ZKRQ, --质控日期
       
       --省略手术记录
       
       LYFS, --离院方式
       ZZYJH, --再住院计划
       MD, --目的
       RYQ_T, --入院前天
       RYQ_XS, --入院前小时
       RYQ_F, --入院前分钟
       RYH_T, --入院后天
       RYH_XS, --入院后小时
       RYH_F --入院后分钟
       
       --省略手术记录
       
       )
      SELECT T.住院病历号,
             '' 医保医疗机构代码,
             '122108044641640037' AS 组织机构代码,
             T.医疗付费方式,
             T.健康卡号,
             T.住院次数,
             T.病案号,
             SUBSTR(T.病人姓名, 0, 20),
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
             SUBSTR(T.户口电话, 0, 20),
             SUBSTR(T.现住址邮编, 0, 6),
             T.户口地址,
             SUBSTR(T.户口邮政编码, 0, 6),
             T.工作单位地址,
             SUBSTR(T.工作电话, 0, 20),
             SUBSTR(T.工作邮政编码, 0, 6),
             SUBSTR(T.联系人姓名, 0, 20),
             T.关系,
             T.联系人地址,
             SUBSTR(T.联系人电话, 0, 20),
             T.入院途径,
             T.治疗类别,
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
                 AND ROWNUM = 2) AS 门诊诊断名称,
             SUBSTR((SELECT (CASE
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
                       AND ROWNUM = 2),
                    0,
                    16) AS 疾病编码,
             (SELECT A.疾病名称
                FROM 住院管理_在院病人诊断 A
               WHERE A.机构编码 = STR_机构编码
                 AND A.住院病历号 = T.住院病历号
                 AND A.诊断类型 = '门诊诊断'
                 AND A.诊断分类 = '1'
                 AND ROWNUM = 1) AS 门诊诊断名称,
             SUBSTR((SELECT (CASE
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
                       AND ROWNUM = 1),
                    0,
                    16) AS 疾病编码,
             T.实施临床路径,
             T.使用医疗机构中药制剂,
             T.使用中医诊疗设备,
             T.使用中医诊疗技术,
             T.辩证施护,
             --省略若干诊断
             T.病理号,
             DECODE(T.药物过敏, '1', '无', '2', '有'),
             T.过敏药物,
             DECODE(T.尸检, '否', '0', '是', '1', '0') 尸检,
             T.血型,
             T.RH,
             T.抢救次数,
             T.成功次数,
             T.输血反应,
             T.梅毒,
             '' 新生儿疾病筛查,
             '' 产后出血,
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
         and T.治疗类别 != '3'
         AND TT.病人类型编码 = '2'
         AND T.出院日期 BETWEEN DAT_出院时间起始 AND DAT_出院时间截止
         AND T.归档人编码 IS NOT NULL
         AND (T.住院病历号 LIKE '%' || STR_过滤数据 || '%' OR
             T.病案号 LIKE '%' || STR_过滤数据 || '%' OR
             T.病人姓名 LIKE '%' || STR_过滤数据 || '%');
  
  END;

  --更新费用记录信息
  FOR ROW_费用记录 IN CUR_费用记录 LOOP
    EXIT WHEN CUR_费用记录%NOTFOUND;
    UPDATE 临时表_病案首页中医_医保中心 T
       SET T.ZFY      = ROW_费用记录.总金额,
           T.ZFJE     = ROW_费用记录.自付金额,
           T.ZFIJE    = ROW_费用记录.自付金额,
           T.QTZF    =
           (ROW_费用记录.总金额 - ROW_费用记录.自付金额),
           T.YLFWF    = ROW_费用记录.一般医疗服务费,
           T.BZLZF    = ROW_费用记录.其中_中医辨证论治费,
           T.ZYBLZHZF = ROW_费用记录.其中_中医辨证论治会诊费,
           T.ZLCZF    = ROW_费用记录.一般治疗操作费,
           T.HLF      = ROW_费用记录.护理费,
           T.QTFY     = ROW_费用记录.其他费用,
           T.BLZDF    = ROW_费用记录.病理诊断费,
           T.SYSZDF   = ROW_费用记录.实验室诊断费,
           T.YXXZDF   = ROW_费用记录.影像学诊断费,
           T.LCZDXMF  = ROW_费用记录.临床诊断项目费,
           T.FSSZLXMF = ROW_费用记录.非手术治疗项目费,
           T.ZLF      = ROW_费用记录.其中_临床物理治疗费,
           T.SSZLF    = ROW_费用记录.手术治疗费,
           T.MZF      = ROW_费用记录.其中_麻醉费,
           T.SSF      = ROW_费用记录.其中_手术费,
           T.KFF      = ROW_费用记录.康复费,
           T.ZYL_ZYZD = ROW_费用记录.中医诊断,
           T.ZYZL     = ROW_费用记录.中医治疗,
           T.ZYWZ     = ROW_费用记录.其中_中医外治,
           T.ZYGS     = ROW_费用记录.其中_中医骨伤,
           T.ZCYJF    = ROW_费用记录.其中_针刺与灸法,
           T.ZYTNZL   = ROW_费用记录.其中_中医推拿治疗,
           T.ZYGCZL   = ROW_费用记录.其中_中医肛肠治疗,
           T.ZYTSZL   = ROW_费用记录.其中_中医特殊治疗,
           T.ZYQT     = ROW_费用记录.中医其他,
           T.ZYTSTPJG = ROW_费用记录.其中_中医特殊调配加工,
           T.BZSS     = ROW_费用记录.其中_辨证施膳,
           T.XYF      = ROW_费用记录.西药费,
           T.KJYWF    = ROW_费用记录.其中_抗菌药物费,
           T.ZCYF     = ROW_费用记录.中成药费,
           T.YZJF_ZCY = ROW_费用记录.其中_医疗机构中药制剂费,
           T.ZCYF1    = ROW_费用记录.中草药费,
           T.XF       = ROW_费用记录.血费,
           T.BDBLZPF  = ROW_费用记录.白蛋白类制品费,
           T.QDBLZPF  = ROW_费用记录.球蛋白类制品费,
           T.NXYZLZPF = ROW_费用记录.凝血因子类制品费,
           T.XBYZLZPF = ROW_费用记录.细胞因子类制品费,
           T.CYYYCLF  = ROW_费用记录.检查用一次性医用材料费,
           T.YYCLF    = ROW_费用记录.治疗用一次性医用材料费,
           T.SSYCXCLF = ROW_费用记录.手术用一次性医用材料费,
           T.QTF      = ROW_费用记录.其他费
    
     WHERE T.JYH = ROW_费用记录.住院病历号;
  END LOOP;

  --更新手术记录信息
  FOR ROW_手术记录 IN CUR_手术记录 LOOP
    EXIT WHEN CUR_手术记录%NOTFOUND;
  
    STR_SQL := 'UPDATE 临时表_病案首页中医_医保中心 SET SSBM' || ROW_手术记录.RN ||
               '_S=:1, SSJCZRQ' || ROW_手术记录.RN || '=:2, SSJB' ||
               ROW_手术记录.RN || '= :3
               , SSJCZMC' || ROW_手术记录.RN || '=:4, SZ' ||
               ROW_手术记录.RN || '=:5, YZ' || ROW_手术记录.RN || '=:6, EZ' ||
               ROW_手术记录.RN || '=:7, QKYHDJ' || ROW_手术记录.RN || '=:8, QKYHLB' ||
               ROW_手术记录.RN || '=:9, MZFS' || ROW_手术记录.RN || '=:10, MZYS' ||
               ROW_手术记录.RN || '=:11 WHERE JYH=:12';
    EXECUTE IMMEDIATE STR_SQL
      USING ROW_手术记录.国标码, ROW_手术记录.手术操作日期, ROW_手术记录.手术级别编码, ROW_手术记录.手术操作名称, ROW_手术记录.术者, ROW_手术记录.I助, ROW_手术记录.II助, ROW_手术记录.切口等级, ROW_手术记录.切口愈合等级, ROW_手术记录.麻醉方式编码, ROW_手术记录.麻醉医师, ROW_手术记录.住院病历号;
  
  END LOOP;

  --更新诊断记录信息
  FOR ROW_诊断记录 IN CUR_诊断记录 LOOP
    EXIT WHEN CUR_诊断记录%NOTFOUND;
    IF ROW_诊断记录.诊断类型 = '出院诊断' THEN
      IF ROW_诊断记录.诊断分类 = '2' then
        --中医
        STR_SQL := 'UPDATE 临时表_病案首页中医_医保中心 SET ZB=:1,ZBBM_S=:2,ZB_RYBQ=:3,
                   ZZ1=:4,ZZBM1_S=:5,ZZ_RYBQ1=:6 ,
                   ZZ2=:7,ZZBM2_S=:8,ZZ_RYBQ2=:9,
                   ZZ3=:10,ZZBM3_S=:11,ZZ_RYBQ3=:12,
                   ZZ4=:13,ZZBM4_S=:14,ZZ_RYBQ4=:15, 
                   ZZ5=:16,ZZBM5_S=:17,ZZ_RYBQ5=:18, 
                   ZZ6=:19,ZZBM6_S=:20,ZZ_RYBQ6=:21, 
                   ZZ7=:22,ZZBM7_S=:23,ZZ_RYBQ7=:24, 
                   ZZ8=:25,ZZBM8_S=:26,ZZ_RYBQ8=:27, 
                   ZZ9=:28,ZZBM9_S=:29,ZZ_RYBQ9=:30
                   WHERE JYH=:31';
      
        EXECUTE IMMEDIATE STR_SQL
          using ROW_诊断记录.疾病名称, SUBSTR(ROW_诊断记录.ICD码, 0, 6), ROW_诊断记录.入院病情, 
          ROW_诊断记录.疾病名称1, SUBSTR(ROW_诊断记录.ICD码1, 0, 6), ROW_诊断记录.入院病情1, 
          ROW_诊断记录.疾病名称2, SUBSTR(ROW_诊断记录.ICD码2, 0, 6), ROW_诊断记录.入院病情2, 
          ROW_诊断记录.疾病名称3, SUBSTR(ROW_诊断记录.ICD码3, 0, 6), ROW_诊断记录.入院病情3, 
          ROW_诊断记录.疾病名称4, SUBSTR(ROW_诊断记录.ICD码4, 0, 6), ROW_诊断记录.入院病情4, 
          ROW_诊断记录.疾病名称5, SUBSTR(ROW_诊断记录.ICD码5, 0, 6), ROW_诊断记录.入院病情5, 
          ROW_诊断记录.疾病名称6, SUBSTR(ROW_诊断记录.ICD码6, 0, 6), ROW_诊断记录.入院病情6, 
          ROW_诊断记录.疾病名称7, SUBSTR(ROW_诊断记录.ICD码7, 0, 6), ROW_诊断记录.入院病情7, 
          ROW_诊断记录.疾病名称8, SUBSTR(ROW_诊断记录.ICD码8, 0, 6), ROW_诊断记录.入院病情8, 
          ROW_诊断记录.疾病名称9, SUBSTR(ROW_诊断记录.ICD码9, 0, 6), ROW_诊断记录.入院病情9, 
          ROW_诊断记录.住院病历号;
      else
        --西医
        STR_SQL := 'UPDATE 临时表_病案首页中医_医保中心 SET ZYZD=:1,ZYZDBM_S=:2,XY_RYBQ=:3 WHERE JYH=:4';
        EXECUTE IMMEDIATE STR_SQL
          USING ROW_诊断记录.疾病名称, SUBSTR(ROW_诊断记录.ICD码, 0, 10), ROW_诊断记录.入院病情, ROW_诊断记录.住院病历号;
      end if;
    
    ELSIF ROW_诊断记录.诊断类型 = '其他诊断' THEN
      STR_SQL := 'UPDATE 临时表_病案首页中医_医保中心 SET QTZD' || ROW_诊断记录.RN ||
                 '=:1,QTZDBM' || ROW_诊断记录.RN || '_S=:2,RYBQ' || ROW_诊断记录.RN ||
                 '=:3 WHERE JYH=:4';
      EXECUTE IMMEDIATE STR_SQL
        USING ROW_诊断记录.疾病名称, SUBSTR(ROW_诊断记录.ICD码, 0, 10), ROW_诊断记录.入院病情, ROW_诊断记录.住院病历号;
    ELSIF ROW_诊断记录.诊断类型 = '损伤和中毒外部原因' THEN
      STR_SQL := 'UPDATE 临时表_病案首页中医_医保中心 SET WBYY=:1,JBBM1_S=:2 WHERE JYH=:3';
      EXECUTE IMMEDIATE STR_SQL
        USING ROW_诊断记录.疾病名称, SUBSTR(ROW_诊断记录.ICD码, 0, 10), ROW_诊断记录.住院病历号;
    ELSIF ROW_诊断记录.诊断类型 = '病理诊断' THEN
      STR_SQL := 'UPDATE 临时表_病案首页中医_医保中心 SET BLZD=:1,JBBM2_S=:2 WHERE JYH=:3';
      EXECUTE IMMEDIATE STR_SQL
        USING ROW_诊断记录.疾病名称, SUBSTR(ROW_诊断记录.ICD码, 0, 10), ROW_诊断记录.住院病历号;
    END IF;
  END LOOP;

  --返回数据集
  OPEN CUR_导出_列表信息 FOR
    SELECT T.* FROM 临时表_病案首页中医_医保中心 T WHERE T.ZYZD!='无费退院';
END PR_病案首页中医_医保中心;
/
