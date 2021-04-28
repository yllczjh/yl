create or replace procedure PR_数据上报_门诊发热病例信息(STR_参数          IN VARCHAR2,
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
    OPEN CUR_导出_列表信息 FOR
      select G.机构编码 as P900,
             '机构名称' as P6891,
             null as P686, --医疗保险手册号,
             X.健康卡号 as p800,
             '01' as P7501, -- 就诊类型,
             G.门诊病历号 as P7502, -- 就诊卡号,
             G.门诊病历号 as P7000, -- 门诊就诊流水号,
             X.姓名 as p4,
             x.性别 as p5,
             X.出生日期 as p6,
             X.年龄 as p7,
             null as P12, --国籍,
             X.民族ID as p11,
             X.婚姻状况 as p8,
             B.职业 as p9,
             null as p7503, -- 注册证件类型代码,
             X.身份证号 as p13,
             B.现住_地址 as p801,
             X.手机号码 as p802,
             B.现住_邮编 as p803,
             B.工作单位及地址 as P14,
             B.单位电话 as P15,
             null as P16, --工作单位邮政编码
             B.联系人_姓名 as P18,
             B.联系人_关系 as P19,
             B.联系人_地址 as P20,
             B.联系人_电话 as p21,
             null as p7505, --就诊次数
             decode(G.是否急诊, '复诊', '否', '是') as P7520, --是否出诊
             null as p7521, --是否转诊
             G.就诊科室编码 as P7504,
             (select a.科室名称
                from 基础项目_科室资料 A
               where a.机构编码 = G.机构编码
                 and a.科室编码 = G.就诊科室编码) as P7522, --就诊科室代码
             G.挂号时间 as P7506, --就诊日期
             null as P7507, --主诉
             null as p7523, --现病史
             null as p7524, --体格检查
             
             null       as p7525, --症状代码
             null       as p7526, --症状名称
             null       as p7527, --症状描述
             null       as p7528, --发病日期
             null       as p7529, --是否留观
             G.疾病编码 as p28,
             g.疾病名称 as p281
      
        from 门诊管理_挂号登记     G,
             基础项目_病人信息     X,
             基础项目_病人病案信息 B
       where G.机构编码 = X.机构编码
         and x.机构编码 = b.机构编码
         and G.病人ID = X.病人ID
         and x.病人ID = b.病人ID;
  
  end;

end PR_数据上报_门诊发热病例信息;
/
