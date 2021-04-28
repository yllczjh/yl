CREATE OR REPLACE Procedure Pr_票据_门诊单据_系统默认(Str_打印类型       In Varchar2,
                                            Str_机构编码       In Varchar2,
                                            Str_医嘱号         In Varchar2,
                                            Str_处方序号       In Varchar2,
                                            Str_小类编码       In Varchar2,
                                            Str_挂号序号       In Varchar2,
                                            Str_病人id         In Varchar2,
                                            Cur_数据集         Out Sys_Refcursor,
                                            Cur_西药数据集     Out Sys_Refcursor,
                                            Cur_中药数据集     Out Sys_Refcursor,
                                            Cur_病历诊断数据集 Out Sys_Refcursor,
                                            Cur_辅助诊疗数据集 Out Sys_Refcursor) As
  Num_诊疗费                 Number(18, 3);
  Str_诊断集合               Varchar2(1000);
  Str_非主诊断               Varchar2(1000);
  Str_处方诊断集合           Varchar2(1000);
  Str_处方非主诊断           Varchar2(1000);
  Str_临时挂号序号           Varchar2(100);
  Dae_挂号时间               Date;
  Str_机构级别               Varchar2(10);
  str_卫材和诊疗是否可共处方 varchar2(10);

Begin

  Select 机构级别
    Into Str_机构级别
    From 基础项目_机构资料
   Where 机构编码 = Str_机构编码;

  Begin
    --查询主诊断
    Select 疾病名称, 挂号时间
      Into Str_诊断集合, Dae_挂号时间
      From 门诊管理_挂号登记
     Where 机构编码 = Str_机构编码
       And 挂号序号 = Str_挂号序号;
  
    Select Wmsys.Wm_Concat(疾病名称)
      Into Str_非主诊断
      From 门诊管理_病历诊断
     Where 机构编码 = Str_机构编码
       And 挂号序号 = Str_挂号序号
       And 是否主诊断 <> 'True';
  
    Str_诊断集合 := Str_诊断集合 || ',' || Str_非主诊断;
  
  Exception
    When Others Then
      Str_诊断集合 := '';
  End;

  If Str_打印类型 = '门诊病历' Then
    Open Cur_数据集 For
      Select a.门诊病历号,
             主诉,
             现病史,
             既往史,
             过敏史,
             体温,
             呼吸,
             脉搏,
             (收缩血压 || '/' || 舒张血压) as 血压,
             心率,
             (Select 机构名称
                From 基础项目_机构资料
               Where 机构编码 = a.机构编码
                 and 删除标志 = '0') As 机构名称,
             b.姓名 As 病人姓名,
             (Select 名称
                From 基础项目_字典明细
               Where 分类编码 = 'GB_0001'
                 And 编码 = b.性别
                 and 删除标志 = '0') As 性别,
             (Select 名称
                From 基础项目_字典明细
               Where 分类编码 = 'GB_0007'
                 And 编码 = b.婚姻状况
                 and 删除标志 = '0') As 婚姻状况,
             Fu_得到_年龄(b.出生日期) As 年龄,
             b.家庭地址,
             (Select 科室名称
                From 基础项目_科室资料
               Where 机构编码 = a.机构编码
                 And 科室编码 = c.就诊科室编码
                 and 删除标志 = '0') As 科室名称,
             Str_诊断集合 As 诊断,
             体查,
             处理意见,
             录入时间 As 就诊时间,
             录入人 As 开方医生,
             (select 家长姓名
                from 基础项目_病人信息_其他
               where 机构编码 = b.机构编码
                 and 病人ID = b.病人ID) as 家长姓名
        From 门诊管理_病历 a, 基础项目_病人信息 b, 门诊管理_挂号登记 c
       Where a.机构编码 = b.机构编码
         And a.病人id = b.病人id
         And a.机构编码 = c.机构编码
         And a.挂号序号 = c.挂号序号
         And a.机构编码 = Str_机构编码
         And a.挂号序号 = Str_挂号序号;
  
    Open Cur_西药数据集 For
      select (项目名称 || 规格 || ' ' || 用量 || 剂量名称 || ' ' || 总量 || 单位名称) as 医嘱项目信息,
             剂量名称,
             频率名称,
             用法名称,
             单位名称,
             '' as 组线,
             医嘱号,
             组号,
             处方序号,
             用量,
             天数
        from 门诊管理_门诊医嘱
       where 挂号序号 = str_挂号序号
         and 机构编码 = str_机构编码
         and 大类编码 = '2'
         and 收费状态 != '已退费'
         and 医嘱状态 = '有效'
       order by 医嘱号 asc, 处方序号 asc, 组号 asc, 排序号 asc;
  
    Open Cur_中药数据集 For
      select 1 from dual;
  
    Open Cur_病历诊断数据集 For
      select 1 from dual;
  
    Open Cur_辅助诊疗数据集 For
      select 1 from dual;
  End If;

  if str_打印类型 = '门诊留观病历' then
    open cur_数据集 for
      select distinct ('    主　诉：' || 主诉 || CHR(10) || '    现病史：' || 现病史 ||
                      CHR(10) || '    既往史：' || 既往史 || CHR(10) ||
                      '    过敏史：' || 过敏史 || CHR(10) || '    体格检查：' ||
                      ('T:' || 体温 || '℃ R:' || 呼吸 || '次/分 P:' || 脉搏 ||
                      '次/分 BP:' || 收缩血压 || '/' || 舒张血压) || 'mmHg' ||
                      CHR(10) || 体查 || CHR(10) || '    辅助检查结果：' || '') as 病史情况,
                      a.门诊病历号,
                      b. 姓名 as 病人姓名,
                      (select 名称
                         from 基础项目_字典明细
                        where 分类编码 = 'GB_0001'
                          and 编码 = b.性别
                          and 删除标志 = '0') as 性别,
                      FU_得到_年龄(b.出生日期) as 年龄,
                      b.家庭地址,
                      t.家长姓名,
                      b.手机号码,
                      t.职业,
                      (case b.婚姻状况
                        when '1' then
                         '未婚'
                        when '2' then
                         '已婚'
                        when '3' then
                         '丧偶'
                        when '4' then
                         '离婚'
                        else
                         '位置'
                      end) as 婚姻状况,
                      (select 科室名称
                         from 基础项目_科室资料
                        where 机构编码 = a.机构编码
                          and 科室编码 = c.就诊科室编码
                          and 删除标志 = '0') as 科室名称,
                      fun_门诊日志_病人病历诊断汇总(c.挂号序号, c.疾病名称) as 诊断,
                      ('   ' || 体查) as 体查,
                      处理意见,
                      录入时间 as 就诊时间,
                      录入人 as 开方医生,
                      就诊模式
        from 门诊管理_病历 a, 门诊管理_挂号登记 c, 基础项目_病人信息 b
        left join 基础项目_病人信息_其他 t
          on b.机构编码 = t.机构编码
         and b.病人ID = t.病人ID
       where a.机构编码 = b.机构编码
         and a.病人ID = b.病人ID
         and a.机构编码 = c.机构编码
         and a.挂号序号 = c.挂号序号
         and a.机构编码 = str_机构编码
         and a.挂号序号 = str_挂号序号;
  
    --所有的医嘱情况
    open cur_西药数据集 for
      select (rownum || ')' || 项目名称) as 项目名称,
             (rownum || ')' || 医嘱内容) as 医嘱内容,
             (case
               when 规格 is null then
                ''
               else
                ('(' || 规格 || ')')
             end) as 规格,
             总量,
             剂量名称,
             频率名称,
             用法名称,
             单位名称,
             '' as 组线,
             医嘱号,
             组号,
             处方序号,
             用量,
             天数
        from 门诊管理_门诊医嘱
       where 挂号序号 = str_挂号序号
         and 机构编码 = str_机构编码
         and 大类编码 = '2'
         and 收费状态 != '已退费'
         and 医嘱状态 = '有效'
       order by 医嘱号 asc, 处方序号 asc, 组号 asc, 排序号 asc;
  
    open cur_中药数据集 for
      select 1 from dual;
  
    --医生的处理措施
    open cur_病历诊断数据集 for
      select *
        from 门诊管理_留观观察处理记录
       where 挂号序号 = str_挂号序号
         and 机构编码 = str_机构编码
         and 记录类型 = '处理措施';
    --护士病情观察
    open cur_辅助诊疗数据集 for
      select *
        from 门诊管理_留观观察处理记录
       where 挂号序号 = str_挂号序号
         and 机构编码 = str_机构编码
         and 记录类型 = '病情观察';
  end if;

  if str_打印类型 = '处方单' then
  
    Begin
      Select 值
        Into str_卫材和诊疗是否可共处方
        From 基础项目_机构参数列表
       Where 参数编码 = '910643'
         And 机构编码 = Str_机构编码
         and 删除标志 = '0';
    Exception
      When Others Then
        str_卫材和诊疗是否可共处方 := '否';
    End;
  
    if str_小类编码 = '3' or  str_小类编码 = '12' then
      open cur_数据集 for
        select (select 机构名称
                  from 基础项目_机构资料
                 where 机构编码 = a.机构编码
                   and 删除标志 = '0') as 机构名称,
               a.门诊病历号,
               a.医嘱号,
               (select 科室名称
                  from 基础项目_科室资料
                 where 机构编码 = a.机构编码
                   and 科室编码 = a.病人科室编码
                   and 删除标志 = '0') as 科室名称,
               (select 人员姓名
                  from 基础项目_人员资料
                 where 机构编码 = a.机构编码
                   and 人员编码 = a.开方医生编码
                   and 删除标志 = '0') as 开方医生,
               t.姓名 as 病人姓名,
               FU_得到_年龄(t.出生日期) as 病人年龄,
               (case
                 when t.性别 = '1' then
                  '男'
                 when t.性别 = '2' then
                  '女'
                 else
                  '未知'
               end) as 病人性别,
               (select 名称
                  from 基础项目_字典明细
                 where 分类编码 = 'GB_009000'
                   and 编码 = c.病人类型编码) as 病人类型,
               (select 医保卡号
                  from 基础项目_病人信息_其他
                 where 机构编码 = a.机构编码
                   and 病人ID = a.病人ID) as 医保卡号,
               Str_诊断集合 as 诊断,
               --t.家庭地址 as 地址,
               (case
                 when nvl(t.家庭地址, '不详') = '不详' then
                  nvl(t.工作单位, '不详')
                 else
                  t.家庭地址
               end) as 地址,
               (b.项目名称 || ' ' || (b.用法名称) || '  ' || b.总量 || b.单位名称) as 项目信息,
               b.项目名称,
               a.总量,
               a.单位名称,
               (a.剂数 || '付') as 剂数,
               b.用法名称,
               a.频率名称,
               a.组号,
               a.医生嘱托 as 加水量,
               a.处方序号,
               a.录入时间 as 处方时间,
               '' as 组线,
               b.煎法名称,
               b.总金额　as　项目总金额,
               a.rowid as 唯一号,
               (case
                 when FU_得到_年龄_精确年(t.出生日期) <= 12 then
                  '儿童'
                 --when c.挂号类型编码 = '000038' then
                 -- '急诊'
                 else
                  '普通'
               end) as 处方显示类型,
               (case
                 when a.病人科室编码 in ('0201') then
                  '备注:1,请遵医嘱服药;2,请在窗口点清药品;3,处方当日有效;4,发出药品不予退换'
                 else
                  '备注:1,请遵医嘱服药;2,请在窗口点清药品;3,发出药品不予退换'
               end) as 处方说明,
               (select 身份证号
                  from 基础项目_病人信息
                 where 机构编码 = a.机构编码
                   and 病人ID = a.病人ID) as 身份证号
          from 门诊管理_门诊医嘱     a,
               门诊管理_门诊医嘱项目 b,
               基础项目_病人信息     t,
               门诊管理_挂号登记     c
         where a.机构编码 = str_机构编码
           and a.医嘱号 = str_医嘱号
           and a.处方序号 = str_处方序号
           and a.机构编码 = b.机构编码
           and a.医嘱号 = b.医嘱号
           and a.项目id = b.项目id
           and a.机构编码 = t.机构编码
           and a.病人ID = t.病人ID
           and a.机构编码 = c.机构编码
           and a.挂号序号 = c.挂号序号
           and a.门诊病历号 = c.门诊病历号
           and a.大类编码 = '2'
           and (a.小类编码 = '3' or a.小类编码 = '12')
         order by b.序号 asc;
    elsif str_小类编码 = '7' then
      open cur_数据集 for
        select a.门诊病历号,
               (select 机构名称
                  from 基础项目_机构资料
                 where 机构编码 = a.机构编码
                   and 删除标志 = '0') as 机构名称,
               a.医嘱号,
               (select 科室名称
                  from 基础项目_科室资料
                 where 机构编码 = a.机构编码
                   and 科室编码 = a.病人科室编码
                   and 删除标志 = '0') as 科室名称,
               (select 姓名
                  from 基础项目_病人信息
                 where 机构编码 = a.机构编码
                   and 病人ID = a.病人ID) as 病人姓名,
               (to_char(录入时间, 'yyyy') || '年' || to_char(录入时间, 'MM') || '月' ||
               to_char(录入时间, 'dd') || '日' || to_char(录入时间, 'hh24') || '时' ||
               to_char(录入时间, 'mi') || '分') as 打印时间,
               (select fu_得到_年龄(出生日期)
                  from 基础项目_病人信息
                 where 机构编码 = a.机构编码
                   and 病人ID = a.病人ID) as 病人年龄,
               (select 名称
                  from 基础项目_字典明细
                 where 分类编码 = 'GB_009000'
                   and 删除标志 = '0'
                   and 编码 = c.病人类型编码) as 病人类型,
               (select 医保卡号
                  from 基础项目_病人信息_其他
                 where 机构编码 = a.机构编码
                   and 病人ID = a.病人ID) as 医保卡号,
               Str_诊断集合 as 诊断,
               (select (case
                         when nvl(家庭地址, '不详') = '不详' then
                          nvl(工作单位, '不详')
                         else
                          家庭地址
                       end) as 家庭地址
                  from 基础项目_病人信息
                 where 机构编码 = a.机构编码
                   and 病人ID = a.病人ID) as 地址,
               (select 手机号码
                  from 基础项目_病人信息
                 where 机构编码 = a.机构编码
                   and 病人ID = a.病人ID) as 手机号码,
               a.项目名称,
               a.医嘱内容,
               a.规格,
               (a.规格 || '(取' || to_char(a.总量, 'FM9999999990.0999') ||
               a.单位名称 || ')') as 规格及总量,
               to_char(a.用量, 'FM9999999990.0999') as 用量,
               a.频率名称 as 频率,
               replace(a.用法名称, '皮试', '皮试(   )') as 用法名称,
               a.操作员姓名,
               a.单价,
               a.总量,
               a.单位名称,
               a.总金额,
               (select 人员姓名
                  from 基础项目_人员资料
                 where 机构编码 = a.机构编码
                   and 人员编码 = a.开方医生编码
                   and 删除标志 = '0') as 开发医生姓名,
               (select 名称
                  from 基础项目_字典明细
                 where 分类编码 = 'GB_0001'
                   and 删除标志 = '0'
                   and 编码 = (select 性别
                               from 基础项目_病人信息
                              where 机构编码 = a.机构编码
                                and 病人ID = a.病人ID)) as 病人性别,
               to_char(a.总量, 'FM9999999990.0999') as 总数量,
               '' as 组线,
               (a.处方序号 || ':') as 处方序号,
               a.小类编码,
               a.医生嘱托,
               组号,
               (select sum(总金额)
                  from 门诊管理_门诊医嘱项目
                 where 机构编码 = a.机构编码　 and　医嘱号 = a.医嘱号
                   and 项目ID = a.项目ID
                   And 生成时间 >= a.录入时间 - 3) 　as　总费用,
               a.rowid as 唯一号,
               天数,
               (case
                 when FU_得到_年龄_精确年(t.出生日期) <= 12 then
                  '儿童'
                 when c.挂号类型编码 = '000038' then
                  '急诊'
                 else
                  '普通'
               end) as 处方显示类型,
               (case
                 when a.病人科室编码 in ('0201') then
                  '备注:1,请遵医嘱服药;2,请在窗口点清药品;3,处方当日有效;4,发出药品不予退换'
                 else
                  '备注:1,请遵医嘱服药;2,请在窗口点清药品;3,发出药品不予退换'
               end) as 处方说明,
               (select 身份证号
                  from 基础项目_病人信息
                 where 机构编码 = a.机构编码
                   and 病人ID = a.病人ID) as 身份证号
          from 门诊管理_门诊医嘱 a,
               门诊管理_挂号登记 c,
               基础项目_病人信息 t
         where a.机构编码 = str_机构编码
           and a.机构编码 = t.机构编码
           and a.病人id = t.病人id
           and a.医嘱号 = str_医嘱号
           and a.机构编码 = c.机构编码
           and a.挂号序号 = c.挂号序号
           and a.门诊病历号 = c.门诊病历号
           and a.收费状态 not in ('已退费', '已退药', '发送已收费')
              --and a.处方序号 = str_处方序号
           and (a.大类编码 = '1' or
               (a.大类编码 = '2' and 小类编码 = '4' and str_卫材和诊疗是否可共处方 = '是'))
         order by 处方序号 asc, 组号 asc, a.排序号 asc;
    elsif str_小类编码 = '8' then
      open cur_数据集 for
        select a.门诊病历号,
               (select 机构名称
                  from 基础项目_机构资料
                 where 机构编码 = a.机构编码
                   and 删除标志 = '0') as 机构名称,
               a.医嘱号,
               (select 科室名称
                  from 基础项目_科室资料
                 where 机构编码 = a.机构编码
                   and 科室编码 = a.病人科室编码
                   and 删除标志 = '0') as 科室名称,
               (select 姓名
                  from 基础项目_病人信息
                 where 机构编码 = a.机构编码
                   and 病人ID = a.病人ID) as 病人姓名,
               (to_char(录入时间, 'yyyy') || '年' || to_char(录入时间, 'MM') || '月' ||
               to_char(录入时间, 'dd') || '日' || to_char(录入时间, 'hh24') || '时' ||
               to_char(录入时间, 'mi') || '分') as 打印时间,
               (select fu_得到_年龄(出生日期)
                  from 基础项目_病人信息
                 where 机构编码 = a.机构编码
                   and 病人ID = a.病人ID) as 病人年龄,
               (select 名称
                  from 基础项目_字典明细
                 where 分类编码 = 'GB_009000'
                   and 删除标志 = '0'
                   and 编码 = c.病人类型编码) as 病人类型,
               (select 医保卡号
                  from 基础项目_病人信息_其他
                 where 机构编码 = a.机构编码
                   and 病人ID = a.病人ID) as 医保卡号,
               Str_诊断集合 as 诊断,
               (select (case
                         when nvl(家庭地址, '不详') = '不详' then
                          nvl(工作单位, '不详')
                         else
                          家庭地址
                       end) as 家庭地址
                  from 基础项目_病人信息
                 where 机构编码 = a.机构编码
                   and 病人ID = a.病人ID) as 地址,
               (select 手机号码
                  from 基础项目_病人信息
                 where 机构编码 = a.机构编码
                   and 病人ID = a.病人ID) as 手机号码,
               a.项目名称,
               a.医嘱内容,
               a.规格,
               (a.规格 || '(取' || to_char(a.总量, 'FM9999999990.0999') ||
               a.单位名称 || ')') as 规格及总量,
               to_char(a.用量, 'FM9999999990.0999') as 用量,
               a.频率名称 as 频率,
               a.用法名称,
               a.操作员姓名,
               a.单价,
               a.总量,
               a.单位名称,
               a.总金额,
               (select 人员姓名
                  from 基础项目_人员资料
                 where 机构编码 = a.机构编码
                   and 人员编码 = a.开方医生编码
                   and 删除标志 = '0') as 开发医生姓名,
               (select 名称
                  from 基础项目_字典明细
                 where 分类编码 = 'GB_0001'
                   and 删除标志 = '0'
                   and 编码 = (select 性别
                               from 基础项目_病人信息
                              where 机构编码 = a.机构编码
                                and 病人ID = a.病人ID)) as 病人性别,
               to_char(a.总量, 'FM9999999990.0999') as 总数量,
               '' as 组线,
               (a.处方序号 || ':') as 处方序号,
               a.小类编码,
               a.医生嘱托,
               组号,
               (select sum(总金额)
                  from 门诊管理_门诊医嘱项目
                 where 机构编码 = a.机构编码　 and　医嘱号 = a.医嘱号
                   and 项目ID = a.项目ID
                   And 生成时间 >= a.录入时间 - 3) 　as　总费用,
               a.rowid as 唯一号,
               天数,
               (case
                 when FU_得到_年龄_精确年(t.出生日期) <= 12 then
                  '儿童'
                 when c.挂号类型编码 = '000038' then
                  '急诊'
                 else
                  '普通'
               end) as 处方显示类型,
               (case
                 when a.病人科室编码 in ('0201') then
                  '备注:1,请遵医嘱服药;2,请在窗口点清药品;3,处方当日有效;4,发出药品不予退换'
                 else
                  '备注:1,请遵医嘱服药;2,请在窗口点清药品;3,发出药品不予退换'
               end) as 处方说明,
               (select 身份证号
                  from 基础项目_病人信息
                 where 机构编码 = a.机构编码
                   and 病人ID = a.病人ID) as 身份证号
          from 门诊管理_门诊医嘱 a,
               门诊管理_挂号登记 c,
               基础项目_病人信息 t
         where a.机构编码 = str_机构编码
           and a.机构编码 = t.机构编码
           and a.病人id = t.病人id
           and a.医嘱号 = str_医嘱号
           and a.机构编码 = c.机构编码
           and a.挂号序号 = c.挂号序号
           and a.门诊病历号 = c.门诊病历号
           and a.收费状态 not in ('已退费', '已退药', '发送已收费')
           and a.处方序号 = str_处方序号
           and (a.大类编码 = '1' or
               (a.大类编码 = '2' and 小类编码 = '4' and str_卫材和诊疗是否可共处方 = '是'))
         order by 处方序号 asc, 组号 asc, a.排序号 asc;
    else
      open cur_数据集 for
        select a.门诊病历号,
               (select 机构名称
                  from 基础项目_机构资料
                 where 机构编码 = a.机构编码
                   and 删除标志 = '0') as 机构名称,
               a.医嘱号,
               (select 科室名称
                  from 基础项目_科室资料
                 where 机构编码 = a.机构编码
                   and 科室编码 = a.病人科室编码
                   and 删除标志 = '0') as 科室名称,
               (select 姓名
                  from 基础项目_病人信息
                 where 机构编码 = a.机构编码
                   and 病人ID = a.病人ID) as 病人姓名,
               (to_char(录入时间, 'yyyy') || '年' || to_char(录入时间, 'MM') || '月' ||
               to_char(录入时间, 'dd') || '日' || to_char(录入时间, 'hh24') || '时' ||
               to_char(录入时间, 'mi') || '分') as 打印时间,
               (select fu_得到_年龄(出生日期)
                  from 基础项目_病人信息
                 where 机构编码 = a.机构编码
                   and 病人ID = a.病人ID) as 病人年龄,
               (select 名称
                  from 基础项目_字典明细
                 where 分类编码 = 'GB_009000'
                   and 删除标志 = '0'
                   and 编码 = c.病人类型编码) as 病人类型,
               (select 医保卡号
                  from 基础项目_病人信息_其他
                 where 机构编码 = a.机构编码
                   and 病人ID = a.病人ID) as 医保卡号,
               Str_诊断集合 as 诊断,
               (select (case
                         when nvl(家庭地址, '不详') = '不详' then
                          nvl(工作单位, '不详')
                         else
                          家庭地址
                       end) as 家庭地址
                  from 基础项目_病人信息
                 where 机构编码 = a.机构编码
                   and 病人ID = a.病人ID) as 地址,
               (select 手机号码
                  from 基础项目_病人信息
                 where 机构编码 = a.机构编码
                   and 病人ID = a.病人ID) as 手机号码,
               a.项目名称,
               a.医嘱内容,
               a.规格,
               (a.规格 || '(取' || to_char(a.总量, 'FM9999999990.0999') ||
               a.单位名称 || ')') as 规格及总量,
               (to_char(a.用量, 'FM9999999990.0999') || a.剂量名称) as 用量,
               a.频率名称 as 频率,
               replace(a.用法名称, '皮试', '皮试(      )') as 用法名称,
               a.操作员姓名,
               a.单价,
               a.总量,
               a.单位名称,
               a.总金额,
               (select 人员姓名
                  from 基础项目_人员资料
                 where 机构编码 = a.机构编码
                   and 人员编码 = a.开方医生编码
                   and 删除标志 = '0') as 开发医生姓名,
               (select 名称
                  from 基础项目_字典明细
                 where 分类编码 = 'GB_0001'
                   and 删除标志 = '0'
                   and 编码 = (select 性别
                               from 基础项目_病人信息
                              where 机构编码 = a.机构编码
                                and 病人ID = a.病人ID)) as 病人性别,
               to_char(a.总量, 'FM9999999990.0999') as 总数量,
               '' as 组线,
               (a.处方序号 || ':') as 处方序号,
               a.小类编码,
               a.医生嘱托,
               组号,
               (select sum(总金额)
                  from 门诊管理_门诊医嘱项目
                 where 机构编码 = a.机构编码　 and　医嘱号 = a.医嘱号
                   and 项目ID = a.项目ID
                   And 生成时间 >= a.录入时间 - 3) 　as　总费用,
               a.rowid as 唯一号,
               天数,
               (case
                 when FU_得到_年龄_精确年(t.出生日期) <= 12 then
                  '儿童'
                 when c.挂号类型编码 = '000038' then
                  '急诊'
                 else
                  '普通'
               end) as 处方显示类型,
               (case
                 when a.病人科室编码 in ('0201') then
                  '备注:1,请遵医嘱服药;2,请在窗口点清药品;3,处方当日有效;4,发出药品不予退换'
                 else
                  '备注:1,请遵医嘱服药;2,请在窗口点清药品;3,发出药品不予退换'
               end) as 处方说明,
               (select 身份证号
                  from 基础项目_病人信息
                 where 机构编码 = a.机构编码
                   and 病人ID = a.病人ID) as 身份证号,
               (case
                 when a.病人科室编码 in ('217A', '0202', '0214') and a.用法名称 = '口服' then
                  'A' || a.组号
                 else
                  'B' || a.序号
               end) as 特殊组号
          from 门诊管理_门诊医嘱 a,
               门诊管理_挂号登记 c,
               基础项目_病人信息 t
         where a.机构编码 = str_机构编码
           and a.机构编码 = t.机构编码
           and a.病人id = t.病人id
           and a.医嘱号 = str_医嘱号
           and a.处方序号 = str_处方序号
           and a.机构编码 = c.机构编码
           and a.挂号序号 = c.挂号序号
           and a.门诊病历号 = c.门诊病历号
           and a.收费状态 not in ('已退费', '已退药')
           and a.大类编码 = '2'
        --and a.小类编码 in ('1', '2','4')
         order by 医嘱号 asc, a.排序号 asc;
    end if;
    open cur_西药数据集 for
      select 1 from dual where 1 = 0;
  
    open cur_中药数据集 for
      select 1 from dual where 1 = 0;
  
    open cur_病历诊断数据集 for
      select 1 from dual where 1 = 0;
  
    open cur_辅助诊疗数据集 for
      select 1 from dual where 1 = 0;
  end if;

  If Str_打印类型 = '医嘱单' Then
    Open Cur_数据集 For
      Select a.门诊病历号,
             (select 机构名称
                from 基础项目_机构资料
               where 机构编码 = a.机构编码
                 and 删除标志 = '0') as 机构名称,
             a.医嘱号,
             (select 科室名称
                from 基础项目_科室资料
               where 机构编码 = a.机构编码
                 and 科室编码 = a.病人科室编码
                 and 删除标志 = '0') as 科室名称,
             (select 姓名
                from 基础项目_病人信息
               where 机构编码 = a.机构编码
                 and 病人ID = a.病人ID) as 病人姓名,
             (to_char(录入时间, 'yyyy') || '年' || to_char(录入时间, 'MM') || '月' ||
             to_char(录入时间, 'dd') || '日' || to_char(录入时间, 'hh24') || '时' ||
             to_char(录入时间, 'mi') || '分') as 打印时间,
             (select fu_得到_年龄(出生日期)
                from 基础项目_病人信息
               where 机构编码 = a.机构编码
                 and 病人ID = a.病人ID) as 病人年龄,
             (select 名称
                from 基础项目_字典明细
               where 分类编码 = 'GB_009000'
                 and 删除标志 = '0'
                 and 编码 = (select 病人类型编码
                             from 门诊管理_挂号登记
                            where 机构编码 = a.机构编码
                              and 挂号序号 = a.挂号序号
                              and 门诊病历号 = a.门诊病历号
                              and rownum = 1)) as 病人类型,
             (select 医保卡号
                from 基础项目_病人信息_其他
               where 机构编码 = a.机构编码
                 and 病人ID = a.病人ID) as 医保卡号,
             Str_诊断集合 as 诊断,
             (select 家庭地址
                from 基础项目_病人信息
               where 机构编码 = a.机构编码
                 and 病人ID = a.病人ID) as 地址,
             (select 手机号码
                from 基础项目_病人信息
               where 机构编码 = a.机构编码
                 and 病人ID = a.病人ID) as 手机号码,
             a.项目名称,
             a.医嘱内容,
             a.规格,
             (a.规格 || '(取' || to_char(a.总量, 'FM9999999990.0999') || a.单位名称 || ')') as 规格及总量,
             to_char(a.用量, 'FM9999999990.0999') as 用量,
             a.频率名称 as 频率,
             a.用法名称,
             a.操作员姓名,
             a.单价,
             a.总量,
             a.单位名称,
             a.总金额,
             (select 人员姓名
                from 基础项目_人员资料
               where 机构编码 = a.机构编码
                 and 人员编码 = a.开方医生编码
                 and 删除标志 = '0') as 开发医生姓名,
             (select 名称
                from 基础项目_字典明细
               where 分类编码 = 'GB_0001'
                 and 删除标志 = '0'
                 and 编码 = (select 性别
                             from 基础项目_病人信息
                            where 机构编码 = a.机构编码
                              and 病人ID = a.病人ID)) as 病人性别,
             to_char(a.总量, 'FM9999999990.0999') as 总数量,
             '' as 组线,
             (a.处方序号 || ':') as 处方序号,
             a.小类编码,
             a.医生嘱托,
             组号,
             (select sum(总金额)
                from 门诊管理_门诊医嘱项目
               where 机构编码 = a.机构编码　 and　医嘱号 = a.医嘱号
                 and 项目ID = a.项目ID
                 And 生成时间 >= a.录入时间 - 3) 　as　总费用,
             rowid as 唯一号,
             天数
        From 门诊管理_门诊医嘱 a
       Where a.机构编码 = Str_机构编码
         And a.医嘱号 = Str_医嘱号
         and a.收费状态 not in ('已退费', '已退药')
       order by 处方序号 asc, 组号 asc, a.排序号 asc;
  
    Open Cur_西药数据集 For
      Select 1 From Dual Where 1 = 0;
  
    Open Cur_中药数据集 For
      Select 1 From Dual Where 1 = 0;
  
    Open Cur_病历诊断数据集 For
      Select 1 From Dual Where 1 = 0;
  
    Open Cur_辅助诊疗数据集 For
      Select 1 From Dual Where 1 = 0;
  End If;

  If Str_打印类型 = '注射单' Then
    Open Cur_数据集 For
      Select (Select 机构名称
                From 基础项目_机构资料
               Where 机构编码 = a.机构编码
                 and 删除标志 = '0') As 机构名称,
             Str_诊断集合 As 诊断集合,
             a.门诊病历号,
             (Select 科室名称
                From 基础项目_科室资料
               Where 机构编码 = a.机构编码
                 And 科室编码 = a.病人科室编码
                 and 删除标志 = '0') As 科室名称,
             (Select 姓名
                From 基础项目_病人信息
               Where 机构编码 = a.机构编码
                 And 病人id = a.病人id) As 病人姓名,
             (To_Char(录入时间, 'yyyy') || '年' || To_Char(录入时间, 'MM') || '月' ||
             To_Char(录入时间, 'dd') || '日' || To_Char(录入时间, 'hh24') || '时' ||
             To_Char(录入时间, 'mi') || '分') As 打印时间,
             (Select Fu_得到_年龄(出生日期)
                From 基础项目_病人信息
               Where 机构编码 = a.机构编码
                 And 病人id = a.病人id) As 病人年龄,
             (Select 名称
                From 基础项目_字典明细
               Where 分类编码 = 'GB_0001'
                 and 删除标志 = '0'
                 And 编码 = (Select 性别
                             From 基础项目_病人信息
                            Where 机构编码 = a.机构编码
                              And 病人id = a.病人id)) As 病人性别,
             (Select 名称
                From 基础项目_字典明细
               Where 分类编码 = 'GB_009000'
                 and 删除标志 = '0'
                 And 编码 = (Select 病人类型编码
                             From 门诊管理_挂号登记
                            Where 机构编码 = a.机构编码
                              And 挂号序号 = a.挂号序号
                              And 门诊病历号 = a.门诊病历号)) As 病人类型,
             a.处方序号,
             (a.项目名称 || (Case
               When 规格 Is Null Then
                ''
               Else
                ('(' || a.规格 || ')')
             End)) As 项目名称及规格,
             a.医嘱内容,
             (To_Char(a.用量, 'FM9999999990.0999') || a.剂量名称 || ' X ' || a.总量) As 医嘱信息,
             (a.天数 || '天') As 天数,
             (a.总量 || a.单位名称) As 总量信息,
             a.用法名称,
             a.用法名称 As 医嘱用法名称,
             (To_Char(a.用量, 'FM9999999990.0999') || a.剂量名称) As 用量信息,
             nvl((Select 次数
                   From 基础项目_频率字典
                  Where 机构编码 = a.机构编码
                    And 有效状态 = '有效'
                    And 频率编码 = a.频率编码),
                 '1') As 次数,
             a.频率名称,
             a.频率名称 As 医嘱频率名称,
             '' As 组线,
             a.组号,
             a.医嘱号,
             a.滴速,
             (Select 人员姓名
                From 基础项目_人员资料
               Where 机构编码 = a.机构编码
                 And 人员编码 = a.开方医生编码
                 and 删除标志 = '0') As 开方医生
        From 门诊管理_门诊医嘱 a
       Where 机构编码 = Str_机构编码
         And 医嘱号 = Str_医嘱号
         And 处方序号 = Str_处方序号
         and a.收费状态 not in ('已退费', '已退药')
         And 大类编码 != '1'
         And 小类编码 != '3'
         And (用法编码 In (Select 用法编码
                         From 基础项目_用法对应打印
                        Where 打印对象编码 = '0000000121'
                          And 机构编码 = Str_机构编码
                          and 删除标志 = '0') Or
             (Nvl(用法编码, '-1') = '-1' And 皮试序号 Like '%-'))
       Order By a.医嘱号 Asc, a.处方序号 Asc, a.组号 Asc, a.排序号 Asc;
    Open Cur_西药数据集 For
      Select 1 From Dual Where 1 = 0;
  
    Open Cur_中药数据集 For
      Select 1 From Dual Where 1 = 0;
  
    Open Cur_病历诊断数据集 For
      Select 1 From Dual Where 1 = 0;
  
    Open Cur_辅助诊疗数据集 For
      Select 1 From Dual Where 1 = 0;
  End If;

  If Str_打印类型 = '雾化单' Then
    Open Cur_数据集 For
      Select (Select 机构名称
                From 基础项目_机构资料
               Where 机构编码 = a.机构编码
                 and 删除标志 = '0') As 机构名称,
             a.门诊病历号,
             (Select 科室名称
                From 基础项目_科室资料
               Where 机构编码 = a.机构编码
                 And 科室编码 = a.病人科室编码
                 and 删除标志 = '0') As 科室名称,
             (Select 姓名
                From 基础项目_病人信息
               Where 机构编码 = a.机构编码
                 And 病人id = a.病人id) As 病人姓名,
             (To_Char(录入时间, 'yyyy') || '年' || To_Char(录入时间, 'MM') || '月' ||
             To_Char(录入时间, 'dd') || '日' || To_Char(录入时间, 'hh24') || '时' ||
             To_Char(录入时间, 'mi') || '分') As 打印时间,
             (Select Fu_得到_年龄(出生日期)
                From 基础项目_病人信息
               Where 机构编码 = a.机构编码
                 And 病人id = a.病人id) As 病人年龄,
             (Select 名称
                From 基础项目_字典明细
               Where 分类编码 = 'GB_0001'
                 and 删除标志 = '0'
                 And 编码 = (Select 性别
                             From 基础项目_病人信息
                            Where 机构编码 = a.机构编码
                              And 病人id = a.病人id)) As 病人性别,
             (Select 名称
                From 基础项目_字典明细
               Where 分类编码 = 'GB_009000'
                 and 删除标志 = '0'
                 And 编码 = (Select 病人类型编码
                             From 门诊管理_挂号登记
                            Where 机构编码 = a.机构编码
                              And 挂号序号 = a.挂号序号
                              And 门诊病历号 = a.门诊病历号)) As 病人类型,
             a.处方序号,
             (a.项目名称 || (Case
               When 规格 Is Null Then
                ''
               Else
                ('(' || a.规格 || ')')
             End)) As 项目名称及规格,
             a.医嘱内容,
             (To_Char(a.用量, 'FM9999999990.0999') || a.剂量名称 || ' X ' || a.总量) As 医嘱信息,
             (a.天数 || '天') As 天数,
             (a.总量 || a.单位名称) As 总量信息,
             a.用法名称,
             (To_Char(a.用量, 'FM9999999990.0999') || a.剂量名称 || ' X ') As 用量信息,
             nvl((Select 次数
                   From 基础项目_频率字典
                  Where 机构编码 = a.机构编码
                    And 有效状态 = '有效'
                    and 删除标志 = '0'
                    And 频率编码 = a.频率编码),
                 '1') As 次数,
             a.频率名称,
             '' As 组线,
             a.组号,
             a.医嘱号,
             a.滴速,
             (Select 人员姓名
                From 基础项目_人员资料
               Where 机构编码 = a.机构编码
                 and 删除标志 = '0'
                 And 人员编码 = a.开方医生编码) As 开方医生
        From 门诊管理_门诊医嘱 a
       Where 机构编码 = Str_机构编码
         And 医嘱号 = Str_医嘱号
         And 处方序号 = Str_处方序号
         and a.收费状态 not in ('已退费', '已退药')
         And 大类编码 != '1'
         And 小类编码 != '3'
         And 用法编码 In (Select 用法编码
                        From 基础项目_用法对应打印
                       Where 打印对象编码 = '5'
                         And 机构编码 = Str_机构编码
                         and 删除标志 = '0')
       Order By a.医嘱号 Asc, a.处方序号 Asc, a.组号 Asc, a.排序号 Asc;
    Open Cur_西药数据集 For
      Select 1 From Dual Where 1 = 0;
  
    Open Cur_中药数据集 For
      Select 1 From Dual Where 1 = 0;
  
    Open Cur_病历诊断数据集 For
      Select 1 From Dual Where 1 = 0;
  
    Open Cur_辅助诊疗数据集 For
      Select 1 From Dual Where 1 = 0;
  End If;

  If Str_打印类型 = '治疗单' Then
    Open Cur_数据集 For
      Select (Select 机构名称
                From 基础项目_机构资料
               Where 机构编码 = a.机构编码
                 and 删除标志 = '0') As 机构名称,
             Str_诊断集合 As 诊断集合,
             a.门诊病历号,
             (Select 科室名称
                From 基础项目_科室资料
               Where 机构编码 = a.机构编码
                 And 科室编码 = a.病人科室编码
                 and 删除标志 = '0') As 科室名称,
             (Select 姓名
                From 基础项目_病人信息
               Where 机构编码 = a.机构编码
                 And 病人id = a.病人id) As 病人姓名,
             (To_Char(录入时间, 'yyyy') || '年' || To_Char(录入时间, 'MM') || '月' ||
             To_Char(录入时间, 'dd') || '日' || To_Char(录入时间, 'hh24') || '时' ||
             To_Char(录入时间, 'mi') || '分') As 打印时间,
             (Select Fu_得到_年龄(出生日期)
                From 基础项目_病人信息
               Where 机构编码 = a.机构编码
                 And 病人id = a.病人id) As 病人年龄,
             (Select 名称
                From 基础项目_字典明细
               Where 分类编码 = 'GB_0001'
                 and 删除标志 = '0'
                 And 编码 = (Select 性别
                             From 基础项目_病人信息
                            Where 机构编码 = a.机构编码
                              And 病人id = a.病人id)) As 病人性别,
             (Select 名称
                From 基础项目_字典明细
               Where 分类编码 = 'GB_009000'
                 and 删除标志 = '0'
                 And 编码 = (Select 病人类型编码
                             From 门诊管理_挂号登记
                            Where 机构编码 = a.机构编码
                              And 挂号序号 = a.挂号序号
                              And 门诊病历号 = a.门诊病历号)) As 病人类型,
             a.处方序号,
             (a.项目名称 || (Case
               When 规格 Is Null Then
                ''
               Else
                ('(' || a.规格 || ')')
             End)) As 项目名称及规格,
             a.医嘱内容,
             (To_Char(a.用量, 'FM9999999990.0999') || a.剂量名称 || ' X ' || a.总量) As 医嘱信息,
             (a.天数 || '天') As 天数,
             (a.总量 || a.单位名称) As 总量信息,
             a.用法名称,
             (To_Char(a.用量, 'FM9999999990.0999') || a.剂量名称) As 用量信息,
             nvl((Select 次数
                   From 基础项目_频率字典
                  Where 机构编码 = a.机构编码
                    And 有效状态 = '有效'
                    and 删除标志 = '0'
                    And 频率编码 = a.频率编码),
                 '1') As 次数,
             a.频率名称,
             '' As 组线,
             a.组号,
             a.医嘱号,
             a.滴速,
             (Select 人员姓名
                From 基础项目_人员资料
               Where 机构编码 = a.机构编码
                 and 删除标志 = '0'
                 And 人员编码 = a.开方医生编码) As 开方医生,
             排序号
        From 门诊管理_门诊医嘱 a
       Where 机构编码 = Str_机构编码
         And 医嘱号 =  Str_医嘱号
            --And 处方序号 = Str_处方序号
         And 大类编码 = '2'
         and a.收费状态 not in ('已退费', '已退药')
         And 小类编码 not in ('3', '4')
         And (用法编码 In (Select 用法编码
                         From 基础项目_用法对应打印
                        Where 打印对象编码 = '4'
                          And 机构编码 = Str_机构编码
                          and 删除标志 = '0') Or (皮试序号 Like '%-'))
       Order By a.医嘱号 Asc, a.处方序号 Asc, a.组号 Asc, a.排序号 Asc;
    Open Cur_西药数据集 For
      Select 1 From Dual Where 1 = 0;
  
    Open Cur_中药数据集 For
      Select 1 From Dual Where 1 = 0;
  
    Open Cur_病历诊断数据集 For
      Select 1 From Dual Where 1 = 0;
  
    Open Cur_辅助诊疗数据集 For
      Select 1 From Dual Where 1 = 0;
  End If;

  If Str_打印类型 = '诊断证明' Then
    Open Cur_数据集 For
      Select Rownum As 序号,
             Fu_取得_机构名称(t.机构编码) As 机构名称,
             b.姓名,
             (Case b.性别
               When '1' Then
                '男'
               When '2' Then
                '女'
               Else
                '未知'
             End) As 性别,
             Fu_得到_年龄(b.出生日期) As 年龄,
             t.门诊病历号,
             t.疾病编码,
             t.疾病名称,
             Nvl((Select 人员姓名
                   From 基础项目_人员资料 r,
                        (Select Nvl(就诊医生编码, 挂号医生编码) As 开方医生编码,
                                机构编码
                           From 门诊管理_挂号登记
                          Where 挂号序号 = Str_挂号序号
                            And 机构编码 = Str_机构编码
                            And 病人id = Str_病人id
                            And Rownum = 1) g
                  Where r.机构编码 = g.机构编码
                    And r.人员编码 = g.开方医生编码),
                 '未知医生') As 开方医生姓名,
             Sysdate As 打印日期,
             Nvl((Select 处理意见
                   From 门诊管理_病历
                  Where 机构编码 = Str_机构编码
                    And 挂号序号 = Str_挂号序号
                    And 病人id = Str_病人id
                    And Rownum = 1),
                 '') As 处理意见
        From 基础项目_病人信息 b, 门诊管理_病历诊断 t
       where b.机构编码 = t.机构编码
         And b.病人id = t.病人id
         and b.机构编码 = Str_机构编码
         And t.挂号序号 = Str_挂号序号
         And t.是否主诊断 = 'True';
  
    Open Cur_病历诊断数据集 For
      Select 1 From Dual Where 1 = 0;
  
    Open Cur_西药数据集 For
      Select 1 From Dual Where 1 = 0;
  
    Open Cur_中药数据集 For
      Select 1 From Dual Where 1 = 0;
  
    Open Cur_辅助诊疗数据集 For
      Select 1 From Dual Where 1 = 0;
  End If;

  If Str_打印类型 = '输液卡' Then
    Open Cur_数据集 For
      Select (Select 机构名称
                From 基础项目_机构资料
               Where 机构编码 = a.机构编码
                 and 删除标志 = '0') As 机构名称,
             Str_诊断集合 As 诊断集合,
             a.门诊病历号,
             (Select 科室名称
                From 基础项目_科室资料
               Where 机构编码 = a.机构编码
                 And 科室编码 = a.病人科室编码
                 and 删除标志 = '0') As 科室名称,
             (Select 姓名
                From 基础项目_病人信息
               Where 机构编码 = a.机构编码
                 And 病人id = a.病人id) As 病人姓名,
             (To_Char(录入时间, 'yyyy') || '年' || To_Char(录入时间, 'MM') || '月' ||
             To_Char(录入时间, 'dd') || '日' || To_Char(录入时间, 'hh24') || '时' ||
             To_Char(录入时间, 'mi') || '分') As 打印时间,
             (Select Fu_得到_年龄(出生日期)
                From 基础项目_病人信息
               Where 机构编码 = a.机构编码
                 And 病人id = a.病人id) As 病人年龄,
             (Select 名称
                From 基础项目_字典明细
               Where 分类编码 = 'GB_0001'
                 and 删除标志 = '0'
                 And 编码 = (Select 性别
                             From 基础项目_病人信息
                            Where 机构编码 = a.机构编码
                              And 病人id = a.病人id)) As 病人性别,
             (Select 名称
                From 基础项目_字典明细
               Where 分类编码 = 'GB_009000'
                 and 删除标志 = '0'
                 And 编码 = (Select 病人类型编码
                             From 门诊管理_挂号登记
                            Where 机构编码 = a.机构编码
                              And 挂号序号 = a.挂号序号
                              And 门诊病历号 = a.门诊病历号)) As 病人类型,
             a.处方序号,
             (a.项目名称 || (Case
               When 规格 Is Null Then
                ''
               Else
                ('(' || a.规格 || ')')
             End)) As 项目名称及规格,
             a.医嘱内容,
             (To_Char(a.用量, 'FM9999999990.0999') || a.剂量名称 || ' X ' || a.总量) As 医嘱信息,
             (a.天数 || '天') As 天数,
             (a.总量 || a.单位名称) As 总量信息,
             a.用法名称,
             a.用法名称 As 医嘱用法名称,
             (To_Char(a.用量, 'FM9999999990.0999') || a.剂量名称) As 用量信息,
             nvl((Select 次数
                   From 基础项目_频率字典
                  Where 机构编码 = a.机构编码
                    And 有效状态 = '有效'
                    And 频率编码 = a.频率编码),
                 '1') As 次数,
             (Select 频率中文名
                From 基础项目_频率字典
               Where 机构编码 = a.机构编码
                 And 有效状态 = '有效'
                 And 频率编码 = a.频率编码) as 频率名称,
             a.频率名称 As 医嘱频率名称,
             '' As 组线,
             a.组号,
             to_char(a.组号) as 组号信息,
             a.医嘱号,
             a.滴速,
             (Select 人员姓名
                From 基础项目_人员资料
               Where 机构编码 = a.机构编码
                 And 人员编码 = a.开方医生编码
                 and 删除标志 = '0') As 开方医生
        From 门诊管理_门诊医嘱 a
       Where 机构编码 = Str_机构编码
         And 医嘱号 = Str_医嘱号
         And 处方序号 = Str_处方序号
         and a.收费状态 not in ('已退费', '已退药')
         And 大类编码 = '2'
         And 小类编码 not in ('3', '4')
         And (用法编码 In (Select 用法编码
                         From 基础项目_用法对应打印
                        Where 打印对象编码 = '1'
                          And 机构编码 = Str_机构编码
                          and 删除标志 = '0') Or (皮试序号 Like '%-'))
       Order By a.医嘱号 Asc, a.处方序号 Asc, a.组号 Asc, a.排序号 Asc;
    Open Cur_西药数据集 For
      Select 1 From Dual Where 1 = 0;
  
    Open Cur_中药数据集 For
      Select 1 From Dual Where 1 = 0;
  
    Open Cur_病历诊断数据集 For
      Select 1 From Dual Where 1 = 0;
  
    Open Cur_辅助诊疗数据集 For
      Select 1 From Dual Where 1 = 0;
  End If;

End;

 
 
 
/
