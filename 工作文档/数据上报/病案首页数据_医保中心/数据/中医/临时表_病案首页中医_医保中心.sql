-- Create table
create global temporary table 临时表_病案首页中医_医保中心
(
  jyh        VARCHAR2(100),
  aaz107     VARCHAR2(11),
  idc        VARCHAR2(20),
  ylfkfs     VARCHAR2(3),
  jkkh       VARCHAR2(100),
  zycs       VARCHAR2(10),
  bah        VARCHAR2(18),
  xm         VARCHAR2(20),
  xb         VARCHAR2(1),
  csrq       VARCHAR2(12),
  nl         NUMBER(10),
  gj         VARCHAR2(3),
  bzyzs_nl   NUMBER(10),
  xsetz      NUMBER(12,2),
  xserytz    NUMBER(12,2),
  csd        VARCHAR2(200),
  gg         VARCHAR2(200),
  mz         VARCHAR2(2),
  sfzh       VARCHAR2(100),
  zy         VARCHAR2(2),
  hy         VARCHAR2(2),
  xzz        VARCHAR2(254),
  dh         VARCHAR2(20),
  yb1        VARCHAR2(6),
  hkdz       VARCHAR2(254),
  yb2        VARCHAR2(6),
  gzdwjdz    VARCHAR2(254),
  dwdh       VARCHAR2(20),
  yb3        VARCHAR2(6),
  lxrxm      VARCHAR2(20),
  gx         VARCHAR2(1),
  dz         VARCHAR2(200),
  dh1        VARCHAR2(20),
  rytj       VARCHAR2(1),
  zllb       VARCHAR2(3),
  rysj       VARCHAR2(12),
  rysj_s     NUMBER(10),
  rykb       VARCHAR2(100),
  rybf       VARCHAR2(100),
  zkkb       VARCHAR2(100),
  cysj       VARCHAR2(12),
  cysj_s     NUMBER(10),
  cykb       VARCHAR2(100),
  cybf       VARCHAR2(100),
  sjzy       NUMBER(8,2),
  mzd_zyzd   VARCHAR2(200),
  jbdm_s     VARCHAR2(10),
  mzzd_xyzd  VARCHAR2(200),
  jbbm_s     VARCHAR2(16),
  sslclj     VARCHAR2(1),
  zyyj       VARCHAR2(1),
  zyzlsb     VARCHAR2(1),
  zyzljs     VARCHAR2(1),
  bzsh       VARCHAR2(1),
  zb         VARCHAR2(200),
  zz1        VARCHAR2(200),
  zz2        VARCHAR2(200),
  zz3        VARCHAR2(200),
  zz4        VARCHAR2(200),
  zz5        VARCHAR2(200),
  zz6        VARCHAR2(200),
  zz7        VARCHAR2(200),
  zz8        VARCHAR2(200),
  zz9        VARCHAR2(200),
  zz10       VARCHAR2(200),
  zyzd       VARCHAR2(200),
  qtzd1      VARCHAR2(200),
  qtzd2      VARCHAR2(200),
  qtzd3      VARCHAR2(200),
  qtzd4      VARCHAR2(200),
  qtzd5      VARCHAR2(200),
  qtzd6      VARCHAR2(200),
  qtzd7      VARCHAR2(200),
  qtzd8      VARCHAR2(200),
  qtzd9      VARCHAR2(200),
  qtzd10     VARCHAR2(200),
  qtzd11     VARCHAR2(200),
  qtzd12     VARCHAR2(200),
  qtzd13     VARCHAR2(200),
  qtzd14     VARCHAR2(200),
  qtzd15     VARCHAR2(200),
  zbbm_s     VARCHAR2(6),
  zzbm1_s    VARCHAR2(6),
  zzbm2_s    VARCHAR2(6),
  zzbm3_s    VARCHAR2(6),
  zzbm4_s    VARCHAR2(6),
  zzbm5_s    VARCHAR2(6),
  zzbm6_s    VARCHAR2(6),
  zzbm7_s    VARCHAR2(6),
  zzbm8_s    VARCHAR2(6),
  zzbm9_s    VARCHAR2(6),
  zzbm10_s   VARCHAR2(6),
  zyzdbm_s   VARCHAR2(10),
  qtzdbm1_s  VARCHAR2(10),
  qtzdbm2_s  VARCHAR2(10),
  qtzdbm3_s  VARCHAR2(10),
  qtzdbm4_s  VARCHAR2(10),
  qtzdbm5_s  VARCHAR2(10),
  qtzdbm6_s  VARCHAR2(10),
  qtzdbm7_s  VARCHAR2(10),
  qtzdbm8_s  VARCHAR2(10),
  qtzdbm9_s  VARCHAR2(10),
  qtzdbm10_s VARCHAR2(10),
  qtzdbm11_s VARCHAR2(10),
  qtzdbm12_s VARCHAR2(10),
  qtzdbm13_s VARCHAR2(10),
  qtzdbm14_s VARCHAR2(10),
  qtzdbm15_s VARCHAR2(10),
  zb_rybq    VARCHAR2(10),
  zz_rybq1   VARCHAR2(10),
  zz_rybq2   VARCHAR2(10),
  zz_rybq3   VARCHAR2(10),
  zz_rybq4   VARCHAR2(10),
  zz_rybq5   VARCHAR2(10),
  zz_rybq6   VARCHAR2(10),
  zz_rybq7   VARCHAR2(10),
  zz_rybq8   VARCHAR2(10),
  zz_rybq9   VARCHAR2(10),
  zz_rybq10  VARCHAR2(10),
  xy_rybq    VARCHAR2(10),
  rybq1      VARCHAR2(10),
  rybq2      VARCHAR2(10),
  rybq3      VARCHAR2(10),
  rybq4      VARCHAR2(10),
  rybq5      VARCHAR2(10),
  rybq6      VARCHAR2(10),
  rybq7      VARCHAR2(10),
  rybq8      VARCHAR2(10),
  rybq9      VARCHAR2(10),
  rybq10     VARCHAR2(10),
  rybq11     VARCHAR2(10),
  rybq12     VARCHAR2(10),
  rybq13     VARCHAR2(10),
  rybq14     VARCHAR2(10),
  rybq15     VARCHAR2(10),
  wbyy       VARCHAR2(100),
  jbbm1_s    VARCHAR2(10),
  blzd       VARCHAR2(100),
  jbbm2_s    VARCHAR2(10),
  blh        VARCHAR2(100),
  ywgm       VARCHAR2(100),
  gmyw       VARCHAR2(100),
  sj         VARCHAR2(1),
  xx         VARCHAR2(1),
  rh         VARCHAR2(1),
  qjcs       NUMBER(12),
  cgcs       NUMBER(12),
  sxfy       VARCHAR2(1),
  rcmdsc     VARCHAR2(1),
  xsrjbsc    VARCHAR2(50),
  chcx       VARCHAR2(1),
  kzr        VARCHAR2(100),
  zrys       VARCHAR2(100),
  zzys       VARCHAR2(100),
  zyys       VARCHAR2(100),
  zrhs       VARCHAR2(100),
  jxys       VARCHAR2(100),
  sxys       VARCHAR2(100),
  bmy        VARCHAR2(100),
  bazl       VARCHAR2(1),
  zkys       VARCHAR2(100),
  zkhs       VARCHAR2(100),
  zkrq       VARCHAR2(12),
  ssbm1_s    VARCHAR2(20),
  ssbm2_s    VARCHAR2(20),
  ssbm3_s    VARCHAR2(20),
  ssbm4_s    VARCHAR2(20),
  ssbm5_s    VARCHAR2(20),
  ssbm6_s    VARCHAR2(20),
  ssbm7_s    VARCHAR2(20),
  ssjczrq1   VARCHAR2(12),
  ssjczrq2   VARCHAR2(12),
  ssjczrq3   VARCHAR2(12),
  ssjczrq4   VARCHAR2(12),
  ssjczrq5   VARCHAR2(12),
  ssjczrq6   VARCHAR2(12),
  ssjczrq7   VARCHAR2(12),
  ssjb1      VARCHAR2(10),
  ssjb2      VARCHAR2(10),
  ssjb3      VARCHAR2(10),
  ssjb4      VARCHAR2(10),
  ssjb5      VARCHAR2(10),
  ssjb6      VARCHAR2(10),
  ssjb7      VARCHAR2(10),
  ssjczmc1   VARCHAR2(200),
  ssjczmc2   VARCHAR2(200),
  ssjczmc3   VARCHAR2(200),
  ssjczmc4   VARCHAR2(200),
  ssjczmc5   VARCHAR2(200),
  ssjczmc6   VARCHAR2(200),
  ssjczmc7   VARCHAR2(200),
  sz1        VARCHAR2(100),
  sz2        VARCHAR2(100),
  sz3        VARCHAR2(100),
  sz4        VARCHAR2(100),
  sz5        VARCHAR2(100),
  sz6        VARCHAR2(100),
  sz7        VARCHAR2(100),
  yz1        VARCHAR2(100),
  yz2        VARCHAR2(100),
  yz3        VARCHAR2(100),
  yz4        VARCHAR2(100),
  yz5        VARCHAR2(100),
  yz6        VARCHAR2(100),
  yz7        VARCHAR2(100),
  ez1        VARCHAR2(100),
  ez2        VARCHAR2(100),
  ez3        VARCHAR2(100),
  ez4        VARCHAR2(100),
  ez5        VARCHAR2(100),
  ez6        VARCHAR2(100),
  ez7        VARCHAR2(100),
  qkylb1     VARCHAR2(5),
  qkylb2     VARCHAR2(5),
  qkylb3     VARCHAR2(5),
  qkylb4     VARCHAR2(5),
  qkylb5     VARCHAR2(5),
  qkylb6     VARCHAR2(5),
  qkylb7     VARCHAR2(5),
  qkyhdj1    VARCHAR2(5),
  qkyhdj2    VARCHAR2(5),
  qkyhdj3    VARCHAR2(5),
  qkyhdj4    VARCHAR2(5),
  qkyhdj5    VARCHAR2(5),
  qkyhdj6    VARCHAR2(5),
  qkyhdj7    VARCHAR2(5),
  mzfs1      VARCHAR2(100),
  mzfs2      VARCHAR2(100),
  mzfs3      VARCHAR2(100),
  mzfs4      VARCHAR2(100),
  mzfs5      VARCHAR2(100),
  mzfs6      VARCHAR2(100),
  mzfs7      VARCHAR2(100),
  mzys1      VARCHAR2(100),
  mzys2      VARCHAR2(100),
  mzys3      VARCHAR2(100),
  mzys4      VARCHAR2(100),
  mzys5      VARCHAR2(100),
  mzys6      VARCHAR2(100),
  mzys7      VARCHAR2(100),
  lyfs       VARCHAR2(1),
  zzyjh      VARCHAR2(1),
  md         VARCHAR2(100),
  ryq_t      NUMBER(10),
  ryq_xs     NUMBER(10),
  ryq_f      NUMBER(10),
  ryh_t      NUMBER(10),
  ryh_xs     NUMBER(10),
  ryh_f      NUMBER(10),
  zfy        NUMBER(12,2),
  zfje       NUMBER(12,2),
  zfije      NUMBER(12,2),
  qtzf       NUMBER(12,2),
  ylfwf      NUMBER(12,2),
  bzlzf      NUMBER(12,2),
  zyblzhzf   NUMBER(12,2),
  zlczf      NUMBER(12,2),
  hlf        NUMBER(12,2),
  qtfy       NUMBER(12,2),
  blzdf      NUMBER(12,2),
  syszdf     NUMBER(12,2),
  yxxzdf     NUMBER(12,2),
  lczdxmf    NUMBER(12,2),
  fsszlxmf   NUMBER(12,2),
  zlf        NUMBER(12,2),
  sszlf      NUMBER(12,2),
  mzf        NUMBER(12,2),
  ssf        NUMBER(12,2),
  kff        NUMBER(12,2),
  zyl_zyzd   NUMBER(12,2),
  zyzl       NUMBER(12,2),
  zywz       NUMBER(12,2),
  zygs       NUMBER(12,2),
  zcyjf      NUMBER(12,2),
  zytnzl     NUMBER(12,2),
  zygczl     NUMBER(12,2),
  zytszl     NUMBER(12,2),
  zyqt       NUMBER(12,2),
  zytstpjg   NUMBER(12,2),
  bzss       NUMBER(12,2),
  xyf        NUMBER(12,2),
  kjywf      NUMBER(12,2),
  zcyf       NUMBER(12,2),
  yzjf_zcy   NUMBER(12,2),
  zcyf1      NUMBER(12,2),
  xf         NUMBER(12,2),
  bdblzpf    NUMBER(12,2),
  qdblzpf    NUMBER(12,2),
  nxyzlzpf   NUMBER(12,2),
  xbyzlzpf   NUMBER(12,2),
  cyyyclf    NUMBER(12,2),
  yyclf      NUMBER(12,2),
  ssycxclf   NUMBER(12,2),
  qtf        NUMBER(12,2),
  jys        NUMBER(10),
  sblb       VARCHAR2(1),
  bz1        VARCHAR2(100),
  bz2        VARCHAR2(100),
  bz3        VARCHAR2(100),
  bz4        VARCHAR2(100),
  bz5        VARCHAR2(100)
)
on commit preserve rows;
-- Add comments to the columns 
comment on column 临时表_病案首页中医_医保中心.jyh
  is '就医号（医院内部生成的唯一编号）';
