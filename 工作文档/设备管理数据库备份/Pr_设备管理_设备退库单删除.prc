create or replace procedure Pr_设备管理_设备退库单删除(str_机构编码 in varchar2,
                                            str_退库单号 in varchar2,
                                            str_设备编码 in varchar2,
                                            str_资产编码 in varchar2,
                                            i_返回值     out integer,
                                            str_返回信息 out varchar2) AS

  i_退库明细行数 number(10);
  str_结账标志   varchar2(50);

BEGIN

  BEGIN
  
    str_返回信息 := '查询结账标志失败! ';
    select min(结账标志)
      into str_结账标志
      from 设备管理_退库单
     where 机构编码 = str_机构编码
       and 退库单号 = str_退库单号;
  
    if Str_结账标志 = '已结账' then
      str_返回信息 := '该单据已经结账!';
      GOTO 退出;
    end if;
  
    str_返回信息 := '查询退库单明细行数失败! ';
    select count(0)
      into i_退库明细行数
      from 设备管理_退库单明细
     where 机构编码 = str_机构编码
       and 退库单号 = str_退库单号;
  
    If i_退库明细行数 = 1 then
    
      str_返回信息 := '删除设备入库单单头失败! ';
      delete 设备管理_退库单
       where 机构编码 = str_机构编码
         and 退库单号 = str_退库单号;
    
    end if;
  
    str_返回信息 := '删除设备入库单明细失败! ';
    delete 设备管理_退库单明细
     where 机构编码 = str_机构编码
       and 退库单号 = str_退库单号
       and 设备编码 = str_设备编码
       and 资产编码 = str_资产编码;
  
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

end Pr_设备管理_设备退库单删除;
/
