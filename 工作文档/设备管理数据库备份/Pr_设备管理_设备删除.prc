CREATE OR REPLACE PROCEDURE Pr_设备管理_设备删除(str_机构编码 in varchar2,
                                         str_入库单号 in varchar2,
                                         str_设备编码 in varchar2,
                                         i_返回值     out integer,
                                         str_返回信息 out varchar2) AS

 -- i_数量               number(10);
  i_入库明细行数       number(10);
  --str_设备零件附件标识 varchar2(10);

BEGIN

  BEGIN

    /*str_返回信息 := '查询设备入库明细数量失败! ';
    select 数量, 设备附件零件标志
      into i_数量, str_设备零件附件标识
      from 设备管理_入库单明细
     where 机构编码 = str_机构编码
       and 入库单号 = str_入库单号
       and 设备编码 = str_设备编码;*/

/*    str_返回信息 := '修改设备库存失败! ';
    update 设备管理_库存表
       set 数量 =
           (数量 - i_数量)
     where 机构编码 = str_机构编码
       and 设备编码 = str_设备编码;*/

    select count(0)
      into i_入库明细行数
      from 设备管理_入库单明细
     where 机构编码 = str_机构编码
       and 入库单号 = str_入库单号;

    If i_入库明细行数 = 1 then

      str_返回信息 := '删除设备入库单单头失败! ';
      delete 设备管理_入库单
       where 机构编码 = str_机构编码
         and 入库单号 = str_入库单号;

    end if;

    str_返回信息 := '删除设备入库单明细失败! ';
    delete 设备管理_入库单明细
     where 机构编码 = str_机构编码
       and 入库单号 = str_入库单号
       and 设备编码 = str_设备编码;

/*    str_返回信息 := '删除主设备表失败! ';
    delete 设备管理_主设备表
     where 机构编码 = str_机构编码
       and 入库单号 = str_入库单号
       and 设备编码 = str_设备编码;*/

  EXCEPTION
    WHEN OTHERS THEN
      GOTO 退出;
  END;

  i_返回值     := 1;
  str_返回信息 := '删除成功! ';
  COMMIT;
  RETURN;

  <<退出>>
  i_返回值     := 0;
  str_返回信息 := str_返回信息 || SQLERRM;
  ROLLBACK;
  RETURN;

END;


 
 
 
/