comment on column 临时表_病案首页中医_医保中心.aaz107
  is '医保医疗机构代码';
comment on column 临时表_病案首页中医_医保中心.idc
  is '组织机构代码';
comment on column 临时表_病案首页中医_医保中心.ylfkfs
  is '医疗付费方式';
comment on column 临时表_病案首页中医_医保中心.jkkh
  is '健康卡号';
comment on column 临时表_病案首页中医_医保中心.zycs
  is '住院次数';
comment on column 临时表_病案首页中医_医保中心.bah
  is '病案号';
comment on column 临时表_病案首页中医_医保中心.xm
  is '姓名';
comment on column 临时表_病案首页中医_医保中心.xb
  is '性别 1.男 2.女';
comment on column 临时表_病案首页中医_医保中心.csrq
  is '出生日期';
comment on column 临时表_病案首页中医_医保中心.nl
  is '年龄';
comment on column 临时表_病案首页中医_医保中心.gj
  is '国籍';
comment on column 临时表_病案首页中医_医保中心.bzyzs_nl
  is '年龄不足一周岁的年龄(月龄)';
comment on column 临时表_病案首页中医_医保中心.xsetz
  is '新生儿出生体重（克）';
comment on column 临时表_病案首页中医_医保中心.xserytz
  is '新生儿入院体重（克）';
