using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Configuration;
using System.Reflection;
using System.Diagnostics;
using System.Collections;

namespace WebAPI
{
    /// <summary>
    /// 数据库名称枚举
    /// </summary>
    public enum DbProviderName
    {
        /// <summary>
        /// sqlserver(System.Data.SqlClient)
        /// </summary>
        SqlClient,

        /// <summary>
        /// access(System.Data.OleDb)
        /// </summary>
        OleDb,

        /// <summary>
        /// mysql(MySql.Data.MySqlClient)
        /// </summary>
        MySqlClient,

        /// <summary>
        /// Oracle(System.Data.OracleClient)
        /// </summary>
        OracleClient,

        /// <summary>
        /// Oracle(Oracle.DataAccess.Client)
        /// </summary>
        Oracle
    }
    /// <summary>
    /// 数据库连接配置信息
    /// </summary>
    public static class DbConfig
    {
        private readonly static string _ConnectionString;
        private readonly static string _ProviderName;

        static DbConfig()
        {
            _ConnectionString = ConfigurationManager.ConnectionStrings["connectString"].ConnectionString;
            _ProviderName = ConfigurationManager.ConnectionStrings["connectString"].ProviderName;
        }

        /// <summary>
        /// 连接字符串
        /// </summary>
        public static string ConnectionString
        {
            get { return _ConnectionString; }
        }

        /// <summary>
        /// 数据提供程序的名称
        /// </summary>
        public static string ProviderName
        {
            get { return _ProviderName; }
        }
    }
    /// <summary>
    /// 数据库操作助手
    /// </summary>
    public sealed class DbHelper
    {
        /// <summary>
        /// 连接字符串
        /// </summary>
        public string ConnectionString { get; set; }

        /// <summary>
        /// 数据提供程序的名称
        /// </summary>
        public string ProviderName { get; set; }

        /// <summary>
        /// 数据提供程序的对象
        /// </summary>
        public static DbProviderFactory Factory = DbProviderFactories.GetFactory(DbConfig.ProviderName);

        /// <summary>
        /// 是否开启事务
        /// </summary>
        public bool IsBeginTransaction { get; set; }

        /// <summary>
        /// 事务对象
        /// </summary>
        public DbTransaction Transaction { get; set; }

        /// <summary>
        /// 数据库连接对象
        /// </summary>
        public DbConnection Con { get; set; }

        /// <summary>
        /// 命令对象
        /// </summary>
        public DbCommand Cmd { get; set; }

        /// <summary>
        /// 默认构造
        /// </summary>
        public DbHelper()
        {
            ConnectionString = DbConfig.ConnectionString;
            ProviderName = DbConfig.ProviderName;
            CreateFactory();
        }
        private static DbHelper _db = new DbHelper();
        /// <summary>
        /// 默认构造创建DbHelper实例
        /// </summary>
        public static DbHelper Db
        {
            get
            {
                if (_db == null) return new DbHelper();
                return _db;
            }
        }

        /// <summary>
        /// 创建数据提供程序的实例
        /// </summary>
        private void CreateFactory()
        {
            //if(Factory==null)Factory = DbProviderFactories.GetFactory(ProviderName);
        }

        /// <summary>
        /// 开始事务,配合CommitTransaction方法使用
        /// </summary>
        public void BeginTransaction()
        {
            try
            {
                Con = Factory.CreateConnection();
                Con.ConnectionString = ConnectionString;
                if (Con.State == ConnectionState.Closed)
                {
                    Con.Open();
                }
                Transaction = Con.BeginTransaction();
                Cmd = Con.CreateCommand();
                Cmd.Transaction = Transaction;
                IsBeginTransaction = true;
            }
            catch
            {
                IsBeginTransaction = false;
                if (Con.State == ConnectionState.Open)
                {
                    Cmd.Dispose();
                    Transaction.Dispose();
                    Con.Close();
                }
                throw;
            }
        }

