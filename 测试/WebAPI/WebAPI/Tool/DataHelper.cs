using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using WebAPI.Models;

namespace WebAPI.Tool
{
    public class DataHelper
    {
        /// <summary>
        /// 数据库操作,执行表中配置的查询、插入、更新的语句
        /// </summary>
        /// <param name="msg">消息</param>
        /// <param name="Code">业务编码</param>
        /// <param name="p">参数</param>
        public static Dictionary<string, object> M_业务数据处理(ref MessageModel msg, dynamic p)
        {
            try
            {
                Dictionary<string, object> dic_返回 = new Dictionary<string, object>();

                string str_json = JsonConvert.SerializeObject(p);
                Dictionary<string, object> param = ToolFunction.JsonToDictionary(str_json, ref msg);
                if (msg.success != 1)
                {
                    return null;
                }
                string sql = $@"SELECT * from webapi_list where 业务编号='{msg.code}' and 有效状态='True'";
                DataTable dt = DbHelper.Db.GetDataTable(sql);
                if (null != dt && dt.Rows.Count > 1)
                {
                    Code.Result(ref msg, 编码.消息头错误, "匹配到多个业务记录");
                    return null;
                }
                if (null != dt && dt.Rows.Count == 1)
                {
                    string str_error = string.Empty;

                    #region 插入更新
                    if (!string.IsNullOrEmpty(dt.Rows[0]["主插入语言"].ToString()))
                    {
                        Dictionary<string, object> dic_插入信息 = ToolFunction.getInsert(param, dt.Rows[0], out str_error);
                        if (!string.IsNullOrEmpty(str_error))
                        {
                            Code.Result(ref msg, 编码.参数错误, str_error);
                            return null;
                        }
                        if (dic_插入信息.Count > 0)
                        {
                            str_error = DbHelper.Db.ExecuteBatch(dic_插入信息);
                            if (!string.IsNullOrEmpty(str_error))
                            {
                                Code.Result(ref msg, 编码.参数错误, str_error);
                                return null;
                            }
                        }
                    }
                    #endregion

                    #region 主查询语言
                    string str_sql = dt.Rows[0]["主查询语言"].ToString();
                    DataTable dt_主记录 = null;
                    if (!string.IsNullOrEmpty(str_sql))
                    {
                        ArrayList arr_query = new ArrayList();
                        int count = 1;
                        if (null != param && param.ContainsKey("query"))
                        {
                            arr_query = param["query"] as ArrayList;
                            count = arr_query.Count;
                        }
                        for (int i = 0; i < count; i++)
                        {
                            SqlParameter[] parameters_主 = null;
                            Dictionary<string, object> dic_query = null;
                            string str_数据集名称 = string.Empty;
                            if (null != param && param.ContainsKey("query"))
                            {
                                //包含query节点则有点读取query节点下的参数
                                dic_query = arr_query[i] as Dictionary<string, object>;
                                parameters_主 = ToolFunction.GetParameter(str_sql, dic_query, out str_error, param);
                                if (dic_query.ContainsKey("dataname"))
                                {
                                    str_数据集名称 = dic_query["dataname"].ToString();
                                }
                                else
                                {
                                    Code.Result(ref msg, 编码.参数错误, "query节点下缺少dataname节点");
                                    return null;
                                }
                            }
                            else
                            {
                                //不包含query节点则读取主节点的参数
                                parameters_主 = ToolFunction.GetParameter(str_sql, param, out str_error);
                            }

                            if (!string.IsNullOrEmpty(str_error))
                            {
                                Code.Result(ref msg, 编码.参数错误, str_error);
                                return null;
                            }
                            dt_主记录 = DbHelper.Db.GetDataTable(str_sql.Replace("?", "@"), parameters_主);

                            #region 明细查询语言
                            string str_sql1 = dt.Rows[0]["明细查询语言"].ToString();
                            DataTable dt_明细记录 = null;
                            ArrayList list_返回 = new ArrayList();
                            Dictionary<string, object> dic_明细返回 = new Dictionary<string, object>();
                            if (null != dt_主记录 && dt_主记录.Rows.Count > 0)
                            {
                                if (!string.IsNullOrEmpty(str_sql1))
                                {
                                    for (int j = 0; j < dt_主记录.Rows.Count; j++)
                                    {
                                        DataRow row = dt_主记录.Rows[j];
                                        SqlParameter[] parameters_明细 = ToolFunction.GetParameter(str_sql1, param, row, str_数据集名称, out str_error);
                                        if (!string.IsNullOrEmpty(str_error))
                                        {
                                            Code.Result(ref msg, 编码.参数错误, str_error);
                                            return null;
                                        }
                                        dt_明细记录 = DbHelper.Db.GetDataTable(str_sql1.Replace("?", "@"), parameters_明细);
                                        row = ToolFunction.M_替换表头及顺序(row.Table, dt.Rows[0]["序号"].ToString(), 0, str_数据集名称).Rows[j];
                                        dt_明细记录 = ToolFunction.M_替换表头及顺序(dt_明细记录, dt.Rows[0]["序号"].ToString(), 1, str_数据集名称);
                                        dic_明细返回 = ToolFunction.ToJson(row, dt_明细记录);
                                        list_返回.Add(dic_明细返回);
                                    }
                                }
                                else
                                {
                                    dt_主记录 = ToolFunction.M_替换表头及顺序(dt_主记录, dt.Rows[0]["序号"].ToString(), 0, str_数据集名称);
                                }
                            }
                            #endregion
                            if (null != param && param.ContainsKey("query"))
                            {
                                if (!dic_query.ContainsKey("dataname"))
                                {
                                    Code.Result(ref msg, 编码.参数错误, "query节点下缺少dataname节点");
                                    return null;
                                }
                                dic_返回.Add(dic_query["dataname"] + "count", dt_主记录.Rows.Count);

                                if (list_返回.Count == 0)
                                {
                                    dic_返回.Add(dic_query["dataname"].ToString(), dt_主记录);
                                }
                                else
                                {
                                    dic_返回.Add(dic_query["dataname"].ToString(), list_返回);
                                }
                            }
                            else
                            {
                                dic_返回.Add("datacount", dt_主记录.Rows.Count);
                                if (list_返回.Count == 0)
                                {
                                    dic_返回.Add("dataset", dt_主记录);
                                }
                                else
                                {
                                    dic_返回.Add("dataset", list_返回);
                                }
                            }
                        }
                    }
                    #endregion
                }
                else
                {
                    Code.Result(ref msg, 编码.消息头错误, "业务编号" + msg.code + "错误");
                    return null;
                }
                return dic_返回;
            }
            catch (Exception e)
            {
                Code.Result(ref msg, 编码.程序错误, e.Message);
                Log.Error("M_业务数据处理", e.Message);
                return null;
            }
        }