comment on column 临时表_病案首页中医_医保中心.csd
  is '出生地';
comment on column 临时表_病案首页中医_医保中心.gg
  is '籍贯';
comment on column 临时表_病案首页中医_医保中心.mz
  is '民族';
comment on column 临时表_病案首页中医_医保中心.sfzh
  is '身份证号';
comment on column 临时表_病案首页中医_医保中心.zy
  is '职业';
comment on column 临时表_病案首页中医_医保中心.hy
  is '婚姻  1.未婚 2.已婚 3.丧偶4.离婚 9.其他';
comment on column 临时表_病案首页中医_医保中心.xzz
  is '现住址';
comment on column 临时表_病案首页中医_医保中心.dh
  is '电话号码';
comment on column 临时表_病案首页中医_医保中心.yb1
  is '邮编(现住址)';
comment on column 临时表_病案首页中医_医保中心.hkdz
  is '户口地址';
comment on column 临时表_病案首页中医_医保中心.yb2
  is '邮编(户口地址)';
comment on column 临时表_病案首页中医_医保中心.gzdwjdz
  is '工作单位名称及地址';
comment on column 临时表_病案首页中医_医保中心.dwdh
  is '工作单位电话';
comment on column 临时表_病案首页中医_医保中心.yb3
  is '邮编(工作单位及地址)';
