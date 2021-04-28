namespace 实例
{
    partial class Await
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
            this.btn_Task = new System.Windows.Forms.Button();
            this.输出 = new System.Windows.Forms.RichTextBox();
            this.btn_Task停止 = new System.Windows.Forms.Button();
            this.btn_Await = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // btn_Task
            // 
            this.btn_Task.Location = new System.Drawing.Point(12, 13);
            this.btn_Task.Name = "btn_Task";
            this.btn_Task.Size = new System.Drawing.Size(75, 23);
            this.btn_Task.TabIndex = 0;
            this.btn_Task.Text = "Task";
            this.btn_Task.UseVisualStyleBackColor = true;
            this.btn_Task.Click += new System.EventHandler(this.button1_Click);
            // 
            // 输出
            // 
            this.输出.Location = new System.Drawing.Point(255, 13);
            this.输出.Name = "输出";
            this.输出.Size = new System.Drawing.Size(100, 236);
            this.输出.TabIndex = 1;
            this.输出.Text = "";
            // 
            // btn_Task停止
            // 
            this.btn_Task停止.Location = new System.Drawing.Point(116, 13);
            this.btn_Task停止.Name = "btn_Task停止";
            this.btn_Task停止.Size = new System.Drawing.Size(75, 23);
            this.btn_Task停止.TabIndex = 2;
            this.btn_Task停止.Text = "Task停止";
            this.btn_Task停止.UseVisualStyleBackColor = true;
            this.btn_Task停止.Click += new System.EventHandler(this.btn_Task停止_Click);
            // 
            // btn_Await
            // 
            this.btn_Await.Location = new System.Drawing.Point(12, 66);
            this.btn_Await.Name = "btn_Await";
            this.btn_Await.Size = new System.Drawing.Size(75, 23);
            this.btn_Await.TabIndex = 3;
            this.btn_Await.Text = "Await";
            this.btn_Await.UseVisualStyleBackColor = true;
            this.btn_Await.Click += new System.EventHandler(this.btn_Await_Click);
            // 
            // Await
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(377, 261);
            this.Controls.Add(this.btn_Await);
            this.Controls.Add(this.btn_Task停止);
            this.Controls.Add(this.输出);
            this.Controls.Add(this.btn_Task);
            this.Name = "Await";
            this.Text = "Await";
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btn_Task;
        private System.Windows.Forms.RichTextBox 输出;
        private System.Windows.Forms.Button btn_Task停止;
        private System.Windows.Forms.Button btn_Await;
    }
}