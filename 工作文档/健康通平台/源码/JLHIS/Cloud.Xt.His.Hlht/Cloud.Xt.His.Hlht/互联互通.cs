using System.Security.Cryptography;
using System.Text;
using System.Web.Security;

namespace Cloud.Xt.His.Hlht
{
    public class 互联互通 //: I_互联互通
    {
        public string M_互联互通接口(int int_功能号, object obj_参数实体)
        {
            string req_xml = "";
            switch (int_功能号)
            {
                case 5001:
                    req_xml = XMLHelper.M_停诊通知请求参数(obj_参数实体);
                    break;
                case 5002:
                    req_xml = XMLHelper.M_取消挂号请求参数(obj_参数实体);
                    break;
                case 5003:
                    req_xml = XMLHelper.M_退款请求参数(obj_参数实体);
                    break;
                case 5004:
                    req_xml = XMLHelper.M_取号请求参数(obj_参数实体);
                    break;
                case 5005:
                    req_xml = XMLHelper.M_窗口支付请求参数(obj_参数实体);
                    break;
                case 5006:
                    req_xml = XMLHelper.M_挂号退款查询请求参数(obj_参数实体);
                    break;
                case 6001:
                    req_xml = XMLHelper.M_缴费退款请求参数(obj_参数实体);
                    break;
                case 6002:
                    req_xml = XMLHelper.M_缴费退款查询请求参数(obj_参数实体);
                    break;
            }


            string REQ_ENCRYPTED = AESHelper.EncryptForAES(req_xml, "2098D32C4D1399EC");

            string encryptString = "FUN_CODE=" + int_功能号 + "&REQ_ENCRYPTED=" + REQ_ENCRYPTED + "&USER_ID=ln_12320wx&KEY=2098D32C4D1399EC";


            MD5CryptoServiceProvider md5CSP = new MD5CryptoServiceProvider();
            byte[] testEncrypt = Encoding.Unicode.GetBytes(encryptString);
            byte[] resultEncrypt = md5CSP.ComputeHash(testEncrypt);
            string testResult = System.Text.Encoding.Unicode.GetString(resultEncrypt);
            string result = FormsAuthentication.HashPasswordForStoringInConfigFile(encryptString, "MD5");



            string res_xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
            res_xml += @"<ROOT>
                           <FUN_CODE><![CDATA[{0}]]></FUN_CODE>
                           <USER_ID><![CDATA[ln_12320wx]]></USER_ID>
                           <SIGN_TYPE><![CDATA[MD5]]></SIGN_TYPE>
                           <SIGN><![CDATA[{1}]]></SIGN>
                           <REQ_ENCRYPTED><![CDATA[{2}]]></REQ_ENCRYPTED>
                         </ROOT>";

            res_xml = string.Format(res_xml, int_功能号, result, REQ_ENCRYPTED);

            return res_xml;
        }
    }
}