comment on column 临时表_病案首页中医_医保中心.lxrxm
  is '联系人姓名';
comment on column 临时表_病案首页中医_医保中心.gx
  is '关系(联系人与患者关系)';
comment on column 临时表_病案首页中医_医保中心.dz
  is '联系人地址';
comment on column 临时表_病案首页中医_医保中心.dh1
  is '联系人电话号码';
comment on column 临时表_病案首页中医_医保中心.rytj
  is '入院途径  1.急诊  2.门诊  3.其他医疗机构转入  9.其他';
comment on column 临时表_病案首页中医_医保中心.zllb
  is '治疗类别';
comment on column 临时表_病案首页中医_医保中心.rysj
  is '入院时间';
comment on column 临时表_病案首页中医_医保中心.rysj_s
  is '入院时间(时)';
comment on column 临时表_病案首页中医_医保中心.rykb
  is '入院科别';
comment on column 临时表_病案首页中医_医保中心.rybf
  is '入院病房';
comment on column 临时表_病案首页中医_医保中心.zkkb
  is '转科科别';
comment on column 临时表_病案首页中医_医保中心.cysj
  is '出院时间';
comment on column 临时表_病案首页中医_医保中心.cysj_s
  is '出院时间(时)';
comment on column 临时表_病案首页中医_医保中心.cykb
  is '出院科别';
comment on column 临时表_病案首页中医_医保中心.cybf
  is '出院病房';
comment on column 临时表_病案首页中医_医保中心.sjzy
  is '实际住院天数';
comment on column 临时表_病案首页中医_医保中心.mzd_zyzd
  is '门(急)诊诊断名称1';
comment on column 临时表_病案首页中医_医保中心.jbdm_s
  is '门(急)诊诊断1';
comment on column 临时表_病案首页中医_医保中心.mzzd_xyzd
  is '门(急)诊诊断名称2';
comment on column 临时表_病案首页中医_医保中心.jbbm_s
  is '门(急)诊诊断2';
comment on column 临时表_病案首页中医_医保中心.sslclj
  is '实施临床路径';
comment on column 临时表_病案首页中医_医保中心.zyyj
  is '使用医疗机构中药制剂';
comment on column 临时表_病案首页中医_医保中心.zyzlsb
  is '使用中医诊疗设备';
comment on column 临时表_病案首页中医_医保中心.zyzljs
  is '使用中医诊疗技术';
comment on column 临时表_病案首页中医_医保中心.bzsh
  is '辩证施护';
comment on column 临时表_病案首页中医_医保中心.zb
  is '疾病名称ZB';
comment on column 临时表_病案首页中医_医保中心.zz1
  is '疾病名称ZZ';
comment on column 临时表_病案首页中医_医保中心.zz2
  is '疾病名称ZZ2';
comment on column 临时表_病案首页中医_医保中心.zz3
  is '疾病名称ZZ3';
comment on column 临时表_病案首页中医_医保中心.zz4
  is '疾病名称ZZ4';
comment on column 临时表_病案首页中医_医保中心.zz5
  is '疾病名称ZZ5';
comment on column 临时表_病案首页中医_医保中心.zz6
  is '疾病名称ZZ6';
comment on column 临时表_病案首页中医_医保中心.zz7
  is '疾病名称ZZ7';
comment on column 临时表_病案首页中医_医保中心.zz8
  is '疾病名称ZZ8';
comment on column 临时表_病案首页中医_医保中心.zz9
  is '疾病名称ZZ9';
comment on column 临时表_病案首页中医_医保中心.zz10
  is '疾病名称ZZ10';
comment on column 临时表_病案首页中医_医保中心.zyzd
  is '疾病名称_0';
comment on column 临时表_病案首页中医_医保中心.qtzd1
  is '疾病名称1';
comment on column 临时表_病案首页中医_医保中心.qtzd2
  is '疾病名称2';
comment on column 临时表_病案首页中医_医保中心.qtzd3
  is '疾病名称3';
comment on column 临时表_病案首页中医_医保中心.qtzd4
  is '疾病名称4';
comment on column 临时表_病案首页中医_医保中心.qtzd5
  is '疾病名称5';
comment on column 临时表_病案首页中医_医保中心.qtzd6
  is '疾病名称6';
comment on column 临时表_病案首页中医_医保中心.qtzd7
  is '疾病名称7';
comment on column 临时表_病案首页中医_医保中心.qtzd8
  is '疾病名称8';
comment on column 临时表_病案首页中医_医保中心.qtzd9
  is '疾病名称9';
comment on column 临时表_病案首页中医_医保中心.qtzd10
  is '疾病名称10';
comment on column 临时表_病案首页中医_医保中心.qtzd11
  is '疾病名称11';
comment on column 临时表_病案首页中医_医保中心.qtzd12
  is '疾病名称12';
comment on column 临时表_病案首页中医_医保中心.qtzd13
  is '疾病名称13';
comment on column 临时表_病案首页中医_医保中心.qtzd14
  is '疾病名称14';
comment on column 临时表_病案首页中医_医保中心.qtzd15
  is '疾病名称15';
comment on column 临时表_病案首页中医_医保中心.zbbm_s
  is '疾病编码ZB';
comment on column 临时表_病案首页中医_医保中心.zzbm1_s
  is '疾病编码ZZ';
