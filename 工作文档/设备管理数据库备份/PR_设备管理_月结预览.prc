create or replace procedure PR_设备管理_月结预览(str_机构编码   In Varchar2,
                         dae_开始日期   in date,
                         dae_结束日期   in date,
                         cur_返回记录集 Out PP_全局变量.cur_记录集) is
  begin
    open cur_返回记录集 for
      select to_char(sysdate, 'yyyy-mm-dd') as 月结日期,
             to_char(dae_开始日期, 'yyyy-mm-dd') as 开始日期,
             to_char(dae_结束日期, 'yyyy-mm-dd') as 结束日期,
             AA.机构编码,
             AA.设备编码,
             nvl((select 本期库存
                   from 设备管理_月结表
                  where 机构编码 = AA.机构编码
                    and 设备编码 = AA.设备编码
                    and 结束日期 = dae_开始日期),
                 0) as 期初库存,
             nvl((select 本期库存金额
                   from 设备管理_月结表
                  where 机构编码 = AA.机构编码
                    and 设备编码 = AA.设备编码
                    and 结束日期 = dae_开始日期),
                 0) as 期初库存金额,
             nvl((select sum(数量)
                   from 设备管理_库存表
                  where 机构编码 = AA.机构编码
                    and 设备编码 = AA.设备编码),
                 0) as 本期库存,
             nvl((select sum(数量 * 标准价)
                   from 设备管理_库存表
                  where 机构编码 = AA.机构编码
                    and 设备编码 = AA.设备编码),
                 0) as 本期库存金额,
             nvl((select sum(设备管理_入库单明细.数量 * 设备管理_入库单明细.单价)
                   from 设备管理_入库单明细
                   left join 设备管理_入库单
                     on 设备管理_入库单明细.机构编码 = 设备管理_入库单.机构编码
                    and 设备管理_入库单明细.入库单号 = 设备管理_入库单.入库单号
                  where 设备管理_入库单.入库日期 between dae_开始日期 and dae_结束日期
                    and 设备管理_入库单明细.机构编码 = AA.机构编码
                    and 设备管理_入库单明细.设备编码 = AA.设备编码
                  group by 设备管理_入库单明细.机构编码, 设备管理_入库单明细.设备编码),
                 0) as 本期购入,
             nvl((select sum(本次增值)
                   from 设备管理_设备增值
                  where 增值日期 between dae_开始日期 and dae_结束日期
                    and 设备管理_设备增值.机构编码 = AA.机构编码
                    and 设备管理_设备增值.设备编码 = AA.设备编码
                  group by 机构编码, 设备编码),
                 0) as 本期增值,
             nvl((select sum(设备管理_设备消减.现价值)
                   from 设备管理_设备消减
                  inner join 设备管理_主设备表
                     on 设备管理_设备消减.机构编码 = 设备管理_主设备表.机构编码
                    and 设备管理_设备消减.资产编码 = 设备管理_主设备表.资产编码
                  where 消减日期 between dae_开始日期 and dae_结束日期
                    and 设备管理_设备消减.机构编码 = AA.机构编码
                    and 设备管理_主设备表.设备编码 = AA.设备编码
                  group by 设备管理_设备消减.机构编码, 设备管理_主设备表.设备编码),
                 0) as 本期消减,
             nvl((select sum(月折旧额)
                   from 设备管理_设备折旧
                  inner join 设备管理_主设备表
                     on 设备管理_设备折旧.机构编码 = 设备管理_主设备表.机构编码
                    and 设备管理_设备折旧.资产编码 = 设备管理_主设备表.资产编码
                  where 执行日期 between dae_开始日期 and dae_结束日期
                    and 设备管理_设备折旧.机构编码 = AA.机构编码
                    and 设备管理_主设备表.设备编码 = AA.设备编码
                  group by 设备管理_设备折旧.机构编码, 设备管理_主设备表.设备编码),
                 0) as 本期折旧,
             nvl((select sum(使用数量 * 单价)
                   from 设备管理_附件领用耗用
                  where 单据类型 = '附件耗用'
                    and 操作日期 between dae_开始日期 and dae_结束日期
                    and 设备管理_附件领用耗用.机构编码 = AA.机构编码
                    and 设备管理_附件领用耗用.附件编码 = AA.设备编码
                  group by 机构编码, 附件编码),
                 0) as 本期附件耗用
        from 设备管理_设备目录 AA
       where AA.机构编码 = str_机构编码;

  end PR_设备管理_月结预览;


 
 
 
/
