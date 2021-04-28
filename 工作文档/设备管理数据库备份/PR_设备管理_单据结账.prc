CREATE OR REPLACE PROCEDURE PR_设备管理_单据结账(STR_传入_机构编码 IN VARCHAR2,
                                         STR_传入_单据单号 IN VARCHAR2,
                                         STR_传入_单据类别 IN VARCHAR2,
                                         STR_传入_表主键   IN VARCHAR2,
                                         INT_返回值        OUT INTEGER,
                                         STR_返回信息      OUT VARCHAR2) AS

  NUM_本次增值           NUMBER;
  NUM_增值后值           NUMBER;
  NUM_数量               NUMBER;
  NUM_记录条数           NUMBER;
  STR_SQL                VARCHAR2(1000) := '';
  STR_资产编码           设备管理_主设备表.资产编码%TYPE;
  STR_批次               设备管理_库存表.批次%TYPE;
  STR_使用部门           设备管理_主设备表.使用部门%TYPE;
  STR_设备编码           设备管理_主设备表.设备编码%TYPE;
  STR_结账标志           设备管理_入库单.结账标志%TYPE;
  STR_单据类型           设备管理_附件领用耗用.单据类型%TYPE;
  STR_设备类别           设备管理_设备目录.设备类别%TYPE;
  STR_记录单号           设备管理_主设备附件表.记录单号%TYPE;
  STR_目的机构编码       设备管理_设备调配.目的机构编码%TYPE;
  STR_目的科室编码       设备管理_设备调配.目的科室编码%TYPE;
  STR_放置位置           设备管理_设备调配.放置位置%TYPE;
  STR_启用标志           设备管理_主设备表.启用标志%TYPE;
  STR_变更后折旧类型编码 设备管理_设备折旧变更.变更后折旧类型编码%TYPE;

  TYPE REF_CURSOR_TYPE IS REF CURSOR;
  CUR_结账单据明细 REF_CURSOR_TYPE;
  ROW_入库单明细   设备管理_入库单明细%ROWTYPE;

  DATE_更新时间 DATE := TO_DATE(TO_CHAR(SYSDATE, 'yyyy-MM-dd hh24:mi:ss'),
                            'yyyy-MM-dd hh24:mi:ss');

