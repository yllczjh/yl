CREATE OR REPLACE PROCEDURE Pr_设备管理_设备增购(str_机构编码         in varchar2,
                                         dat_入库日期         in date,
                                         str_采购单号         in varchar2,
                                         str_供货商           in varchar2,
                                         str_采购员           in varchar2,
                                         str_检验员           in varchar2,
                                         str_收货员           in varchar2,
                                         str_分期付款         in varchar2,
                                         dat_到货日期         in date,
                                         str_备注             in varchar2,
                                         str_源单据号         in varchar2,
                                         str_入库类型         in varchar2,
                                         str_设备编码         in varchar2,
                                         str_设备类型编码     in varchar2,
                                         str_生产厂家         in varchar2,
                                         str_品牌型号         in varchar2,
                                         str_规格             in varchar2,
                                         str_数量             in varchar2,
                                         str_单价             in varchar2,
                                         str_批次             in varchar2,
                                         str_设备零件附件标识 in varchar2, --1.设备  2.附件  3.零件
                                         str_产生资产号标志   in varchar2,
                                         str_进口标志         in varchar2,
                                         str_购进时新旧情况   in varchar2,
                                         str_理论设计寿命     in varchar2,
                                         str_车载卫星定位系统 in varchar2,
                                         dat_录入时间         in date,

                                         str_入库单号 out varchar2,
                                         i_返回值     out integer,
                                         str_返回信息 out varchar2) AS

  --str_入库单号 varchar2(50);
  --str_资产编码 varchar2(50);
 -- i_数量       integer;

  arr_设备编码         PP_全局变量.array_类型;
  arr_设备类型编码     PP_全局变量.array_类型;
  arr_生产厂家         PP_全局变量.array_类型;
  arr_品牌型号         PP_全局变量.array_类型;
  arr_规格             PP_全局变量.array_类型;
  arr_数量             PP_全局变量.array_类型;
  arr_单价             PP_全局变量.array_类型;
  arr_批次             PP_全局变量.array_类型;
  arr_设备零件附件标识 PP_全局变量.array_类型;
  arr_产生资产号标志   PP_全局变量.array_类型;
  arr_进口标志         PP_全局变量.array_类型;
  arr_购进时新旧情况   PP_全局变量.array_类型;
  arr_理论设计寿命     PP_全局变量.array_类型;
  arr_车载卫星定位系统 PP_全局变量.array_类型;

