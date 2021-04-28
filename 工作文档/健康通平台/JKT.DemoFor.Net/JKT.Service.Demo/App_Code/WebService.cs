using System.Web.Services;
using System.Configuration;
using System;
using System.Xml;

namespace JKT.Service.Demo
{
    /// <summary>
    /// 提供给健康通平台调用的 WebService 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    //若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消对下行的注释。 
    // [System.Web.Script.Services.ScriptService]
    public class WebService : System.Web.Services.WebService
    {

        public WebService()
        {

            //如果使用设计的组件，请取消注释以下行 
            //InitializeComponent(); 
        }

        /// <summary>
        /// 网络测试接口 提供给健康通平台调用
        /// </summary>
        /// <param name="xml"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true, Description = "网络测试接口 提供给健康通平台调用")]
        public string NetTest(string xml)
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

            string res_xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
            res_xml += @"<ROOT>
                           <RETURN_CODE><![CDATA[{0}]]></RETURN_CODE>
                           <RETURN_MSG><![CDATA[{1}]]></RETURN_MSG>
                           <SIGN_TYPE><![CDATA[{2}]]></SIGN_TYPE>
                           <SIGN><![CDATA[{3}]]></SIGN>
                           <RES_ENCRYPTED><![CDATA[{4}]]></RES_ENCRYPTED>
                         </ROOT>";

            string key = string.Empty;
            int res_code = 0;
            string res_msg = string.Empty;
            string res_sign = string.Empty;
            string res_encrypted = string.Empty;
            try
            {
                XmlDocument root = new XmlDocument();
                root.LoadXml(xml);

                string req_fun_code = root.SelectSingleNode("ROOT/FUN_CODE").InnerText;
                string req_user_id = root.SelectSingleNode("ROOT/USER_ID").InnerText;
                string req_sign = root.SelectSingleNode("ROOT/SIGN").InnerText;
                string req_sign_type = root.SelectSingleNode("ROOT/SIGN_TYPE").InnerText;
                string req_encrypted = root.SelectSingleNode("ROOT/REQ_ENCRYPTED").InnerText;


                key = ConfigurationManager.AppSettings["Key"].ToString();
                //对请求串进行用户校验
                string user_id = ConfigurationManager.AppSettings["UserId"].ToString();
                if (req_user_id != user_id)
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
                        //获取请求业务参数
                        string req_bxml = Common.DecryptForAES(req_encrypted, key);
                        XmlDocument req = new XmlDocument();
                        req.LoadXml(req_bxml);
                        string ip = req.SelectSingleNode("REQ/IP").InnerText;

                        //设置返回业务参数
                        string now = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

                        //设置返回串
                        string res_bxml = @"<RES>
                                              <SYSDATE>{0}</SYSDATE>
                                            </RES>";
                        res_bxml = string.Format(res_bxml, now);
                        res_code = 0;
                        res_msg = "交易成功";
                        res_encrypted = Common.EncryptForAES(res_bxml, key);
                        res_sign = Common.GetResponseSign(res_code, res_msg, res_encrypted, key);
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
                res_encrypted = Common.EncryptForAES("", key);
                res_sign = Common.GetResponseSign(res_code, res_msg, res_encrypted, key);
            }

            return string.Format(res_xml, res_code, res_msg, "MD5", res_sign, res_encrypted);
        }
    }
}
