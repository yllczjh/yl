create or replace procedure PR_设备管理_新增主设备附件(str_机构编码     in varchar2,
                                            str_资产编码     in varchar2,
                                            str_产地         in varchar2,
                                            str_生产厂家     in varchar2,
                                            str_许可证号     in varchar2,
                                            str_进口标志     in varchar2,
                                            str_状态         in varchar2,
                                            str_用途         in varchar2,
                                            str_注册号       in varchar2,
                                            str_放置位置     in varchar2,
                                            str_使用部门     in varchar2,
                                            str_保管员       in varchar2,
                                            str_联系人       in varchar2,
                                            str_购买单价     in varchar2,
                                            str_增值         in varchar2,
                                            str_启用标志     in varchar2,
                                            dat_启用日期     in date,
                                            dat_建立日期     in date,
                                            str_净现值       in varchar2,
                                            str_备注         in varchar2,
                                            str_放置机构编码 in varchar2,
                                            str_批次         in varchar2,
                                            str_入库单号     in varchar2,
                                            str_v_附件编码   in varchar2,
                                            str_v_名称       in varchar2,
                                            str_v_品牌型号   in varchar2,
                                            str_v_规格       in varchar2,
                                            str_v_数量       in varchar2,
                                            str_v_批次       in varchar2,
                                            str_v_备注       in varchar2,
                                            i_返回值         out integer,
                                            str_返回信息     out varchar2) is

  arr_附件编码 PP_全局变量.array_类型;
  arr_名称     PP_全局变量.array_类型;
  arr_品牌型号 PP_全局变量.array_类型;
  arr_规格     PP_全局变量.array_类型;
  arr_数量     PP_全局变量.array_类型;
  arr_批次     PP_全局变量.array_类型;
  arr_备注     PP_全局变量.array_类型;

  i_附件数量   number(18);
  str_记录单号 设备管理_主设备附件表.记录单号%type;

begin

  BEGIN
  
    str_返回信息 := '更新主设备表失败! ';
    update 设备管理_主设备表
       set 产地         = str_产地,
           生产厂家     = str_生产厂家,
           许可证号     = str_许可证号,
           进口标志     = str_进口标志,
           状态         = str_状态,
           用途         = str_用途,
           注册号       = str_注册号,
           放置位置     = str_放置位置,
           使用部门     = str_使用部门,
           保管员       = str_保管员,
           联系人       = str_联系人,
           购买单价     = str_购买单价,
           增值         = str_增值,
           启用标志     = str_启用标志,
           启用日期     = dat_启用日期,
           建立日期     = dat_建立日期,
           净现值       = str_净现值,
           备注         = str_备注,
           放置机构编码 = str_放置机构编码,
           批次         = str_批次
     where 机构编码 = str_机构编码
       and 资产编码 = str_资产编码
       and 入库单号 = str_入库单号;
  
    if length(str_v_附件编码) > 0 then
      arr_附件编码 := FU_Strsplit(str_操作字符串 => str_v_附件编码,
                              str_分隔符     => ',');
      arr_名称     := FU_Strsplit(str_操作字符串 => str_v_名称,
                                str_分隔符     => ',');
      arr_品牌型号 := FU_Strsplit(str_操作字符串 => str_v_品牌型号,
                              str_分隔符     => ',');
      arr_规格     := FU_Strsplit(str_操作字符串 => str_v_规格,
                                str_分隔符     => ',');
      arr_数量     := FU_Strsplit(str_操作字符串 => str_v_数量,
                                str_分隔符     => ',');
      arr_批次     := FU_Strsplit(str_操作字符串 => str_v_批次,
                                str_分隔符     => ',');
      arr_备注     := FU_Strsplit(str_操作字符串 => str_v_备注,
                                str_分隔符     => ',');
    
      for i in 1 .. arr_附件编码.count loop
      
        select count(1)
          into i_附件数量
          from 设备管理_主设备附件表
         where 机构编码 = str_机构编码
           and 资产编码 = str_资产编码
           and 附件编码 = arr_附件编码(i)
           and 随机附件 = '是';
      
      --杨磊修改
        select NVL(max(to_number(记录单号)),0) + 1
          into str_记录单号
          from 设备管理_主设备附件表;
      
        if i_附件数量 > 0 then
        
          str_返回信息 := '更新主设备附件数量失败! ';
          update 设备管理_主设备附件表
             set 数量 = 数量 + to_number(arr_数量(i))
           where 机构编码 = str_机构编码
             and 资产编码 = str_资产编码
             and 附件编码 = arr_附件编码(i)
             and 随机附件 = '是';
        
        else
        
          str_返回信息 := '插入主设备附件失败! ';
          insert into 设备管理_主设备附件表
            (机构编码,
             资产编码,
             附件编码,
             记录单号,
             名称,
             品牌型号,
             规格,
             数量,
             批次,
             随机附件,
             备注)
          values
            (str_机构编码,
             str_资产编码,
             arr_附件编码(i),
             str_记录单号,
             arr_名称(i),
             arr_品牌型号(i),
             arr_规格(i),
             arr_数量(i),
             arr_批次(i),
             '是',
             arr_备注(i));
        
        end if;
      
      end loop;
    
    end if;
  
  EXCEPTION
    WHEN OTHERS THEN
      GOTO 退出;
  END;

  i_返回值     := 1;
  str_返回信息 := '添加成功! ';
  RETURN;

  <<退出>>
  i_返回值     := 0;
  str_返回信息 := str_返回信息 || SQLERRM;
  RETURN;

end PR_设备管理_新增主设备附件;
/
