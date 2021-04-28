using HisCommon.DataEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;

namespace HealthCardWebManager.Tool
{
    public class XmlHelper
    {
        private static string HosID = "41275532X";

        public static void AnalysisXmlResBaseInfo(string xmlInfo, ref string res_retrun_code, ref string res_return_msg, ref string res_sign_type, ref string res_sign, ref string res_encrypted)
        {
            XmlDocument root = new XmlDocument();
            root.LoadXml(xmlInfo);
            res_retrun_code = root.SelectSingleNode("ROOT/RETURN_CODE").InnerText;
            res_return_msg = root.SelectSingleNode("ROOT/RETURN_MSG").InnerText;
            res_sign_type = root.SelectSingleNode("ROOT/SIGN_TYPE").InnerText;
            res_sign = root.SelectSingleNode("ROOT/SIGN").InnerText;
            res_encrypted = root.SelectSingleNode("ROOT/RES_ENCRYPTED").InnerText;
        }

        public static string AnalysisXmlReqStopRegInfo(Platform_StopReg_InParam  stopRegInParam)
        {
            StringBuilder builder = new StringBuilder();
            builder.Append("<REQ>");
            builder.Append("<HOS_ID>" + HosID + "</HOS_ID>");
            builder.Append("<DEPT_ID>" + stopRegInParam.DEPT_ID + "</DEPT_ID>");
            builder.Append("<DOCTOR_ID>" + stopRegInParam.DOCTOR_ID + "</DOCTOR_ID>");
            builder.Append("<REG_DATE>" + stopRegInParam.REG_DATE + "</REG_DATE>");
            builder.Append("<TIME_FLAG>" + stopRegInParam.TIME_FLAG + "</TIME_FLAG>");
            builder.Append("<BEGIN_TIME>" + stopRegInParam.BEGIN_TIME + "</BEGIN_TIME>");
            builder.Append("<END_TIME>" + stopRegInParam.END_TIME + "</END_TIME>");
            builder.Append("<STOP_REMARK>" + stopRegInParam.STOP_REMARK + "</STOP_REMARK>");
            builder.Append("<IS_REFUND>" + stopRegInParam.IS_REFUND + "</IS_REFUND>");
            builder.Append("<IS_CANCEL>" + stopRegInParam.IS_CANCEL + "</IS_CANCEL>");
            builder.Append("</REQ>");
            return builder.ToString();
        }

        public static string AnalysisXmlReqCancelRegInfo(Platform_CancelRegByHIS_InParam cancelRegInParam)
        {
            StringBuilder builder = new StringBuilder();
            builder.Append("<REQ>");
            builder.Append("<HOS_ID>" + HosID + "</HOS_ID>");
            builder.Append("<ORDER_ID>" + cancelRegInParam.ORDER_ID + "</ORDER_ID>");
            builder.Append("<CANCEL_DATE>" + cancelRegInParam.CANCEL_DATE + "</CANCEL_DATE>");
            builder.Append("<CANCEL_REMARK>" + cancelRegInParam.CANCEL_REMARK + "</CANCEL_REMARK>");
            builder.Append("</REQ>");
            return builder.ToString();
        }

        public static string AnalysisXmlReqRefundInfo(Platform_RefundByHIS_InParam refundInParam)
        {
            StringBuilder builder = new StringBuilder();
            builder.Append("<REQ>");
            builder.Append("<HOS_ID>" + HosID + "</HOS_ID>");
            builder.Append("<ORDER_ID>" + refundInParam.ORDER_ID + "</ORDER_ID>");
            builder.Append("<HOSP_ORDER_ID>" + refundInParam.HOSP_ORDER_ID + "</HOSP_ORDER_ID>");
            builder.Append("<HOSP_REFUND_ID>" + refundInParam.HOSP_REFUND_ID + "</HOSP_REFUND_ID>");
            builder.Append("<REFUND_TYPE>" + refundInParam.REFUND_TYPE + "</REFUND_TYPE>");
            builder.Append("<REFUND_DATE>" + refundInParam.REFUND_DATE + "</REFUND_DATE>");
            builder.Append("<TOTAL_FEE>" + refundInParam.TOTAL_FEE + "</TOTAL_FEE>");
            builder.Append("<REFUND_FEE>" + refundInParam.REFUND_FEE + "</REFUND_FEE>");
            builder.Append("<REFUND_REMARK>" + refundInParam.REFUND_REMARK + "</REFUND_REMARK>");
            builder.Append("</REQ>");
            return builder.ToString();
        }

