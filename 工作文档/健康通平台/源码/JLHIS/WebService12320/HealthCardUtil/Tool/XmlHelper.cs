using System.Xml;

namespace HealthCardUtil.Tool
{
    public class XmlHelper
    {

        public static void AnalysisXmlReqBaseInfo(string xmlInfo, ref string req_fun_code, ref string req_user_id, ref string req_sign, ref string req_sign_type, ref string req_encrypted)
        {
            XmlDocument root = new XmlDocument();
            root.LoadXml(xmlInfo);
            req_fun_code = root.SelectSingleNode("ROOT/FUN_CODE").InnerText;
            req_user_id = root.SelectSingleNode("ROOT/USER_ID").InnerText;
            req_sign = root.SelectSingleNode("ROOT/SIGN").InnerText;
            req_sign_type = root.SelectSingleNode("ROOT/SIGN_TYPE").InnerText;
            req_encrypted = root.SelectSingleNode("ROOT/REQ_ENCRYPTED").InnerText;
        }
    }
}