        public static bool M_验证客户ID(string customid, ref MessageModel msg, out string accessToken, out DateTime accessPastTime)
        {
            try
            {
                string sql = $@"select * from webapi_customer where customid='{customid}'";
                DataTable dt = DbHelper.Db.GetDataTable(sql);
                if (null == dt || dt.Rows.Count <= 0)
                {
                    Code.Result(ref msg, 编码.消息头错误, "无效的customid");
                    accessToken = string.Empty;
                    accessPastTime = DateTime.Now;
                    return false;
                }
                if (null != dt && dt.Rows.Count > 1)
                {
                    Code.Result(ref msg, 编码.消息头错误, "customid匹配到多个用户");
                    accessToken = string.Empty;
                    accessPastTime = DateTime.Now;
                    return false;
                }
                accessToken = dt.Rows[0]["accessToken"].ToString();
                accessPastTime = DateTime.Parse(dt.Rows[0]["accessPastTime"].ToString());
            }
            catch (Exception e)
            {
                Code.Result(ref msg, 编码.程序错误, e.Message);
                Log.Error("M_验证客户ID", e.Message);
                accessToken = "";
                accessPastTime = DateTime.Now.AddDays(-1);
                return false;
            }
            return true;
        }
        public static int M_更新第三方Token(TokenModel token, string customid)
        {
            string sql = $"update webapi_customer set accessToken='{token.accessToken}',accessPastTime=convert(datetime,'{token.accessPastTime}') where customid='{customid}'";
            return DbHelper.Db.ExecuteSql(sql);
        }
    }
}