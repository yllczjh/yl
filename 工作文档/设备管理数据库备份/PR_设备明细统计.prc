create or replace procedure PR_设备明细统计(str_机构编码     in varchar2,
                                      cur_查询结果     out sys_refcursor,
                                      i_返回值         out integer,
                                      str_返回信息     out varchar2) is
  Str_表头 varchar2(50);
begin
    open cur_查询结果 for
      select Fu_取得_机构名称(a.机构编码) as 机构名称,
             a.机构编码,
             b.名称 as 设备名称,
             (select 名称
                from 基础项目_字典明细
               where 分类编码 = 'GB_009066'
                 and 编码 = b.设备类别) as 设备类别,
             b.品牌型号,
             b.规格,
             a.数量 as 库存量,
             a.进价,
             a.标准价,
             (select 小类名称
                from 基础项目_小类字典
               where 机构编码 = a.机构编码
                 and 大类编码 = '4'
                 and 小类编码 = b.目录分类
                 and 有效状态 = '有效') as 目录分类,
             (a.进价 * a.数量) as 进价总额,
             (a.标准价 * a.数量) as 标准价总额
        from 设备管理_库存表       a,
             设备管理_设备目录     b,
             基础项目_机构归属管理 c
       where a.机构编码 = b.机构编码
         and a.设备编码 = b.设备编码
         and a.机构编码 = c.管辖机构
         and b.有效状态 = '有效'
         and c.删除标志='0'
         --2020-04-03 杨磊修改
         and a.机构编码=str_机构编码;
         --and c.机构编码 =
           -- (case when str_机构编码 = '全部' or str_机构编码 is null or
             -- str_机构编码 = ' ' then b.机构编码 else str_机构编码 end);

  I_返回值     := 1;
  Str_返回信息 := 'OK';
end PR_设备明细统计;


 
 
 
/
