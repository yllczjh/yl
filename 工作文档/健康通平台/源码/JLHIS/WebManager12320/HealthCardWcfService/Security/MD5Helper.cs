using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web.Security;

namespace HealthCardWcfService.Security
{
    public class MD5Helper
    {

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
    }
}
