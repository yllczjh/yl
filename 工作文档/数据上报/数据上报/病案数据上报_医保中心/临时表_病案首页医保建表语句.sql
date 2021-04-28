-- Create table
create global temporary table 临时表_病案首页医保
(
  jyh      VARCHAR2(100),
  aaz107   VARCHAR2(11),
  idc      VARCHAR2(10),
  ylfkfs   VARCHAR2(3),
  jkkh     VARCHAR2(100),
  zycs     VARCHAR2(10),
  bah      VARCHAR2(18),
  xm       VARCHAR2(20),
  xb       VARCHAR2(1),
  csrq     VARCHAR2(12),
  nl       NUMBER(10),
  gj       VARCHAR2(3),
  bzyzsnl  NUMBER(10),
  xsecstz  NUMBER(12,2),
  xserytz  NUMBER(12,2),
  csd      VARCHAR2(200),
  gg       VARCHAR2(200),
  mz       VARCHAR2(2),
  sfzlb    VARCHAR2(20),
  sfzh     VARCHAR2(100),
  zy       VARCHAR2(2),
  hy       VARCHAR2(2),
  xzz      VARCHAR2(254),
  dh       VARCHAR2(20),
  yb1      VARCHAR2(6),
  hkdz     VARCHAR2(254),
  yb2      VARCHAR2(6),
  gzdwjdz  VARCHAR2(254),
  dwdh     VARCHAR2(20),
  yb3      VARCHAR2(6),
  lxrxm    VARCHAR2(20),
  gx       VARCHAR2(1),
  dz       VARCHAR2(200),
  dh2      VARCHAR2(20),
  rytj     VARCHAR2(1),
  rysj     VARCHAR2(12),
  rysjs    NUMBER(12),
  rykb     VARCHAR2(100),
  rybf     VARCHAR2(100),
  zkkb     VARCHAR2(100),
  cysj     VARCHAR2(12),
  cysjs    NUMBER(10),
  cykb     VARCHAR2(100),
  cybf     VARCHAR2(100),
  sjzyts   NUMBER(8),
  mzzd     VARCHAR2(200),
  jbbm_s   VARCHAR2(16),
  zyzd     VARCHAR2(200),
  qtzd1    VARCHAR2(200),
  qtzd2    VARCHAR2(200),
  qtzd3    VARCHAR2(200),
  qtzd4    VARCHAR2(200),
  qtzd5    VARCHAR2(200),
  qtzd6    VARCHAR2(200),
  qtzd7    VARCHAR2(200),
  qtzd8    VARCHAR2(200),
  qtzd9    VARCHAR2(200),
  qtzd10   VARCHAR2(200),
  qtzd11   VARCHAR2(200),
  qtzd12   VARCHAR2(200),
  qtzd13   VARCHAR2(200),
  qtzd14   VARCHAR2(200),
  qtzd15   VARCHAR2(200),
  jbdm_s   VARCHAR2(10),
  jbdm1_s  VARCHAR2(10),
  jbdm2_s  VARCHAR2(10),
  jbdm3_s  VARCHAR2(10),
  jbdm4_s  VARCHAR2(10),
  jbdm5_s  VARCHAR2(10),
  jbdm6_s  VARCHAR2(10),
  jbdm7_s  VARCHAR2(10),
  jbdm8_s  VARCHAR2(10),
  jbdm9_s  VARCHAR2(10),
  jbdm10_s VARCHAR2(10),
  jbdm11_s VARCHAR2(10),
  jbdm12_s VARCHAR2(10),
  jbdm13_s VARCHAR2(10),
  jbdm14_s VARCHAR2(10),
  jbdm15_s VARCHAR2(10),
  rybq     VARCHAR2(10),
  rybq1    VARCHAR2(10),
  rybq2    VARCHAR2(10),
  rybq3    VARCHAR2(10),
  rybq4    VARCHAR2(10),
  rybq5    VARCHAR2(10),
  rybq6    VARCHAR2(10),
  rybq7    VARCHAR2(10),
  rybq8    VARCHAR2(10),
  rybq9    VARCHAR2(10),
  rybq10   VARCHAR2(10),
  rybq11   VARCHAR2(10),
  rybq12   VARCHAR2(10),
  rybq13   VARCHAR2(10),
  rybq14   VARCHAR2(10),
  rybq15   VARCHAR2(10),
  wbyy     VARCHAR2(100),
  ssbm_s   VARCHAR2(20),
  blzd     VARCHAR2(100),
  jbmm_s   VARCHAR2(10),
  blh      VARCHAR2(100),
  ywgm     VARCHAR2(100),
  gmyw     VARCHAR2(100),
  swhzsj   VARCHAR2(1),
  xx       VARCHAR2(1),
  rh       VARCHAR2(1),
  qjcs     NUMBER(10),
  cgcs     NUMBER(10),
  sxfy     VARCHAR2(1),
  rcmdsc   VARCHAR2(1),
  xsrjbsc  VARCHAR2(50),
  chcx     VARCHAR2(1),
  kzr      VARCHAR2(100),
  zrys     VARCHAR2(100),
  zzys     VARCHAR2(100),
  zyys     VARCHAR2(100),
  zrhs     VARCHAR2(100),
  jxys     VARCHAR2(100),
  sxys     VARCHAR2(100),
  bmy      VARCHAR2(100),
  bazl     VARCHAR2(1),
  zkys     VARCHAR2(100),
  zkhs     VARCHAR2(100),
  zkrq     VARCHAR2(12),
  ssbm1_s  VARCHAR2(20),
  ssbm2_s  VARCHAR2(20),
  ssbm3_s  VARCHAR2(20),
  ssbm4_s  VARCHAR2(20),
  ssbm5_s  VARCHAR2(20),
  ssbm6_s  VARCHAR2(20),
  ssbm7_s  VARCHAR2(20),
  ssjczrq1 VARCHAR2(12),
  ssjczrq2 VARCHAR2(12),
  ssjczrq3 VARCHAR2(12),
  ssjczrq4 VARCHAR2(12),
  ssjczrq5 VARCHAR2(12),
  ssjczrq6 VARCHAR2(12),
  ssjczrq7 VARCHAR2(12),
  sslx     VARCHAR2(20),
  ssjb1    VARCHAR2(10),
  ssjb2    VARCHAR2(10),
  ssjb3    VARCHAR2(10),
  ssjb4    VARCHAR2(10),
  ssjb5    VARCHAR2(10),
  ssjb6    VARCHAR2(10),
  ssjb7    VARCHAR2(10),
  ssjczmc1 VARCHAR2(200),
  ssjczmc2 VARCHAR2(200),
  ssjczmc3 VARCHAR2(200),
  ssjczmc4 VARCHAR2(200),
  ssjczmc5 VARCHAR2(200),
  ssjczmc6 VARCHAR2(200),
  ssjczmc7 VARCHAR2(200),
  sz1      VARCHAR2(100),
  sz2      VARCHAR2(100),
  sz3      VARCHAR2(100),
  sz4      VARCHAR2(100),
  sz5      VARCHAR2(100),
  sz6      VARCHAR2(100),
  sz7      VARCHAR2(100),
  yz1      VARCHAR2(100),
  yz2      VARCHAR2(100),
  yz3      VARCHAR2(100),
  yz4      VARCHAR2(100),
  yz5      VARCHAR2(100),
  yz6      VARCHAR2(100),
  yz7      VARCHAR2(100),
  ez1      VARCHAR2(100),
  ez2      VARCHAR2(100),
  ez3      VARCHAR2(100),
  ez4      VARCHAR2(100),
  ez5      VARCHAR2(100),
  ez6      VARCHAR2(100),
  ez7      VARCHAR2(100),
  qkyhlb1  VARCHAR2(5),
  qkyhlb2  VARCHAR2(5),
  qkyhlb3  VARCHAR2(5),
  qkyhlb4  VARCHAR2(5),
  qkyhlb5  VARCHAR2(5),
  qkyhlb6  VARCHAR2(5),
  qkyhlb7  VARCHAR2(5),
  qkyhdj1  VARCHAR2(5),
  qkyhdj2  VARCHAR2(5),
  qkyhdj3  VARCHAR2(5),
  qkyhdj4  VARCHAR2(5),
  qkyhdj5  VARCHAR2(5),
  qkyhdj6  VARCHAR2(5),
  qkyhdj7  VARCHAR2(5),
  mzfs1    VARCHAR2(100),
  mzfs2    VARCHAR2(100),
  mzfs3    VARCHAR2(100),
  mzfs4    VARCHAR2(100),
  mzfs5    VARCHAR2(100),
  mzfs6    VARCHAR2(100),
  mzfs7    VARCHAR2(100),
  mzys1    VARCHAR2(100),
  mzys2    VARCHAR2(100),
  mzys3    VARCHAR2(100),
  mzys4    VARCHAR2(100),
  mzys5    VARCHAR2(100),
  mzys6    VARCHAR2(100),
  mzys7    VARCHAR2(100),
  lyfs     VARCHAR2(1),
  sfzzyjh  VARCHAR2(1),
  md       VARCHAR2(100),
  ryq_t    NUMBER(10),
  ryq_xs   NUMBER(10),
  ryq_f    NUMBER(10),
  ryh_t    NUMBER(10),
  ryh_xs   NUMBER(10),
  ryh_f    NUMBER(10),
  zfy      NUMBER(12,2),
  zfje     NUMBER(12,2),
  zfeje    NUMBER(12,2),
  qtzf     NUMBER(12,2),
  ylfuf    NUMBER(12,2),
  zlczf    NUMBER(12,2),
  hlf      NUMBER(12,2),
  qtfy     NUMBER(12,2),
  blzdf    NUMBER(12,2),
  syszdf   NUMBER(12,2),
  yxxzdf   NUMBER(12,2),
  lczdxmf  NUMBER(12,2),
  fsszlxmf NUMBER(12,2),
  wlzlf    NUMBER(12,2),
  sszlf    NUMBER(12,2),
  maf      NUMBER(12,2),
  ssf      NUMBER(12,2),
  kff      NUMBER(12,2),
  zyzlf    NUMBER(12,2),
  xyf      NUMBER(12,2),
  kjywf    NUMBER(12,2),
  zcyf     NUMBER(12,2),
  zcyf1    NUMBER(12,2),
  xf       NUMBER(12,2),
  bdblzpf  NUMBER(12,2),
  qdblzpf  NUMBER(12,2),
  nxyzlzpf NUMBER(12,2),
  xbyzlzpf NUMBER(12,2),
  hcyyclf  NUMBER(12,2),
  yyclf    NUMBER(12,2),
  ycxyyclf NUMBER(12,2),
  qtf      NUMBER(12,2),
  jys      NUMBER(10),
  sblb     VARCHAR2(1),
  bz1      VARCHAR2(100),
  bz2      VARCHAR2(100),
  bz3      VARCHAR2(100),
  bz4      VARCHAR2(100),
  bz5      VARCHAR2(100),
  住院病历号    VARCHAR2(50)
)
on commit preserve rows;
-- Add comments to the columns 
comment on column 临时表_病案首页医保.jyh
  is '就医号（医院内部生成的唯一编号）';