BEGIN

  BEGIN
    --查询单据是否已经结账
    STR_返回信息 := '查询结账标志失败! ';
    STR_SQL      := 'select min(结账标志)
                        from ' || STR_传入_单据类别 || '
                       where 机构编码=:1 and ' || STR_传入_表主键 ||
                    '=:2';
  
    EXECUTE IMMEDIATE STR_SQL
      INTO STR_结账标志
      USING STR_传入_机构编码, STR_传入_单据单号;
  
    IF STR_结账标志 = '已结账' THEN
      STR_返回信息 := '该单据已经结账!';
      GOTO 退出;
    END IF;
  
    --更新单据结账标志为'已结账'
    STR_返回信息 := '更新结账标志失败! ';
    STR_SQL      := 'update ' || STR_传入_单据类别 ||
                    ' set 结账标志=''已结账'' where 机构编码=:1 and ' || STR_传入_表主键 ||
                    '=:2';
    EXECUTE IMMEDIATE STR_SQL
      USING STR_传入_机构编码, STR_传入_单据单号;
  
    --设备入库
    IF STR_传入_单据类别 = '设备管理_入库单' THEN
    
      STR_返回信息 := '获取结账单据明细失败! ';
      STR_SQL      := ' select 机构编码,入库单号,设备编码,生产厂家,进口标志,批次,数量,单价,设备附件零件标志,购进时新旧情况,理论设计寿命,车载卫星定位系统 from 设备管理_入库单明细 where 机构编码 = ' ||
                      STR_传入_机构编码 || ' and 入库单号 = ' || STR_传入_单据单号;
    
      OPEN CUR_结账单据明细 FOR STR_SQL;
      ----循环入库单明细 更新库存及主设备表
      LOOP
        FETCH CUR_结账单据明细
          INTO ROW_入库单明细.机构编码,
               ROW_入库单明细.入库单号,
               ROW_入库单明细.设备编码,
               ROW_入库单明细.生产厂家,
               ROW_入库单明细.进口标志,
               ROW_入库单明细.批次,
               ROW_入库单明细.数量,
               ROW_入库单明细.单价,
               ROW_入库单明细.设备附件零件标志,
               ROW_入库单明细.购进时新旧情况,
               ROW_入库单明细.理论设计寿命,
               ROW_入库单明细.车载卫星定位系统;
      
        EXIT WHEN CUR_结账单据明细%NOTFOUND;
      
        ----更新库存
        STR_返回信息 := '库存查询失败! ';
        SELECT COUNT(1)
          INTO NUM_数量
          FROM 设备管理_库存表
         WHERE 机构编码 = STR_传入_机构编码
           AND 设备编码 = ROW_入库单明细.设备编码
           AND 批次 = ROW_入库单明细.批次;
      
        IF NUM_数量 > 0 THEN
          ----库存中有该设备批次的记录 则更新
          STR_返回信息 := '更新库存失败! ';
          UPDATE 设备管理_库存表
             SET 数量    =
                 (TO_NUMBER(数量) + TO_NUMBER(ROW_入库单明细.数量)),
                 进价     = ROW_入库单明细.单价,
                 标准价  =
                 (TO_NUMBER(数量) * TO_NUMBER(标准价) +
                 TO_NUMBER(ROW_入库单明细.数量) * TO_NUMBER(ROW_入库单明细.单价)) /
                 (TO_NUMBER(数量) + TO_NUMBER(ROW_入库单明细.数量)),
                 更新时间 = DATE_更新时间
           WHERE 机构编码 = STR_传入_机构编码
             AND 设备编码 = ROW_入库单明细.设备编码
             AND 批次 = ROW_入库单明细.批次;
        
        ELSE
          ----库存中没有该设备批次的记录 则添加
          STR_返回信息 := '新增库存失败! ';
          INSERT INTO 设备管理_库存表
            (机构编码,
             设备编码,
             批次,
             数量,
             进价,
             标准价,
             己分配量,
             更新时间)
          VALUES
            (STR_传入_机构编码,
             ROW_入库单明细.设备编码,
             ROW_入库单明细.批次,
             ROW_入库单明细.数量,
             ROW_入库单明细.单价,
             ROW_入库单明细.单价,
             0,
             DATE_更新时间);
        
        END IF;
      
        ----更新主设备表
        IF ROW_入库单明细.设备附件零件标志 = '1' THEN
          STR_返回信息 := '查询设备类别失败! ';
          STR_SQL      := 'select min(目录分类) from 设备管理_设备目录 where 设备编码=' ||
                          ROW_入库单明细.设备编码 || ' and 机构编码=' || STR_传入_机构编码;
        
          EXECUTE IMMEDIATE STR_SQL
            INTO STR_设备类别;
        
          IF ROW_入库单明细.数量 = 1 THEN
          
            PR_设备管理_资产编码(STR_机构编码     => STR_传入_机构编码,
                         STR_设备类型编码 => STR_设备类别,
                         STR_资产编码     => STR_资产编码,
                         I_返回值         => INT_返回值,
                         STR_返回信息     => STR_返回信息);
          
            STR_返回信息 := '新增主设备失败! ';
            INSERT INTO 设备管理_主设备表
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
               报废标志,
               净现值,
               折旧类别,
               计量类别,
               购进时新旧情况,
               理论设计寿命,
               车载卫星定位系统,
               更新时间,
               删除标志)
            VALUES
              (STR_传入_机构编码,
               STR_资产编码,
               ROW_入库单明细.设备编码,
               ROW_入库单明细.生产厂家,
               ROW_入库单明细.进口标志,
               ROW_入库单明细.单价,
               TO_DATE(TO_CHAR(SYSDATE, 'yyyy-MM-dd'), 'yyyy-MM-dd'),
               ROW_入库单明细.批次,
               ROW_入库单明细.入库单号,
               '否',
               '否',
               ROW_入库单明细.单价,
               (SELECT 折旧类别
                  FROM 设备管理_设备目录
                 WHERE 设备编码 = ROW_入库单明细.设备编码
                   AND 机构编码 = ROW_入库单明细.机构编码),
               (SELECT 计量类别
                  FROM 设备管理_设备目录
                 WHERE 设备编码 = ROW_入库单明细.设备编码
                   AND 机构编码 = ROW_入库单明细.机构编码),
               ROW_入库单明细.购进时新旧情况,
               ROW_入库单明细.理论设计寿命,
               ROW_入库单明细.车载卫星定位系统,
               DATE_更新时间,
               '0');
          
          ELSE
          
            FOR J IN 1 .. TO_NUMBER(ROW_入库单明细.数量) LOOP
            
              PR_设备管理_资产编码(STR_机构编码     => STR_传入_机构编码,
                           STR_设备类型编码 => STR_设备类别,
                           STR_资产编码     => STR_资产编码,
                           I_返回值         => INT_返回值,
                           STR_返回信息     => STR_返回信息);
            
              STR_返回信息 := '新增主设备失败! ';
              INSERT INTO 设备管理_主设备表
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
                 报废标志,
                 净现值,
                 折旧类别,
                 计量类别,
                 购进时新旧情况,
                 理论设计寿命,
                 车载卫星定位系统,
                 更新时间,
                 删除标志)
              VALUES
                (STR_传入_机构编码,
                 STR_资产编码,
                 ROW_入库单明细.设备编码,
                 ROW_入库单明细.生产厂家,
                 ROW_入库单明细.进口标志,
                 ROW_入库单明细.单价,
                 TO_DATE(TO_CHAR(SYSDATE, 'yyyy-MM-dd'), 'yyyy-MM-dd'),
                 ROW_入库单明细.批次,
                 ROW_入库单明细.入库单号,
                 '否',
                 '否',
                 ROW_入库单明细.单价,
                 (SELECT 折旧类别
                    FROM 设备管理_设备目录
                   WHERE 设备编码 = ROW_入库单明细.设备编码
                     AND 机构编码 = ROW_入库单明细.机构编码),
                 (SELECT 计量类别
                    FROM 设备管理_设备目录
                   WHERE 设备编码 = ROW_入库单明细.设备编码
                     AND 机构编码 = ROW_入库单明细.机构编码),
                 ROW_入库单明细.购进时新旧情况,
                 ROW_入库单明细.理论设计寿命,
                 ROW_入库单明细.车载卫星定位系统,
                 DATE_更新时间,
                 '0');
            
            END LOOP;
          END IF;
        END IF;
      END LOOP;
    
      --设备消减
    ELSIF STR_传入_单据类别 = '设备管理_设备消减' THEN
    
      STR_返回信息 := '获取结账单据明细失败! ';
      STR_SQL      := ' select  资产编码 from 设备管理_设备消减 where 机构编码 = ' ||
                      STR_传入_机构编码 || ' and 消减单号 = ' || STR_传入_单据单号;
    
      OPEN CUR_结账单据明细 FOR STR_SQL;
      LOOP
        FETCH CUR_结账单据明细
          INTO STR_资产编码;
        EXIT WHEN CUR_结账单据明细%NOTFOUND;
      
        STR_返回信息 := '查询主设备表失败! ';
        STR_SQL      := 'select 使用部门,设备编码,批次 from 设备管理_主设备表 where 机构编码=:1 and 资产编码=:2';
        EXECUTE IMMEDIATE STR_SQL
          INTO STR_使用部门, STR_设备编码, STR_批次
          USING STR_传入_机构编码, STR_资产编码;
      
        STR_返回信息 := '更新主设备表失败! ';
        UPDATE 设备管理_主设备表 B
           SET B.报废标志 = '是',
               B.报废日期 = DATE_更新时间,
               B.更新时间 = DATE_更新时间
         WHERE B.机构编码 = STR_传入_机构编码
           AND B.资产编码 = STR_资产编码;
      
        STR_返回信息 := '更新库存表失败! ';
        IF NVL(STR_使用部门, '空') = '空' THEN
          UPDATE 设备管理_库存表 D
             SET D.数量     = D.数量 - 1,
                 D.己分配量 = CASE
                            WHEN NVL(STR_使用部门, '空') = '空' THEN
                             D.己分配量
                            ELSE
                             D.己分配量 - 1
                          END,
                 D.更新时间 = DATE_更新时间
           WHERE D.机构编码 = STR_传入_机构编码
             AND D.设备编码 = STR_设备编码
             AND D.批次 = STR_批次;
        END IF;
      
      END LOOP;
    
      --设备增值
    ELSIF STR_传入_单据类别 = '设备管理_设备增值' THEN
    
      STR_返回信息 := '获取结账单据明细失败! ';
      STR_SQL      := ' select 资产编码, 本次增值, 增值后值 from 设备管理_设备增值 where 机构编码 = ' ||
                      STR_传入_机构编码 || ' and 增值号 = ' || STR_传入_单据单号;
      OPEN CUR_结账单据明细 FOR STR_SQL;
      LOOP
        FETCH CUR_结账单据明细
          INTO STR_资产编码, NUM_本次增值, NUM_增值后值;
      
        EXIT WHEN CUR_结账单据明细%NOTFOUND;
      
        STR_返回信息 := '更新主设备表失败 ! ';
        UPDATE 设备管理_主设备表 B
           SET B.增值     = NVL(B.增值, 0) + TO_NUMBER(NUM_本次增值),
               B.净现值   = NUM_增值后值,
               B.更新时间 = DATE_更新时间
         WHERE B.机构编码 = STR_传入_机构编码
           AND B.资产编码 = STR_资产编码;
      
      END LOOP;
    
      --设备调配
    ELSIF STR_传入_单据类别 = '设备管理_设备调配' THEN
    
      STR_返回信息 := '获取结账单据明细失败! '; 
      STR_SQL := 'select 资产编码, 目的科室编码,目的机构编码,放置位置
      from 设备管理_设备调配
     where 机构编码 = ' || STR_传入_机构编码 || '
        and 调配单号 = ' || STR_传入_单据单号;
    
      OPEN CUR_结账单据明细 FOR STR_SQL;
      LOOP
        FETCH CUR_结账单据明细
          INTO STR_资产编码,
               STR_目的科室编码,
               STR_目的机构编码,
               STR_放置位置;
        EXIT WHEN CUR_结账单据明细%NOTFOUND;
      
        STR_返回信息 := '查询主设备表失败 ! ';
        STR_SQL      := 'select 使用部门,设备编码,批次 from 设备管理_主设备表 where 机构编码=:1 and 资产编码=:2';
        EXECUTE IMMEDIATE STR_SQL
          INTO STR_使用部门, STR_设备编码, STR_批次
          USING STR_传入_机构编码, STR_资产编码;
      
        STR_返回信息 := '更新主设备表失败 ! ';
        UPDATE 设备管理_主设备表 B
           SET B.使用部门     = STR_目的科室编码,
               B.启用日期 = CASE
                          WHEN B.启用标志 = '否' THEN
                           TO_DATE(TO_CHAR(SYSDATE, 'yyyy-MM-dd'),
                                   'yyyy-MM-dd')
                          ELSE
                           B.启用日期
                        END,
               B.启用标志     = '是',
               B.放置位置     = STR_放置位置,
               B.放置机构编码 = STR_目的机构编码,
               B.更新时间     = DATE_更新时间
         WHERE B.机构编码 = STR_传入_机构编码
           AND B.资产编码 = STR_资产编码;
      
        STR_返回信息 := ' 更新库存表失败 ! ';
        IF NVL(STR_使用部门, '空') = '空' THEN
          UPDATE 设备管理_库存表 D
             SET D.己分配量 = D.己分配量 + 1, D.更新时间 = DATE_更新时间
           WHERE D.机构编码 = STR_传入_机构编码
             AND D.设备编码 = STR_设备编码
             AND D.批次 = STR_批次;
        END IF;
      END LOOP;
    
      --配件出库
    ELSIF STR_传入_单据类别 = '设备管理_配件出库单明细' THEN
    
      STR_返回信息 := '获取结账单据明细失败! ';
      STR_SQL      := 'select 设备编码,数量
      from 设备管理_配件出库单明细
     where 机构编码 =' || STR_传入_机构编码 || ' and 出库单号 =' ||
                      STR_传入_单据单号;
    
      OPEN CUR_结账单据明细 FOR STR_SQL;
      LOOP
        FETCH CUR_结账单据明细
          INTO STR_设备编码, NUM_数量;
        EXIT WHEN CUR_结账单据明细%NOTFOUND;
      
        STR_返回信息 := '查询库存数量失败 ! ';
        STR_SQL      := 'select count(1)  from 设备管理_库存表 where 数量>=己分配量+Num_数量 机构编码=:1 and 设备编码=:2';
        EXECUTE IMMEDIATE STR_SQL
          INTO NUM_记录条数
          USING STR_传入_机构编码, STR_设备编码;
      
        IF NUM_记录条数 = 0 THEN
          STR_返回信息 := '库存数量不足!';
          GOTO 退出;
        END IF;
      
        STR_返回信息 := '更新库存表失败! ';
        UPDATE 设备管理_库存表 D
           SET D.己分配量 = D.己分配量 + NUM_数量,
               D.更新时间 = DATE_更新时间
         WHERE D.机构编码 = STR_传入_机构编码
           AND D.设备编码 = STR_设备编码;
      END LOOP;
      --附件领用及耗用
    ELSIF STR_传入_单据类别 = '设备管理_附件领用耗用' THEN
    
      STR_返回信息 := '获取结账单据明细失败! ';
      STR_SQL      := 'select 资产编码,附件编码,单据类型,使用数量,批次,附件记录单号
      from 设备管理_附件领用耗用
     where 机构编码 =' || STR_传入_机构编码 || ' and 单据编码 =' ||
                      STR_传入_单据单号;
      OPEN CUR_结账单据明细 FOR STR_SQL;
      LOOP
        FETCH CUR_结账单据明细
          INTO STR_资产编码,
               STR_设备编码,
               STR_单据类型,
               NUM_数量,
               STR_批次,
               STR_记录单号;
        EXIT WHEN CUR_结账单据明细%NOTFOUND;
      
        ----领用单据
        IF STR_单据类型 = '附件领用' THEN
          STR_返回信息 := '查询库存数量失败 ! ';
          STR_SQL      := 'select count(1)  from 设备管理_库存表 where 数量>=己分配量+' ||
                          TO_NUMBER(NUM_数量) || ' and 机构编码=' || STR_传入_机构编码 ||
                          ' and 设备编码=' || STR_设备编码;
          EXECUTE IMMEDIATE STR_SQL
            INTO NUM_记录条数;
        
          IF NUM_记录条数 = 0 THEN
            STR_返回信息 := '库存数量不足!';
            GOTO 退出;
          END IF;
        
          STR_返回信息 := '更新库存数量失败 ! ';
          UPDATE 设备管理_库存表 A
             SET A.己分配量 = A.己分配量 + NUM_数量,
                 A.更新时间 = DATE_更新时间
           WHERE 机构编码 = STR_传入_机构编码
             AND 设备编码 = STR_设备编码
             AND 批次 = STR_批次;
        
          STR_返回信息 := '获取记录条数失败! ';
          STR_SQL      := 'select count(1)
                        from 设备管理_主设备附件表
                       where 机构编码=:1 and 资产编码=:2 and 附件编码=:3 and 批次=:4';
        
          EXECUTE IMMEDIATE STR_SQL
            INTO NUM_记录条数
            USING STR_传入_机构编码, STR_资产编码, STR_设备编码, STR_批次;
        
          ----主设备附件表中不存在该附件记录  则添加
          IF NUM_记录条数 = 0 THEN
            STR_返回信息 := '获取记录单号失败! ';
            SELECT NVL(MAX(TO_NUMBER(记录单号)), 0) + 1
              INTO STR_记录单号
              FROM 设备管理_主设备附件表;
          
            STR_返回信息 := '插入主设备附件表失败! ';
            INSERT INTO 设备管理_主设备附件表
              (机构编码,
               资产编码,
               附件编码,
               记录单号,
               名称,
               品牌型号,
               规格,
               产地,
               生产厂家,
               数量,
               批次,
               随机附件,
               备注)
              SELECT STR_传入_机构编码,
                     STR_资产编码,
                     STR_设备编码,
                     STR_记录单号,
                     B.名称,
                     B.品牌型号,
                     B.规格,
                     '',
                     '',
                     A.使用数量,
                     A.批次,
                     '否',
                     ''
                FROM 设备管理_附件领用耗用 A, 设备管理_设备目录 B
               WHERE A.机构编码 = B.机构编码
                 AND A.附件编码 = B.设备编码
                 AND A.机构编码 = STR_传入_机构编码
                 AND A.单据编码 = STR_传入_单据单号
                 AND A.资产编码 = STR_资产编码
                 AND A.附件编码 = STR_设备编码;
          
          ELSE
            ----主设备附件表中存在该附件记录  则修改数量
            STR_返回信息 := '更新主设备附件表失败! ';
            UPDATE 设备管理_主设备附件表 A
               SET A.数量 = A.数量 + NUM_数量
             WHERE A.机构编码 = STR_传入_机构编码
               AND A.资产编码 = STR_资产编码
               AND A.附件编码 = STR_设备编码
               AND A.批次 = STR_批次;
          
          END IF;
        
        ELSE
          ----耗用单据
        
          STR_返回信息 := '查询主设备附件表失败 ! ';
          STR_SQL      := 'select count(1) from 设备管理_主设备附件表 where 数量-Num_数量>=0 机构编码=:1 and 设备编码=:2';
          EXECUTE IMMEDIATE STR_SQL
            INTO NUM_记录条数
            USING STR_传入_机构编码, STR_设备编码;
        
          IF NUM_记录条数 = 0 THEN
            STR_返回信息 := '库存数量不足!';
            GOTO 退出;
          END IF;
        
          NUM_数量     := 0 - NUM_数量;
          STR_返回信息 := '插更新库存表失败! ';
          UPDATE 设备管理_库存表 A
             SET A.数量     = A.数量 + NUM_数量,
                 A.己分配量 = A.己分配量 + NUM_数量,
                 A.更新时间 = DATE_更新时间
           WHERE 机构编码 = STR_传入_机构编码
             AND 设备编码 = STR_设备编码
             AND 批次 = STR_批次;
        
          STR_返回信息 := '更新主设备附件表失败! ';
          UPDATE 设备管理_主设备附件表 A
             SET A.数量 = A.数量 + NUM_数量
           WHERE A.机构编码 = STR_传入_机构编码
             AND A.资产编码 = STR_资产编码
             AND A.附件编码 = STR_设备编码
             AND A.批次 = STR_批次
             AND A.记录单号 = STR_记录单号;
        
        END IF;
      
      END LOOP;
    
      --设备归还
    ELSIF STR_传入_单据类别 = '设备管理_设备归还' THEN
    
      STR_返回信息 := '获取结账单据明细失败! ';
      STR_SQL      := 'select 资产编码
      from 设备管理_设备归还
     where 机构编码 =' || STR_传入_机构编码 || ' and 归还单号 =' ||
                      STR_传入_单据单号;
      OPEN CUR_结账单据明细 FOR STR_SQL;
      LOOP
        FETCH CUR_结账单据明细
          INTO STR_资产编码;
        EXIT WHEN CUR_结账单据明细%NOTFOUND;
      
        STR_返回信息 := '查询主设备表失败! ';
        STR_SQL      := 'select 设备编码,批次,启用标志 from 设备管理_主设备表 where 机构编码=:1 and 资产编码=:2';
        EXECUTE IMMEDIATE STR_SQL
          INTO STR_设备编码, STR_批次, STR_启用标志
          USING STR_传入_机构编码, STR_资产编码;
      
        IF STR_启用标志 = '否' THEN
          STR_返回信息 := '该设备已经被归还!';
          GOTO 退出;
        END IF;
      
        STR_返回信息 := '更新主设备表失败! ';
        UPDATE 设备管理_主设备表 B
           SET B.使用部门     = '',
               B.启用标志     = '否',
               B.放置位置     = '',
               B.放置机构编码 = '',
               B.更新时间     = DATE_更新时间
         WHERE B.机构编码 = STR_传入_机构编码
           AND B.资产编码 = STR_资产编码;
      
        STR_返回信息 := '更新库存表失败! ';
        UPDATE 设备管理_库存表 D
           SET D.己分配量 = D.己分配量 - 1, D.更新时间 = DATE_更新时间
         WHERE D.机构编码 = STR_传入_机构编码
           AND D.设备编码 = STR_设备编码
           AND D.批次 = STR_批次;
      END LOOP;
      --设备折旧变更
    ELSIF STR_传入_单据类别 = '设备管理_设备折旧变更' THEN
      STR_返回信息 := '获取结账单据明细失败! ';
      STR_SQL      := 'select 资产编码,变更后折旧类型编码
      from 设备管理_设备折旧变更
     where 机构编码 =' || STR_传入_机构编码 || ' and 折旧单号 =' ||
                      STR_传入_单据单号;
      OPEN CUR_结账单据明细 FOR STR_SQL;
      LOOP
        FETCH CUR_结账单据明细
          INTO STR_资产编码, STR_变更后折旧类型编码;
        EXIT WHEN CUR_结账单据明细%NOTFOUND;
      
        STR_返回信息 := '更新主设备表失败! ';
        UPDATE 设备管理_主设备表 B
           SET B.折旧类别 = STR_变更后折旧类型编码,
               B.更新时间 = DATE_更新时间
         WHERE B.机构编码 = STR_传入_机构编码
           AND B.资产编码 = STR_资产编码;
      
      END LOOP;
    
      --设备退库
    ELSIF STR_传入_单据类别 = '设备管理_退库单' THEN
      STR_返回信息 := '获取结账单据明细失败! ';
      STR_SQL      := 'select 资产编码,设备编码,数量
      from 设备管理_退库单明细
     where 机构编码 =' || STR_传入_机构编码 || ' and 退库单号 =' ||
                      STR_传入_单据单号;
      OPEN CUR_结账单据明细 FOR STR_SQL;
      LOOP
        FETCH CUR_结账单据明细
          INTO STR_资产编码, STR_设备编码, NUM_数量;
        EXIT WHEN CUR_结账单据明细%NOTFOUND;
        IF NVL(STR_资产编码, '空') <> '空' THEN
          STR_返回信息 := '更新主设备表失败! ';
          UPDATE 设备管理_主设备表
             SET 删除标志 = '1', 更新时间 = DATE_更新时间
           WHERE 机构编码 = STR_传入_机构编码
             AND 资产编码 = STR_资产编码;
        ELSE
          STR_返回信息 := '更新库存表失败! ';
          UPDATE 设备管理_库存表
             SET 数量 = 数量 - NUM_数量, 更新时间 = DATE_更新时间
           WHERE 机构编码 = STR_传入_机构编码
             AND 设备编码 = STR_设备编码;
        END IF;
      END LOOP;
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      GOTO 退出;
  END;

  IF CUR_结账单据明细%ISOPEN THEN
    CLOSE CUR_结账单据明细;
  END IF;
  INT_返回值   := 1;
  STR_返回信息 := 'OK';
  COMMIT;
  RETURN;

  <<退出>>
  IF CUR_结账单据明细%ISOPEN THEN
    CLOSE CUR_结账单据明细;
  END IF;
  INT_返回值 := 0;
  IF SQLCODE = 0 THEN
    STR_返回信息 := STR_返回信息;
  ELSE
    STR_返回信息 := STR_返回信息 || SQLERRM;
  END IF;

  ROLLBACK;
  RETURN;

END PR_设备管理_单据结账;
/
