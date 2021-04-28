using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cloud.Xt.His.Hlht
{
    public class Entity
    {
        public class C_停诊通知信息
        {
            public string 医院ID { get; set; }
            public string 科室ID { get; set; }
            public string 医生ID { get; set; }
            public DateTime 停诊日期 { get; set; }
            public string 时段 { get; set; }
            public string 停诊开始时间 { get; set; }
            public string 停诊结束时间 { get; set; }
            public string 停诊原因 { get; set; }
            //（1是 0 否）
            public int 是否需要平台退款 { get; set; }
            //（1是 0 否）
            public int 是否需要平台调用医院退号 { get; set; }
        }

        public class C_取消挂号信息
        {
            public string 医院ID { get; set; }
            public string 订单号 { get; set; }
            public string 取消时间 { get; set; }
            public string 取消原因 { get; set; }
        }

        public class C_退款信息
        {
            public string 医院ID { get; set; }
            public string 平台订单号 { get; set; }
            public string 医院订单号 { get; set; }
            public string 医院退款号 { get; set; }
            /// <summary>
            /// 0-否 1-是
            /// </summary>
            public int 是否需要平台退款 { get; set; }
            /// <summary>
            /// YYYY-MM-DD HI24:MI:SS
            /// </summary>
            public DateTime 退款时间 { get; set; }
            public double 订单总金额 { get; set; }
            public double 退款金额 { get; set; }
            public string 退款原因 { get; set; }
        }

        public class C_取号信息
        {
            public string 医院ID { get; set; }
            public string 订单ID { get; set; }
            public string 医院候诊号 { get; set; }
            /// <summary>
            /// YYYY-MM-DD HI24:MI:SS
            /// </summary>
            public DateTime 取号时间 { get; set; }
        }

        public class C_窗口支付信息
        {
            public string 医院ID { get; set; }
            public string 订单ID { get; set; }
            public string 医院候诊号 { get; set; }
            public double  支付金额 { get; set; }
            public DateTime 支付时间 { get; set; }
        }

        public class C_挂号退款查询信息
        {
            public string 医院ID { get; set; }
            public string 平台订单号 { get; set; }
            public string 平台退款单号 { get; set; }
            public string 医院退款单号 { get; set; }
        }

        public class C_缴费退款信息
        {
            public string 医院ID { get; set; }
            public string 平台订单号 { get; set; }
            public string 医院就诊号 { get; set; }
            public string 医院退款单号 { get; set; }
            /// <summary>
            /// 0-否 1-是
            /// </summary>
            public int 是否需要平台进行退款 { get; set; }
            public DateTime 退款时间 { get; set; }
            public double 订单总金额 { get; set; }
            public double 退款金额 { get; set; }
            public string 退款原因 { get; set; }
        }

        public class C_缴费退款查询信息
        {
            public string 医院ID { get; set; }
            public string 平台订单号 { get; set; }
            public string 平台退款单号 { get; set; }
            public string 医院退款单号 { get; set; }
           
        }
    }
}
