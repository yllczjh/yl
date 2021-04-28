using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.OracleClient;

namespace Cloud.Db
{
    public interface IDbHelper
    {
        #region Insert
        /// <summary>
        /// 执行插入语句,并返回影响的行数
        /// </summary>
        /// <param name="command">Sql语句</param>
        /// <returns></returns>
        int Insert(string command);

        /// <summary>
        /// 带参数SQL 执行插入语句,并返回影响的行数
        /// </summary>
        /// <param name="command">Sql语句</param>
        /// <returns></returns>
        int Insert(string command, Db_Common.InParameter[] InparameterValues);

        /// <summary>
        /// 带参数SQL 执行插入语句,并返回影响的行数
        /// </summary>
        /// <param name="command">Sql语句</param>
        /// <returns></returns>
        int Insert(string command, OracleParameter[] InparameterValues);

        /// <summary>
        /// 执行插入语句,并返回影响的行数
        /// </summary>
        /// <param name="Key">机构对应的Key</param>
        /// <param name="command">Sql语句</param>
        /// <returns></returns>
        int Insert(String Key, string command);

        int InsertBatch(string InsertSql, string StrVal);
        void InsertBatch(string[] BatchSql, Dictionary<string, Db_Common.InParameter[]> Dic_InParam);
        #endregion

        #region Update
        /// <summary>
        /// 保存数据(注:一次只保存一张表)
        /// </summary>
        /// <param name="ds">数据集</param>
        /// <param name="tablename">更新的表名</param>
        /// <param name="selectcommand">用于生成insert,update,delete的select语句</param>
        void Update(DataSet ds, string tablename, string selectcommand);

        /// <summary>
        /// 保存数据(注:一次只保存一张表)
        /// </summary>
        /// <param name="Key">机构对应的Key</param>
        /// <param name="ds">数据集</param>
        /// <param name="tablename">更新的表名</param>
        /// <param name="selectcommand">用于生成insert,update,delete的select语句</param>
        void Update(string Key, DataSet ds, string tablename, string selectcommand);

        /// <summary>
        /// 保存数据(注:一次保存多张表)
        /// </summary>
        /// <param name="ds">数据集</param>
        /// <param name="UpdateItems">更新项的集合</param>
        void Update(DataSet ds, params Db_Common.UpdateItem[] UpdateItems);

        /// <summary>
        /// 保存数据(注:一次保存多张表)
        /// </summary>
        /// <param name="Key">机构对应的Key</param>
        /// <param name="ds">数据集</param>
        /// <param name="UpdateItems">更新项的集合</param>
        void Update(String Key, DataSet ds, params Db_Common.UpdateItem[] UpdateItems);

        /// <summary>
        /// 执行修改语句,并返回影响的行数
        /// </summary>
        /// <param name="command">Sql语句</param>
        /// <returns></returns>
        int Update(string command);

        /// <summary>
        /// 带参数SQL 执行修改语句,并返回影响的行数
        /// </summary>
        /// <param name="command">Sql语句</param>
        /// <returns></returns>
        int Update(string command, Db_Common.InParameter[] InparameterValues);

        /// <summary>
        /// 执行修改语句,并返回影响的行数
        /// </summary>
        /// <param name="Key">机构对应的Key</param>
        /// <param name="command">Sql语句</param>
        /// <returns></returns>
        int Update(String Key, string command);

        int UpdateBatch(string UpdateSql, string StrVal);

        void UpdateBatch(string[] BatchSql, Dictionary<string, Db_Common.InParameter[]> Dic_InParam);
        #endregion

        #region Delete
        /// <summary>
        /// 执行删除语句,并返回影响的行数
        /// </summary>
        /// <param name="command">Sql语句</param>
        /// <returns></returns>
        int Delete(string command);

        /// <summary>
        /// 带参数SQL 执行删除语句,并返回影响的行数
        /// </summary>
        /// <param name="command">Sql语句</param>
        /// <returns></returns>
        int Delete(string command, Db_Common.InParameter[] InparameterValues);

        /// <summary>
        /// 执行删除语句,并返回影响的行数
        /// </summary>
        /// <param name="Key">机构对应的Key</param>
        /// <param name="command">Sql语句</param>
        /// <returns></returns>
        int Delete(String Key, string command);
        #endregion

