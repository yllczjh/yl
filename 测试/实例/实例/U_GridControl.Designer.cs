namespace 实例
{
    partial class U_GridControl
    {
        /// <summary> 
        /// 必需的设计器变量。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// 清理所有正在使用的资源。
        /// </summary>
        /// <param name="disposing">如果应释放托管资源，为 true；否则为 false。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region 组件设计器生成的代码

        /// <summary> 
        /// 设计器支持所需的方法 - 不要修改
        /// 使用代码编辑器修改此方法的内容。
        /// </summary>
        private void InitializeComponent()
        {
            this.toolStrip2 = new System.Windows.Forms.ToolStrip();
            this.sib_新增 = new System.Windows.Forms.ToolStripButton();
            this.sib_删除 = new System.Windows.Forms.ToolStripButton();
            this.sib_保存 = new System.Windows.Forms.ToolStripButton();
            this.sib_打印 = new System.Windows.Forms.ToolStripButton();
            this.gridControl = new DevExpress.XtraGrid.GridControl();
            this.gridView = new DevExpress.XtraGrid.Views.Grid.GridView();
            this.toolStrip2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.gridControl)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridView)).BeginInit();
            this.SuspendLayout();
            // 
            // toolStrip2
            // 
            this.toolStrip2.GripStyle = System.Windows.Forms.ToolStripGripStyle.Hidden;
            this.toolStrip2.ImageScalingSize = new System.Drawing.Size(24, 24);
            this.toolStrip2.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.sib_新增,
            this.sib_删除,
            this.sib_保存,
            this.sib_打印});
            this.toolStrip2.Location = new System.Drawing.Point(0, 0);
            this.toolStrip2.Name = "toolStrip2";
            this.toolStrip2.Size = new System.Drawing.Size(851, 25);
            this.toolStrip2.TabIndex = 23;
            this.toolStrip2.Text = "toolStrip2";
            // 
            // sib_新增
            // 
            this.sib_新增.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.sib_新增.Name = "sib_新增";
            this.sib_新增.Size = new System.Drawing.Size(36, 22);
            this.sib_新增.Text = "新增";
            // 
            // sib_删除
            // 
            this.sib_删除.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.sib_删除.Name = "sib_删除";
            this.sib_删除.Size = new System.Drawing.Size(36, 22);
            this.sib_删除.Text = "删除";
            // 
            // sib_保存
            // 
            this.sib_保存.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.sib_保存.Name = "sib_保存";
            this.sib_保存.Size = new System.Drawing.Size(36, 22);
            this.sib_保存.Text = "保存";
            // 
            // sib_打印
            // 
            this.sib_打印.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.sib_打印.Name = "sib_打印";
            this.sib_打印.Size = new System.Drawing.Size(36, 22);
            this.sib_打印.Text = "打印";
            // 
            // gridControl
            // 
            this.gridControl.Cursor = System.Windows.Forms.Cursors.Default;
            this.gridControl.Dock = System.Windows.Forms.DockStyle.Fill;
            this.gridControl.Location = new System.Drawing.Point(0, 25);
            this.gridControl.MainView = this.gridView;
            this.gridControl.Name = "gridControl";
            this.gridControl.Size = new System.Drawing.Size(851, 318);
            this.gridControl.TabIndex = 24;
            this.gridControl.ViewCollection.AddRange(new DevExpress.XtraGrid.Views.Base.BaseView[] {
            this.gridView});
            // 
            // gridView
            // 
            this.gridView.GridControl = this.gridControl;
            this.gridView.Name = "gridView";
            // 
            // U_GridControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.gridControl);
            this.Controls.Add(this.toolStrip2);
            this.Name = "U_GridControl";
            this.Size = new System.Drawing.Size(851, 343);
            this.toolStrip2.ResumeLayout(false);
            this.toolStrip2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.gridControl)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridView)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.ToolStrip toolStrip2;
        private System.Windows.Forms.ToolStripButton sib_新增;
        private System.Windows.Forms.ToolStripButton sib_删除;
        private System.Windows.Forms.ToolStripButton sib_保存;
        private System.Windows.Forms.ToolStripButton sib_打印;
        private DevExpress.XtraGrid.GridControl gridControl;
        private DevExpress.XtraGrid.Views.Grid.GridView gridView;
    }
}
