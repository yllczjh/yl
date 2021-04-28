using HealthCardWcfService.Security;
using HealthCardWcfService.Tool;
using HisCommon.DataEntity;
using System;

namespace HealthCardWcfService
{
    // 注意: 使用“重构”菜单上的“重命名”命令，可以同时更改代码和配置文件中的类名“Service1”。
    public class Service1 : IService1
    {
        private static string userID = "ln_12320wx";
        private static string key = "2098D32C4D1399EC";
        // ServiceReference1.WsModelSoapClient client = new ServiceReference1.WsModelSoapClient();
       // private  SoapClient soapHelper = new SoapClient(new Uri("http://api.jilin12320.lywf.me/ApiService.asmx"), "http://tempuri.org/RegService");
        // 48 服务地址
        private SoapClient soapHelper = new SoapClient(new Uri("http://api.jilin12320.lywf.me:18820/ApiService.asmx"), "http://tempuri.org/RegService");
        private log4net.ILog log = log4net.LogManager.GetLogger("log4net");
        public string GetData(int value)
        {
            //return string.Format("You entered: {0}", value);
            string str_返回值 = "";
            switch(value){
                case 5001:
                    break;
            }
            return str_返回值;

        }

        public CompositeType GetDataUsingDataContract(CompositeType composite)
        {
            if (composite == null)
            {
                throw new ArgumentNullException("composite");
            }
            if (composite.BoolValue)
            {
                composite.StringValue += "Suffix";
            }
            return composite;
        }

        #region  公开方法
        public Platform_StopReg_OutParamInfo StopReg(Platform_StopReg_InParam inParam)
        {
            Platform_StopReg_OutParamInfo outParam = new Platform_StopReg_OutParamInfo();

            string errMsg = string.Empty;
            string reqXml = XmlHelper.AnalysisXmlReqStopRegInfo(inParam);

            log.Debug("Method [StopReg] InParam xml Info:" + reqXml);

            string req_encrypted = AESHelper.EncryptForAES(reqXml, key);
            string req_sign = Utility.GetRequestSign("5001", userID, req_encrypted, key);
            // client.SoapAction = req_bxml;
            SoapParameter hs1 = new SoapParameter("FUN_CODE", "5001");
            SoapParameter hs2 = new SoapParameter("USER_ID", "ln_12320wx");
            SoapParameter hs3 = new SoapParameter("SIGN_TYPE", "MD5");
            SoapParameter hs4 = new SoapParameter("SIGN", req_sign);
            SoapParameter hs5 = new SoapParameter("REQ_ENCRYPTED", req_encrypted);

            soapHelper.Arguments.Clear();
            soapHelper.Arguments.Add(hs1);
            soapHelper.Arguments.Add(hs2);
            soapHelper.Arguments.Add(hs3);
            soapHelper.Arguments.Add(hs4);
            soapHelper.Arguments.Add(hs5);

            string res_bxml = soapHelper.GetResult().ToString();

            log.Debug("Method [StopReg] Result xml Info:" + res_bxml);

            // 解析加密字符串
            string res_retrun_code = "", res_return_msg = "", res_sign_type = "", res_sign = "", res_encrypted = "";

            XmlHelper.AnalysisXmlResBaseInfo(res_bxml, ref res_retrun_code, ref res_return_msg, ref res_sign_type, ref res_sign, ref res_encrypted);

            log.Debug("Method [StopReg] ReturnCode[" + res_retrun_code + "] ReturnMsg [" + res_return_msg + "]");
            outParam.ErrCode = res_retrun_code;
            outParam.ErrMsg = res_return_msg;
            return outParam;
        }
        public Platform_CancelRegByHIS_OutParamInfo CancelRegByHis(Platform_CancelRegByHIS_InParam inParam)
        {
            Platform_CancelRegByHIS_OutParamInfo outParam = new Platform_CancelRegByHIS_OutParamInfo();
            string errMsg = string.Empty;
            string reqXml = XmlHelper.AnalysisXmlReqCancelRegInfo(inParam);

            log.Debug("Method [CancelRegByHis] InParam xml Info:" + reqXml);

            string req_encrypted = AESHelper.EncryptForAES(reqXml, key);
            string req_sign = Utility.GetRequestSign("5002", userID, req_encrypted, key);
          
            SoapParameter hs1 = new SoapParameter("FUN_CODE", "5002");
            SoapParameter hs2 = new SoapParameter("USER_ID", "ln_12320wx");
            SoapParameter hs3 = new SoapParameter("SIGN_TYPE", "MD5");
            SoapParameter hs4 = new SoapParameter("SIGN", req_sign);
            SoapParameter hs5 = new SoapParameter("REQ_ENCRYPTED", req_encrypted);

            soapHelper.Arguments.Clear();
            soapHelper.Arguments.Add(hs1);
            soapHelper.Arguments.Add(hs2);
            soapHelper.Arguments.Add(hs3);
            soapHelper.Arguments.Add(hs4);
            soapHelper.Arguments.Add(hs5);

            string res_bxml = soapHelper.GetResult().ToString();
            log.Debug("Method [CancelRegByHis] Result xml Info:" + res_bxml);

            // 解析加密字符串
            string res_retrun_code = "", res_return_msg = "", res_sign_type = "", res_sign = "", res_encrypted = "";

            XmlHelper.AnalysisXmlResBaseInfo(res_bxml, ref res_retrun_code, ref res_return_msg, ref res_sign_type, ref res_sign, ref res_encrypted);
            log.Debug("Method [StopReg] ReturnCode[" + res_retrun_code + "] ReturnMsg [" + res_return_msg + "]");

            outParam.ErrCode = res_retrun_code;
            outParam.ErrMsg = res_return_msg;
            return outParam;
        }

