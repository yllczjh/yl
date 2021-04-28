namespace 实例
{
    partial class GridControl学习
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.gridControl1 = new DevExpress.XtraGrid.GridControl();
            this.gridView1 = new DevExpress.XtraGrid.Views.Grid.GridView();
            this.name = new DevExpress.XtraGrid.Columns.GridColumn();
            this.sex = new DevExpress.XtraGrid.Columns.GridColumn();
            this.address = new DevExpress.XtraGrid.Columns.GridColumn();
            this.aihao = new DevExpress.XtraGrid.Columns.GridColumn();
            ((System.ComponentModel.ISupportInitialize)(this.gridControl1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridView1)).BeginInit();
            this.SuspendLayout();
            // 
            // gridControl1
            // 
            this.gridControl1.Cursor = System.Windows.Forms.Cursors.Default;
            this.gridControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.gridControl1.Location = new System.Drawing.Point(0, 0);
            this.gridControl1.MainView = this.gridView1;
            this.gridControl1.Name = "gridControl1";
            this.gridControl1.Size = new System.Drawing.Size(734, 332);
            this.gridControl1.TabIndex = 0;
            this.gridControl1.ViewCollection.AddRange(new DevExpress.XtraGrid.Views.Base.BaseView[] {
            this.gridView1});
            // 
            // gridView1
            // 
            this.gridView1.Columns.AddRange(new DevExpress.XtraGrid.Columns.GridColumn[] {
            this.name,
            this.sex,
            this.address,
            this.aihao});
            this.gridView1.GridControl = this.gridControl1;
            this.gridView1.Name = "gridView1";
            // 
            // name
            // 
            this.name.Caption = "姓名";
            this.name.FieldName = "name";
            this.name.Name = "name";
            this.name.Visible = true;
            this.name.VisibleIndex = 0;
            // 
            // sex
            // 
            this.sex.Caption = "年龄";
            this.sex.FieldName = "sex";
            this.sex.Name = "sex";
            this.sex.Visible = true;
            this.sex.VisibleIndex = 1;
            // 
            // address
            // 
            this.address.Caption = "地址";
            this.address.FieldName = "address";
            this.address.Name = "address";
            this.address.Visible = true;
            this.address.VisibleIndex = 2;
            // 
            // aihao
            // 
            this.aihao.Caption = "爱好";
            this.aihao.FieldName = "aihao";
            this.aihao.Name = "aihao";
            this.aihao.Visible = true;
            this.aihao.VisibleIndex = 3;
            // 
            // GridControl学习
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(734, 332);
            this.Controls.Add(this.gridControl1);
            this.Name = "GridControl学习";
            this.Text = "GridControl学习";
            this.Load += new System.EventHandler(this.GridControl学习_Load);
            ((System.ComponentModel.ISupportInitialize)(this.gridControl1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridView1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private DevExpress.XtraGrid.GridControl gridControl1;
        private DevExpress.XtraGrid.Views.Grid.GridView gridView1;
        private DevExpress.XtraGrid.Columns.GridColumn name;
        private DevExpress.XtraGrid.Columns.GridColumn sex;
        private DevExpress.XtraGrid.Columns.GridColumn address;
        private DevExpress.XtraGrid.Columns.GridColumn aihao;
    }
}