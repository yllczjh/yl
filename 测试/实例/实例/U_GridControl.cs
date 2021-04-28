using DevExpress.XtraGrid.Columns;
using System.Data;
using System.Windows.Forms;

namespace 实例
{
    public partial class U_GridControl : UserControl
    {
        DataTable dt = new DataTable();
        public string P_表名 = string.Empty;
        public string P_显示字段 = string.Empty;//多个以英文逗号分隔
        public string P_列宽 = string.Empty;//0.几  加一起等1，以英文逗号分隔


        public U_GridControl()
        {
            InitializeComponent();
        }

        public void M_初始化()
        {

            gridView.Columns.Clear();


            gridView.Columns.Add(new GridColumn() { Name = "NoCHK", FieldName = "NoCHK", Caption = "选择", VisibleIndex = 0 });
            gridView.Columns.Add(new GridColumn() { Name = "No", FieldName = "No", Caption = "No", Visible = false });
            gridView.Columns["TestNo"].OptionsColumn.AllowEdit = false;
            gridView.Columns.Add(new GridColumn() { Name = "NAME", FieldName = "NAME", Caption = "名称", VisibleIndex = 2 });
            gridView.Columns["NAME"].OptionsColumn.AllowEdit = false;
            gridControl.DataSource = dt;
            //自动列宽,会出现横向滚动条
            gridView.OptionsView.ColumnAutoWidth = false;

            //自动列宽
            gridView.BestFitColumns();

        }

        private void M_加载数据()
        {
            dt.Columns.Add("id", typeof(string));
            dt.Columns.Add("name", typeof(string));
            dt.Columns.Add("addd", typeof(string));
            for (int i = 0; i < 5; i++)
            {
                DataRow row = dt.NewRow();
                row["id"] = "id" + i;
                row["name"] = "name" + i;
                row["addd"] = "addd" + i;
                dt.Rows.Add(row);
            }
        }
    }
}