        /// <summary>
        /// 提交事务
        /// </summary>
        public void CommitTransaction()
        {
            try
            {
                if (IsBeginTransaction && Transaction != null)
                {
                    Transaction.Commit();
                }
            }
            catch
            {
                try
                {
                    Transaction.Rollback();
                    throw;
                }
                catch
                {
                    throw;
                }
            }
            finally
            {
                IsBeginTransaction = false;
                if (Con.State == ConnectionState.Open)
                {
                    Cmd.Dispose();
                    Transaction.Dispose();
                    Con.Close();
                }
            }
        }

        /// <summary>
        /// 回滚事务
        /// </summary>
        public void RollbackTransaction()
        {
            if (IsBeginTransaction)
            {
                Transaction.Rollback();
            }
            IsBeginTransaction = false;
            if (Con.State == ConnectionState.Open)
            {
                Cmd.Dispose();
                Transaction.Dispose();
                Con.Close();
            }
        }

        /// <summary>
        /// 清除参数
        /// </summary>
        public void ClearParameters()
        {
            Cmd.Parameters.Clear();
        }

        /// <summary>
        /// 获得数据提供程序的名称
        /// </summary>
        /// <param name="provider">数据提名称枚举</param>
        /// <returns></returns>
        private string GetProviderName(DbProviderName provider)
        {
            switch (provider)
            {
                case DbProviderName.SqlClient:
                    return "System.Data.SqlClient";
                case DbProviderName.OleDb:
                    return "System.Data.OleDb";
                case DbProviderName.MySqlClient:
                    return "MySql.Data.MySqlClient";
                case DbProviderName.OracleClient:
                    return "System.Data.OracleClient";
                case DbProviderName.Oracle:
                    return "Oracle.DataAccess.Client";
                default:
                    return null;
            }
        }

        /// <summary>
        /// 执行非查询
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="CommandType">执行类型</param>
        /// <param name="param">参数</param>
        /// <returns></returns>
        public int ExecuteNonQuery(string sql, CommandType CommandType, params DbParameter[] param)
        {
            if (IsBeginTransaction)
            {
                try
                {
                    Cmd.CommandType = CommandType;
                    Cmd.CommandText = sql;
                    Cmd.Parameters.Clear();
                    Cmd.Parameters.AddRange(param);
                    return Cmd.ExecuteNonQuery();
                }
                catch
                {
                    try
                    {
                        RollbackTransaction();
                        throw;
                    }
                    catch
                    {
                        throw;
                    }
                }
            }
            else
            {
                using (Con = Factory.CreateConnection())
                {
                    using (Cmd = Con.CreateCommand())
                    {
                        try
                        {
                            Con.ConnectionString = ConnectionString;
                            Cmd.CommandType = CommandType;
                            Cmd.CommandText = sql;
                            Cmd.Parameters.AddRange(param);
                            Con.Open();
                            return Cmd.ExecuteNonQuery();
                        }
                        catch (Exception ex)
                        {
                            Con.Close();
                            throw ex;
                            // return -1;
                        }
                    }
                }
            }
        }
        /// <summary>
        /// 执行非查询
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="param">参数</param>
        /// <returns></returns>
        public int Execute(string sql, params DbParameter[] param)
        {
            return ExecuteNonQuery(sql, CommandType.Text, param);
        }

