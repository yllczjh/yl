using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace HisDBLayer
{
    /// <summary>
    /// 写日志
    /// </summary>
    public class WriteLog
    {
        private string strFileName = "D:\\pacslog.txt";

        /// 写日志
        /// </summary>
        /// <param name="str"></param>
        public void WriteLogs(string str)
        {
            try
            {
                System.IO.TextWriter output = File.AppendText(strFileName);
                output.WriteLine(System.DateTime.Now + "\n" + str);
                output.Close();
            }
            catch 
            {

            }
        }
    }
}
