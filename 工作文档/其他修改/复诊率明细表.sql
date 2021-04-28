select (select 人员姓名 from 基础项目_人员资料 where 人员编码 = 就诊医生编码) as 医生姓名,
       挂号人次,
       无消费人次,
       消费总人次,
       一次消费 as "1次消费人次",
       (case
         when 消费总人次 > 0 then
          ROUND(一次消费 / 消费总人次, 2) * 100 || '%'
         else
          null
       end) as "1次消费人次占比",
       二次消费 as "2次消费人次",
       (case
         when 消费总人次 > 0 then
          ROUND(二次消费 / 消费总人次, 2) * 100 || '%'
         else
          null
       end) as "2次消费人次占比",
       三次消费 as "3次消费人次",
       (case
         when 消费总人次 > 0 then
          ROUND(三次消费 / 消费总人次, 2) * 100 || '%'
         else
          null
       end) as "3次消费人次占比",
       四次消费 as "4次消费人次",
       (case
         when 消费总人次 > 0 then
          ROUND(四次消费 / 消费总人次, 2) * 100 || '%'
         else
          null
       end) as "4次消费人次占比",
       五次消费 as "5次消费人次",
       六次消费 as "6次消费人次",
       七次消费 as "7次消费人次",
       八次消费 as "8次消费人次",
       九次消费 as "9次消费人次",
       十次消费 as "10次消费人次以上"

  from (select 就诊医生编码,
               sum(case
                     when 消费次数 >= 0 then
                      1
                     else
                      0
                   end) as 挂号人次,
               sum(case
                     when 消费次数 = 0 then
                      1
                     else
                      0
                   end) as 无消费人次,
               sum(case
                     when 消费次数 >= 1 then
                      1
                     else
                      0
                   end) as 消费总人次,
               sum(case
                     when 消费次数 = 1 then
                      1
                     else
                      0
                   end) as 一次消费,
               sum(case
                     when 消费次数 = 2 then
                      1
                     else
                      0
                   end) as 二次消费,
               sum(case
                     when 消费次数 = 3 then
                      1
                     else
                      0
                   end) as 三次消费,
               sum(case
                     when 消费次数 = 4 then
                      1
                     else
                      0
                   end) as 四次消费,
               sum(case
                     when 消费次数 = 5 then
                      1
                     else
                      0
                   end) as 五次消费,
               sum(case
                     when 消费次数 = 6 then
                      1
                     else
                      0
                   end) as 六次消费,
               sum(case
                     when 消费次数 = 7 then
                      1
                     else
                      0
                   end) as 七次消费,
               sum(case
                     when 消费次数 = 8 then
                      1
                     else
                      0
                   end) as 八次消费,
               sum(case
                     when 消费次数 = 9 then
                      1
                     else
                      0
                   end) as 九次消费,
               sum(case
                     when 消费次数 >= 10 then
                      1
                     else
                      0
                   end) as 十次消费
          from (select 就诊医生编码, 挂号序号, count(发票序号) 消费次数
                  from (select g.就诊医生编码, g.挂号序号, c.发票序号
                          from 门诊管理_挂号登记 g
                          left join 门诊管理_门诊处方 c
                            on g.机构编码 = c.机构编码
                           and g.门诊病历号 = c.门诊病历号
                           and g.挂号序号 = c.挂号序号
                         where g.就诊状态 = '完成接诊'
                           and g.退号标志 = '否'
                           and g.挂号时间 between
                               to_date('2020-05-01', 'yyyy-MM-dd') and
                               to_date('2020-06-01', 'yyyy-MM-dd')
                         group by g.就诊医生编码, g.挂号序号, c.发票序号)
                 group by 就诊医生编码, 挂号序号) a
         group by a.就诊医生编码);
