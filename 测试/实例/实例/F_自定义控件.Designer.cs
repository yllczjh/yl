namespace 实例
{
    partial class F_自定义控件
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
            this.u_GridControl1 = new 实例.U_GridControl();
            this.SuspendLayout();
            // 
            // u_GridControl1
            // 
            this.u_GridControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.u_GridControl1.Location = new System.Drawing.Point(0, 0);
            this.u_GridControl1.Name = "u_GridControl1";
            this.u_GridControl1.Size = new System.Drawing.Size(710, 313);
            this.u_GridControl1.TabIndex = 0;
            // 
            // F_自定义控件
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(710, 313);
            this.Controls.Add(this.u_GridControl1);
            this.Name = "F_自定义控件";
            this.Text = "F_自定义控件";
            this.ResumeLayout(false);

        }

        #endregion

        private U_GridControl u_GridControl1;
    }
}