        public Platform_RefundByHIS_OutParamInfo RefundByHis(Platform_RefundByHIS_InParam inParam)
        {
            Platform_RefundByHIS_OutParamInfo outParam = new Platform_RefundByHIS_OutParamInfo();
            string errMsg = string.Empty;
            string reqXml = XmlHelper.AnalysisXmlReqRefundInfo(inParam);

            log.Debug("Method [RefundByHis] InParam xml Info:" + reqXml);

            string req_encrypted = AESHelper.EncryptForAES(reqXml, key);
            string req_sign = Utility.GetRequestSign("5003", userID, req_encrypted, key);
            SoapParameter hs1 = new SoapParameter("FUN_CODE", "5003");
            SoapParameter hs2 = new SoapParameter("USER_ID", "ln_12320wx");
            SoapParameter hs3 = new SoapParameter("SIGN_TYPE", "MD5");
            SoapParameter hs4 = new SoapParameter("SIGN", req_sign);
            SoapParameter hs5 = new SoapParameter("REQ_ENCRYPTED", req_encrypted);

            soapHelper.Arguments.Clear();
            soapHelper.Arguments.Add(hs1);
            soapHelper.Arguments.Add(hs2);
            soapHelper.Arguments.Add(hs3);
            soapHelper.Arguments.Add(hs4);
            soapHelper.Arguments.Add(hs5);

            string res_bxml = soapHelper.GetResult().ToString();
            log.Debug("Method [CancelRegByHis] Result xml Info:" + res_bxml);

            // 解析加密字符串
            string res_retrun_code = "", res_return_msg = "", res_sign_type = "", res_sign = "", res_encrypted = "";

            XmlHelper.AnalysisXmlResBaseInfo(res_bxml, ref res_retrun_code, ref res_return_msg, ref res_sign_type, ref res_sign, ref res_encrypted);
            log.Debug("Method [CancelRegByHis] ReturnCode[" + res_retrun_code + "] ReturnMsg [" + res_return_msg + "]");

            outParam.ErrCode = res_retrun_code;
            outParam.ErrMsg = res_return_msg;
            if (outParam.ErrCode != "0")
                return outParam;

            string res_xml = AESHelper.DecryptForAES(res_encrypted, key);
            log.Debug("Method [CancelRegByHis] Resxml Info [" + res_xml + "]");

            outParam.OutParam = XmlHelper.AnalysisXmlResRefundInfo(res_xml);
            return outParam;
        }