        /// <summary>
        /// 执行非查询(SGL)
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="CommandType">执行类型</param>
        /// <param name="param">参数</param>
        /// <returns></returns>
        public int ExecuteNonQuery(string sql, CommandType CommandType, Dictionary<string, object> param)
        {
            Console.WriteLine(sql + ";--dbhelper2");
            if (IsBeginTransaction)
            {
                try
                {
                    Cmd.CommandType = CommandType;
                    Cmd.CommandText = sql;
                    Cmd.Parameters.Clear();
                    CreateAndSetCommandParameters(param);
                    MethodInfo method = (MethodInfo)(new StackTrace().GetFrame(1).GetMethod());
                    return Cmd.ExecuteNonQuery();
                }
                catch
                {
                    try
                    {
                        RollbackTransaction();
                        MethodInfo method = (MethodInfo)(new StackTrace().GetFrame(1).GetMethod());
                        throw;
                    }
                    catch
                    {
                        MethodInfo method = (MethodInfo)(new StackTrace().GetFrame(1).GetMethod());
                        throw;
                    }
                }
            }
            else
            {
                using (Con = Factory.CreateConnection())
                {
                    using (Cmd = Con.CreateCommand())
                    {
                        try
                        {
                            Con.ConnectionString = ConnectionString;
                            Cmd.CommandType = CommandType;
                            Cmd.CommandText = sql;
                            CreateAndSetCommandParameters(param);
                            Con.Open();
                            MethodInfo method = (MethodInfo)(new StackTrace().GetFrame(1).GetMethod());
                            return Cmd.ExecuteNonQuery();
                        }
                        catch
                        {
                            Con.Close();
                            MethodInfo method = (MethodInfo)(new StackTrace().GetFrame(1).GetMethod());
                            throw;
                        }
                    }
                }
            }
        }
        /// <summary>
        /// 组合参数(SGL)
        /// </summary>
        /// <param name="paraList"></param>
        private void CreateAndSetCommandParameters(IDictionary<string, object> paraList)
        {
            Cmd.Parameters.Clear();
            if (paraList == null) return;
            foreach (string key in paraList.Keys)
            {
                object value = paraList[key];
                if (value is string && string.IsNullOrEmpty(value as string))
                {
                    value = DBNull.Value;
                }
                if (value == null)
                {
                    value = DBNull.Value;
                }
                DbParameter p = Cmd.CreateParameter();
                p.ParameterName = key;
                p.Value = value;
                Cmd.Parameters.Add(p);
            }
        }

        /// <summary>
        /// 执行非查询
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="param">参数</param>
        /// <returns></returns>
        public int ExecuteNonQuery(string sql, params DbParameter[] param)
        {
            Console.WriteLine(sql + ";--dbhelper3");
            try
            {
                MethodInfo method = (MethodInfo)(new StackTrace().GetFrame(1).GetMethod());
                return ExecuteNonQuery(sql, CommandType.Text, param);
            }
            catch
            {
                MethodInfo method = (MethodInfo)(new StackTrace().GetFrame(1).GetMethod());
                return -1;
            }
        }

        /// <summary>
        /// 获得DataReader
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="CommandType">执行类型</param>
        /// <param name="param">参数</param>
        /// <returns></returns>
        public DbDataReader ExecuteReader(string sql, CommandType CommandType, params DbParameter[] param)
        {
            Console.WriteLine(sql + ";--dbhelper4");
            if (IsBeginTransaction)
            {
                try
                {
                    Cmd.CommandType = CommandType;
                    Cmd.CommandText = sql;
                    Cmd.Parameters.Clear();
                    Cmd.Parameters.AddRange(param);
                    return Cmd.ExecuteReader();
                }
                catch
                {
                    try
                    {
                        RollbackTransaction();
                        throw;
                    }
                    catch
                    {
                        throw;
                    }
                }
            }
            else
            {
                Con = Factory.CreateConnection();
                using (Cmd = Con.CreateCommand())
                {
                    try
                    {
                        Con.ConnectionString = ConnectionString;
                        Cmd.CommandType = CommandType;
                        Cmd.CommandText = sql;
                        Cmd.Parameters.AddRange(param);
                        Con.Open();
                        return Cmd.ExecuteReader(CommandBehavior.CloseConnection);
                    }
                    catch
                    {
                        Con.Close();
                        throw;
                    }
                }
            }
        }

        /// <summary>
        /// 获得DataReader
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="param">参数</param>
        /// <returns></returns>
        public DbDataReader ExecuteReader(string sql, params DbParameter[] param)
        {
            return ExecuteReader(sql, CommandType.Text, param);
        }