comment on column 临时表_病案首页医保.aaz107
  is '医保医疗机构代码';
comment on column 临时表_病案首页医保.idc
  is '组织机构代码';
comment on column 临时表_病案首页医保.ylfkfs
  is '医疗付费方式';
comment on column 临时表_病案首页医保.jkkh
  is '健康卡号';
comment on column 临时表_病案首页医保.zycs
  is '住院次数';
comment on column 临时表_病案首页医保.bah
  is '病案号';
comment on column 临时表_病案首页医保.xm
  is '姓名';
comment on column 临时表_病案首页医保.xb
  is '性别 1.男 2.女';
comment on column 临时表_病案首页医保.csrq
  is '出生日期';
comment on column 临时表_病案首页医保.nl
  is '年龄  ';
comment on column 临时表_病案首页医保.gj
  is '国籍';
comment on column 临时表_病案首页医保.bzyzsnl
  is '(年龄不足一周岁的)年龄';
comment on column 临时表_病案首页医保.xsecstz
  is '新生儿出生体重';
comment on column 临时表_病案首页医保.xserytz
  is '新生儿入院体重';
comment on column 临时表_病案首页医保.csd
  is '出生地';
comment on column 临时表_病案首页医保.gg
  is '籍贯';
comment on column 临时表_病案首页医保.mz
  is '民族';
