using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.Script.Serialization;
using System.Security.Cryptography;
using WebAPI.Models;

namespace WebAPI.Tool
{
    public class ToolFunction
    {
        #region 数据处理相关
        public static SqlParameter[] GetParameter(string str_sql, Dictionary<string, object> p, out string str_error, params Dictionary<string, object>[] p1)
        {
            string str_err = string.Empty;
            try
            {
                MatchCollection mats = Regex.Matches(str_sql, @"(?<p>\?\w+)");
                List<string> list_SQL参数 = new List<string>();
                foreach (Match mat in mats)
                {
                    if (!list_SQL参数.Contains(mat.Value))
                    {
                        list_SQL参数.Add(mat.Value);
                    }
                }
                if (list_SQL参数.Count > 0)
                {
                    SqlParameter[] parameters = new SqlParameter[list_SQL参数.Count];
                    for (int i = 0; i < list_SQL参数.Count; i++)
                    {
                        string str_参数名 = list_SQL参数[i].ToString();
                        str_参数名 = str_参数名.Replace("?", "");
                        string str_参数值 = string.Empty;
                        if (null == p || !p.ContainsKey(str_参数名))
                        {
                            if (p1.Count() > 0)
                            {
                                if (!p1[0].ContainsKey(str_参数名))
                                {
                                    str_error = "SQL中参数" + str_参数名 + "不存在!";
                                    return null;
                                }
                                else
                                {
                                    str_参数值 = p1[0][str_参数名].ToString();
                                }
                            }
                            else
                            {
                                str_error = "SQL中参数" + str_参数名 + "不存在!";
                                return null;
                            }
                        }
                        else
                        {
                            str_参数值 = p[str_参数名].ToString();
                        }
                        parameters[i] = new SqlParameter(str_参数名.Replace("?", "@"), str_参数值);
                    }
                    str_error = str_err;
                    return parameters;
                }
                else
                {
                    str_error = str_err;
                    return null;
                }
            }
            catch (Exception e)
            {
                str_error = e.Message;
                return null;
            }
        }

        public static SqlParameter[] GetParameter(string str_sql, Dictionary<string, object> p, DataRow row, string str_数据集名称, out string str_error)
        {
            string str_err = string.Empty;
            try
            {
                MatchCollection mats = Regex.Matches(str_sql, @"(?<p>\?\w+)");
                List<string> list_SQL参数 = new List<string>();
                foreach (Match mat in mats)
                {
                    list_SQL参数.Add(mat.Value);
                }
                if (list_SQL参数.Count > 0)
                {
                    SqlParameter[] parameters = new SqlParameter[list_SQL参数.Count];
                    for (int i = 0; i < list_SQL参数.Count; i++)
                    {
                        string str_参数名 = list_SQL参数[i].ToString();
                        str_参数名 = str_参数名.Replace("?", "");
                        string str_参数值 = string.Empty;
                        if (str_参数名 == "dataname" && !string.IsNullOrEmpty(str_数据集名称))
                        {
                            str_参数值 = str_数据集名称;
                        }
                        else
                        {
                            if (row.Table.Columns.Contains(str_参数名))
                            {
                                str_参数值 = row[str_参数名].ToString();
                            }
                            else
                            {
                                if (p.ContainsKey(str_参数名))
                                {
                                    str_参数值 = p[str_参数名].ToString();
                                }
                                else
                                {
                                    str_error = "SQL中参数" + str_参数名 + "不存在!";
                                    return null;
                                }
                            }
                        }
                        parameters[i] = new SqlParameter(str_参数名.Replace("?", "@"), str_参数值);
                    }
                    str_error = str_err;
                    return parameters;
                }
                else
                {
                    str_error = str_err;
                    return null;
                }
            }
            catch (Exception e)
            {
                str_error = e.Message;
                return null;
            }
        }