        /// <summary>
        /// 获得第一行第一列结果
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="CommandType">执行类型</param>
        /// <param name="param">参数</param>
        /// <returns></returns>
        public object ExecuteScalar(string sql, CommandType CommandType, params DbParameter[] param)
        {
            Console.WriteLine(sql + ";--dbhelper6");
            if (IsBeginTransaction)
            {
                try
                {
                    Cmd.CommandType = CommandType;
                    Cmd.CommandText = sql;
                    Cmd.Parameters.Clear();
                    Cmd.Parameters.AddRange(param);
                    return Cmd.ExecuteScalar();
                }
                catch
                {
                    try
                    {
                        RollbackTransaction();
                        throw;
                    }
                    catch
                    {
                        throw;
                    }
                }
            }
            else
            {
                using (Con = Factory.CreateConnection())
                {
                    using (Cmd = Con.CreateCommand())
                    {
                        try
                        {
                            Con.ConnectionString = ConnectionString;
                            Cmd.CommandType = CommandType;
                            Cmd.CommandText = sql;
                            Cmd.Parameters.AddRange(param);
                            Con.Open();
                            return Cmd.ExecuteScalar();
                        }
                        catch
                        {
                            Con.Close();
                            throw;
                        }
                    }
                }
            }
        }

        /// <summary>
        /// 获得第一行第一列结果
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="param">参数</param>
        /// <returns></returns>
        public object ExecuteScalar(string sql, params DbParameter[] param)
        {
            return ExecuteScalar(sql, CommandType.Text, param);
        }

        /// <summary>
        /// 获得第一行第一列结果，采用泛型作为返回值类型
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="CommandType">执行类型</param>
        /// <param name="param">参数</param>
        /// <returns></returns>
        public T ExecuteScalar<T>(string sql, CommandType CommandType, params DbParameter[] param)
        {
            return (T)Convert.ChangeType(ExecuteScalar(sql, CommandType, param), typeof(T));
        }

        /// <summary>
        /// 获得第一行第一列结果，采用泛型作为返回值类型
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="param">参数</param>
        /// <returns></returns>
        public T ExecuteScalar<T>(string sql, params DbParameter[] param)
        {
            return ExecuteScalar<T>(sql, CommandType.Text, param);
        }

        /// <summary>
        /// 获得DataSet
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="CommandType">执行类型</param>
        /// <param name="param">参数</param>
        /// <returns></returns>
        public DataSet GetDataSet(string sql, CommandType CommandType, params DbParameter[] param)
        {
            if (IsBeginTransaction)
            {
                try
                {
                    Cmd.CommandType = CommandType;
                    Cmd.CommandText = sql;
                    Cmd.Parameters.Clear();
                    Cmd.Parameters.AddRange(param);
                    using (DbDataAdapter da = Factory.CreateDataAdapter())
                    {
                        da.SelectCommand = Cmd;
                        DataSet ds = new DataSet();
                        da.Fill(ds);
                        return ds;
                    }
                }
                catch
                {
                    try
                    {
                        RollbackTransaction();
                        throw;
                    }
                    catch
                    {
                        throw;
                    }
                }
            }
            else
            {
                using (Con = Factory.CreateConnection())
                {
                    using (Cmd = Con.CreateCommand())
                    {
                        try
                        {
                            Con.ConnectionString = ConnectionString;
                            Cmd.CommandType = CommandType;
                            Cmd.CommandText = sql;
                            Cmd.Parameters.AddRange(param);
                            Con.Open();
                            using (DbDataAdapter da = Factory.CreateDataAdapter())
                            {
                                da.SelectCommand = Cmd;
                                DataSet ds = new DataSet();
                                da.Fill(ds);
                                return ds;
                            }
                        }
                        catch
                        {
                            Con.Close();
                            throw;
                        }
                    }
                }
            }
        }

        /// <summary>
        /// 获得DataSet
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="param">参数</param>
        /// <returns></returns>
        public DataSet GetDataSet(string sql, params DbParameter[] param)
        {
            return GetDataSet(sql, CommandType.Text, param);
        }