        public Platform_PrintRegByHIS_OutParamInfo PrintRegByHis(Platform_PrintRegByHIS_InParam inParam)
        {
            Platform_PrintRegByHIS_OutParamInfo outParam = new Platform_PrintRegByHIS_OutParamInfo();

            string errMsg = string.Empty;
            string reqXml = XmlHelper.AnalysisXmlReqPrintRegInfo(inParam);
            log.Debug("Method [PrintRegByHis] InParam xml Info:" + reqXml);

            string req_encrypted = AESHelper.EncryptForAES(reqXml, key);
            string req_sign = Utility.GetRequestSign("5004", userID, req_encrypted, key);
            SoapParameter hs1 = new SoapParameter("FUN_CODE", "5004");
            SoapParameter hs2 = new SoapParameter("USER_ID", "ln_12320wx");
            SoapParameter hs3 = new SoapParameter("SIGN_TYPE", "MD5");
            SoapParameter hs4 = new SoapParameter("SIGN", req_sign);
            SoapParameter hs5 = new SoapParameter("REQ_ENCRYPTED", req_encrypted);

            soapHelper.Arguments.Clear();
            soapHelper.Arguments.Add(hs1);
            soapHelper.Arguments.Add(hs2);
            soapHelper.Arguments.Add(hs3);
            soapHelper.Arguments.Add(hs4);
            soapHelper.Arguments.Add(hs5);

            string res_bxml = soapHelper.GetResult().ToString();
            log.Debug("Method [PrintRegByHis] Result xml Info:" + res_bxml);

            // 解析加密字符串
            string res_retrun_code = "", res_return_msg = "", res_sign_type = "", res_sign = "", res_encrypted = "";

            XmlHelper.AnalysisXmlResBaseInfo(res_bxml, ref res_retrun_code, ref res_return_msg, ref res_sign_type, ref res_sign, ref res_encrypted);
            log.Debug("Method [PrintRegByHis] ReturnCode[" + res_retrun_code + "] ReturnMsg [" + res_return_msg + "]");
            outParam.ErrCode = res_retrun_code;
            outParam.ErrMsg = res_return_msg;

            return outParam;
        }

        public Platform_PayRegByHIS_OutParamInfo PayRegByHis(Platform_PayRegByHIS_InParam inParam)
        {
            Platform_PayRegByHIS_OutParamInfo outParam = new Platform_PayRegByHIS_OutParamInfo();

            string errMsg = string.Empty;
            string reqXml = XmlHelper.AnalysisXmlReqPayRegInfo(inParam);

            log.Debug("Method [PayRegByHis] InParam xml Info:" + reqXml);

            string req_encrypted = AESHelper.EncryptForAES(reqXml, key);
            string req_sign = Utility.GetRequestSign("5005", userID, req_encrypted, key);
            SoapParameter hs1 = new SoapParameter("FUN_CODE", "5005");
            SoapParameter hs2 = new SoapParameter("USER_ID", "ln_12320wx");
            SoapParameter hs3 = new SoapParameter("SIGN_TYPE", "MD5");
            SoapParameter hs4 = new SoapParameter("SIGN", req_sign);
            SoapParameter hs5 = new SoapParameter("REQ_ENCRYPTED", req_encrypted);

            soapHelper.Arguments.Clear();
            soapHelper.Arguments.Add(hs1);
            soapHelper.Arguments.Add(hs2);
            soapHelper.Arguments.Add(hs3);
            soapHelper.Arguments.Add(hs4);
            soapHelper.Arguments.Add(hs5);

            string res_bxml = soapHelper.GetResult().ToString();
            log.Debug("Method [PayRegByHis] Result xml Info:" + res_bxml);

            // 解析加密字符串
            string res_retrun_code = "", res_return_msg = "", res_sign_type = "", res_sign = "", res_encrypted = "";

            XmlHelper.AnalysisXmlResBaseInfo(res_bxml, ref res_retrun_code, ref res_return_msg, ref res_sign_type, ref res_sign, ref res_encrypted);
            log.Debug("Method [PayRegByHis] ReturnCode[" + res_retrun_code + "] ReturnMsg [" + res_return_msg + "]");
            outParam.ErrCode = res_retrun_code;
            outParam.ErrMsg = res_return_msg;
            return outParam;
        }

