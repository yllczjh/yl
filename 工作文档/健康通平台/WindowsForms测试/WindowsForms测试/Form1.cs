using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Web.Security;
using System.Xml;
using System.IO;

namespace WindowsForms测试
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            ServiceReference1.APIServiceSoapClient s= new ServiceReference1.APIServiceSoapClient();
            传出.Text = s.PubService(传入.Text);
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.richTextBox2.Text = AESHelper.EncryptForAES(this.richTextBox1.Text, "2098D32C4D1399EC");
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.richTextBox3.Text = AESHelper.DecryptForAES(this.richTextBox2.Text, "2098D32C4D1399EC");
        }

        private void button4_Click(object sender, EventArgs e)
        {

            try
            {
                string encryptString = this.richTextBox1.Text;
                MD5CryptoServiceProvider md5CSP = new MD5CryptoServiceProvider();
                byte[] testEncrypt = Encoding.Unicode.GetBytes(encryptString);
                byte[] resultEncrypt = md5CSP.ComputeHash(testEncrypt);
                string testResult = System.Text.Encoding.Unicode.GetString(resultEncrypt);
                this.richTextBox2.Text = FormsAuthentication.HashPasswordForStoringInConfigFile(encryptString, "MD5");
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("加签失败：{0}", ex.Message));
            }
        }

        private void button6_Click(object sender, EventArgs e)
        {
            button2_Click(null,null);


            XmlDocument root = new XmlDocument();
            root.LoadXml(传入.Text);
           string req_fun_code = root.SelectSingleNode("ROOT/FUN_CODE").InnerText;

            string encryptString = "FUN_CODE=" + req_fun_code + "&REQ_ENCRYPTED=" + this.richTextBox2.Text + "&USER_ID=ln_12320wx&KEY=2098D32C4D1399EC";

            MD5CryptoServiceProvider md5CSP = new MD5CryptoServiceProvider();
            byte[] testEncrypt = Encoding.Unicode.GetBytes(encryptString);
            byte[] resultEncrypt = md5CSP.ComputeHash(testEncrypt);
            string testResult = System.Text.Encoding.Unicode.GetString(resultEncrypt);
            this.richTextBox3.Text = FormsAuthentication.HashPasswordForStoringInConfigFile(encryptString, "MD5");

        }

        private void button5_Click(object sender, EventArgs e)
        {
            button2_Click(null, null);

            string encryptString = "FUN_CODE=" + textBox1.Text + "&REQ_ENCRYPTED=" + richTextBox2.Text + "&USER_ID=ln_12320wx&KEY=2098D32C4D1399EC";

            MD5CryptoServiceProvider md5CSP = new MD5CryptoServiceProvider();
            byte[] testEncrypt = Encoding.Unicode.GetBytes(encryptString);
            byte[] resultEncrypt = md5CSP.ComputeHash(testEncrypt);
            string testResult = System.Text.Encoding.Unicode.GetString(resultEncrypt);
            this.richTextBox3.Text = FormsAuthentication.HashPasswordForStoringInConfigFile(encryptString, "MD5");

   //         <? xml version = "1.0" encoding = "UTF-8" ?>
   //< ROOT >
   //< FUN_CODE >< ![CDATA[2001]] ></ FUN_CODE >
   //< USER_ID >< ![CDATA[ln_12320wx]] ></ USER_ID >
   //< SIGN_TYPE >< ![CDATA[MD5]] ></ SIGN_TYPE >
   //< SIGN >< ![CDATA[A35020DE45CD8E676F87BC9286BBF091]] ></ SIGN >
   //< REQ_ENCRYPTED >< ![CDATA[91EHXNlpXfSoNJRB8HYgB / dHyKpYxfKL4MLukSjtY8UCv6bx / cNt + BfAY / HgFjn5AUjZ62PTxipstda4OEKWE3S517QryCr0TBJMGEnUil0 =]] ></ REQ_ENCRYPTED >
   //</ ROOT >

               string res_xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
            res_xml += @"<ROOT>
                           <FUN_CODE><![CDATA[{0}]]></FUN_CODE>
                           <USER_ID><![CDATA[ln_12320wx]]></USER_ID>
                           <SIGN_TYPE><![CDATA[MD5]]></SIGN_TYPE>
                           <SIGN><![CDATA[{1}]]></SIGN>
                           <REQ_ENCRYPTED><![CDATA[{2}]]></REQ_ENCRYPTED>
                         </ROOT>";

            传入.Text = string.Format(res_xml, textBox1.Text, richTextBox3.Text, richTextBox2.Text);
        }
    }
}