        public static Platform_RefundByHIS_OutParam AnalysisXmlResRefundInfo(string strResXml)
        {
            Platform_RefundByHIS_OutParam outParam = new Platform_RefundByHIS_OutParam();
            XmlDocument root = new XmlDocument();
            root.LoadXml(strResXml);
            outParam.REFUND_ID = root.SelectSingleNode("RES/REFUND_ID").InnerText;
            return outParam;
        }

        public static string AnalysisXmlReqPrintRegInfo(Platform_PrintRegByHIS_InParam printRegInParam)
        {
            StringBuilder builder = new StringBuilder();
            builder.Append("<REQ>");
            builder.Append("<HOS_ID>" + HosID + "</HOS_ID>");
            builder.Append("<ORDER_ID>" + printRegInParam.ORDER_ID + "</ORDER_ID>");
            builder.Append("<HOSP_SERIAL_NUM>" + printRegInParam.HOSP_SERIAL_NUM + "</HOSP_SERIAL_NUM>");
            builder.Append("<PRINT_DATE>" + printRegInParam.PRINT_DATE + "</PRINT_DATE>");
            builder.Append("</REQ>");
            return builder.ToString();
        }

        public static string AnalysisXmlReqPayRegInfo(Platform_PayRegByHIS_InParam payRegInParam)
        {
            StringBuilder builder = new StringBuilder();
            builder.Append("<REQ>");
            builder.Append("<HOS_ID>" + HosID + "</HOS_ID>");
            builder.Append("<ORDER_ID>" + payRegInParam.ORDER_ID + "</ORDER_ID>");
            builder.Append("<HOSP_SERIAL_NUM>" + payRegInParam.HOSP_SERIAL_NUM + "</HOSP_SERIAL_NUM>");
            builder.Append("<PAY_FEE>" + payRegInParam.PAY_FEE + "</PAY_FEE>");
            builder.Append("<PAY_DATE>" + payRegInParam.PAY_DATE + "</PAY_DATE>");
            builder.Append("</REQ>");
            return builder.ToString();
        }

        public static string AnalysisXmlReqQueryRegRefundInfo(Platform_QueryRegRefund_InParam queryRefundInParam)
        {
            StringBuilder builder = new StringBuilder();
            builder.Append("<REQ>");
            builder.Append("<HOS_ID>" + HosID + "</HOS_ID>");
            builder.Append("<ORDER_ID>" + queryRefundInParam.ORDER_ID + "</ORDER_ID>");
            builder.Append("<REFUND_ID>" + queryRefundInParam.REFUND_ID + "</REFUND_ID>");
            builder.Append("<HOSP_REFUND_ID>" + queryRefundInParam.HOSP_REFUND_ID + "</HOSP_REFUND_ID>");
            builder.Append("</REQ>");
            return builder.ToString();
        }

        public static Platform_QueryRegRefund_OutParam AnalysisXmlResQueryRegRefundInfo(string strResXml)
        {
            Platform_QueryRegRefund_OutParam outParam = new Platform_QueryRegRefund_OutParam();
            XmlDocument root = new XmlDocument();
            root.LoadXml(strResXml);
            outParam.TOTAL_FEE = root.SelectSingleNode("RES/TOTAL_FEE").InnerText;
            outParam.REFUND_FEE = root.SelectSingleNode("RES/REFUND_FEE").InnerText;
            outParam.REFUND_ID = root.SelectSingleNode("RES/REFUND_ID").InnerText;
            outParam.REFUND_COUNT = root.SelectSingleNode("RES/REFUND_COUNT").InnerText;
            outParam.REFUND_STATUS = root.SelectSingleNode("RES/REFUND_STATUS").InnerText;
            return outParam;
        }

        public static string AnalysisXmlReqRefundPayInfo(Platform_RefundPay_InParam refundPayInParam)
        {
            StringBuilder builder = new StringBuilder();
            builder.Append("<REQ>");
            builder.Append("<HOS_ID>" + HosID + "</HOS_ID>");
            builder.Append("<ORDER_ID>" + refundPayInParam.ORDER_ID + "</ORDER_ID>");
            builder.Append("<HOSP_SEQUENCE>" + refundPayInParam.HOSP_SEQUENCE + "</HOSP_SEQUENCE>");
            builder.Append("<HOSP_REFUND_ID>" + refundPayInParam.HOSP_REFUND_ID + "</HOSP_REFUND_ID>");
            builder.Append("<REFUND_TYPE>" + refundPayInParam.REFUND_TYPE + "</REFUND_TYPE>");
            builder.Append("<REFUND_DATE>" + refundPayInParam.REFUND_DATE + "</REFUND_DATE>");
            builder.Append("<TOTAL_FEE>" + refundPayInParam.TOTAL_FEE + "</TOTAL_FEE>");
            builder.Append("<REFUND_FEE>" + refundPayInParam.REFUND_FEE + "</REFUND_FEE>");
            builder.Append("<REFUND_REMARK>" + refundPayInParam.REFUND_REMARK + "</REFUND_REMARK>");
            builder.Append("</REQ>");
            return builder.ToString();
        }