        /// <summary>
        /// 获得DataTable
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="CommandType">执行类型</param>
        /// <param name="param">参数</param>
        /// <returns></returns>
        public DataTable GetDataTable(string sql, CommandType CommandType, params DbParameter[] param)
        {
            if (IsBeginTransaction)
            {
                try
                {
                    Cmd.CommandType = CommandType;
                    Cmd.CommandText = sql;
                    Cmd.Parameters.Clear();
                    if (null != param)
                    {
                        Cmd.Parameters.AddRange(param);
                    }
                    using (DbDataAdapter da = Factory.CreateDataAdapter())
                    {
                        da.SelectCommand = Cmd;
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        return dt;
                    }
                }
                catch
                {
                    try
                    {
                        RollbackTransaction();
                        throw;
                    }
                    catch
                    {
                        throw;
                    }
                }
            }
            else
            {
                using (Con = Factory.CreateConnection())
                {
                    using (Cmd = Con.CreateCommand())
                    {
                        try
                        {
                            Con.ConnectionString = ConnectionString;
                            Cmd.CommandType = CommandType;
                            Cmd.CommandText = sql;
                            if (null != param)
                            {
                                Cmd.Parameters.AddRange(param);
                            }
                            Con.Open();
                            using (DbDataAdapter da = Factory.CreateDataAdapter())
                            {
                                da.SelectCommand = Cmd;
                                DataTable dt = new DataTable();
                                da.Fill(dt);
                                return dt;
                            }
                        }
                        catch
                        {
                            Con.Close();

                            throw;
                        }
                    }
                }
            }
        }

        /// <summary>
        /// 获得DataTable
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="param">参数</param>
        /// <returns></returns>
        public DataTable GetDataTable(string sql, params DbParameter[] param)
        {
            return GetDataTable(sql, CommandType.Text, param);
        }

        /// <summary>
        /// 获得DataRow
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="index">行号从0开始</param>
        /// <param name="CommandType">执行类型</param>
        /// <param name="param">参数</param>
        /// <returns></returns>
        public DataRow GetDataRow(string sql, int index, CommandType CommandType, params DbParameter[] param)
        {
            Console.WriteLine(sql + ";--dbhelper14");
            if (IsBeginTransaction)
            {
                try
                {
                    Cmd.CommandType = CommandType;
                    Cmd.CommandText = sql;
                    Cmd.Parameters.Clear();
                    Cmd.Parameters.AddRange(param);
                    using (DbDataAdapter da = Factory.CreateDataAdapter())
                    {
                        da.SelectCommand = Cmd;
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            return dt.Rows[index];
                        }
                        return null;
                    }
                }
                catch
                {
                    try
                    {
                        RollbackTransaction();
                        throw;
                    }
                    catch
                    {
                        throw;
                    }
                }
            }
            else
            {
                using (Con = Factory.CreateConnection())
                {
                    using (Cmd = Con.CreateCommand())
                    {
                        try
                        {
                            Con.ConnectionString = ConnectionString;
                            Cmd.CommandType = CommandType;
                            Cmd.CommandText = sql;
                            Cmd.Parameters.AddRange(param);
                            Con.Open();
                            using (DbDataAdapter da = Factory.CreateDataAdapter())
                            {
                                da.SelectCommand = Cmd;
                                DataTable dt = new DataTable();
                                da.Fill(dt);
                                if (dt != null && dt.Rows.Count > 0)
                                {
                                    return dt.Rows[index];
                                }
                                return null;
                            }
                        }
                        catch
                        {
                            Con.Close();
                            throw;
                        }
                    }
                }
            }
        }

        /// <summary>
        /// 获得第一行DataRow
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="param">参数</param>
        /// <returns></returns>
        public DataRow GetDataRow(string sql, params DbParameter[] param)
        {
            return GetDataRow(sql, 0, CommandType.Text, param);
        }

        /// <summary>
        /// 获得DataRow
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="param">参数</param>
        /// <returns></returns>
        public DataRow GetDataRow(string sql, int index, params DbParameter[] param)
        {
            return GetDataRow(sql, index, CommandType.Text, param);
        }

