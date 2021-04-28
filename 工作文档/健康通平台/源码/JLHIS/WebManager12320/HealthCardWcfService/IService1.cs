using HisCommon.DataEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace HealthCardWcfService
{
    // 注意: 使用“重构”菜单上的“重命名”命令，可以同时更改代码和配置文件中的接口名“IService1”。
    [ServiceContract]
    public interface IService1
    {
        [OperationContract]
        string GetData(int value);

        [OperationContract]
        CompositeType GetDataUsingDataContract(CompositeType composite);


        [OperationContract]
        Platform_StopReg_OutParamInfo StopReg(Platform_StopReg_InParam inParam);

        [OperationContract]
        Platform_CancelRegByHIS_OutParamInfo CancelRegByHis(Platform_CancelRegByHIS_InParam inParam);

        [OperationContract]
        Platform_RefundByHIS_OutParamInfo RefundByHis(Platform_RefundByHIS_InParam inParam);

        [OperationContract]
        Platform_PrintRegByHIS_OutParamInfo PrintRegByHis(Platform_PrintRegByHIS_InParam inParam);

        [OperationContract]
        Platform_PayRegByHIS_OutParamInfo PayRegByHis(Platform_PayRegByHIS_InParam inParam);

        [OperationContract]
        Platform_QueryRegRefund_OutParamInfo QueryRegRefund(Platform_QueryRegRefund_InParam inParam);

        [OperationContract]
        Platform_RefundPay_OutParamInfo RefundPay(Platform_RefundPay_InParam inParam);

        [OperationContract]
        Platform_QueryPayRefund_OutParamInfo QueryPayRefund(Platform_QueryPayRefund_InParam inParam);

        [OperationContract]
        Platform_PushInfo_OutParam PushInfo(Platform_PushInfo_InParam inParam);

        // TODO: 在此添加您的服务操作
    }

    // 使用下面示例中说明的数据约定将复合类型添加到服务操作。
    [DataContract]
    public class CompositeType
    {
        bool boolValue = true;
        string stringValue = "Hello ";

        [DataMember]
        public bool BoolValue
        {
            get { return boolValue; }
            set { boolValue = value; }
        }

        [DataMember]
        public string StringValue
        {
            get { return stringValue; }
            set { stringValue = value; }
        }
    }
}