        public Platform_QueryRegRefund_OutParamInfo QueryRegRefund(Platform_QueryRegRefund_InParam inParam)
        {
            Platform_QueryRegRefund_OutParamInfo outParam = new Platform_QueryRegRefund_OutParamInfo();
            string errMsg = string.Empty;
            string reqXml = XmlHelper.AnalysisXmlReqQueryRegRefundInfo(inParam);

            log.Debug("Method [QueryRegRefund] InParam xml Info:" + reqXml);

            string req_encrypted = AESHelper.EncryptForAES(reqXml, key);
            string req_sign = Utility.GetRequestSign("5006", userID, req_encrypted, key);
            SoapParameter hs1 = new SoapParameter("FUN_CODE", "5006");
            SoapParameter hs2 = new SoapParameter("USER_ID", "ln_12320wx");
            SoapParameter hs3 = new SoapParameter("SIGN_TYPE", "MD5");
            SoapParameter hs4 = new SoapParameter("SIGN", req_sign);
            SoapParameter hs5 = new SoapParameter("REQ_ENCRYPTED", req_encrypted);

            soapHelper.Arguments.Clear();
            soapHelper.Arguments.Add(hs1);
            soapHelper.Arguments.Add(hs2);
            soapHelper.Arguments.Add(hs3);
            soapHelper.Arguments.Add(hs4);
            soapHelper.Arguments.Add(hs5);
            log.Debug("Method [QueryRegRefund] Result xml Info:" + reqXml);
            string res_bxml = soapHelper.GetResult().ToString();
            log.Debug("Method [QueryRegRefund] Result xml Info:" + res_bxml);

            // 解析加密字符串
            string res_retrun_code = "", res_return_msg = "", res_sign_type = "", res_sign = "", res_encrypted = "";

            XmlHelper.AnalysisXmlResBaseInfo(res_bxml, ref res_retrun_code, ref res_return_msg, ref res_sign_type, ref res_sign, ref res_encrypted);
            log.Debug("Method [QueryRegRefund] ReturnCode[" + res_retrun_code + "] ReturnMsg [" + res_return_msg + "]");

            outParam.ErrCode = res_retrun_code;
            outParam.ErrMsg = res_return_msg;
            if (outParam.ErrCode != "0")
                return outParam;

            string res_xml = AESHelper.DecryptForAES(res_encrypted, key);
            log.Debug("Method [QueryRegRefund] Resxml Info[" + res_xml + "]");
            if (string.IsNullOrEmpty(res_xml))
                return outParam;
            outParam.OutParam = XmlHelper.AnalysisXmlResQueryRegRefundInfo(res_xml);
            return outParam;
        }

        public Platform_RefundPay_OutParamInfo RefundPay(Platform_RefundPay_InParam inParam)
        {
            Platform_RefundPay_OutParamInfo outParam = new Platform_RefundPay_OutParamInfo();

            string errMsg = string.Empty;
            string reqXml = XmlHelper.AnalysisXmlReqRefundPayInfo(inParam);

            log.Debug("Method [RefundPay] InParam xml Info:" + reqXml);

            string req_encrypted = AESHelper.EncryptForAES(reqXml, key);
            string req_sign = Utility.GetRequestSign("6001", userID, req_encrypted, key);
            SoapParameter hs1 = new SoapParameter("FUN_CODE", "6001");
            SoapParameter hs2 = new SoapParameter("USER_ID", "ln_12320wx");
            SoapParameter hs3 = new SoapParameter("SIGN_TYPE", "MD5");
            SoapParameter hs4 = new SoapParameter("SIGN", req_sign);
            SoapParameter hs5 = new SoapParameter("REQ_ENCRYPTED", req_encrypted);

            soapHelper.Arguments.Clear();
            soapHelper.Arguments.Add(hs1);
            soapHelper.Arguments.Add(hs2);
            soapHelper.Arguments.Add(hs3);
            soapHelper.Arguments.Add(hs4);
            soapHelper.Arguments.Add(hs5);

            string res_bxml = soapHelper.GetResult().ToString();
            log.Debug("Method [RefundPay] Result xml Info:" + res_bxml);

            // 解析加密字符串
            string res_retrun_code = "", res_return_msg = "", res_sign_type = "", res_sign = "", res_encrypted = "";

            XmlHelper.AnalysisXmlResBaseInfo(res_bxml, ref res_retrun_code, ref res_return_msg, ref res_sign_type, ref res_sign, ref res_encrypted);
            log.Debug("Method [RefundPay] ReturnCode[" + res_retrun_code + "] ReturnMsg [" + res_return_msg + "]");

            outParam.ErrCode = res_retrun_code;
            outParam.ErrMsg = res_return_msg;
            if (res_retrun_code != "0")
            {
                return outParam;
            }

            string res_xml = AESHelper.DecryptForAES(res_encrypted, key);
            log.Debug("Method [RefundPay] Resxml Info[" + res_xml + "]");
            outParam.OutParam= XmlHelper.AnalysisXmlResRefundPayInfo(res_xml);

            return outParam;
        }

