create or replace procedure PRC_门诊管理_生成门诊排班记录(str_机构编码 in varchar2,
                                              str_星期     in varchar2,
                                              str_日期     in varchar2,
                                              int_返回值   out integer,
                                              str_返回信息 out varchar2) is
begin

  insert into 门诊管理_当天排班记录
    (机构编码,
     记录ID,
     排班日期,
     排班序号,
     挂号类型名称,
     星期,
     科室编码,
     科室名称,
     医生编码,
     医生姓名,
     上午限号,
     上午最大限号,
     上午已挂号数,
     下午限号,
     下午最大限号,
     下午已挂号数,
     诊室名称,
     诊室位置,
     生成时间,
     生成方式,
     挂号类型编码)
    select a.机构编码,
           SYS_GUID(),
           to_date(str_日期, 'yyyy-MM-dd'),
           a.排班序号,
           a.挂号类型名称,
           a.星期,
           a.科室编码,
           a.科室名称,
           a.医生编码,
           a.医生姓名,
           a.上午限号,
           a.上午最大限号,
           0,
           a.下午限号,
           a.下午最大限号,
           0,
           a.诊室名称,
           a.诊室位置,
           sysdate,
           '手动生成',
           a.挂号类型编码
      from 门诊管理_门诊一周排班表 a
     where a.机构编码 = str_机构编码
       and a.星期 = str_星期;

  int_返回值   := 1;
  str_返回信息 := 'ok';
  commit;
exception
  when others then
    int_返回值   := 0;
    str_返回信息 := sqlerrm;
    rollback;

end PRC_门诊管理_生成门诊排班记录;

 
 
 
/
