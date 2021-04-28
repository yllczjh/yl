using System;
using System.Drawing;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace 实例
{
    public partial class Await : Form
    {
        public Await()
        {
            InitializeComponent();
        }

        //private AutoResetEvent manualResetEvent = new AutoResetEvent(false);
        private ManualResetEvent manualResetEvent = new ManualResetEvent(false);//与上面相同，用于Task停止。优先采用此方法

        private void button1_Click(object sender, EventArgs e)
        {
            btn_Task.Enabled = false;
            manualResetEvent.Reset();
            Task.Run(() => Task1("aa", "bb"));
        }

        private void Task1(string s, string s1)
        {
            for (int i = 0; i < 100; i++)
            {
                输出.Invoke(new Action(() =>
                {
                    输出.AppendText(s + i.ToString() + "\n");
                    输出.HideSelection = false;
                }));
                if (manualResetEvent.WaitOne(500))
                {
                    break;
                }
            }
            btn_Task.Invoke(new Action(() => btn_Task.Enabled = true));
        }

        private void btn_Task停止_Click(object sender, EventArgs e)
        {
            manualResetEvent.Set();
        }

        private async void btn_Await_Click(object sender, EventArgs e)
        {
            var result = await DoSomethingAsync();
            if (result)
            {
                btn_Await.BackColor = Color.Green;
            }
            else
            {
                btn_Await.BackColor = Color.Red;
            }

            await Task.Delay(1000);

            btn_Await.BackColor = Color.White;
        }

        private async Task<bool> DoSomethingAsync()
        {
            await Task.Run(() =>
            {
                Thread.Sleep(5000);
            });
            return true;
        }
    }
}