        /// <summary>
        /// 生成插入信息字典
        /// </summary>
        /// <param name="param">入参字典</param>
        /// <param name="row">接口列表信息</param>
        /// <param name="str_error">错误信息</param>
        /// <returns></returns>
        public static Dictionary<string, object> getInsert(Dictionary<string, object> param, DataRow row, out string str_error)
        {
            string str_err = string.Empty;
            Dictionary<string, object> out_dic = new Dictionary<string, object>();//返回主Dictionary
            try
            {
                string str_完成语言 = row["完成语言"].ToString();
                string str_主插入语言 = row["主插入语言"].ToString();
                string str_明细插入语言 = row["明细插入语言"].ToString();
                string str_主更新语言 = row["主更新语言"].ToString();
                if (param.ContainsKey("dataset"))
                {
                    if (!string.IsNullOrEmpty(str_主插入语言))
                    {
                        out_dic.Add("finishsql", str_完成语言.Replace("?", "@"));
                        out_dic.Add("updatesql", str_主更新语言.Replace("?", "@"));
                        out_dic.Add("datasql", str_主插入语言.Replace("?", "@"));
                        out_dic.Add("rowsql", str_明细插入语言.Replace("?", "@"));
                        if (param.ContainsKey("datacount"))
                        {
                            out_dic.Add("datacount", param["datacount"]);
                        }
                        else
                        {
                            str_err = "入参缺少datacount节点!";
                        }
                        ArrayList in_arr_dataset = param["dataset"] as ArrayList;
                        ArrayList out_listset = new ArrayList();
                        for (int i = 0; i < in_arr_dataset.Count; i++)
                        {
                            Dictionary<string, object> out_dic_set = new Dictionary<string, object>();
                            Dictionary<string, object> in_dic_dataset = in_arr_dataset[i] as Dictionary<string, object>;
                            out_dic_set.Add("dataparam", GetParameter(str_主插入语言, in_dic_dataset, out str_error));
                            out_dic_set.Add("updateparam", GetParameter(str_主更新语言, in_dic_dataset, out str_error));

                            if (in_dic_dataset.ContainsKey("datadetail"))
                            {
                                if (in_dic_dataset.ContainsKey("rowcount"))
                                {
                                    out_dic_set.Add("rowcount", in_dic_dataset["rowcount"]);
                                }
                                else
                                {
                                    str_err = "入参缺少rowcount节点!";
                                }
                                if (!string.IsNullOrEmpty(str_明细插入语言))
                                {
                                    ArrayList in_arr_datadetail = in_dic_dataset["datadetail"] as ArrayList;
                                    ArrayList out_listdetail = new ArrayList();
                                    for (int j = 0; j < in_arr_datadetail.Count; j++)
                                    {
                                        Dictionary<string, object> in_dic_datadetail = in_arr_datadetail[j] as Dictionary<string, object>;
                                        out_listdetail.Add(GetParameter(str_明细插入语言, in_dic_datadetail, out str_error, in_dic_dataset));
                                    }
                                    out_dic_set.Add("rowparam", out_listdetail);
                                }
                                else
                                {
                                    str_err = "未设置明细插入语言!";
                                    goto 退出;
                                }
                            }
                            out_listset.Add(out_dic_set);
                        }
                        out_dic.Add("dataparam", out_listset);
                    }
                    else
                    {
                        str_err = "未设置主插入语言!";
                        goto 退出;
                    }
                }
            }
            catch (Exception e)
            {
                str_err = e.Message;
            }
            退出: str_error = str_err;
            return out_dic;
            //finishsql:"完成语言"
            //datasql:"主插入语言"
            //rowsql:"明细插入语言"
            //datacount:"主记录条数"
            //dataparam:list
            //    dataparam:"主记录参数"
            //    rowcount:"明细记录条数"
            //    rowparam:list
        }

        #endregion

        #region 数据转换工具

        /// <summary>
        /// 主记录+明细 转为JSON
        /// </summary>
        /// <param name="row">主记录row</param>
        /// <param name="dt">明细记录</param>
        /// <returns></returns>
        public static Dictionary<string, object> ToJson(DataRow row, DataTable dt)
        {
            Dictionary<string, object> m_values = new Dictionary<string, object>();
            DataTable d = row.Table;
            for (int k = 0; k < d.Columns.Count; k++)
            {
                string columnName = d.Columns[k].ColumnName.ToString();
                m_values.Add(columnName, row[columnName].ToString());
            }
            m_values.Add("rowcount", dt.Rows.Count);
            m_values.Add("datadetail", dt);
            return m_values;
        }
        public static Dictionary<string, object> JsonToDictionary(string jsonData,ref MessageModel msg)
        {
            //实例化JavaScriptSerializer类的新实例
            JavaScriptSerializer jss = new JavaScriptSerializer();
            try
            {
                //将指定的 JSON 字符串转换为 Dictionary<string, object> 类型的对象
                return jss.Deserialize<Dictionary<string, object>>(jsonData);
            }
            catch (Exception ex)
            {
                Code.Result(ref msg, 编码.参数错误, ex.Message);
                return null;
            }
        }
        /// <summary>
        /// 替换表头及顺序
        /// </summary>
        /// <param name="dt">要处理的原数据</param>
        /// <param name="str_序号">接口列表序号</param>
        /// <param name="type">0主记录  1明细记录</param>
        /// <param name="str_数据集名称">当返回多个数据集时，query节点下的name节点</param>
        public static DataTable M_替换表头及顺序(DataTable dt_原数据集, string str_序号, int type, string str_数据集名称)
        {
            string sql = $@"SELECT * from webapi_contrast where 业务序号='{str_序号}' and 有效状态='True'";
            if (!string.IsNullOrEmpty(str_数据集名称))
            {
                sql += $@" and 数据集名称='{str_数据集名称}'";
            }
            DataTable dt_对照表 = DbHelper.Db.GetDataTable(sql);
            if (null != dt_对照表 && dt_对照表.Rows.Count > 0)
            {
                if (type == 0)
                {
                    dt_对照表.DefaultView.RowFilter = "上级序号='0' and 分级节点='False'";
                    dt_对照表.DefaultView.Sort = "排序";
                    dt_对照表 = dt_对照表.DefaultView.ToTable();
                }
                else
                {
                    string str_上级节点 = dt_对照表.Compute("max(序号)", "分级节点='True'").ToString();
                    if (!string.IsNullOrEmpty(str_上级节点))
                    {
                        dt_对照表.DefaultView.RowFilter = "上级序号='" + str_上级节点 + "'";
                        dt_对照表.DefaultView.Sort = "排序";
                        dt_对照表 = dt_对照表.DefaultView.ToTable();
                    }
                    else
                    {
                        dt_对照表 = null;
                    }
                }
                if (null != dt_对照表 && dt_对照表.Rows.Count > 0)
                {
                    #region 修改顺序
                    List<string> l_新表头顺序 = new List<string>();
                    foreach (DataRow dr in dt_对照表.Rows)
                    {
                        if (dt_原数据集.Columns.Contains(dr["本地列名"].ToString()))
                        {
                            l_新表头顺序.Add(dr["本地列名"].ToString());
                        }
                    }
                    DataTable dt_新数据集 = dt_原数据集;
                    if (l_新表头顺序.Count > 0)
                    {
                        dt_新数据集 = dt_原数据集.DefaultView.ToTable(false, l_新表头顺序.ToArray());
                    }
                    #endregion

                    #region 修改列名
                    foreach (DataColumn col in dt_新数据集.Columns)
                    {
                        var 新表头 = (from a in dt_对照表.AsEnumerable()
                                   where a.Field<string>("本地列名") == col.ColumnName
                                   select a.Field<string>("返回列名")).FirstOrDefault() ?? "";
                        if (!string.IsNullOrEmpty(新表头.ToString()))
                        {
                            col.ColumnName = 新表头.ToString();
                        }
                    }
                    #endregion
                    return dt_新数据集;
                }
            }
            return dt_原数据集;
        }