        /// <summary>
        /// 执行储存过程,并返回参数的集合
        /// </summary>
        /// <param name="procName">存储过程名称</param>
        /// <param name="param">参数</param>
        /// <returns></returns>
        public DbParameterCollection ExecuteProc(string procName, params DbParameter[] param)
        {
            if (IsBeginTransaction)
            {
                try
                {
                    Cmd.CommandType = CommandType.StoredProcedure;
                    Cmd.CommandText = procName;
                    Cmd.Parameters.Clear();
                    Cmd.Parameters.AddRange(param);
                    Cmd.ExecuteNonQuery();
                    return Cmd.Parameters;
                }
                catch
                {
                    try
                    {
                        RollbackTransaction();
                        throw;
                    }
                    catch
                    {
                        throw;
                    }
                }
            }
            else
            {
                using (Con = Factory.CreateConnection())
                {
                    using (Cmd = Con.CreateCommand())
                    {
                        try
                        {
                            Con.ConnectionString = ConnectionString;
                            Cmd.CommandType = CommandType.StoredProcedure;
                            Cmd.CommandText = procName;
                            Cmd.Parameters.AddRange(param);
                            Con.Open();
                            Cmd.ExecuteNonQuery();
                            return Cmd.Parameters;
                        }
                        catch
                        {
                            Con.Close();
                            throw;
                        }
                    }
                }
            }
        }

        /// <summary>
        /// 执行储存过程,并返回表集合
        /// </summary>
        /// <param name="procName">存储过程名称</param>
        /// <param name="param">参数</param>
        /// <returns></returns>
        public DataSet ExecuteProcDataSet(string procName, params DbParameter[] param)
        {
            if (IsBeginTransaction)
            {
                try
                {
                    Cmd.CommandType = CommandType.StoredProcedure;
                    Cmd.CommandText = procName;
                    Cmd.Parameters.Clear();
                    Cmd.Parameters.AddRange(param);
                    using (DbDataAdapter da = Factory.CreateDataAdapter())
                    {
                        da.SelectCommand = Cmd;
                        DataSet ds = new DataSet();
                        da.Fill(ds);
                        return ds;
                    }
                }
                catch
                {
                    try
                    {
                        RollbackTransaction();
                        throw;
                    }
                    catch
                    {
                        throw;
                    }
                }
            }
            else
            {
                using (Con = Factory.CreateConnection())
                {
                    using (Cmd = Con.CreateCommand())
                    {
                        try
                        {
                            Con.ConnectionString = ConnectionString;
                            Cmd.CommandType = CommandType.StoredProcedure;
                            Cmd.CommandText = procName;
                            Cmd.Parameters.AddRange(param);
                            using (DbDataAdapter da = Factory.CreateDataAdapter())
                            {
                                da.SelectCommand = Cmd;
                                DataSet ds = new DataSet();
                                da.Fill(ds);
                                return ds;
                            }
                        }
                        catch
                        {
                            Con.Close();
                            throw;
                        }
                    }
                }
            }
        }

        /// <summary>
        /// 执行储存过程,并返回表集合和返回参数集合
        /// </summary>
        /// <param name="procName">存储过程名称</param>
        /// <param name="param">参数</param>
        /// <returns></returns>
        public DataSet ExecuteProcDataSet(string procName, out DbParameterCollection dbpc, params DbParameter[] param)
        {
            if (IsBeginTransaction)
            {
                try
                {
                    Cmd.CommandType = CommandType.StoredProcedure;
                    Cmd.CommandText = procName;
                    Cmd.Parameters.Clear();
                    Cmd.Parameters.AddRange(param);
                    //Cmd.ExecuteNonQuery();
                    //return Cmd.Parameters;
                    using (DbDataAdapter da = Factory.CreateDataAdapter())
                    {
                        da.SelectCommand = Cmd;
                        DataSet ds = new DataSet();
                        da.Fill(ds);
                        dbpc = da.SelectCommand.Parameters;
                        return ds;
                    }
                }
                catch
                {
                    try
                    {
                        RollbackTransaction();
                        throw;
                    }
                    catch
                    {
                        throw;
                    }
                }
            }
            else
            {
                using (Con = Factory.CreateConnection())
                {
                    using (Cmd = Con.CreateCommand())
                    {
                        try
                        {
                            Con.ConnectionString = ConnectionString;
                            Cmd.CommandType = CommandType.StoredProcedure;
                            Cmd.CommandText = procName;
                            Cmd.Parameters.AddRange(param);
                            //Con.Open();
                            //Cmd.ExecuteNonQuery();
                            //return Cmd.Parameters;
                            using (DbDataAdapter da = Factory.CreateDataAdapter())
                            {
                                da.SelectCommand = Cmd;
                                DataSet ds = new DataSet();
                                da.Fill(ds);
                                dbpc = da.SelectCommand.Parameters;
                                return ds;
                            }
                        }
                        catch
                        {
                            Con.Close();
                            throw;
                        }
                    }
                }
            }
        }

