create or replace procedure PR_设备管理_折旧结算(str_机构编码   In Varchar2,
                                         str_开始日期   in date,
                                         str_结束日期   in date,
                                         str_从启用开始 in varchar2,
                                         str_资产编码   in varchar2,
                                         rt_记录集      Out PP_全局变量.rt_返回记录集,
                                         i_返回值       Out Integer,
                                         str_返回信息   Out Varchar2) is

  i_标识         number(10);
  v_折到0后折旧  varchar2(50);
  v_折旧年月     设备管理_设备折旧.折旧年月%TYPE;
  v_资产编码     设备管理_设备折旧.资产编码%TYPE;
  v_名称         设备管理_设备折旧.名称%TYPE;
  v_执行日期     设备管理_设备折旧.执行日期%TYPE;
  v_折旧月数     设备管理_设备折旧.折旧月数%TYPE;
  v_累计折旧     设备管理_设备折旧.累计折旧%TYPE;
  v_购买单价     设备管理_设备折旧.购买单价%TYPE;
  v_净现值       设备管理_设备折旧.净现值%TYPE;
  v_启用日期     设备管理_主设备表.启用日期%TYPE;
  v_折旧类别     设备管理_主设备表.折旧类别%TYPE;
  v_折旧类别名称 设备管理_设备折旧.折旧类别名称%TYPE;
  v_每月折旧率   设备管理_设备折旧类别.每月折旧率%TYPE;
  v_月折旧额     设备管理_设备折旧.月折旧额%TYPE;
  v_备注         设备管理_设备折旧.备注%TYPE;
  v_折旧单号     设备管理_设备折旧.折旧单号%TYPE;

