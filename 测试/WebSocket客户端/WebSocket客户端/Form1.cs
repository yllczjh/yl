using System;
using System.Net.WebSockets;
using System.Text;
using System.Threading;
using System.Windows.Forms;

namespace WindowsFormsApplication2
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        ClientWebSocket webSocket = new ClientWebSocket();
        private void button1_Click(object sender, EventArgs e)
        {
            webSocket.ConnectAsync(new Uri("ws://127.0.0.1:7181"), CancellationToken.None).Wait();
            StartReceiving(webSocket);
            
        }


        private async void StartReceiving(ClientWebSocket client)
        {
            while (true)
            {
                var array = new byte[4096];
                var result = await client.ReceiveAsync(new ArraySegment<byte>(array), CancellationToken.None);
                if (result.MessageType == WebSocketMessageType.Text)
                {
                    string msg = Encoding.UTF8.GetString(array, 0, result.Count);
                    richTextBox1.Invoke(new Action(() => richTextBox1.Text = richTextBox1.Text + "\n" + msg));
                }
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            var array = new ArraySegment<byte>(Encoding.UTF8.GetBytes(textBox1.Text));
            webSocket.SendAsync(array, WebSocketMessageType.Text, true, CancellationToken.None);
        }
    }
}