comment on column 临时表_病案首页医保.sfzlb
  is '身份证类别';
comment on column 临时表_病案首页医保.sfzh
  is '身份证号';
comment on column 临时表_病案首页医保.zy
  is '职业';
comment on column 临时表_病案首页医保.hy
  is '婚姻 1.未婚 2.已婚 3.丧偶4.离婚 9.其他';
comment on column 临时表_病案首页医保.xzz
  is '现住址';
comment on column 临时表_病案首页医保.dh
  is '电话(现住址)';
comment on column 临时表_病案首页医保.yb1
  is '邮编(现住址)';
comment on column 临时表_病案首页医保.hkdz
  is '户口地址';
comment on column 临时表_病案首页医保.yb2
  is '邮编(户口地址)';
comment on column 临时表_病案首页医保.gzdwjdz
  is '工作单位及地址';
comment on column 临时表_病案首页医保.dwdh
  is '工作电话(工作单位及地址)';
comment on column 临时表_病案首页医保.yb3
  is '邮编(工作单位及地址)';
comment on column 临时表_病案首页医保.lxrxm
  is '联系人姓名';
comment on column 临时表_病案首页医保.gx
  is '联系人关系';
comment on column 临时表_病案首页医保.dz
  is '联系人地址';
comment on column 临时表_病案首页医保.dh2
  is '联系人电话';
