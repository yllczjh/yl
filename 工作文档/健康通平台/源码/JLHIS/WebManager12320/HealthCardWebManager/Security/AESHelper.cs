using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;

namespace HealthCardWebManager.Security
{
    public class AESHelper
    {
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
    }
}