        #endregion

        #region 签名验证
        /// <summary>
        /// 得到签名
        /// </summary>
        /// <param name="MsgID"></param>
        /// <param name="UserID"></param>
        /// <param name="Token"></param>
        /// <param name="Code"></param>
        /// <param name="parame"></param>
        /// <returns></returns>
        public static string GetRequsetSign(MessageModel msg, dynamic param)
        {
            string str_json = string.Empty;
            if (null != param)
            {
                str_json = JsonConvert.SerializeObject(param);
            }
            SortedDictionary<string, object> dic = new SortedDictionary<string, object>();
            dic.Add("msgid", msg.msgid);
            dic.Add("customid", msg.customid);
            dic.Add("token", msg.token);
            dic.Add("code", msg.code);
            dic.Add("clienttype", msg.clienttype);
            dic.Add("reqtime", msg.reqtime);
            dic.Add("param", str_json);
            var dicstr = dic.Select(kv => kv.Key + "=" + kv.Value);
            string p = string.Join("&", dicstr);
            return EncryptForMD5(p);
        }

        #endregion

        #region 加密相关
        static RSACryptoServiceProvider oRSA = new RSACryptoServiceProvider();

        /// <summary>
        /// RSA加密
        /// </summary>
        /// <param name="publickey"></param>
        /// <param name="content"></param>
        /// <returns></returns>
        public static string Encrypt(string publickey, string content)
        {
            //得到公钥
            oRSA.FromXmlString(publickey);
            //把你要加密的内容转换成byte[]
            byte[] PlainTextBArray = Encoding.UTF8.GetBytes(content);
            //使用.NET中的Encrypt方法加密
            byte[] CypherTextBArray = oRSA.Encrypt(PlainTextBArray, false);
            //最后把加密后的byte[]转换成Base64String，这里就是加密后的内容了
            string EncryptedContent = Convert.ToBase64String(CypherTextBArray);
            return EncryptedContent;
        }

        /// <summary>
        /// RSA解密
        /// </summary>
        /// <param name="privatekey"></param>
        /// <param name="content"></param>
        /// <returns></returns>
        public static string Decrypt(string privatekey, string content)
        {
            //得到私钥
            oRSA.FromXmlString(privatekey);
            //把原来加密后的String转换成byte[]
            byte[] PlainTextBArray = Convert.FromBase64String(content);
            //使用.NET中的Decrypt方法解密
            byte[] DypherTextBArray = oRSA.Decrypt(PlainTextBArray, false);
            //转换解密后的byte[]，这就得到了我们原来的加密前的内容了
            string EncryptedContent = Encoding.UTF8.GetString(DypherTextBArray);
            return EncryptedContent;
        }

        /// <summary>
        /// MD5 加签
        /// </summary>
        /// <param name="encryptString">待加签的字符串</param>
        /// <returns></returns>
        public static string EncryptForMD5(string encryptString)
        {
            using (MD5 mi = MD5.Create())
            {
                byte[] buffer = Encoding.Default.GetBytes(encryptString);
                //开始加密
                byte[] newBuffer = mi.ComputeHash(buffer);
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < newBuffer.Length; i++)
                {
                    sb.Append(newBuffer[i].ToString("x2"));
                }
                return sb.ToString();
            }
        }
        #endregion
    }
}