        public static Platform_RefundPay_OutParam AnalysisXmlResRefundPayInfo(string strResXml)
        {
            Platform_RefundPay_OutParam outParam = new Platform_RefundPay_OutParam();
            XmlDocument root = new XmlDocument();
            root.LoadXml(strResXml);
            outParam.REFUND_ID = root.SelectSingleNode("RES/REFUND_ID").InnerText;
            return outParam;
        }

        public static string AnalysisXmlReqQueryPayRefundInfo(Platform_QueryPayRefund_InParam queryPayRefundInParam)
        {
            StringBuilder builder = new StringBuilder();
            builder.Append("<REQ>");
            builder.Append("<HOS_ID>" + HosID + "</HOS_ID>");
            builder.Append("<ORDER_ID>" + queryPayRefundInParam.ORDER_ID + "</ORDER_ID>");
            builder.Append("<REFUND_ID>" + queryPayRefundInParam.REFUND_ID + "</REFUND_ID>");
            builder.Append("<HOSP_REFUND_ID>" + queryPayRefundInParam.HOSP_REFUND_ID + "</HOSP_REFUND_ID>");
            builder.Append("</REQ>");
            return builder.ToString();
        }

        public static Platform_QueryPayRefund_OutParam AnalysisXmlResQueryPayRefundInfo(string strResXml)
        {
            Platform_QueryPayRefund_OutParam outParam = new Platform_QueryPayRefund_OutParam();
            XmlDocument root = new XmlDocument();
            root.LoadXml(strResXml);
            outParam.TOTAL_FEE = root.SelectSingleNode("RES/TOTAL_FEE").InnerText;
            outParam.REFUND_FEE = root.SelectSingleNode("RES/REFUND_FEE").InnerText;
            outParam.REFUND_ID = root.SelectSingleNode("RES/REFUND_ID").InnerText;
            outParam.REFUND_COUNT = root.SelectSingleNode("RES/REFUND_COUNT").InnerText;
            outParam.REFUND_STATUS = root.SelectSingleNode("RES/REFUND_STATUS").InnerText;
            return outParam;
        }

        public static string AnalysisXmlReqPushInfo(Platform_PushInfo_InParam pushInfoInParam)
        {
            StringBuilder builder = new StringBuilder();
            builder.Append("<REQ>");
            builder.Append("<HOS_ID>" + HosID + "</HOS_ID>");
            builder.Append("<DATA_INFO>");

            foreach (DataInfo item in pushInfoInParam.DATA_INFO)
            {
                builder.Append("<DATA_TIME>" + item.DATA_TIME + "</DATA_TIME>");
                builder.Append("<HEALTH_CARD_ID>" + item.HEALTH_CARD_ID + "</HEALTH_CARD_ID>");
                builder.Append("<PATIENT_NAME>" + item.PATIENT_NAME + "</PATIENT_NAME>");
                builder.Append("<PATIENT_SEX>" + item.PATIENT_SEX + "</PATIENT_SEX>");
                builder.Append("<PATIENT_AGE>" + item.PATIENT_AGE + "</PATIENT_AGE>");
                builder.Append("<ORDER_ID>" + item.ORDER_ID + "</ORDER_ID>");
                builder.Append("<HOSP_ORDER_ID>" + item.HOSP_ORDER_ID + "</HOSP_ORDER_ID>");
                builder.Append("<DEPT_NAME>" + item.DEPT_NAME + "</DEPT_NAME>");
                builder.Append("<DOCTOR_NAME>" + item.DOCTOR_NAME + "</DOCTOR_NAME>");
                builder.Append("<REG_DT>" + item.REG_DT + "</REG_DT>");
                builder.Append("<PUSH_TYPE>" + item.PUSH_TYPE + "</PUSH_TYPE>");
                builder.Append("<PUSH_ID>" + item.PUSH_ID + "</PUSH_ID>");
                builder.Append("<PUSH_CONTENT>" + item.PUSH_CONTENT + "</PUSH_CONTENT>");
            }
            builder.Append("</DATA_INFO>");

        
            builder.Append("</REQ>");
            return builder.ToString();
        }
    }
}
