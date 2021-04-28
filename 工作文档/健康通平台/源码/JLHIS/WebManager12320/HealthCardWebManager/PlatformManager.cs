using HealthCardWebManager.Security;
using HealthCardWebManager.Tool;
using HisCommon.DataEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace HealthCardWebManager
{
    public class PlatformManager
    {
        #region 单例实现
        private static PlatformManager _instance = null;

        public static PlatformManager Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new PlatformManager();
                }
                return _instance;
            }
        }
        #endregion

        #region 变量

        private static string userID = "ln_12320wx";
        private static string key = "2098D32C4D1399EC";

       
        private static string ipAddress = string.Empty;
        private static string port = string.Empty;
        private static readonly string url = "http://api.jilin12320.lywf.me/ApiService.asmx?wsdl";
         
        #endregion


        #region 私有方法

        public string  PackAESReqXml(string funCode,string signInfo,string encryptedXml)
        {
            string req_xml = "<![CDATA[<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
            req_xml += @"<ROOT>
               <FUN_CODE><![CDATA[{0}]]></FUN_CODE>
               <USER_ID><![CDATA[{1}]]></USER_ID>
               <SIGN_TYPE><![CDATA[{2}]]></SIGN_TYPE>
               <SIGN><![CDATA[{3}]]></SIGN>
               <REQ_ENCRYPTED><![CDATA[{4}]]></REQ_ENCRYPTED>
             </ROOT>]]>";

            req_xml = string.Format(req_xml, funCode, userID, "MD5", signInfo, encryptedXml);
            return req_xml;
        }
        #endregion

        #region 公开方法

        public  bool  StopReg(Platform_StopReg_InParam inParam,Dictionary<string,string> dicErr)
        {
           string errMsg = string.Empty;
           string  reqXml=  XmlHelper.AnalysisXmlReqStopRegInfo(inParam);
           string  req_encrypted = AESHelper.EncryptForAES(reqXml, key);
           string req_sign = Utility.GetRequestSign("5001", userID, req_encrypted, key);
           string req_bxml = PackAESReqXml("5001", req_sign, req_encrypted);
            string res_bxml = "";
         
                // 解析加密字符串
           string res_retrun_code = "", res_return_msg = "", res_sign_type = "", res_sign = "", res_encrypted = "";

            XmlHelper.AnalysisXmlResBaseInfo(res_bxml,ref res_retrun_code, ref res_return_msg, ref res_sign_type, ref res_sign, ref res_encrypted);
            if (res_retrun_code!="0")
            {
                dicErr.Add(res_retrun_code, res_return_msg);
                return false;
            }
            return true;
        }

        public bool CancelRegByHis(Platform_CancelRegByHIS_InParam inParam, Dictionary<string, string> dicErr)
        {
            string errMsg = string.Empty;
            string reqXml = XmlHelper.AnalysisXmlReqCancelRegInfo(inParam);
            string req_encrypted = AESHelper.EncryptForAES(reqXml, key);
            string req_sign = Utility.GetRequestSign("5002", userID, req_encrypted, key);
            string req_bxml = PackAESReqXml("5002", req_sign, req_encrypted);
            string res_bxml = "";

            // 解析加密字符串
            string res_retrun_code = "", res_return_msg = "", res_sign_type = "", res_sign = "", res_encrypted = "";

            XmlHelper.AnalysisXmlResBaseInfo(res_bxml, ref res_retrun_code, ref res_return_msg, ref res_sign_type, ref res_sign, ref res_encrypted);
            if (res_retrun_code != "0")
            {
                dicErr.Add(res_retrun_code, res_return_msg);
                return false;
            }
            return true;
        }

        public Platform_RefundByHIS_OutParam RefundByHis(Platform_RefundByHIS_InParam inParam, Dictionary<string, string> dicErr)
        {
            string errMsg = string.Empty;
            string reqXml = XmlHelper.AnalysisXmlReqRefundInfo(inParam);
            string req_encrypted = AESHelper.EncryptForAES(reqXml, key);
            string req_sign = Utility.GetRequestSign("5003", userID, req_encrypted, key);
            string req_bxml = PackAESReqXml("5003", req_sign, req_encrypted);
            string res_bxml = "";

            // 解析加密字符串
            string res_retrun_code = "", res_return_msg = "", res_sign_type = "", res_sign = "", res_encrypted = "";

            XmlHelper.AnalysisXmlResBaseInfo(res_bxml, ref res_retrun_code, ref res_return_msg, ref res_sign_type, ref res_sign, ref res_encrypted);
            if (res_retrun_code != "0")
            {
                dicErr.Add(res_retrun_code, res_return_msg);
                return null;
            }

            string res_xml = AESHelper.DecryptForAES(res_encrypted, key);
            return XmlHelper.AnalysisXmlResRefundInfo(res_xml);
        }

        public bool PrintRegByHis(Platform_PrintRegByHIS_InParam inParam, Dictionary<string, string> dicErr)
        {
            string errMsg = string.Empty;
            string reqXml = XmlHelper.AnalysisXmlReqPrintRegInfo(inParam);
            string req_encrypted = AESHelper.EncryptForAES(reqXml, key);
            string req_sign = Utility.GetRequestSign("5004", userID, req_encrypted, key);
            string req_bxml = PackAESReqXml("5004", req_sign, req_encrypted);
            string res_bxml = "";

            // 解析加密字符串
            string res_retrun_code = "", res_return_msg = "", res_sign_type = "", res_sign = "", res_encrypted = "";

            XmlHelper.AnalysisXmlResBaseInfo(res_bxml, ref res_retrun_code, ref res_return_msg, ref res_sign_type, ref res_sign, ref res_encrypted);
            if (res_retrun_code != "0")
            {
                dicErr.Add(res_retrun_code, res_return_msg);
                return false;
            }
            return true;
        }

        public bool PayRegByHis(Platform_PayRegByHIS_InParam inParam, Dictionary<string, string> dicErr)
        {

            string errMsg = string.Empty;
            string reqXml = XmlHelper.AnalysisXmlReqPayRegInfo(inParam);
            string req_encrypted = AESHelper.EncryptForAES(reqXml, key);
            string req_sign = Utility.GetRequestSign("5005", userID, req_encrypted, key);
            string req_bxml = PackAESReqXml("5005", req_sign, req_encrypted);
            string res_bxml = "";

            // 解析加密字符串
            string res_retrun_code = "", res_return_msg = "", res_sign_type = "", res_sign = "", res_encrypted = "";

            XmlHelper.AnalysisXmlResBaseInfo(res_bxml, ref res_retrun_code, ref res_return_msg, ref res_sign_type, ref res_sign, ref res_encrypted);
            if (res_retrun_code != "0")
            {
                dicErr.Add(res_retrun_code, res_return_msg);
                return false;
            }
            return true;
        }

        public Platform_QueryRegRefund_OutParam QueryRegRefund(Platform_QueryRegRefund_InParam inParam, Dictionary<string, string> dicErr)
        {

            string errMsg = string.Empty;
            string reqXml = XmlHelper.AnalysisXmlReqQueryRegRefundInfo(inParam);
            string req_encrypted = AESHelper.EncryptForAES(reqXml, key);
            string req_sign = Utility.GetRequestSign("5006", userID, req_encrypted, key);
            string req_bxml = PackAESReqXml("5006", req_sign, req_encrypted);
            string res_bxml = "";

            // 解析加密字符串
            string res_retrun_code = "", res_return_msg = "", res_sign_type = "", res_sign = "", res_encrypted = "";

            XmlHelper.AnalysisXmlResBaseInfo(res_bxml, ref res_retrun_code, ref res_return_msg, ref res_sign_type, ref res_sign, ref res_encrypted);
            if (res_retrun_code != "0")
            {
                dicErr.Add(res_retrun_code, res_return_msg);
                return null;
            }

            string res_xml = AESHelper.DecryptForAES(res_encrypted, key);
            return XmlHelper.AnalysisXmlResQueryRegRefundInfo(res_xml);
        }

        public Platform_RefundPay_OutParam RefundPay(Platform_RefundPay_InParam inParam, Dictionary<string, string> dicErr)
        {

            string errMsg = string.Empty;
            string reqXml = XmlHelper.AnalysisXmlReqRefundPayInfo(inParam);
            string req_encrypted = AESHelper.EncryptForAES(reqXml, key);
            string req_sign = Utility.GetRequestSign("6001", userID, req_encrypted, key);
            string req_bxml = PackAESReqXml("6001", req_sign, req_encrypted);
            string res_bxml = "";

            // 解析加密字符串
            string res_retrun_code = "", res_return_msg = "", res_sign_type = "", res_sign = "", res_encrypted = "";

            XmlHelper.AnalysisXmlResBaseInfo(res_bxml, ref res_retrun_code, ref res_return_msg, ref res_sign_type, ref res_sign, ref res_encrypted);
            if (res_retrun_code != "0")
            {
                dicErr.Add(res_retrun_code, res_return_msg);
                return null;
            }

            string res_xml = AESHelper.DecryptForAES(res_encrypted, key);
            return XmlHelper.AnalysisXmlResRefundPayInfo(res_xml);
        }

        public Platform_QueryPayRefund_OutParam QueryPayRefund(Platform_QueryPayRefund_InParam inParam, Dictionary<string, string> dicErr)
        {
            string errMsg = string.Empty;
            string reqXml = XmlHelper.AnalysisXmlReqQueryPayRefundInfo(inParam);
            string req_encrypted = AESHelper.EncryptForAES(reqXml, key);
            string req_sign = Utility.GetRequestSign("6002", userID, req_encrypted, key);
            string req_bxml = PackAESReqXml("6002", req_sign, req_encrypted);
            string res_bxml = "";

            // 解析加密字符串
            string res_retrun_code = "", res_return_msg = "", res_sign_type = "", res_sign = "", res_encrypted = "";

            XmlHelper.AnalysisXmlResBaseInfo(res_bxml, ref res_retrun_code, ref res_return_msg, ref res_sign_type, ref res_sign, ref res_encrypted);
            if (res_retrun_code != "0")
            {
                dicErr.Add(res_retrun_code, res_return_msg);
                return null;
            }

            string res_xml = AESHelper.DecryptForAES(res_encrypted, key);
            return XmlHelper.AnalysisXmlResQueryPayRefundInfo(res_xml);
        }

        public bool PushInfo(Platform_PushInfo_InParam inParam, Dictionary<string, string> dicErr)
        {
            string errMsg = string.Empty;
            string reqXml = XmlHelper.AnalysisXmlReqPushInfo(inParam);
            string req_encrypted = AESHelper.EncryptForAES(reqXml, key);
            string req_sign = Utility.GetRequestSign("7001", userID, req_encrypted, key);
            string req_bxml = PackAESReqXml("7001", req_sign, req_encrypted);
            string res_bxml = "";

            // 解析加密字符串
            string res_retrun_code = "", res_return_msg = "", res_sign_type = "", res_sign = "", res_encrypted = "";

            XmlHelper.AnalysisXmlResBaseInfo(res_bxml, ref res_retrun_code, ref res_return_msg, ref res_sign_type, ref res_sign, ref res_encrypted);
            if (res_retrun_code != "0")
            {
                dicErr.Add(res_retrun_code, res_return_msg);
                return false;
            }

            return true;
        }
        #endregion

    }
}