comment on column 临时表_病案首页中医_医保中心.zzbm2_s
  is '疾病编码ZZ2';
comment on column 临时表_病案首页中医_医保中心.zzbm3_s
  is '疾病编码ZZ3';
comment on column 临时表_病案首页中医_医保中心.zzbm4_s
  is '疾病编码ZZ4';
comment on column 临时表_病案首页中医_医保中心.zzbm5_s
  is '疾病编码ZZ5';
comment on column 临时表_病案首页中医_医保中心.zzbm6_s
  is '疾病编码ZZ6';
comment on column 临时表_病案首页中医_医保中心.zzbm7_s
  is '疾病编码ZZ7';
comment on column 临时表_病案首页中医_医保中心.zzbm8_s
  is '疾病编码ZZ8';
comment on column 临时表_病案首页中医_医保中心.zzbm9_s
  is '疾病编码ZZ9';
comment on column 临时表_病案首页中医_医保中心.zzbm10_s
  is '疾病编码ZZ10';
comment on column 临时表_病案首页中医_医保中心.zyzdbm_s
  is '疾病编码_0';
comment on column 临时表_病案首页中医_医保中心.qtzdbm1_s
  is '疾病编码1';
comment on column 临时表_病案首页中医_医保中心.qtzdbm2_s
  is '疾病编码2';
comment on column 临时表_病案首页中医_医保中心.qtzdbm3_s
  is '疾病编码3';
comment on column 临时表_病案首页中医_医保中心.qtzdbm4_s
  is '疾病编码4';
comment on column 临时表_病案首页中医_医保中心.qtzdbm5_s
  is '疾病编码5';
comment on column 临时表_病案首页中医_医保中心.qtzdbm6_s
  is '疾病编码6';
comment on column 临时表_病案首页中医_医保中心.qtzdbm7_s
  is '疾病编码7';
comment on column 临时表_病案首页中医_医保中心.qtzdbm8_s
  is '疾病编码8';
comment on column 临时表_病案首页中医_医保中心.qtzdbm9_s
  is '疾病编码9';
comment on column 临时表_病案首页中医_医保中心.qtzdbm10_s
  is '疾病编码10';
comment on column 临时表_病案首页中医_医保中心.qtzdbm11_s
  is '疾病编码11';
comment on column 临时表_病案首页中医_医保中心.qtzdbm12_s
  is '疾病编码12';
comment on column 临时表_病案首页中医_医保中心.qtzdbm13_s
  is '疾病编码13';
comment on column 临时表_病案首页中医_医保中心.qtzdbm14_s
  is '疾病编码14';
comment on column 临时表_病案首页中医_医保中心.qtzdbm15_s
  is '疾病编码15';
comment on column 临时表_病案首页中医_医保中心.zb_rybq
  is '入院病情ZB';
comment on column 临时表_病案首页中医_医保中心.zz_rybq1
  is '入院病情ZZ';
comment on column 临时表_病案首页中医_医保中心.zz_rybq2
  is '入院病情ZZ2';
comment on column 临时表_病案首页中医_医保中心.zz_rybq3
  is '入院病情ZZ3';
comment on column 临时表_病案首页中医_医保中心.zz_rybq4
  is '入院病情ZZ4';
comment on column 临时表_病案首页中医_医保中心.zz_rybq5
  is '入院病情ZZ5';
comment on column 临时表_病案首页中医_医保中心.zz_rybq6
  is '入院病情ZZ6';
comment on column 临时表_病案首页中医_医保中心.zz_rybq7
  is '入院病情ZZ7';
comment on column 临时表_病案首页中医_医保中心.zz_rybq8
  is '入院病情ZZ8';
comment on column 临时表_病案首页中医_医保中心.zz_rybq9
  is '入院病情ZZ9';
comment on column 临时表_病案首页中医_医保中心.zz_rybq10
  is '入院病情ZZ10';
comment on column 临时表_病案首页中医_医保中心.xy_rybq
  is '入院病情_0';
comment on column 临时表_病案首页中医_医保中心.rybq1
  is '入院病情1';
comment on column 临时表_病案首页中医_医保中心.rybq2
  is '入院病情2';
comment on column 临时表_病案首页中医_医保中心.rybq3
  is '入院病情3';
comment on column 临时表_病案首页中医_医保中心.rybq4
  is '入院病情4';
comment on column 临时表_病案首页中医_医保中心.rybq5
  is '入院病情5';
comment on column 临时表_病案首页中医_医保中心.rybq6
  is '入院病情6';
comment on column 临时表_病案首页中医_医保中心.rybq7
  is '入院病情7';
comment on column 临时表_病案首页中医_医保中心.rybq8
  is '入院病情8';
comment on column 临时表_病案首页中医_医保中心.rybq9
  is '入院病情9';
comment on column 临时表_病案首页中医_医保中心.rybq10
  is '入院病情10';
comment on column 临时表_病案首页中医_医保中心.rybq11
  is '入院病情11';
comment on column 临时表_病案首页中医_医保中心.rybq12
  is '入院病情12';
comment on column 临时表_病案首页中医_医保中心.rybq13
  is '入院病情13';
comment on column 临时表_病案首页中医_医保中心.rybq14
  is '入院病情14';
comment on column 临时表_病案首页中医_医保中心.rybq15
  is '入院病情15';
comment on column 临时表_病案首页中医_医保中心.wbyy
  is '损伤、中毒的外部原因名称';
