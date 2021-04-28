using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace HealthCardWebManager
{
    public  class Utility
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="funCode"></param>
        /// <param name="userID"></param>
        /// <param name="req_encrypted"></param>
        /// <param name="key"></param>
        /// <returns></returns>
        public static string GetRequestSign(string funCode, string userID, string req_encrypted, string key)
        {
            Dictionary<string, string> dict = new Dictionary<string, string>();
            dict.Add("FUN_CODE", funCode);
            dict.Add("USER_ID", userID);
            dict.Add("REQ_ENCRYPTED", req_encrypted);
            string p = GetSortContent(dict);
            p = p + "&KEY=" + key;
            return Security.MD5Helper.EncryptForMD5(p);
        }

        /// <summary>
        /// 按字母排序，组成query类型的字符串(key1=value1&key2=value2) 
        /// </summary>
        /// <param name="parameters"></param>
        /// <returns></returns>
        private static string GetSortContent(IDictionary<string, string> parameters)
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
