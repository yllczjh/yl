using CefSharp;
using CefSharp.WinForms;
using DevExpress.XtraEditors;
using Fleck;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApplication1
{
    public partial class Form1 : XtraForm
    {
        public Form1()
        {
            InitializeComponent();

            //InitializeChromium();
        }

        public ChromiumWebBrowser chromeBrowser;
        public void InitializeChromium()
        {
            CefSettings settings = new CefSettings();
            settings.WindowlessRenderingEnabled = true;
            // Initialize cef with the provided settings
            Cef.Initialize(settings);
            // Create a browser component
            chromeBrowser = new ChromiumWebBrowser("https://www.baidu.com");
            // Add it to the form and fill it to the form window.
            this.Controls.Add(chromeBrowser);
            chromeBrowser.Dock = DockStyle.Fill;
        }
        List<IWebSocketConnection> allSockets = new List<IWebSocketConnection>();
        private void button1_Click(object sender, EventArgs e)
        {
            FleckLog.Level = LogLevel.Debug;
            
            var server = new WebSocketServer("ws://127.0.0.1:7181");
            server.Start(socket =>
            {
                socket.OnOpen = () =>
                {
                    allSockets.Add(socket);
                };
                socket.OnClose = () =>
                {
                    allSockets.Remove(socket);
                };
                socket.OnMessage = message =>
                {
                    richTextBox1.Invoke(new Action(() => richTextBox1.Text = richTextBox1.Text +"\n"+ message));
                };
            });

        }

        private void button2_Click(object sender, EventArgs e)
        {
            foreach (var socket in allSockets.ToList())
            {
                socket.Send(textBox1.Text);
            }
        }
    }
}