comment on column 临时表_病案首页中医_医保中心.jbbm1_s
  is '损伤、中毒的外部原因';
comment on column 临时表_病案首页中医_医保中心.blzd
  is '病理诊断名称';
comment on column 临时表_病案首页中医_医保中心.jbbm2_s
  is '病理诊断';
comment on column 临时表_病案首页中医_医保中心.blh
  is '病理号';
comment on column 临时表_病案首页中医_医保中心.ywgm
  is '药物过敏';
comment on column 临时表_病案首页中医_医保中心.gmyw
  is '过敏药物';
comment on column 临时表_病案首页中医_医保中心.sj
  is '死亡患者尸检';
comment on column 临时表_病案首页中医_医保中心.xx
  is '血型';
comment on column 临时表_病案首页中医_医保中心.rh
  is 'RH';
comment on column 临时表_病案首页中医_医保中心.qjcs
  is '抢救次数';
comment on column 临时表_病案首页中医_医保中心.cgcs
  is '成功次数';
comment on column 临时表_病案首页中医_医保中心.sxfy
  is '输血反应';
comment on column 临时表_病案首页中医_医保中心.rcmdsc
  is '妊娠梅毒筛查';
comment on column 临时表_病案首页中医_医保中心.xsrjbsc
  is '新生儿疾病筛查';
comment on column 临时表_病案首页中医_医保中心.chcx
  is '产后出血';
comment on column 临时表_病案首页中医_医保中心.kzr
  is '科主任';
comment on column 临时表_病案首页中医_医保中心.zrys
  is '主任（副主任）医师';
comment on column 临时表_病案首页中医_医保中心.zzys
  is '主治医师';
comment on column 临时表_病案首页中医_医保中心.zyys
  is '住院医师';
comment on column 临时表_病案首页中医_医保中心.zrhs
  is '责任护士';
comment on column 临时表_病案首页中医_医保中心.jxys
  is '进修医生';
comment on column 临时表_病案首页中医_医保中心.sxys
  is '实习医师';
comment on column 临时表_病案首页中医_医保中心.bmy
  is '编码员';
comment on column 临时表_病案首页中医_医保中心.bazl
  is '病案质量';
comment on column 临时表_病案首页中医_医保中心.zkys
  is '质控医师';
comment on column 临时表_病案首页中医_医保中心.zkhs
  is '质控护士';
comment on column 临时表_病案首页中医_医保中心.zkrq
  is '质控日期';
comment on column 临时表_病案首页中医_医保中心.ssbm1_s
  is '手术及操作编码';
comment on column 临时表_病案首页中医_医保中心.ssbm2_s
  is '手术及操作编码(2)';
comment on column 临时表_病案首页中医_医保中心.ssbm3_s
  is '手术及操作编码(3)';
comment on column 临时表_病案首页中医_医保中心.ssbm4_s
  is '手术及操作编码(4)';
comment on column 临时表_病案首页中医_医保中心.ssbm5_s
  is '手术及操作编码(5)';
comment on column 临时表_病案首页中医_医保中心.ssbm6_s
  is '手术及操作编码(6)';
comment on column 临时表_病案首页中医_医保中心.ssbm7_s
  is '手术及操作编码(7)';
comment on column 临时表_病案首页中医_医保中心.ssjczrq1
  is '手术及操作日期';
comment on column 临时表_病案首页中医_医保中心.ssjczrq2
  is '手术及操作日期(2)';
comment on column 临时表_病案首页中医_医保中心.ssjczrq3
  is '手术及操作日期(3)';
comment on column 临时表_病案首页中医_医保中心.ssjczrq4
  is '手术及操作日期(4)';
comment on column 临时表_病案首页中医_医保中心.ssjczrq5
  is '手术及操作日期(5)';
comment on column 临时表_病案首页中医_医保中心.ssjczrq6
  is '手术及操作日期(6)';
comment on column 临时表_病案首页中医_医保中心.ssjczrq7
  is '手术及操作日期(7)';
comment on column 临时表_病案首页中医_医保中心.ssjb1
  is '手术级别';
comment on column 临时表_病案首页中医_医保中心.ssjb2
  is '手术级别(2)';
comment on column 临时表_病案首页中医_医保中心.ssjb3
  is '手术级别(3)';
comment on column 临时表_病案首页中医_医保中心.ssjb4
  is '手术级别(4)';
comment on column 临时表_病案首页中医_医保中心.ssjb5
  is '手术级别(5)';
comment on column 临时表_病案首页中医_医保中心.ssjb6
  is '手术级别(6)';
comment on column 临时表_病案首页中医_医保中心.ssjb7
  is '手术级别(7)';
comment on column 临时表_病案首页中医_医保中心.ssjczmc1
  is '手术及操作名称';
comment on column 临时表_病案首页中医_医保中心.ssjczmc2
  is '手术及操作名称(2)';
comment on column 临时表_病案首页中医_医保中心.ssjczmc3
  is '手术及操作名称(3)';
comment on column 临时表_病案首页中医_医保中心.ssjczmc4
  is '手术及操作名称(4)';
comment on column 临时表_病案首页中医_医保中心.ssjczmc5
  is '手术及操作名称(5)';
comment on column 临时表_病案首页中医_医保中心.ssjczmc6
  is '手术及操作名称(6)';
comment on column 临时表_病案首页中医_医保中心.ssjczmc7
  is '手术及操作名称(7)';
comment on column 临时表_病案首页中医_医保中心.sz1
  is '手术者';
