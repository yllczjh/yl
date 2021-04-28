using System;
using System.Data;
using System.Configuration;

namespace Cloud.Db
{
    public class Db_Common
    {
        #region 通用参数类型

        /// <summary>
        /// 保存表的设置项目结构体
        /// </summary>
        public struct UpdateItem
        {
            public string TableName;
            public string SelectSql;
        }
        /// <summary>
        ///  存储过程入口参数结构
        /// </summary>
        public struct InParameter
        {
            public string name;
            public DbType dbType;
            public Object value;
            public ParameterDirection direction;
            public int size;
        }
        /// <summary>
        /// 存储过程出口参数结构
        /// </summary>
        public struct OutParameter
        {
            public string name;
            public DbType dbType;
            public int size;
        }

        /// <summary>
        /// 用于保存查询结果值的通用结构体
        /// </summary>
        public struct rtnvalues
        {
            public string arg0;
            public string arg1;
            public string arg2;
            public string arg3;
            public string arg4;
            public string arg5;
            public string arg6;
            public string arg7;
            public string arg8;
            public string arg9;
            public string arg10;
            public string arg11;
            public string arg12;
            public string arg13;
            public string arg14;
            public string arg15;
            public string arg16;
            public string arg17;
            public string arg18;
            public string arg19;
            public string arg20;
            public string arg21;
            public string arg22;
            public string arg23;
            public string arg24;
            public string arg25;
            public string arg26;
            public string arg27;
            public string arg28;
            public string arg29;
            public string arg30;
            public string arg31;
            public string arg32;
            public string arg33;
            public string arg34;
            public string arg35;
            public string arg36;
            public string arg37;
            public string arg38;
            public string arg39;
            public string arg40;
        }

        public enum Db_类型
        {
            SQL,
            Oracle,
            Access
        }
        #endregion

        private static IDbHelper dbHelper = null;
        public static IDbHelper Get_DbHelper()
        {
            if (dbHelper == null)
            {
                string str_服务器类型 = GetConnStr("数据库服务器类型");
                switch (str_服务器类型)
                {
                    case "oracle":
                        dbHelper = new OracleHelper_Interface();
                        break;
                    default:
                        dbHelper = new OracleHelper_Interface();
                        break;
                }
            }
            return dbHelper;
        }

        /// <summary>
        /// 动态获取数据库访问对象
        /// </summary>
        /// <param name="str_类型"></param>
        /// <returns></returns>
        public static IDbHelper Get_DbHelper(string str_类型)
        {
            IDbHelper dbHelper_Temp = null;
            switch (str_类型)
            {
                case "oracle":
                    dbHelper_Temp = new OracleHelper_Interface();
                    break;
                default:
                    dbHelper_Temp = new OracleHelper_Interface();
                    break;
            }

            return dbHelper_Temp;
        }

        public static Db_类型 Get_Db_类型()
        {
            Db_类型 db_类型;
            string str_服务器类型 = GetConnStr("数据库服务器类型");
            if (!string.IsNullOrEmpty(str_服务器类型))
                str_服务器类型 = str_服务器类型.ToLower();
            switch (str_服务器类型)
            {
                case "sql":
                    db_类型 = Db_类型.SQL;
                    break;
                case "oracle":
                    db_类型 = Db_类型.Oracle;
                    break;
                case "access":
                    db_类型 = Db_类型.Access;
                    break;
                default:
                    db_类型 = Db_类型.Oracle;
                    break;
            }
            return db_类型;
        }

        public static string GetConnStr(string Key)
        {
            string ConnStr = "";
            try
            {
                //ConnStr = System.Configuration.ConfigurationManager.AppSettings[Key];
                ConnStr = ConfigurationManager.ConnectionStrings["OraConnString2"].ConnectionString;
                if (!string.IsNullOrEmpty(ConnStr))
                    ConnStr = ConnStr.ToLower();
            }
            catch (Exception)
            {

                ConnStr = "";
            }

            return ConnStr;
        }

        /// <summary>
        /// 字符串替换函数
        /// </summary>
        /// <param name="sql_parm">SQL语句</param>
        /// <param name="str_Source">替换前字符</param>
        /// <param name="str_dest">替换后字符</param>
        /// <returns></returns>
        public static string get_Replace_SQL(string str_sql, string str_Source, string str_dest)
        {
            string str_Return = "";
            string[] str_sqls = str_sql.Split('\'');//单引号里面的是值，不能替换
            for (int i = 0; i < str_sqls.Length; i++)
            {
                //偶数列需要处理
                if (i % 2 == 0)
                {
                    str_Return += str_sqls[i].Replace(str_Source, str_dest);
                }
                else
                {
                    str_Return += "'" + str_sqls[i] + "' ";
                }
            }
            return str_Return;
        }

        /// <summary>
        /// 字符串替换函数
        /// </summary>
        /// <param name="sql_parm">参数名称</param>
        /// <param name="str_Source">替换前字符</param>
        /// <param name="str_dest">替换后字符</param>
        /// <returns></returns>
        public static string get_Replace_Param(string str_param, string str_Source, string str_dest)
        {
            string str_Return = str_param.Trim();
            if (!string.IsNullOrEmpty(str_Return))
            {
                string str_First = str_Return.Substring(0, 1);
                if (str_First.Equals(str_Source) || str_First.Equals(str_dest))
                    str_Return = str_Return.Substring(1);
            }
            str_Return = str_dest + str_Return;
            return str_Return;
        }
    }
}
