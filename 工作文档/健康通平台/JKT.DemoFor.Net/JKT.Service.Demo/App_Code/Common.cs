using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using System.Reflection;
using System.Security.Cryptography;
using System.Web.Security;

namespace JKT.Service.Demo
{
    /// <summary>
    /// 公共方法
    /// </summary>
    public class Common
    {

        #region 加签

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
            return EncryptForMD5(p);
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
            return EncryptForMD5(p);
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

        #endregion


        #region 加解密

        /// <summary>
        /// MD5 加签
        /// </summary>
        /// <param name="encryptString">待加签的字符串</param>
        /// <returns></returns>
        public static string EncryptForMD5(string encryptString)
        {
            try
            {
                MD5CryptoServiceProvider md5CSP = new MD5CryptoServiceProvider();
                byte[] testEncrypt = Encoding.Unicode.GetBytes(encryptString);
                byte[] resultEncrypt = md5CSP.ComputeHash(testEncrypt);
                string testResult = System.Text.Encoding.Unicode.GetString(resultEncrypt);
                return FormsAuthentication.HashPasswordForStoringInConfigFile(encryptString, "MD5");
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("加签失败：{0}", ex.Message));
            }
        }

        /// <summary>
        /// AES 加密
        /// </summary>
        /// <param name="encryptString">待加密的业务参数串</param>
        /// <param name="encryptKey">加密密钥</param>
        /// <returns></returns>
        public static string EncryptForAES(string encryptString, string encryptKey)
        {
            try
            {
                byte[] keyArray = UTF8Encoding.UTF8.GetBytes(encryptKey);
                byte[] toEncryptArray = UTF8Encoding.UTF8.GetBytes(encryptString);
                RijndaelManaged rm = new RijndaelManaged();
                rm.Key = keyArray;
                rm.Mode = CipherMode.ECB;
                //rDel.Padding = PaddingMode.PKCS7;
                ICryptoTransform cTransform = rm.CreateEncryptor();
                byte[] resultArray = cTransform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length);
                return Convert.ToBase64String(resultArray, 0, resultArray.Length);
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("加密失败：{0}", ex.Message));
            }
        }

        /// <summary>
        /// AES 解密
        /// </summary>
        /// <param name="decryptString">待解密的业务参数串</param>
        /// <param name="decryptKey">解密秘钥，和加密秘钥相同</param>
        /// <returns></returns>
        public static string DecryptForAES(string decryptString, string decryptKey)
        {
            try
            {
                byte[] keyArray = UTF8Encoding.UTF8.GetBytes(decryptKey);
                byte[] toEncryptArray = Convert.FromBase64String(decryptString);
                RijndaelManaged rm = new RijndaelManaged();
                rm.Key = keyArray;
                rm.Mode = CipherMode.ECB;
                //rDel.Padding = PaddingMode.PKCS7;
                ICryptoTransform cTransform = rm.CreateDecryptor();
                byte[] resultArray = cTransform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length);
                return UTF8Encoding.UTF8.GetString(resultArray);
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("解密失败：{0}", ex.Message));
            }
        }

        #endregion

    }
}

