using Cloud.Xt.His.Hlht;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static Cloud.Xt.His.Hlht.Entity;

namespace 测试
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            互联互通 i_互联互通 = new 互联互通();
            C_停诊通知信息 c_停诊通知信息 = new C_停诊通知信息();
            c_停诊通知信息.医院ID = "111";
            c_停诊通知信息.科室ID = "1001";
            c_停诊通知信息.医生ID = "1212";
            i_互联互通.M_互联互通接口(5001, c_停诊通知信息);
        }
    }
}