comment on column 临时表_病案首页医保.rytj
  is '入院途径 1.急诊  2.门诊  3.其他医疗机构转入  9.其他';
comment on column 临时表_病案首页医保.rysj
  is '入院时间';
comment on column 临时表_病案首页医保.rysjs
  is '入院时间(时)';
comment on column 临时表_病案首页医保.rykb
  is '入院科别';
comment on column 临时表_病案首页医保.rybf
  is '入院病房';
comment on column 临时表_病案首页医保.zkkb
  is '转科科别';
comment on column 临时表_病案首页医保.cysj
  is '出院时间';
comment on column 临时表_病案首页医保.cysjs
  is '出院时间(时)';
comment on column 临时表_病案首页医保.cykb
  is '出院科别';
comment on column 临时表_病案首页医保.cybf
  is '出院病房';
comment on column 临时表_病案首页医保.sjzyts
  is '实际住院天数';
comment on column 临时表_病案首页医保.mzzd
  is '门(急)诊诊断名称';
comment on column 临时表_病案首页医保.jbbm_s
  is '门(急)诊诊断';
comment on column 临时表_病案首页医保.zyzd
  is '疾病名称_0';
comment on column 临时表_病案首页医保.qtzd1
  is '疾病名称_1';
comment on column 临时表_病案首页医保.qtzd2
  is '疾病名称_2';
comment on column 临时表_病案首页医保.qtzd3
  is '疾病名称_3';
comment on column 临时表_病案首页医保.qtzd4
  is '疾病名称_4';
comment on column 临时表_病案首页医保.qtzd5
  is '疾病名称_5';
comment on column 临时表_病案首页医保.qtzd6
  is '疾病名称_6';
comment on column 临时表_病案首页医保.qtzd7
  is '疾病名称_7';
comment on column 临时表_病案首页医保.qtzd8
  is '疾病名称_8';
comment on column 临时表_病案首页医保.qtzd9
  is '疾病名称_9';
comment on column 临时表_病案首页医保.qtzd10
  is '疾病名称_10';
comment on column 临时表_病案首页医保.qtzd11
  is '疾病名称_11';
comment on column 临时表_病案首页医保.qtzd12
  is '疾病名称_12';