        #region ExecuteBatch 批量执行Sql语句
        /// <summary>
        /// 批量执行Sql语句
        /// </summary>
        /// <param name="BatchSql">Sql语句数组</param>
        void ExecuteBatch(string[] BatchSql);

        /// <summary>
        /// 批量执行Sql语句
        /// </summary>
        /// <param name="Key">机构对应的Key</param>
        /// <param name="BatchSql">Sql语句数组</param>
        void ExecuteBatch(String Key, string[] BatchSql);

        /// <summary>
        /// 批量执行Sql语句
        /// </summary>
        /// <param name="BatchSql">Sql语句</param>
        /// <param name="Dic_InParam">参数泛型Dictionary Key格式：sql对应序号-行号</param>
        void ExecuteBatch(string[] BatchSql, Dictionary<string, Db_Common.InParameter[]> Dic_InParam);

        /// <summary>
        /// 批量执行Sql语句
        /// </summary>
        /// <param name="BatchSql">Sql语句数组</param>
        /// <param name="BatchSql">参数值数组</param>
        void ExecuteBatch(string[] BatchSql, string[] BatchVal);

        #endregion

        #region Load方法
        /// <summary>
        /// 根据Sql语句或存储过程向数据集添加DataTable
        /// </summary>
        /// <param name="CType">类型</param>
        /// <param name="ds">数据集</param>
        /// <param name="command">命令字符串</param>
        /// <param name="TableName">表名</param>
        void Load(CommandType CType, DataSet ds, string command, string TableName);

        /// <summary>
        /// 根据Sql语句或存储过程向数据集添加DataTable
        /// </summary>
        /// <param name="CType">类型</param>
        /// <param name="ds">数据集</param>
        /// <param name="command">命令字符串</param>
        /// <param name="TableName">表名</param>
        void Load(CommandType CType, Db_Common.InParameter[] InparameterValues, DataSet ds, string command, string TableName);

        /// <summary>
        /// 根据Sql语句或存储过程向数据集添加DataTable
        /// </summary>
        /// <param name="Key">机构对应的Key</param>
        /// <param name="CType">类型</param>
        /// <param name="ds">数据集</param>
        /// <param name="command">命令字符串</param>
        /// <param name="TableName">表名</param>
        void Load(String Key, CommandType CType, DataSet ds, string command, string TableName);
        #endregion

        #region QueryValues
        /// <summary>
        /// SQL语句查询指定字段值,返回到查询结果值通用结构体中
        /// </summary>
        /// <param name="selectcommand">查询Sql语句</param>
        /// <returns></returns>
        Db_Common.rtnvalues QueryValues(string selectcommand);

        /// <summary>
        /// SQL语句查询指定字段值,返回到查询结果值通用结构体中
        /// </summary>
        /// <param name="Key">机构对应的Key</param>
        /// <param name="selectcommand">查询Sql语句</param>
        /// <returns></returns>
        Db_Common.rtnvalues QueryValues(String Key, string selectcommand);

        /// <summary>
        /// 带参数SQL  SQL语句查询指定字段值,返回到查询结果值通用结构体中
        /// </summary>
        /// <param name="selectcommand">查询Sql语句</param>
        /// <returns></returns>
        Db_Common.rtnvalues QueryValues(string selectcommand, Db_Common.InParameter[] InparameterValues);

        /// <summary>
        /// 存储过程查询值,返回到查询结果值通用结构体中
        /// </summary>
        /// <param name="StoredProcedureName">存储过程名称</param>
        /// <param name="InparameterValues">存储过程入口参数</param>
        /// <param name="OutparameterValues">存储过程出口参数</param>
        /// <returns></returns>
        Db_Common.rtnvalues QueryValues(string StoredProcedureName, Db_Common.InParameter[] InparameterValues, Db_Common.OutParameter[] OutparameterValues);