begin

  BEGIN

    IF str_从启用开始 = '1' THEN
      v_备注 := '从启用日期开始折旧';
    ELSE
      v_备注 := '按月折旧';
    END IF;

    SELECT count(值)
      INTO i_标识
      FROM 基础项目_机构参数列表
     WHERE 机构编码 = str_机构编码
       AND 参数编码 = '163';

    if i_标识 = 0 then
      v_折到0后折旧 := '否';
    else
      SELECT 值
        INTO v_折到0后折旧
        FROM 基础项目_机构参数列表
       WHERE 机构编码 = str_机构编码
         AND 参数编码 = '163';
    end if;

    Select Nvl(Max(折旧单号), 0) + 1
      into v_折旧单号
      From 设备管理_设备折旧
     Where 机构编码 = str_机构编码;

    DECLARE
      CURSOR C_折旧处理 IS
        SELECT to_char(str_结束日期, 'yyyymm') 折旧年月,
               A.资产编码,
               (SELECT 名称
                  FROM 设备管理_设备目录 B
                 WHERE B.机构编码 = A.机构编码
                   AND B.设备编码 = A.设备编码) 名称,
               (select to_date(to_char(sysdate, 'yyyy-mm-dd'), 'yyyy-mm-dd')
                  from dual) 执行日期,
               (select count(0) + 1
                  from 设备管理_设备折旧 B
                 where B.机构编码 = A.机构编码
                   and B.资产编码 = A.资产编码) 折旧月数,
               nvl((select sum(nvl(B.月折旧额, 0))
                     from 设备管理_设备折旧 B
                    where B.机构编码 = A.机构编码
                      and B.资产编码 = A.资产编码),
                   0) 累计折旧,
               A.购买单价,
               A.净现值,
               A.启用日期,
               A.折旧类别,
               (select 类别名称
                  from 设备管理_设备折旧类别 B
                 where B.机构编码 = A.机构编码
                   and B.类别编码 = A.折旧类别) 折旧类别名称,
               nvl((select nvl(每月折旧率, 0)
                     from 设备管理_设备折旧类别 B
                    where B.机构编码 = A.机构编码
                      and B.类别编码 = A.折旧类别),
                   0) 每月折旧率 　 　
          FROM 设备管理_主设备表 A 　　　
         WHERE A.机构编码 = str_机构编码
           and A.资产编码 like decode(str_资产编码, 'ALL', '%', str_资产编码)
           and A.启用标志 = '是'
           and nvl(A.报废标志, '否') = '否'
           AND A.折旧类别 IN (SELECT B.类别编码
                            FROM 设备管理_设备折旧类别 B
                           WHERE B.机构编码 = A.机构编码
                             AND B.类别编码 = A.折旧类别);
    BEGIN
      OPEN C_折旧处理;
      LOOP
        FETCH C_折旧处理
          INTO v_折旧年月,
               v_资产编码,
               v_名称,
               v_执行日期,
               v_折旧月数,
               v_累计折旧,
               v_购买单价,
               v_净现值,
               v_启用日期,
               v_折旧类别,
               v_折旧类别名称,
               v_每月折旧率;
        EXIT WHEN C_折旧处理%NOTFOUND;
        IF v_净现值 > 0 OR (v_折到0后折旧 = '是' and v_净现值 <= 0) THEN
          IF str_从启用开始 = '0' THEN
            v_月折旧额 := v_购买单价 * v_每月折旧率;
          ELSE
            v_月折旧额 := v_购买单价 * (str_结束日期 - v_启用日期) / 30 * v_每月折旧率;
          END IF;
          v_累计折旧 := v_累计折旧 + v_月折旧额;
          --2020-03-19 杨磊 净现值算法修改
          v_净现值   := v_购买单价 - v_累计折旧;
          --v_净现值   := v_净现值 - v_累计折旧;
          IF v_净现值 < 0 THEN
            v_净现值 := 0;
          END IF;
          insert into 设备管理_设备折旧
            (机构编码,
             折旧单号,
             折旧年月,
             资产编码,
             名称,
             执行日期,
             开始日期,
             结束日期,
             折旧月数,
             月折旧额,
             累计折旧,
             净现值,
             购买单价,
             折旧类别,
             折旧类别名称,
             备注)
          values
            (str_机构编码,
             v_折旧单号,
             v_折旧年月,
             v_资产编码,
             v_名称,
             v_执行日期,
             str_开始日期,
             str_结束日期,
             v_折旧月数,
             v_月折旧额,
             v_累计折旧,
             v_净现值,
             v_购买单价,
             v_折旧类别,
             v_折旧类别名称,
             v_备注);
          If Sqlcode <> 0 Then
            Rollback;
            i_返回值     := 0;
            str_返回信息 := '失败! ' || Sqlerrm;
            EXIT;
          End If;

        END IF;
      END LOOP;
      CLOSE C_折旧处理;
    END COMMIT;
    UPDATE 设备管理_主设备表 A
       SET A.净现值 =
           (SELECT 净现值
              FROM 设备管理_设备折旧 B
             WHERE B.机构编码 = A.机构编码
               AND B.资产编码 = A.资产编码
               AND B.折旧年月 = TO_CHAR(str_结束日期, 'yyyymm'))
     WHERE A.机构编码 = str_机构编码
       AND A.资产编码 like decode(str_资产编码, 'ALL', '%', str_资产编码)
       AND A.启用标志 = '是'
       AND nvl(A.报废标志, '否') = '否'
       AND A.资产编码 IN
           (SELECT B.资产编码
              FROM 设备管理_设备折旧 B
             WHERE B.机构编码 = A.机构编码
               AND B.资产编码 = A.资产编码
               AND B.折旧年月 = TO_CHAR(str_结束日期, 'yyyymm'));

    open rt_记录集 for
      select 机构编码,
             折旧年月,
             资产编码,
             名称,
             执行日期,
             开始日期,
             结束日期,
             折旧月数,
             月折旧额,
             累计折旧,
             净现值,
             购买单价,
             折旧类别,
             折旧类别名称,
             备注
        from 设备管理_设备折旧
       where 机构编码 = str_机构编码
         and 资产编码 like decode(str_资产编码, 'ALL', '%', str_资产编码)
         and to_char(str_结束日期, 'yyyymm') = 折旧年月;

  EXCEPTION
    WHEN OTHERS THEN
      GOTO 退出;
  END;

  i_返回值     := 1;
  str_返回信息 := '成功!';
  RETURN;

  <<退出>>
  i_返回值     := 0;
  str_返回信息 := str_返回信息 || SQLERRM;
  RETURN;

end PR_设备管理_折旧结算;


 
 
 
/