comment on column 临时表_病案首页医保.qtzd13
  is '疾病名称_13';
comment on column 临时表_病案首页医保.qtzd14
  is '疾病名称_14';
comment on column 临时表_病案首页医保.qtzd15
  is '疾病名称_15';
comment on column 临时表_病案首页医保.jbdm_s
  is '疾病编码_0';
comment on column 临时表_病案首页医保.jbdm1_s
  is '疾病编码_1';
comment on column 临时表_病案首页医保.jbdm2_s
  is '疾病编码_2';
comment on column 临时表_病案首页医保.jbdm3_s
  is '疾病编码_3';
comment on column 临时表_病案首页医保.jbdm4_s
  is '疾病编码_4';
comment on column 临时表_病案首页医保.jbdm5_s
  is '疾病编码_5';
comment on column 临时表_病案首页医保.jbdm6_s
  is '疾病编码_6';
comment on column 临时表_病案首页医保.jbdm7_s
  is '疾病编码_7';
comment on column 临时表_病案首页医保.jbdm8_s
  is '疾病编码_8';
comment on column 临时表_病案首页医保.jbdm9_s
  is '疾病编码_9';
comment on column 临时表_病案首页医保.jbdm10_s
  is '疾病编码_10';
comment on column 临时表_病案首页医保.jbdm11_s
  is '疾病编码_11';
comment on column 临时表_病案首页医保.jbdm12_s
  is '疾病编码_12';
comment on column 临时表_病案首页医保.jbdm13_s
  is '疾病编码_13';
comment on column 临时表_病案首页医保.jbdm14_s
  is '疾病编码_14';
comment on column 临时表_病案首页医保.jbdm15_s
  is '疾病编码_15';
comment on column 临时表_病案首页医保.rybq
  is '入院病情_0  长度1';
comment on column 临时表_病案首页医保.rybq1
  is '入院病情_1  长度1';
comment on column 临时表_病案首页医保.rybq2
  is '入院病情_2  长度1';
comment on column 临时表_病案首页医保.rybq3
  is '入院病情_3  长度1';
comment on column 临时表_病案首页医保.rybq4
  is '入院病情_4  长度1';
comment on column 临时表_病案首页医保.rybq5
  is '入院病情_5  长度1';
comment on column 临时表_病案首页医保.rybq6
  is '入院病情_6  长度1';
comment on column 临时表_病案首页医保.rybq7
  is '入院病情_7  长度1';
comment on column 临时表_病案首页医保.rybq8
  is '入院病情_8  长度1';
comment on column 临时表_病案首页医保.rybq9
  is '入院病情_9  长度1';
comment on column 临时表_病案首页医保.rybq10
  is '入院病情_10  长度1';
comment on column 临时表_病案首页医保.rybq11
  is '入院病情_11  长度1';
comment on column 临时表_病案首页医保.rybq12
  is '入院病情_12  长度1';
comment on column 临时表_病案首页医保.rybq13
  is '入院病情_13  长度1';
comment on column 临时表_病案首页医保.rybq14
  is '入院病情_14  长度1';
comment on column 临时表_病案首页医保.rybq15
  is '入院病情_15  长度1';
comment on column 临时表_病案首页医保.wbyy
  is '损伤、中毒的外部原因名称';
comment on column 临时表_病案首页医保.ssbm_s
  is '损伤、中毒的外部原因';
comment on column 临时表_病案首页医保.blzd
  is '病理诊断名称';
comment on column 临时表_病案首页医保.jbmm_s
  is '病理诊断';
comment on column 临时表_病案首页医保.blh
  is '病理号';
comment on column 临时表_病案首页医保.ywgm
  is '是否药物过敏';
comment on column 临时表_病案首页医保.gmyw
  is '过敏药物';
comment on column 临时表_病案首页医保.swhzsj
  is '死亡患者尸检';
comment on column 临时表_病案首页医保.xx
  is '血型';
comment on column 临时表_病案首页医保.rh
  is 'RH';
comment on column 临时表_病案首页医保.qjcs
  is '抢救次数';