        /// <summary>
        /// 存储过程查询值,返回到查询结果值通用结构体中
        /// </summary>
        /// <param name="Key">机构对应的Key</param>
        /// <param name="StoredProcedureName">存储过程名称</param>
        /// <param name="InparameterValues">存储过程入口参数</param>
        /// <param name="OutparameterValues">存储过程出口参数</param>
        /// <returns></returns>
        Db_Common.rtnvalues QueryValues(String Key, string StoredProcedureName, Db_Common.InParameter[] InparameterValues, Db_Common.OutParameter[] OutparameterValues);

        /// <summary>
        /// 带参数SQL  SQL语句查询指定字段值,返回到object中
        /// </summary>
        /// <param name="selectcommand">查询Sql语句</param>
        /// <returns></returns>
        object QueryObject(string selectcommand, Db_Common.InParameter[] InparameterValues);
        #endregion

        #region Retrieve
        /// <summary>
        /// 执行Sql语句或执行不带参数的存储过程返回数据集
        /// </summary>
        /// <param name="CType">执行类型</param>
        /// <param name="command">执行语句</param>
        /// <returns></returns>
        DataSet Retrieve(CommandType CType, string command, string TableName);

        /// <summary>
        /// 执行Sql语句返回数据集
        /// </summary>
        /// <param name="command"></param>
        /// <param name="TableName"></param>
        /// <returns></returns>
        DataSet Retrieve(CommandType CType, string command, Db_Common.InParameter[] InparameterValues, string TableName);

        /// <summary>
        /// 根据存储过程返回数据集-执行带参数的存储过程
        /// </summary>
        /// <param name="StoredProcedureName">存储过程名称</param>
        /// <param name="InparameterValues">存储过程入口参数</param>
        /// <returns></returns>
        DataSet Retrieve(string StoredProcedureName, Db_Common.InParameter[] InparameterValues, string TableName);

        /// <summary>
        /// 执行Sql语句或执行不带参数的存储过程返回数据集
        /// </summary>
        /// <param name="Key">机构对应的Key</param>
        /// <param name="CType">执行类型</param>
        /// <param name="command">执行语句</param>
        /// <returns></returns>
        DataSet Retrieve(String Key, CommandType CType, string command, string TableName);

        /// <summary>
        /// 根据存储过程返回数据集-执行带参数的存储过程
        /// </summary>
        /// <param name="Key">机构对应的Key</param>
        /// <param name="StoredProcedureName">存储过程名称</param>
        /// <param name="InparameterValues">存储过程入口参数</param>
        /// <returns></returns>
        DataSet Retrieve(String Key, string StoredProcedureName, Db_Common.InParameter[] InparameterValues, string TableName);


        /// <summary>
        /// 执行Sql语句  Oracle特用,SQL Server暂不需用
        /// </summary>
        /// <param name="CType"></param>
        /// <param name="command"></param>
        /// <param name="TableName"></param>
        /// <param name="Organization"></param>
        /// <returns></returns>
        DataSet Retrieve(CommandType CType, string command, string TableName, string Organization);

        /// <summary>
        /// 执行Sql语句  Oracle特用,SQL Server暂不需用
        /// </summary>
        /// <param name="key"></param>
        /// <param name="CType"></param>
        /// <param name="command"></param>
        /// <param name="TableName"></param>
        /// <param name="Organization"></param>
        /// <returns></returns>
        DataSet Retrieve(string key, CommandType CType, string command, string TableName, string Organization);
        /// <summary>
        /// 取单个值
        /// </summary>
        /// <param name="safeSql">执行sql</param>
        /// <returns>返回值</returns>
        int GetScalar(string safeSql);
        /// <summary>
        /// 执行Sql语句  Oracle特用,SQL Server暂不需用
        /// </summary>
        /// <param name="CType"></param>
        /// <param name="command"></param>
        /// <param name="InparameterValues"></param>
        /// <param name="TableName"></param>
        /// <param name="Organization"></param>
        /// <returns></returns>
        DataSet Retrieve(CommandType CType, string command, Db_Common.InParameter[] InparameterValues, string TableName, string Organization);
        #endregion

        #region  执行存储过程

        /// <summary>
        /// 执行带参数的存储过程
        /// </summary>
        /// <param name="StoredProcedureName">存储过程名</param>
        /// <param name="parameters">参数</param>
        void RunProcedure(string StoredProcedureName, Db_Common.InParameter[] InparameterValues);