BEGIN

  BEGIN
    Pr_设备管理_入库单号(str_机构编码 => str_机构编码,
                 str_入库单号 => str_入库单号,
                 i_返回值     => i_返回值,
                 str_返回信息 => str_返回信息);

    arr_设备编码         := FU_Strsplit(str_操作字符串 => str_设备编码,
                                    str_分隔符     => ',');
    arr_设备类型编码     := FU_Strsplit(str_操作字符串 => str_设备类型编码,
                                  str_分隔符     => ',');
    arr_生产厂家         := FU_Strsplit(str_操作字符串 => str_生产厂家,
                                    str_分隔符     => ',');
    arr_品牌型号         := FU_Strsplit(str_操作字符串 => str_品牌型号,
                                    str_分隔符     => ',');
    arr_规格             := FU_Strsplit(str_操作字符串 => str_规格,
                                      str_分隔符     => ',');
    arr_数量             := FU_Strsplit(str_操作字符串 => str_数量,
                                      str_分隔符     => ',');
    arr_单价             := FU_Strsplit(str_操作字符串 => str_单价,
                                      str_分隔符     => ',');
    arr_批次             := FU_Strsplit(str_操作字符串 => str_批次,
                                      str_分隔符     => ',');
    arr_设备零件附件标识 := FU_Strsplit(str_操作字符串 => str_设备零件附件标识,
                                str_分隔符     => ',');
    arr_产生资产号标志   := FU_Strsplit(str_操作字符串 => str_产生资产号标志,
                                 str_分隔符     => ',');
    arr_进口标志         := FU_Strsplit(str_操作字符串 => str_进口标志,
                                    str_分隔符     => ',');
    arr_购进时新旧情况   := FU_Strsplit(str_操作字符串 => str_购进时新旧情况,
                                 str_分隔符     => ',');
    arr_理论设计寿命     := FU_Strsplit(str_操作字符串 => str_理论设计寿命,
                                  str_分隔符     => ',');
    arr_车载卫星定位系统 := FU_Strsplit(str_操作字符串 => str_车载卫星定位系统,
                                str_分隔符     => ',');

    str_返回信息 := '插入设备入库单失败! ';
    insert into 设备管理_入库单
      (机构编码,
       入库单号,
       入库日期,
       采购单号,
       供货商,
       采购员,
       检验员,
       收货员,
       分期付款,
       到货日期,
       备注,
       源单据号,
       入库类型,
       录入时间)
    values
      (str_机构编码,
       str_入库单号,
       dat_入库日期,
       str_采购单号,
       str_供货商,
       str_采购员,
       str_检验员,
       str_收货员,
       str_分期付款,
       dat_到货日期,
       str_备注,
       str_源单据号,
       str_入库类型,
       dat_录入时间);

    --将数据插入到入库单明细表中
    for i in 1 .. arr_设备编码.count loop

      str_返回信息 := '入库单明细插入失败! ';
      insert into 设备管理_入库单明细
        (机构编码,
         入库单号,
         设备编码,
         生产厂家,
         品牌型号,
         规格,
         数量,
         单价,
         批次,
         设备附件零件标志,
         产生资产号标志,
         进口标志,
         购进时新旧情况,
         理论设计寿命,
         车载卫星定位系统)
      values
        (str_机构编码,
         str_入库单号,
         arr_设备编码(i),
         arr_生产厂家(i),
         arr_品牌型号(i),
         arr_规格(i),
         arr_数量(i),
         arr_单价(i),
         arr_批次(i),
         arr_设备零件附件标识(i),
         arr_产生资产号标志(i),
         arr_进口标志(i),
         arr_购进时新旧情况(i),
         arr_理论设计寿命(i),
         arr_车载卫星定位系统(i));

     /* --增加库存
      str_返回信息 := '库存查询失败! ';
      select count(*)
        into i_数量
        from 设备管理_库存表
       where 机构编码 = str_机构编码
         and 设备编码 = arr_设备编码(i);

      if i_数量 > 0 then

        str_返回信息 := '更新库存失败! ';
        update 设备管理_库存表
           set 数量  =
               (to_number(数量) + to_number(arr_数量(i))),
               进价   = arr_单价(i),
               标准价 =
               (to_number(数量) * to_number(标准价) +
               to_number(arr_数量(i)) * to_number(arr_单价(i))) /
               (to_number(数量) + to_number(arr_数量(i)))
         where 机构编码 = str_机构编码
           and 设备编码 = arr_设备编码(i);

      else

        str_返回信息 := '新增库存失败! ';
        insert into 设备管理_库存表
          (机构编码, 设备编码, 批次, 数量, 进价, 标准价, 己分配量)
        values
          (str_机构编码,
           arr_设备编码(i),
           arr_批次(i),
           arr_数量(i),
           arr_单价(i),
           arr_单价(i),
           0);

      end if;

      --设备零件附件标识等于 1 时,为设备,

      if arr_设备零件附件标识(i) = '1' then

        --添加主设备,如果数量为 1,则直接插入主设备表,如果大于 1,则遍历数量循环插入
        if arr_数量(i) = 1 then

          Pr_设备管理_资产编码(str_机构编码     => str_机构编码,
                       str_设备类型编码 => arr_设备类型编码(i),
                       str_资产编码     => str_资产编码,
                       i_返回值         => i_返回值,
                       str_返回信息     => str_返回信息);

          str_返回信息 := '新增主设备失败! ';
          insert into 设备管理_主设备表
            (机构编码,
             资产编码,
             设备编码,
             生产厂家,
             进口标志,
             购买单价,
             建立日期,
             批次,
             入库单号,
             启用标志,
             净现值,
             折旧类别,
             计量类别,
             购进时新旧情况,
             理论设计寿命,
             车载卫星定位系统)
          values
            (str_机构编码,
             str_资产编码,
             arr_设备编码(i),
             arr_生产厂家(i),
             arr_进口标志(i),
             arr_单价(i),
             dat_入库日期,
             arr_批次(i),
             str_入库单号,
             '否',
             arr_单价(i),
             (select 折旧类别
                from 设备管理_设备目录
               where 设备编码 = arr_设备编码(i)
                 and 机构编码 = str_机构编码),
             (select 计量类别
                from 设备管理_设备目录
               where 设备编码 = arr_设备编码(i)
                 and 机构编码 = str_机构编码),
             arr_购进时新旧情况(i),
             arr_理论设计寿命(i),
             arr_车载卫星定位系统(i));

        else

          for j in 1 .. to_number(arr_数量(i)) loop

            PR_设备管理_资产编码(str_机构编码     => str_机构编码,
                         str_设备类型编码 => arr_设备类型编码(i),
                         str_资产编码     => str_资产编码,
                         i_返回值         => i_返回值,
                         str_返回信息     => str_返回信息);

            str_返回信息 := '新增主设备失败! ';
            insert into 设备管理_主设备表
              (机构编码,
               资产编码,
               设备编码,
               生产厂家,
               进口标志,
               购买单价,
               建立日期,
               批次,
               入库单号,
               启用标志,
               净现值,
               折旧类别,
               计量类别,
               购进时新旧情况,
               理论设计寿命,
               车载卫星定位系统)
            values
              (str_机构编码,
               str_资产编码,
               arr_设备编码(i),
               arr_生产厂家(i),
               arr_进口标志(i),
               arr_单价(i),
               dat_入库日期,
               arr_批次(i),
               str_入库单号,
               '否',
               arr_单价(i),
               (select 折旧类别
                  from 设备管理_设备目录
                 where 设备编码 = arr_设备编码(i)
                   and 机构编码 = str_机构编码),
               (select 计量类别
                  from 设备管理_设备目录
                 where 设备编码 = arr_设备编码(i)
                   and 机构编码 = str_机构编码),
               arr_购进时新旧情况(i),
               arr_理论设计寿命(i),
               arr_车载卫星定位系统(i));

          end loop;

        end if;

      end if;*/

    end loop;

  EXCEPTION
    WHEN OTHERS THEN
      GOTO 退出;
  END;

  i_返回值     := 1;
  str_返回信息 := '新增主设备成功! ';
  RETURN;

  <<退出>>
  i_返回值     := 0;
  str_返回信息 := str_返回信息 || SQLERRM;
  RETURN;

END;

 
 
 
/