comment on column 临时表_病案首页医保.cgcs
  is '成功次数';
comment on column 临时表_病案首页医保.sxfy
  is '输血反应';
comment on column 临时表_病案首页医保.rcmdsc
  is '妊娠梅毒筛查';
comment on column 临时表_病案首页医保.xsrjbsc
  is '新生儿疾病筛查';
comment on column 临时表_病案首页医保.chcx
  is '产后出血';
comment on column 临时表_病案首页医保.kzr
  is '科主任';
comment on column 临时表_病案首页医保.zrys
  is '主任(副主任)医师';
comment on column 临时表_病案首页医保.zzys
  is '主治医师';
comment on column 临时表_病案首页医保.zyys
  is '住院医师';
comment on column 临时表_病案首页医保.zrhs
  is '责任护士';
comment on column 临时表_病案首页医保.jxys
  is '进修医师';
comment on column 临时表_病案首页医保.sxys
  is '实习医师';
comment on column 临时表_病案首页医保.bmy
  is '编码员';
comment on column 临时表_病案首页医保.bazl
  is '病案质量';
comment on column 临时表_病案首页医保.zkys
  is '质控医师';
comment on column 临时表_病案首页医保.zkhs
  is '质控护士';
comment on column 临时表_病案首页医保.zkrq
  is '质控日期';
comment on column 临时表_病案首页医保.ssbm1_s
  is '手术及操作编码1';
comment on column 临时表_病案首页医保.ssbm2_s
  is '手术及操作编码2';
comment on column 临时表_病案首页医保.ssbm3_s
  is '手术及操作编码3';
comment on column 临时表_病案首页医保.ssbm4_s
  is '手术及操作编码4';
comment on column 临时表_病案首页医保.ssbm5_s
  is '手术及操作编码5';
comment on column 临时表_病案首页医保.ssbm6_s
  is '手术及操作编码6';
comment on column 临时表_病案首页医保.ssbm7_s
  is '手术及操作编码7';
comment on column 临时表_病案首页医保.ssjczrq1
  is '手术及操作日期1';
comment on column 临时表_病案首页医保.ssjczrq2
  is '手术及操作日期2';
comment on column 临时表_病案首页医保.ssjczrq3
  is '手术及操作日期3';
comment on column 临时表_病案首页医保.ssjczrq4
  is '手术及操作日期4';
comment on column 临时表_病案首页医保.ssjczrq5
  is '手术及操作日期5';
comment on column 临时表_病案首页医保.ssjczrq6
  is '手术及操作日期6';
comment on column 临时表_病案首页医保.ssjczrq7
  is '手术及操作日期7';
comment on column 临时表_病案首页医保.sslx
  is '手术类型';
comment on column 临时表_病案首页医保.ssjb1
  is '手术级别1  长度1';
comment on column 临时表_病案首页医保.ssjb2
  is '手术级别2  长度1';
comment on column 临时表_病案首页医保.ssjb3
  is '手术级别3  长度1';
comment on column 临时表_病案首页医保.ssjb4
  is '手术级别4  长度1';
comment on column 临时表_病案首页医保.ssjb5
  is '手术级别5  长度1';
comment on column 临时表_病案首页医保.ssjb6
  is '手术级别6  长度1';
comment on column 临时表_病案首页医保.ssjb7
  is '手术级别7  长度1';
comment on column 临时表_病案首页医保.ssjczmc1
  is '手术及操作名称1';
comment on column 临时表_病案首页医保.ssjczmc2
  is '手术及操作名称2';
comment on column 临时表_病案首页医保.ssjczmc3
  is '手术及操作名称3';
comment on column 临时表_病案首页医保.ssjczmc4
  is '手术及操作名称4';
comment on column 临时表_病案首页医保.ssjczmc5
  is '手术及操作名称5';
comment on column 临时表_病案首页医保.ssjczmc6
  is '手术及操作名称6';
comment on column 临时表_病案首页医保.ssjczmc7
  is '手术及操作名称7';
comment on column 临时表_病案首页医保.sz1
  is '术者1';