comment on column 临时表_病案首页中医_医保中心.sz2
  is '手术者(2)';
comment on column 临时表_病案首页中医_医保中心.sz3
  is '手术者(3)';
comment on column 临时表_病案首页中医_医保中心.sz4
  is '手术者(4)';
comment on column 临时表_病案首页中医_医保中心.sz5
  is '手术者(5)';
comment on column 临时表_病案首页中医_医保中心.sz6
  is '手术者(6)';
comment on column 临时表_病案首页中医_医保中心.sz7
  is '手术者(7)';
comment on column 临时表_病案首页中医_医保中心.yz1
  is 'Ⅰ助签名';
comment on column 临时表_病案首页中医_医保中心.yz2
  is 'Ⅰ助签名(2)';
comment on column 临时表_病案首页中医_医保中心.yz3
  is 'Ⅰ助签名(3)';
comment on column 临时表_病案首页中医_医保中心.yz4
  is 'Ⅰ助签名(4)';
comment on column 临时表_病案首页中医_医保中心.yz5
  is 'Ⅰ助签名(5)';
comment on column 临时表_病案首页中医_医保中心.yz6
  is 'Ⅰ助签名(6)';
comment on column 临时表_病案首页中医_医保中心.yz7
  is 'Ⅰ助签名(7)';
comment on column 临时表_病案首页中医_医保中心.ez1
  is 'Ⅱ助签名';
comment on column 临时表_病案首页中医_医保中心.ez2
  is 'Ⅱ助签名(2)';
comment on column 临时表_病案首页中医_医保中心.ez3
  is 'Ⅱ助签名(3)';
comment on column 临时表_病案首页中医_医保中心.ez4
  is 'Ⅱ助签名(4)';
comment on column 临时表_病案首页中医_医保中心.ez5
  is 'Ⅱ助签名(5)';
comment on column 临时表_病案首页中医_医保中心.ez6
  is 'Ⅱ助签名(6)';
comment on column 临时表_病案首页中医_医保中心.ez7
  is 'Ⅱ助签名(7)';
comment on column 临时表_病案首页中医_医保中心.qkylb1
  is '手术切口愈合等级';
comment on column 临时表_病案首页中医_医保中心.qkylb2
  is '手术切口愈合等级(2)';
comment on column 临时表_病案首页中医_医保中心.qkylb3
  is '手术切口愈合等级(3)';
comment on column 临时表_病案首页中医_医保中心.qkylb4
  is '手术切口愈合等级(4)';
comment on column 临时表_病案首页中医_医保中心.qkylb5
  is '手术切口愈合等级(5)';
comment on column 临时表_病案首页中医_医保中心.qkylb6
  is '手术切口愈合等级(6)';
comment on column 临时表_病案首页中医_医保中心.qkylb7
  is '手术切口愈合等级(7)';
comment on column 临时表_病案首页中医_医保中心.qkyhdj1
  is '切口愈合等级1';
comment on column 临时表_病案首页中医_医保中心.qkyhdj2
  is '切口愈合等级2';
comment on column 临时表_病案首页中医_医保中心.qkyhdj3
  is '切口愈合等级3';
comment on column 临时表_病案首页中医_医保中心.qkyhdj4
  is '切口愈合等级4';
comment on column 临时表_病案首页中医_医保中心.qkyhdj5
  is '切口愈合等级5';
comment on column 临时表_病案首页中医_医保中心.qkyhdj6
  is '切口愈合等级6';
comment on column 临时表_病案首页中医_医保中心.qkyhdj7
  is '切口愈合等级7';
comment on column 临时表_病案首页中医_医保中心.mzfs1
  is '麻醉方式';
comment on column 临时表_病案首页中医_医保中心.mzfs2
  is '麻醉方式(2)';
comment on column 临时表_病案首页中医_医保中心.mzfs3
  is '麻醉方式(3)';
comment on column 临时表_病案首页中医_医保中心.mzfs4
  is '麻醉方式(4)';
comment on column 临时表_病案首页中医_医保中心.mzfs5
  is '麻醉方式(5)';
comment on column 临时表_病案首页中医_医保中心.mzfs6
  is '麻醉方式(6)';
comment on column 临时表_病案首页中医_医保中心.mzfs7
  is '麻醉方式(7)';
comment on column 临时表_病案首页中医_医保中心.mzys1
  is '麻醉医师签名';
comment on column 临时表_病案首页中医_医保中心.mzys2
  is '麻醉医师签名(2)';
comment on column 临时表_病案首页中医_医保中心.mzys3
  is '麻醉医师签名(3)';
comment on column 临时表_病案首页中医_医保中心.mzys4
  is '麻醉医师签名(4)';
comment on column 临时表_病案首页中医_医保中心.mzys5
  is '麻醉医师签名(5)';
comment on column 临时表_病案首页中医_医保中心.mzys6
  is '麻醉医师签名(6)';
comment on column 临时表_病案首页中医_医保中心.mzys7
  is '麻醉医师签名(7)';
comment on column 临时表_病案首页中医_医保中心.lyfs
  is '离院方式';
comment on column 临时表_病案首页中医_医保中心.zzyjh
  is '再住院';
comment on column 临时表_病案首页中医_医保中心.md
  is '目的';
comment on column 临时表_病案首页中医_医保中心.ryq_t
  is '入院前天';
comment on column 临时表_病案首页中医_医保中心.ryq_xs
  is '入院前小时';
