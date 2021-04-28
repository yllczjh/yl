using System.Collections.Generic;
using System.Text;

namespace HealthCardUtil
{
    public class Common
    {
        /// <summary>
        /// 请求参数串签名
        /// </summary>
        /// <param name="req_root">请求参数对象</param>
        /// <param name="key">业务参数加密秘钥</param>
        /// <returns></returns>
        public static string GetRequsetSign(string fun_code, string user_id, string req_encrypted, string key)
        {
            Dictionary<string, string> dict = new Dictionary<string, string>();
            dict.Add("FUN_CODE", fun_code);
            dict.Add("USER_ID", user_id);
            dict.Add("REQ_ENCRYPTED", req_encrypted);
            string p = GetSortContent(dict);
            p = p + "&KEY=" + key;
            return Security.MD5Helper.EncryptForMD5(p);
        }

        /// <summary>
        /// 返回参数串签名
        /// </summary>
        /// <param name="req_root">返回参数对象</param>
        /// <param name="key">业务参数加密秘钥</param>
        /// <returns></returns>
        public static string GetResponseSign(int code, string msg, string res_encrypted, string key)
        {
            Dictionary<string, string> dict = new Dictionary<string, string>();
            dict.Add("RETURN_CODE", code.ToString());
            dict.Add("RETURN_MSG", msg);
            dict.Add("RES_ENCRYPTED", res_encrypted);
            string p = GetSortContent(dict);
            p = p + "&KEY=" + key;
            
            return Security.MD5Helper.EncryptForMD5(p);
        }

        /// <summary>
        /// 按字母排序，组成query类型的字符串(key1=value1&key2=value2) 
        /// </summary>
        /// <param name="parameters"></param>
        /// <returns></returns>
        public static string GetSortContent(IDictionary<string, string> parameters)
        {
            // 第一步：把字典按Key的字母顺序排序
            IDictionary<string, string> sortedParams = new SortedDictionary<string, string>(parameters);
            IEnumerator<KeyValuePair<string, string>> dem = sortedParams.GetEnumerator();

            // 第二步：把所有参数名和参数值串在一起 
            StringBuilder query = new StringBuilder("");
            while (dem.MoveNext())
            {
                string key = dem.Current.Key;
                string value = dem.Current.Value;
                if (!string.IsNullOrEmpty(key) && !string.IsNullOrEmpty(value))
                {
                    query.Append(key).Append("=").Append(value).Append("&");
                }
            }
            return query.ToString().Substring(0, query.Length - 1);
        }
    }
}
