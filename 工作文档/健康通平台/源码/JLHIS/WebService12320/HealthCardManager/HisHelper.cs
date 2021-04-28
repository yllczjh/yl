using Cloud.Db;
using System.Data;
using System.Data.OracleClient;

namespace HealthCardManager
{
    public  class HisHelper
    {
        #region 局部静态变量
        private static IDbHelper dbhelper = Db_Common.Get_DbHelper();
        #endregion

        #region 公有方法
      
        public static string M_获取响应参数(string str_功能号,string str_请求参数,ref int res_code, ref string res_msg)
        {
            OracleParameter[] pra = new OracleParameter[] {
                new OracleParameter("str_功能号",OracleType.VarChar,50),
                    new OracleParameter("str_请求参数",OracleType.VarChar,4000),
                    new OracleParameter("lob_响应参数",OracleType.Clob),
                    new OracleParameter("res_code",OracleType.VarChar,100),
                    new OracleParameter("res_msg",OracleType.VarChar,100)
                };
            pra[0].Direction = ParameterDirection.Input;
            pra[0].Value = str_功能号;
            pra[1].Direction = ParameterDirection.Input;
            pra[1].Value = str_请求参数;
            pra[2].Direction = ParameterDirection.Output;
            pra[3].Direction = ParameterDirection.Output;
            pra[4].Direction = ParameterDirection.Output;


            dbhelper.RunProcedure("PR_互联互通_总线调用", pra);
            res_code = int.Parse(pra[3].Value.ToString());
            res_msg = pra[4].Value.ToString();
            return pra[2].Value.ToString();
        }
        
        #endregion

    }
}