comment on column 临时表_病案首页医保.sz2
  is '术者2';
comment on column 临时表_病案首页医保.sz3
  is '术者3';
comment on column 临时表_病案首页医保.sz4
  is '术者4';
comment on column 临时表_病案首页医保.sz5
  is '术者5';
comment on column 临时表_病案首页医保.sz6
  is '术者6';
comment on column 临时表_病案首页医保.sz7
  is '术者7';
comment on column 临时表_病案首页医保.yz1
  is 'Ⅰ助1';
comment on column 临时表_病案首页医保.yz2
  is 'Ⅰ助2';
comment on column 临时表_病案首页医保.yz3
  is 'Ⅰ助3';
comment on column 临时表_病案首页医保.yz4
  is 'Ⅰ助4';
comment on column 临时表_病案首页医保.yz5
  is 'Ⅰ助5';
comment on column 临时表_病案首页医保.yz6
  is 'Ⅰ助6';
comment on column 临时表_病案首页医保.yz7
  is 'Ⅰ助7';
comment on column 临时表_病案首页医保.ez1
  is 'Ⅱ助1';
comment on column 临时表_病案首页医保.ez2
  is 'Ⅱ助2';
comment on column 临时表_病案首页医保.ez3
  is 'Ⅱ助3';
comment on column 临时表_病案首页医保.ez4
  is 'Ⅱ助4';
comment on column 临时表_病案首页医保.ez5
  is 'Ⅱ助5';
comment on column 临时表_病案首页医保.ez6
  is 'Ⅱ助6';
comment on column 临时表_病案首页医保.ez7
  is 'Ⅱ助7';
comment on column 临时表_病案首页医保.qkyhlb1
  is '切口愈合类别1';
comment on column 临时表_病案首页医保.qkyhlb2
  is '切口愈合类别2';
comment on column 临时表_病案首页医保.qkyhlb3
  is '切口愈合类别3';
comment on column 临时表_病案首页医保.qkyhlb4
  is '切口愈合类别4';
comment on column 临时表_病案首页医保.qkyhlb5
  is '切口愈合类别5';
comment on column 临时表_病案首页医保.qkyhlb6
  is '切口愈合类别6';
comment on column 临时表_病案首页医保.qkyhlb7
  is '切口愈合类别7';
comment on column 临时表_病案首页医保.qkyhdj1
  is '切口愈合等级1';
comment on column 临时表_病案首页医保.qkyhdj2
  is '切口愈合等级2';
comment on column 临时表_病案首页医保.qkyhdj3
  is '切口愈合等级3';
comment on column 临时表_病案首页医保.qkyhdj4
  is '切口愈合等级4';
comment on column 临时表_病案首页医保.qkyhdj5
  is '切口愈合等级5';
comment on column 临时表_病案首页医保.qkyhdj6
  is '切口愈合等级6';
comment on column 临时表_病案首页医保.qkyhdj7
  is '切口愈合等级7';
comment on column 临时表_病案首页医保.mzfs1
  is '麻醉方式1';
comment on column 临时表_病案首页医保.mzfs2
  is '麻醉方式2';
comment on column 临时表_病案首页医保.mzfs3
  is '麻醉方式3';
comment on column 临时表_病案首页医保.mzfs4
  is '麻醉方式4';
comment on column 临时表_病案首页医保.mzfs5
  is '麻醉方式5';
comment on column 临时表_病案首页医保.mzfs6
  is '麻醉方式6';
comment on column 临时表_病案首页医保.mzfs7
  is '麻醉方式7';
comment on column 临时表_病案首页医保.mzys1
  is '麻醉医师1';
comment on column 临时表_病案首页医保.mzys2
  is '麻醉医师2';
comment on column 临时表_病案首页医保.mzys3
  is '麻醉医师3';
comment on column 临时表_病案首页医保.mzys4
  is '麻醉医师4';
comment on column 临时表_病案首页医保.mzys5
  is '麻醉医师5';
comment on column 临时表_病案首页医保.mzys6
  is '麻醉医师6';
comment on column 临时表_病案首页医保.mzys7
  is '麻醉医师7';
