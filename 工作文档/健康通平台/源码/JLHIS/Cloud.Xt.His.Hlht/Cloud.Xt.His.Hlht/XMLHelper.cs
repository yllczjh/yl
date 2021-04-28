using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static Cloud.Xt.His.Hlht.Entity;
namespace Cloud.Xt.His.Hlht
{
    class XMLHelper
    {
        public static  string M_停诊通知请求参数(Object obj_参数实体)
        {
            StringBuilder req_xml = new StringBuilder();
            C_停诊通知信息 entity = (C_停诊通知信息)obj_参数实体;
            req_xml.Append("<REQ>");
            req_xml.Append("<HOS_ID>" + entity.医院ID + "</HOS_ID>");
            req_xml.Append("<DEPT_ID>" + entity.科室ID + "</DEPT_ID>");
            req_xml.Append("<DOCTOR_ID>" + entity.医生ID + "</DOCTOR_ID>");
            req_xml.Append("<REG_DATE>" + entity.停诊日期 + "</REG_DATE>");
            req_xml.Append("<TIME_FLAG>" + entity.时段 + "</TIME_FLAG>");
            req_xml.Append("<BEGIN_TIME>" + entity.停诊开始时间 + "</BEGIN_TIME>");
            req_xml.Append("<END_TIME>" + entity.停诊结束时间 + "</END_TIME>");
            req_xml.Append("<STOP_REMARK>" + entity.停诊原因 + "</STOP_REMARK>");
            req_xml.Append("<IS_REFUND>" + entity.是否需要平台退款 + "</IS_REFUND>");
            req_xml.Append("<IS_CANCEL>" + entity.是否需要平台调用医院退号 + "</IS_CANCEL>");
            req_xml.Append("</REQ>");
            return req_xml.ToString();
        }

        public static string M_取消挂号请求参数(Object obj_参数实体)
        {
            StringBuilder req_xml = new StringBuilder();
            C_取消挂号信息 entity = (C_取消挂号信息)obj_参数实体;
            req_xml.Append("<REQ>");
            req_xml.Append("<HOS_ID>" + entity.医院ID + "</HOS_ID>");
            req_xml.Append("<ORDER_ID>" + entity.订单号 + "</ORDER_ID>");
            req_xml.Append("<CANCEL_DATE>" + entity.取消时间 + "</CANCEL_DATE>");
            req_xml.Append("<CANCEL_REMARK>" + entity.取消原因 + "</CANCEL_REMARK>");
            req_xml.Append("</REQ>");
            return req_xml.ToString();
        }

        public static string M_退款请求参数(Object obj_参数实体)
        {
            StringBuilder req_xml = new StringBuilder();
            C_退款信息 entity = (C_退款信息)obj_参数实体;
            req_xml.Append("<REQ>");
            req_xml.Append("<HOS_ID>" + entity.医院ID + "</HOS_ID>");
            req_xml.Append("<ORDER_ID>" + entity.平台订单号 + "</ORDER_ID>");
            req_xml.Append("<HOSP_ORDER_ID>" + entity.医院订单号 + "</HOSP_ORDER_ID>");
            req_xml.Append("<HOSP_REFUND_ID>" + entity.医院退款号 + "</HOSP_REFUND_ID>");
            req_xml.Append("<REFUND_TYPE>" + entity.是否需要平台退款 + "</REFUND_TYPE>");
            req_xml.Append("<REFUND_DATE>" + entity.退款时间 + "</REFUND_DATE>");
            req_xml.Append("<TOTAL_FEE>" + entity.订单总金额 + "</TOTAL_FEE>");
            req_xml.Append("<REFUND_FEE>" + entity.退款金额 + "</REFUND_FEE>");
            req_xml.Append("<REFUND_REMARK>" + entity.退款原因 + "</REFUND_REMARK>");
            req_xml.Append("</REQ>");
            return req_xml.ToString();
        }
        public static string M_取号请求参数(Object obj_参数实体)
        {
            StringBuilder req_xml = new StringBuilder();
            C_取号信息 entity = (C_取号信息)obj_参数实体;
            req_xml.Append("<REQ>");
            req_xml.Append("<HOS_ID>" + entity.医院ID + "</HOS_ID>");
            req_xml.Append("<ORDER_ID>" + entity.订单ID + "</ORDER_ID>");
            req_xml.Append("<HOSP_SERIAL_NUM>" + entity.医院候诊号 + "</HOSP_SERIAL_NUM>");
            req_xml.Append("<PRINT_DATE>" + entity.取号时间 + "</PRINT_DATE>");
            req_xml.Append("</REQ>");
            return req_xml.ToString();
        }
        public static string M_窗口支付请求参数(Object obj_参数实体)
        {
            StringBuilder req_xml = new StringBuilder();
            C_窗口支付信息 entity = (C_窗口支付信息)obj_参数实体;
            req_xml.Append("<REQ>");
            req_xml.Append("<HOS_ID>" + entity.医院ID + "</HOS_ID>");
            req_xml.Append("<ORDER_ID>" + entity.订单ID + "</ORDER_ID>");
            req_xml.Append("<HOSP_SERIAL_NUM>" + entity.医院候诊号 + "</HOSP_SERIAL_NUM>");
            req_xml.Append("<PAY_FEE>" + entity.支付金额 + "</PAY_FEE>");
            req_xml.Append("<PAY_DATE>" + entity.支付时间 + "</PAY_DATE>");
            req_xml.Append("</REQ>");
            return req_xml.ToString();
        }

