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
    public partial class json转换 : Form
    {
        public json转换()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string str_json = M_转换DataTableToJson(dt,1);
        }
        DataTable dt = new DataTable();
        private void json转换_Load(object sender, EventArgs e)
        {
            dt.Columns.Add("name", typeof(string));
            dt.Columns.Add("age", typeof(string));
            DataRow row = dt.NewRow();
            row["name"] = "name1";
            row["age"] = "age1";
            dt.Rows.Add(row);

            row = dt.NewRow();
            row["name"] = "name2";
            row["age"] = "age2";
            dt.Rows.Add(row);
        }

        public static string M_转换DataTableToJson(DataTable table,int type)
        {
            StringBuilder JsonString = new StringBuilder();
            int len = table.Rows.Count;
            if (len > 0)
            {
                if (type == 1)
                {
                    JsonString.Append("[");
                }else
                {
                    len = 1;
                }
                
                for (int i = 0; i < len; i++)
                {
                    JsonString.Append("{");
                    for (int j = 0; j < table.Columns.Count; j++)
                    {
                        if (table.Columns[j].DataType.Name == "Decimal")
                        {
                            if (string.IsNullOrEmpty(table.Rows[i][j].ToString()))
                            {
                                JsonString.Append("\"" + table.Columns[j].ColumnName.ToString().ToLower() + "\":0");
                            }
                            else
                            {
                                JsonString.Append("\"" + table.Columns[j].ColumnName.ToString().ToLower() + "\":" + table.Rows[i][j].ToString());
                            }
                        }
                        else
                        {
                            JsonString.Append("\"" + table.Columns[j].ColumnName.ToString().ToLower() + "\":" + "\"" + table.Rows[i][j].ToString() + "\"");
                        }
                        if (j < table.Columns.Count - 1)
                        {
                            JsonString.Append(",");
                        }
                    }
                    if (i == len - 1)
                    {
                        JsonString.Append("}");
                    }
                    else
                    {
                        JsonString.Append("},");
                    }
                }
                if (type == 1)
                {
                    JsonString.Append("]");
                }
               
            }
            return JsonString.ToString();
        }
    }
}