comment on column 临时表_病案首页医保.lyfs
  is '离院方式';
comment on column 临时表_病案首页医保.sfzzyjh
  is '再住院计划';
comment on column 临时表_病案首页医保.md
  is '目的';
comment on column 临时表_病案首页医保.ryq_t
  is '入院前天';
comment on column 临时表_病案首页医保.ryq_xs
  is '入院前小时';
comment on column 临时表_病案首页医保.ryq_f
  is '入院前分钟';
comment on column 临时表_病案首页医保.ryh_t
  is '入院后天';
comment on column 临时表_病案首页医保.ryh_xs
  is '入院后小时';
comment on column 临时表_病案首页医保.ryh_f
  is '入院后分钟';
comment on column 临时表_病案首页医保.zfy
  is '住院费用（元）：总费用';
comment on column 临时表_病案首页医保.zfje
  is '自付金额';
comment on column 临时表_病案首页医保.zfeje
  is '自费金额';
comment on column 临时表_病案首页医保.qtzf
  is '其他支付';
comment on column 临时表_病案首页医保.ylfuf
  is '一般医疗服务费';
comment on column 临时表_病案首页医保.zlczf
  is '一般治疗操作费';
comment on column 临时表_病案首页医保.hlf
  is '护理费';
comment on column 临时表_病案首页医保.qtfy
  is '其他费用';
comment on column 临时表_病案首页医保.blzdf
  is '病理诊断费';
comment on column 临时表_病案首页医保.syszdf
  is '实验室诊断费';
comment on column 临时表_病案首页医保.yxxzdf
  is '影像学诊断费';
comment on column 临时表_病案首页医保.lczdxmf
  is '临床诊断项目费';
comment on column 临时表_病案首页医保.fsszlxmf
  is '非手术治疗项目费';
comment on column 临时表_病案首页医保.wlzlf
  is '临床物理治疗费';
comment on column 临时表_病案首页医保.sszlf
  is '手术治疗费';
comment on column 临时表_病案首页医保.maf
  is '麻醉费_手术治疗费';
comment on column 临时表_病案首页医保.ssf
  is '手术费_手术治疗费';
comment on column 临时表_病案首页医保.kff
  is '康复费';
comment on column 临时表_病案首页医保.zyzlf
  is '中医治疗费';
comment on column 临时表_病案首页医保.xyf
  is '西药费';
comment on column 临时表_病案首页医保.kjywf
  is '抗菌药物费用';
comment on column 临时表_病案首页医保.zcyf
  is '中成药费';
comment on column 临时表_病案首页医保.zcyf1
  is '中草药费';
comment on column 临时表_病案首页医保.xf
  is '血费';
comment on column 临时表_病案首页医保.bdblzpf
  is '白蛋白类制品费';
comment on column 临时表_病案首页医保.qdblzpf
  is '球蛋白类制品费';
comment on column 临时表_病案首页医保.nxyzlzpf
  is '凝血因子类制品费';
comment on column 临时表_病案首页医保.xbyzlzpf
  is '细胞因子类制品费';
comment on column 临时表_病案首页医保.hcyyclf
  is '检查用一次性医用材料费';
comment on column 临时表_病案首页医保.yyclf
  is '治疗用一次性医用材料费';
comment on column 临时表_病案首页医保.ycxyyclf
  is '手术用一次性医用材料费';
comment on column 临时表_病案首页医保.qtf
  is '其他费';
comment on column 临时表_病案首页医保.jys
  is '交易数 每份病案结算完成后共与医保中心发生的结算次数';
comment on column 临时表_病案首页医保.sblb
  is '申报类别：0.按病种分值结算；1.按病种床日分值结算；9.其他';
comment on column 临时表_病案首页医保.bz1
  is '备注1';
comment on column 临时表_病案首页医保.bz2
  is '备注2';
comment on column 临时表_病案首页医保.bz3
  is '备注3';
comment on column 临时表_病案首页医保.bz4
  is '备注4';
comment on column 临时表_病案首页医保.bz5
  is '备注5';