        public bool Exists(string sql, params DbParameter[] param)
        {
            return GetDataTable(sql, CommandType.Text, param).Rows.Count > 0;
        }

        public int ExecuteSql(string sql, params DbParameter[] param)
        {
            try
            {
                MethodInfo method = (MethodInfo)(new StackTrace().GetFrame(1).GetMethod());
                return ExecuteNonQuery(sql, CommandType.Text, param);
            }
            catch
            {
                MethodInfo method = (MethodInfo)(new StackTrace().GetFrame(1).GetMethod());
                throw;
            }
        }

        public DataSet Query(string sql, params DbParameter[] param)
        {
            return GetDataSet(sql, CommandType.Text, param);
        }
        public string ExecuteBatch(Dictionary<string, object> dic)
        {
            return ExecuteBatch(dic, CommandType.Text);
        }
        public string ExecuteBatch(Dictionary<string, object> dic, CommandType CommandType)
        {
            BeginTransaction();
            try
            {
                Cmd.CommandType = CommandType;
                string str_完成语言 = dic["finishsql"].ToString();
                string str_主更新语言 = dic["updatesql"].ToString();
                string str_主插入 = dic["datasql"].ToString();
                string str_明细插入 = dic["rowsql"].ToString();
                ArrayList list_主记录 = dic["dataparam"] as ArrayList;
                for (int i = 0; i < list_主记录.Count; i++)
                {
                    Dictionary<string, object> dic_主参数 = list_主记录[i] as Dictionary<string, object>;
                    DbParameter[] p_主参数 = dic_主参数["dataparam"] as DbParameter[];
                    Cmd.CommandText = str_主插入;
                    Cmd.Parameters.Clear();
                    Cmd.Parameters.AddRange(p_主参数);
                    Cmd.ExecuteNonQuery();
                    if (dic_主参数.ContainsKey("rowparam") && !string.IsNullOrEmpty(str_明细插入))
                    {
                        ArrayList list_明细记录 = dic_主参数["rowparam"] as ArrayList;
                        for (int j = 0; j < list_明细记录.Count; j++)
                        {
                            DbParameter[] p_明细参数 = list_明细记录[j] as DbParameter[];
                            Cmd.CommandText = str_明细插入;
                            Cmd.Parameters.Clear();
                            Cmd.Parameters.AddRange(p_明细参数);
                            Cmd.ExecuteNonQuery();
                        }
                    }

                    if (dic_主参数.ContainsKey("updateparam") && !string.IsNullOrEmpty(str_主更新语言))
                    {
                        DbParameter[] p_更新参数 = dic_主参数["updateparam"] as DbParameter[];
                        Cmd.CommandText = str_主更新语言;
                        Cmd.Parameters.Clear();
                        Cmd.Parameters.AddRange(p_更新参数);
                        Cmd.ExecuteNonQuery();
                    }
                }

                //执行完成后提交事务
                CommitTransaction();
                return string.Empty;
            }
            catch (Exception e)
            {
                try
                {
                    RollbackTransaction();
                    return e.Message;
                }
                catch (Exception e1)
                {
                    return e1.Message;
                }
            }
        }
    }
}