        /// <summary>
        /// 存储过程返回结果集
        /// </summary>
        /// <param name="StoredProcedureName">存储过程名称</param>
        /// <param name="parameters">参数</param>
        /// <param name="tableName">表名</param>
        /// <returns>结果集</returns>
        DataSet RunProcedure(string StoredProcedureName, Db_Common.InParameter[] InparameterValues, string tableName);

        /// <summary>
        /// 执行带参数的存储过程
        /// </summary>
        /// <param name="StoredProcedureName">存储过程名</param>
        /// <param name="parameters">参数</param>
        void RunProcedure(string StoredProcedureName, OracleParameter[] parameters);

        DataSet RunProcedure(string StoredProcedureName, OracleParameter[] parameters, string tableName);
        #endregion
        #region 更改序号，用于排序
        /// <summary>
        /// 更改序号,上移,序号由大变小,也即跟比它大一点的进行交换
        /// </summary>
        /// <param name="sTableName"></param>
        /// <param name="ID"></param>
        /// <param name="sWhere"></param>
        Db_Common.rtnvalues ChangeSortUp(string sTableName, string s_主键字段, string s_主键字段值, string s_排序字段, string sWhere);
        /// <summary>
        /// 更改序号,下移,序号由小变大,也即跟比它小一点的进行交换
        /// </summary>
        /// <param name="sTableName"></param>
        /// <param name="ID"></param>
        /// <param name="sWhere"></param>
        Db_Common.rtnvalues ChangeSortDown(string sTableName, string s_主键字段, string s_主键字段值, string s_排序字段, string sWhere);
        #endregion
        
        #region 取得唯一号

        Db_Common.rtnvalues M_取得_唯一号(string str_唯一号编码, string str_机构编码, string str_事务类型);
        #endregion
        void ExecuteBatch_Tran(string[] BatchSql, Dictionary<string, Db_Common.InParameter[]> Dic_InParam, bool IsNull);

        #region 多个过程共用同一事务

        /// <summary>
        /// 开始事务
        /// </summary>
        void BeginTrans();
        
        /// <summary>
        /// 执行提交事务
        /// </summary>
        void CommintTrans();
        
        /// <summary>
        /// 回滚事务
        /// </summary>
        void RollbackTrans();
        
        /// <summary>
        /// 插入一条记录
        /// </summary>
        /// <param name="command"></param>
        /// <param name="InparameterValues"></param>
        /// <returns></returns>
        int Insert_Tran(string command, Db_Common.InParameter[] InparameterValues);
        
        /// <summary>
        /// 批量执行Sql语句
        /// </summary>
        /// <param name="BatchSql">Sql语句数组</param>
        void ExecuteBatch_Tran(string[] BatchSql);
        
        /// <summary>
        /// 批量执行Sql语句
        /// </summary>
        /// <param name="BatchSql">批量SQL</param>
        /// <param name="BatchVal">批量值字符串(格式:列名1,列名2##列名1值~列名1值~|) DataTableToStr或ListToStr可以生成</param>
        /// <returns></returns>
        void ExecuteBatch_Tran(string[] BatchSql, string[] BatchVal);
        
        /// <summary>
        /// 批量执行Sql语句
        /// </summary>
        /// <param name="BatchSql">Sql语句</param>
        /// <param name="Dic_InParam">参数泛型Dictionary Key格式：sql对应序号-行号</param>
        void ExecuteBatch_Tran(string[] BatchSql, Dictionary<string, Db_Common.InParameter[]> Dic_InParam);

        /// <summary>
        /// 执行带参数的存储过程
        /// </summary>
        /// <param name="StoredProcedureName">存储过程名</param>
        /// <param name="parameters">参数</param>
        void RunProcedure_Tran(string StoredProcedureName, OracleParameter[] parameters);
        
        /// <summary>
        /// 保存图片
        /// </summary>
        /// <param name="str_Sql">SQL语句</param>
        /// <param name="str_PhotoCoumn">图片字段</param>
        /// <param name="imgByte"></param>
        void SavePhoto_Tran(string str_Sql, string str_PhotoCoumn, Byte[] imgByte);
        #endregion

        bool getConn(string conn);
    }
}