using HealthCardProxyService.MyServiceProxy;
using HealthCardWcfService;
using HealthCardWcfService.Security;
using HealthCardWcfService.Tool;
using HisCommon.DataEntity;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApp2
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        private static string userID = "ln_12320wx";
        private static string key = "2098D32C4D1399EC";
        HealthCardProxyService.MyServiceProxy.Service1Client client = new HealthCardProxyService.MyServiceProxy.Service1Client();
        private void Button1_Click(object sender, EventArgs e)
        {
      

            Dictionary<string, string> errInfo = new Dictionary<string, string>();


            // 退款
            Platform_QueryRegRefund_InParam inParam = new Platform_QueryRegRefund_InParam();
            inParam.HOSP_REFUND_ID = "1";
            inParam.ORDER_ID = "1";
            client.QueryRegRefund(inParam);
            
        }

        private void Button2_Click(object sender, EventArgs e)
        {
            Dictionary<string, string> errInfo = new Dictionary<string, string>();

            //Platform_QueryPayRefund_InParam inParam = new Platform_QueryPayRefund_InParam();
            //inParam.HOSP_REFUND_ID = "1";
            //inParam.ORDER_ID = "1";
            //client.QueryPayRefund(inParam);
      
            
            string description = @"pchwjmrsfBuDWumer+7X+ftxnXPGvhZXw9tbIidBJSI7I8mzwcXO3x2dBhJ7Uo5wHe41DEiv6dsPMSRRfX5A+zaQT5kdetS9QaQr7rM/+QeUWWadPCZqt25aGAk7LXbJQdB+gUpOGoGqK/jCt6AOjny84D9pavSBXU3EVcSfQrRUOIjVjfTlRReJkLso56E/pLwPOK+78LgwMz9Gk8pNJ+Tf6ZGczGTbAMYJjEeV55G8HpNBg53xVnf0RN7tCmzCLFer3WezGALF8XZnFJQaw1Gw8DJj9G2tTHTazlBUVvs72/msoSpZN/iu/HfBni/09YUUxz8zgDWd4YDpFh9t/cIMXMVCF+TBPmnwfvWlkdk=";
        string str=    AESHelper.DecryptForAES(description, key);
          
            XmlHelper.AnalysisXmlResQueryRegRefundInfo(str);
        }
    }
}