        public static string M_挂号退款查询请求参数(Object obj_参数实体)
        {
            StringBuilder req_xml = new StringBuilder();
            C_挂号退款查询信息 entity = (C_挂号退款查询信息)obj_参数实体;
            req_xml.Append("<REQ>");
            req_xml.Append("<HOS_ID>" + entity.医院ID + "</HOS_ID>");
            req_xml.Append("<ORDER_ID>" + entity.平台订单号 + "</ORDER_ID>");
            req_xml.Append("<REFUND_ID>" + entity.平台退款单号 + "</REFUND_ID>");
            req_xml.Append("<HOSP_REFUND_ID>" + entity.医院退款单号 + "</HOSP_REFUND_ID>");
            req_xml.Append("</REQ>");
            return req_xml.ToString();
        }

        public static string M_缴费退款请求参数(Object obj_参数实体)
        {
            StringBuilder req_xml = new StringBuilder();
            C_缴费退款信息 entity = (C_缴费退款信息)obj_参数实体;
            req_xml.Append("<REQ>");
            req_xml.Append("<HOS_ID>" + entity.医院ID + "</HOS_ID>");
            req_xml.Append("<ORDER_ID>" + entity.平台订单号 + "</ORDER_ID>");
            req_xml.Append("<HOSP_SEQUENCE>" + entity.医院就诊号 + "</HOSP_SEQUENCE>");
            req_xml.Append("<HOSP_REFUND_ID>" + entity.医院退款单号 + "</HOSP_REFUND_ID>");
            req_xml.Append("<REFUND_TYPE>" + entity.是否需要平台进行退款 + "</REFUND_TYPE>");
            req_xml.Append("<REFUND_DATE>" + entity.退款时间 + "</REFUND_DATE>");
            req_xml.Append("<TOTAL_FEE>" + entity.订单总金额 + "</TOTAL_FEE>");
            req_xml.Append("<REFUND_FEE>" + entity.退款金额 + "</REFUND_FEE>");
            req_xml.Append("<REFUND_REMARK>" + entity.退款原因 + "</REFUND_REMARK>");
            req_xml.Append("</REQ>");
            return req_xml.ToString();
        }

        public static string M_缴费退款查询请求参数(Object obj_参数实体)
        {
            StringBuilder req_xml = new StringBuilder();
            C_缴费退款查询信息 entity = (C_缴费退款查询信息)obj_参数实体;
            req_xml.Append("<REQ>");
            req_xml.Append("<HOS_ID>" + entity.医院ID + "</HOS_ID>");
            req_xml.Append("<ORDER_ID>" + entity.平台订单号 + "</ORDER_ID>");
            req_xml.Append("<REFUND_ID>" + entity.平台退款单号 + "</REFUND_ID>");
            req_xml.Append("<HOSP_REFUND_ID>" + entity.医院退款单号 + "</HOSP_REFUND_ID>");
            req_xml.Append("</REQ>");
            return req_xml.ToString();
        }
        
    }
}
