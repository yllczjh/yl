using HealthCardUtil;
using HealthCardUtil.Security;
using HealthCardUtil.Tool;
using System;
using System.Configuration;

namespace HealthCardManager
{
    /// <summary>
    /// http帮助类
    /// </summary>
    public static class HttpHelper
    {
        private static string userID = ConfigurationManager.AppSettings["UserID"].ToString();
        private static string key = ConfigurationManager.AppSettings["KEY"].ToString();
        private static string HosID = ConfigurationManager.AppSettings["HosID"].ToString();

        public static string HealthCardService(string reqXml)
        {
            /*
             请求xml示例：
             <?xml version="1.0" encoding="UTF-8"?>
             <ROOT>
               <FUN_CODE><![CDATA[]]></FUN_CODE>
               <USER_ID><![CDATA[]]></USER_ID>
               <SIGN_TYPE><![CDATA[MD5]]></SIGN_TYPE>
               <SIGN><![CDATA[]]></SIGN>
               <REQ_ENCRYPTED><![CDATA[]]></REQ_ENCRYPTED>
             </ROOT>
          */
            int res_code = 0;
            string res_msg = string.Empty;
            string res_sign = string.Empty;
            string res_encrypted = string.Empty;

            string res_xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
            res_xml += @"<ROOT>
                           <RETURN_CODE><![CDATA[{0}]]></RETURN_CODE>
                           <RETURN_MSG><![CDATA[{1}]]></RETURN_MSG>
                           <SIGN_TYPE><![CDATA[{2}]]></SIGN_TYPE>
                           <SIGN><![CDATA[{3}]]></SIGN>
                           <RES_ENCRYPTED><![CDATA[{4}]]></RES_ENCRYPTED>
                         </ROOT>";
            try
            {
                string req_fun_code = string.Empty;
                string req_user_id = string.Empty;
                string req_sign = string.Empty;
                string req_sign_type = string.Empty;
                string req_encrypted = string.Empty;

                XmlHelper.AnalysisXmlReqBaseInfo(reqXml, ref req_fun_code, ref req_user_id, ref req_sign, ref req_sign_type, ref req_encrypted);
                
                if (req_user_id != userID)
                {
                    res_code = 1;
                    res_msg = "用户名不正确";
                }
                else
                {
                    //对请求串进行md5验签
                    string sign = Common.GetRequsetSign(req_fun_code, req_user_id, req_encrypted, key);
                    if (req_sign != sign || req_sign_type != "MD5")
                    {
                        res_code = 2;
                        res_msg = "签名不正确";
                    }
                    else
                    {
                        M_响应接口操作(req_fun_code, req_encrypted, ref res_code, ref res_msg, ref res_encrypted, ref res_sign);
                    }
                }
            }
            catch (Exception ex)
            {
                res_code = -1;
                res_msg = string.Format("异常：{0}", ex.Message);
            }
            if (res_code != 0)
            {
                res_encrypted = AESHelper.EncryptForAES("", key);
                res_sign = Common.GetResponseSign(res_code, res_msg, res_encrypted, key);
            }
            return string.Format(res_xml, res_code, res_msg, "MD5", res_sign, res_encrypted);
        }

        private static void M_响应接口操作(string req_fun_code, string req_encrypted, ref int res_code, ref string res_msg, ref string res_encrypted, ref string res_sign)
        {
            string res_bxml = "";
            try
            {
                //获取请求业务参数
                string req_bxml = AESHelper.DecryptForAES(req_encrypted, key);
                res_bxml = HisHelper.M_获取响应参数(req_fun_code, req_bxml, ref res_code, ref res_msg);
          
                res_encrypted = AESHelper.EncryptForAES(res_bxml, key);
                res_sign = Common.GetResponseSign(res_code, res_msg, res_encrypted, key);
            }
            catch (Exception ex)
            {
                res_code = 99;
                res_msg = req_fun_code + "交易失败" + ex.ToString();
                res_encrypted = AESHelper.EncryptForAES(res_bxml, key);
                res_sign = Common.GetResponseSign(res_code, res_msg, res_encrypted, key);
            }
        }
    }
}
