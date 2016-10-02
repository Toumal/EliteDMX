namespace EliteDMX
{
    partial class Main
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Main));
            this.btnOff = new System.Windows.Forms.Button();
            this.btnAllOn = new System.Windows.Forms.Button();
            this.btnScene1 = new System.Windows.Forms.Button();
            this.btnScene3 = new System.Windows.Forms.Button();
            this.btnScene2 = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.txtChannel1 = new System.Windows.Forms.TextBox();
            this.txtChannel2 = new System.Windows.Forms.TextBox();
            this.txtChannel3 = new System.Windows.Forms.TextBox();
            this.txtLevel3 = new System.Windows.Forms.TextBox();
            this.txtLevel2 = new System.Windows.Forms.TextBox();
            this.txtLevel1 = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.statusStrip1 = new System.Windows.Forms.StatusStrip();
            this.toolStripStatusLabel1 = new System.Windows.Forms.ToolStripStatusLabel();
            this.statusStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // btnOff
            // 
            this.btnOff.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnOff.Location = new System.Drawing.Point(83, 44);
            this.btnOff.Name = "btnOff";
            this.btnOff.Size = new System.Drawing.Size(75, 26);
            this.btnOff.TabIndex = 0;
            this.btnOff.Text = "Off";
            this.btnOff.UseVisualStyleBackColor = true;
            this.btnOff.Click += new System.EventHandler(this.btnOff_Click);
            // 
            // btnAllOn
            // 
            this.btnAllOn.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnAllOn.Location = new System.Drawing.Point(83, 10);
            this.btnAllOn.Name = "btnAllOn";
            this.btnAllOn.Size = new System.Drawing.Size(75, 26);
            this.btnAllOn.TabIndex = 1;
            this.btnAllOn.Text = "All On";
            this.btnAllOn.UseVisualStyleBackColor = true;
            this.btnAllOn.Click += new System.EventHandler(this.btnAllOn_Click);
            // 
            // btnScene1
            // 
            this.btnScene1.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnScene1.Location = new System.Drawing.Point(157, 99);
            this.btnScene1.Name = "btnScene1";
            this.btnScene1.Size = new System.Drawing.Size(75, 23);
            this.btnScene1.TabIndex = 2;
            this.btnScene1.Text = "Send Data";
            this.btnScene1.UseVisualStyleBackColor = true;
            this.btnScene1.Click += new System.EventHandler(this.btnScene1_Click);
            // 
            // btnScene3
            // 
            this.btnScene3.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnScene3.Location = new System.Drawing.Point(157, 157);
            this.btnScene3.Name = "btnScene3";
            this.btnScene3.Size = new System.Drawing.Size(75, 23);
            this.btnScene3.TabIndex = 3;
            this.btnScene3.Text = "Send Data";
            this.btnScene3.UseVisualStyleBackColor = true;
            this.btnScene3.Click += new System.EventHandler(this.btnScene3_Click);
            // 
            // btnScene2
            // 
            this.btnScene2.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnScene2.Location = new System.Drawing.Point(157, 128);
            this.btnScene2.Name = "btnScene2";
            this.btnScene2.Size = new System.Drawing.Size(75, 23);
            this.btnScene2.TabIndex = 4;
            this.btnScene2.Text = "Send Data";
            this.btnScene2.UseVisualStyleBackColor = true;
            this.btnScene2.Click += new System.EventHandler(this.btnScene2_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(13, 77);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(64, 16);
            this.label1.TabIndex = 5;
            this.label1.Text = "Channel";
            // 
            // txtChannel1
            // 
            this.txtChannel1.Location = new System.Drawing.Point(25, 99);
            this.txtChannel1.Name = "txtChannel1";
            this.txtChannel1.Size = new System.Drawing.Size(31, 20);
            this.txtChannel1.TabIndex = 6;
            this.txtChannel1.Text = "1";
            this.txtChannel1.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // txtChannel2
            // 
            this.txtChannel2.Location = new System.Drawing.Point(25, 131);
            this.txtChannel2.Name = "txtChannel2";
            this.txtChannel2.Size = new System.Drawing.Size(31, 20);
            this.txtChannel2.TabIndex = 7;
            this.txtChannel2.Text = "2";
            this.txtChannel2.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // txtChannel3
            // 
            this.txtChannel3.Location = new System.Drawing.Point(25, 160);
            this.txtChannel3.Name = "txtChannel3";
            this.txtChannel3.Size = new System.Drawing.Size(31, 20);
            this.txtChannel3.TabIndex = 8;
            this.txtChannel3.Text = "3";
            this.txtChannel3.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // txtLevel3
            // 
            this.txtLevel3.Location = new System.Drawing.Point(102, 160);
            this.txtLevel3.Name = "txtLevel3";
            this.txtLevel3.Size = new System.Drawing.Size(31, 20);
            this.txtLevel3.TabIndex = 12;
            this.txtLevel3.Text = "255";
            this.txtLevel3.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // txtLevel2
            // 
            this.txtLevel2.Location = new System.Drawing.Point(102, 131);
            this.txtLevel2.Name = "txtLevel2";
            this.txtLevel2.Size = new System.Drawing.Size(31, 20);
            this.txtLevel2.TabIndex = 11;
            this.txtLevel2.Text = "255";
            this.txtLevel2.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // txtLevel1
            // 
            this.txtLevel1.Location = new System.Drawing.Point(102, 99);
            this.txtLevel1.Name = "txtLevel1";
            this.txtLevel1.Size = new System.Drawing.Size(31, 20);
            this.txtLevel1.TabIndex = 10;
            this.txtLevel1.Text = "255";
            this.txtLevel1.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(80, 77);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(87, 16);
            this.label2.TabIndex = 9;
            this.label2.Text = "Level 0-255";
            // 
            // label3
            // 
            this.label3.Location = new System.Drawing.Point(7, 189);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(124, 102);
            this.label3.TabIndex = 92;
            this.label3.Text = "Note: You need a DMX512/OpenDMX compatible USB devicet PC.";
            // 
            // statusStrip1
            // 
            this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripStatusLabel1});
            this.statusStrip1.Location = new System.Drawing.Point(0, 307);
            this.statusStrip1.Name = "statusStrip1";
            this.statusStrip1.Size = new System.Drawing.Size(258, 22);
            this.statusStrip1.TabIndex = 93;
            this.statusStrip1.Text = "statusStrip1";
            // 
            // toolStripStatusLabel1
            // 
            this.toolStripStatusLabel1.Name = "toolStripStatusLabel1";
            this.toolStripStatusLabel1.Size = new System.Drawing.Size(122, 17);
            this.toolStripStatusLabel1.Text = "No USB Device Found";
            // 
            // Main
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(258, 329);
            this.Controls.Add(this.statusStrip1);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.txtLevel3);
            this.Controls.Add(this.txtLevel2);
            this.Controls.Add(this.txtLevel1);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.txtChannel3);
            this.Controls.Add(this.txtChannel2);
            this.Controls.Add(this.txtChannel1);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.btnScene2);
            this.Controls.Add(this.btnScene3);
            this.Controls.Add(this.btnScene1);
            this.Controls.Add(this.btnAllOn);
            this.Controls.Add(this.btnOff);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "Main";
            this.Text = "Elite DMX";
            this.Load += new System.EventHandler(this.Main_Load);
            this.statusStrip1.ResumeLayout(false);
            this.statusStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnOff;
        private System.Windows.Forms.Button btnAllOn;
        private System.Windows.Forms.Button btnScene1;
        private System.Windows.Forms.Button btnScene3;
        private System.Windows.Forms.Button btnScene2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtChannel1;
        private System.Windows.Forms.TextBox txtChannel2;
        private System.Windows.Forms.TextBox txtChannel3;
        private System.Windows.Forms.TextBox txtLevel3;
        private System.Windows.Forms.TextBox txtLevel2;
        private System.Windows.Forms.TextBox txtLevel1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.StatusStrip statusStrip1;
        private System.Windows.Forms.ToolStripStatusLabel toolStripStatusLabel1;
    }
}

