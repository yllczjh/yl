using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace 实例
{
    public partial class GridControl学习 : Form
    {
        public GridControl学习()
        {
            InitializeComponent();
        }

        private DataTable InitDt()
        {
            DataTable dt = new DataTable("个人简历");
            dt.Columns.Add("id", typeof(int));
            dt.Columns.Add("name", typeof(string));
            dt.Columns.Add("sex", typeof(int));
            dt.Columns.Add("address", typeof(string));
            dt.Columns.Add("aihao", typeof(string));
            dt.Columns.Add("photo", typeof(string));
            dt.Rows.Add(new object[] { 1, "张三", 1, "东大街6号", "看书", "" });
            dt.Rows.Add(new object[] { 1, "王五", 0, "西大街2号", "上网,游戏", "" });
            dt.Rows.Add(new object[] { 1, "李四", 1, "南大街3号", "上网,逛街", "" });
            dt.Rows.Add(new object[] { 1, "钱八", 0, "北大街5号", "上网,逛街,看书,游戏", "" });
            dt.Rows.Add(new object[] { 1, "赵九", 1, "中大街1号", "看书,逛街,游戏", "" });
            return dt;
        }


        private void GridControl学习_Load(object sender, EventArgs e)
        {
            gridControl1.DataSource = InitDt();
        }
    }
}