comment on column 临时表_病案首页中医_医保中心.ryq_f
  is '入院前分钟';
comment on column 临时表_病案首页中医_医保中心.ryh_t
  is '入院后天';
comment on column 临时表_病案首页中医_医保中心.ryh_xs
  is '入院后小时';
comment on column 临时表_病案首页中医_医保中心.ryh_f
  is '入院后分钟';
comment on column 临时表_病案首页中医_医保中心.zfy
  is '总费用';
comment on column 临时表_病案首页中医_医保中心.zfje
  is '自付金额';
comment on column 临时表_病案首页中医_医保中心.zfije
  is '自费金额';
comment on column 临时表_病案首页中医_医保中心.qtzf
  is '其他支付';
comment on column 临时表_病案首页中医_医保中心.ylfwf
  is '一般医疗服务费';
comment on column 临时表_病案首页中医_医保中心.bzlzf
  is '中医辨证论治费';
comment on column 临时表_病案首页中医_医保中心.zyblzhzf
  is '中医辨证论治会诊费';
comment on column 临时表_病案首页中医_医保中心.zlczf
  is '一般治疗操作费';
comment on column 临时表_病案首页中医_医保中心.hlf
  is '护理费';
comment on column 临时表_病案首页中医_医保中心.qtfy
  is '其他费用';
comment on column 临时表_病案首页中医_医保中心.blzdf
  is '病理诊断费';
comment on column 临时表_病案首页中医_医保中心.syszdf
  is '实验室诊断费';
comment on column 临时表_病案首页中医_医保中心.yxxzdf
  is '影像学诊断费';
comment on column 临时表_病案首页中医_医保中心.lczdxmf
  is '临床诊断项目费';
comment on column 临时表_病案首页中医_医保中心.fsszlxmf
  is '非手术治疗项目费';
comment on column 临时表_病案首页中医_医保中心.zlf
  is '临床物理治疗费';
comment on column 临时表_病案首页中医_医保中心.sszlf
  is '手术治疗费';
comment on column 临时表_病案首页中医_医保中心.mzf
  is '麻醉费';
comment on column 临时表_病案首页中医_医保中心.ssf
  is '手术费';
comment on column 临时表_病案首页中医_医保中心.kff
  is '康复费';
comment on column 临时表_病案首页中医_医保中心.zyl_zyzd
  is '中医诊断费';
comment on column 临时表_病案首页中医_医保中心.zyzl
  is '中医治疗费';
comment on column 临时表_病案首页中医_医保中心.zywz
  is '中医外治';
comment on column 临时表_病案首页中医_医保中心.zygs
  is '中医骨伤';
comment on column 临时表_病案首页中医_医保中心.zcyjf
  is '针刺和灸法';
comment on column 临时表_病案首页中医_医保中心.zytnzl
  is '中医推拿治疗';
comment on column 临时表_病案首页中医_医保中心.zygczl
  is '中医肛肠治疗';
comment on column 临时表_病案首页中医_医保中心.zytszl
  is '中医特殊治疗';
comment on column 临时表_病案首页中医_医保中心.zyqt
  is '中医其他';
comment on column 临时表_病案首页中医_医保中心.zytstpjg
  is '中医特殊调配加工';
comment on column 临时表_病案首页中医_医保中心.bzss
  is '辨证施膳';
comment on column 临时表_病案首页中医_医保中心.xyf
  is '西药费';
comment on column 临时表_病案首页中医_医保中心.kjywf
  is '抗菌药物费用';
comment on column 临时表_病案首页中医_医保中心.zcyf
  is '中成药费';
comment on column 临时表_病案首页中医_医保中心.yzjf_zcy
  is '中药制剂费';
comment on column 临时表_病案首页中医_医保中心.zcyf1
  is '中草药费';
comment on column 临时表_病案首页中医_医保中心.xf
  is '血费';
comment on column 临时表_病案首页中医_医保中心.bdblzpf
  is '白蛋白类制品费';
comment on column 临时表_病案首页中医_医保中心.qdblzpf
  is '球蛋白类制品费';
comment on column 临时表_病案首页中医_医保中心.nxyzlzpf
  is '凝血因子类制品费';
comment on column 临时表_病案首页中医_医保中心.xbyzlzpf
  is '细胞因子类制品费';
comment on column 临时表_病案首页中医_医保中心.cyyyclf
  is '检查用一次性医疗材料费';
comment on column 临时表_病案首页中医_医保中心.yyclf
  is '治疗用一次性医用材料费';
comment on column 临时表_病案首页中医_医保中心.ssycxclf
  is '手术用一次性医疗材料费';
comment on column 临时表_病案首页中医_医保中心.qtf
  is '其他费';
comment on column 临时表_病案首页中医_医保中心.jys
  is '交易数 每份病案结算完成后共与医保中心发生的结算次数';
comment on column 临时表_病案首页中医_医保中心.sblb
  is '申报类别：0.按病种分值结算；1.按病种床日分值结算；9.其他';
comment on column 临时表_病案首页中医_医保中心.bz1
  is '备注1';
comment on column 临时表_病案首页中医_医保中心.bz2
  is '备注2';
comment on column 临时表_病案首页中医_医保中心.bz3
  is '备注3';
comment on column 临时表_病案首页中医_医保中心.bz4
  is '备注4';
comment on column 临时表_病案首页中医_医保中心.bz5
  is '备注5';