        public Platform_QueryPayRefund_OutParamInfo QueryPayRefund(Platform_QueryPayRefund_InParam inParam)
        {
            Platform_QueryPayRefund_OutParamInfo outParam = new Platform_QueryPayRefund_OutParamInfo();

            string errMsg = string.Empty;
            string reqXml = XmlHelper.AnalysisXmlReqQueryPayRefundInfo(inParam);

            log.Debug("Method [QueryPayRefund] InParam xml Info:" + reqXml);

            string req_encrypted = AESHelper.EncryptForAES(reqXml, key);
            string req_sign = Utility.GetRequestSign("6002", userID, req_encrypted, key);
            SoapParameter hs1 = new SoapParameter("FUN_CODE", "6002");
            SoapParameter hs2 = new SoapParameter("USER_ID", "ln_12320wx");
            SoapParameter hs3 = new SoapParameter("SIGN_TYPE", "MD5");
            SoapParameter hs4 = new SoapParameter("SIGN", req_sign);
            SoapParameter hs5 = new SoapParameter("REQ_ENCRYPTED", req_encrypted);

            soapHelper.Arguments.Clear();
            soapHelper.Arguments.Add(hs1);
            soapHelper.Arguments.Add(hs2);
            soapHelper.Arguments.Add(hs3);
            soapHelper.Arguments.Add(hs4);
            soapHelper.Arguments.Add(hs5);

            string res_bxml = soapHelper.GetResult().ToString();
            log.Debug("Method [QueryPayRefund] Result xml Info:" + res_bxml);

            // 解析加密字符串
            string res_retrun_code = "", res_return_msg = "", res_sign_type = "", res_sign = "", res_encrypted = "";

            XmlHelper.AnalysisXmlResBaseInfo(res_bxml, ref res_retrun_code, ref res_return_msg, ref res_sign_type, ref res_sign, ref res_encrypted);
            log.Debug("Method [QueryPayRefund] ReturnCode[" + res_retrun_code + "] ReturnMsg [" + res_return_msg + "]");

            outParam.ErrCode = res_retrun_code;
            outParam.ErrMsg = res_return_msg;
            if (res_retrun_code != "0")
            {
                return outParam;
            }

            string res_xml = AESHelper.DecryptForAES(res_encrypted, key);
            log.Debug("Method [QueryPayRefund] Resxml Info[" + res_xml + "]");

            outParam.OutParam= XmlHelper.AnalysisXmlResQueryPayRefundInfo(res_xml);

            return outParam;
        }

        public Platform_PushInfo_OutParam PushInfo(Platform_PushInfo_InParam inParam)
        {
            Platform_PushInfo_OutParam outParam = new Platform_PushInfo_OutParam();
            string errMsg = string.Empty;
            string reqXml = XmlHelper.AnalysisXmlReqPushInfo(inParam);

            log.Debug("Method [PushInfo] InParam xml Info:" + reqXml);

            string req_encrypted = AESHelper.EncryptForAES(reqXml, key);
            string req_sign = Utility.GetRequestSign("7001", userID, req_encrypted, key);
            SoapParameter hs1 = new SoapParameter("FUN_CODE", "7001");
            SoapParameter hs2 = new SoapParameter("USER_ID", "ln_12320wx");
            SoapParameter hs3 = new SoapParameter("SIGN_TYPE", "MD5");
            SoapParameter hs4 = new SoapParameter("SIGN", req_sign);
            SoapParameter hs5 = new SoapParameter("REQ_ENCRYPTED", req_encrypted);

            soapHelper.Arguments.Clear();
            soapHelper.Arguments.Add(hs1);
            soapHelper.Arguments.Add(hs2);
            soapHelper.Arguments.Add(hs3);
            soapHelper.Arguments.Add(hs4);
            soapHelper.Arguments.Add(hs5);

            string res_bxml = soapHelper.GetResult().ToString();
            log.Debug("Method [PushInfo] Result xml Info:" + res_bxml);

            // 解析加密字符串
            string res_retrun_code = "", res_return_msg = "", res_sign_type = "", res_sign = "", res_encrypted = "";

            XmlHelper.AnalysisXmlResBaseInfo(res_bxml, ref res_retrun_code, ref res_return_msg, ref res_sign_type, ref res_sign, ref res_encrypted);
            log.Debug("Method [PushInfo] ReturnCode[" + res_retrun_code + "] ReturnMsg [" + res_return_msg + "]");

            outParam.ErrMsg = res_return_msg;
            outParam.ErrCode = res_retrun_code;

            return outParam;
        }
        #endregion
    }
}
