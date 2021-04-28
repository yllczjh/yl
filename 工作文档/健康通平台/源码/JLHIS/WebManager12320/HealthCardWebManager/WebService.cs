using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace HealthCardWebManager
{
    public class WebService
    {

        public static string GetXmlStrByUrl(string url, string jsonStrParam, Dictionary<string, string> dicParam, ref string errMsg)
        {
            WebProxy proxy = new WebProxy();
            HttpWebRequest wRequest = (HttpWebRequest)WebRequest.Create(url);
            wRequest.Method = "POST";
            wRequest.ContentType = "Application/xml";
            wRequest.AllowAutoRedirect = false;

            #region 添加Post入参
            if (dicParam != null && dicParam.ToList().Count > 0)
            {
                StringBuilder builder = new StringBuilder();
                int i = 0;
                foreach (var item in dicParam)
                {
                    if (i > 0)
                        builder.Append("&");
                    builder.AppendFormat("{0}={1}", item.Key, item.Value);
                    i++;
                }
                byte[] data = Encoding.UTF8.GetBytes(builder.ToString());
                wRequest.ContentLength = data.Length;

                using (Stream reqStream = wRequest.GetRequestStream())
                {
                    reqStream.Write(data, 0, data.Length);
                    reqStream.Close();
                }

            }
            else
            {
                byte[] data = Encoding.UTF8.GetBytes(jsonStrParam);
                wRequest.ContentLength = data.Length;
                using (Stream reqStream = wRequest.GetRequestStream())
                {
                    reqStream.Write(data, 0, data.Length);
                    reqStream.Close();
                }
            }

            #endregion
            HttpWebResponse resp = (HttpWebResponse)wRequest.GetResponse();
            Stream stream = resp.GetResponseStream();
            //获取响应内容  
            using (StreamReader reader = new StreamReader(stream, Encoding.UTF8))
            {
                return reader.ReadToEnd();
            }
        }


        /// <summary>
        /// 根据url地址获得流信息
        /// </summary>
        /// <param name="url"></param>
        /// <param name="errMsg"></param>
        /// <returns></returns>
        public static Stream GetStreamInfoByUrl(string url, Dictionary<string, string> keyValues, ref string errMsg)
        {
            HttpWebRequest wRequest = (HttpWebRequest)WebRequest.Create(url);
            wRequest.Method = "GET";
            wRequest.ContentType = "text/html;charset=UTF-8";

            wRequest.AllowAutoRedirect = false;
            foreach (var item in keyValues)
            {
                wRequest.Headers.Add(item.Key, item.Value);
            }

            WebResponse wResponse = wRequest.GetResponse();
            HttpWebResponse response = (HttpWebResponse)wResponse;

            if (response.StatusCode.ToString() == "OK")
            {
                return response.GetResponseStream();
            }
            else
            {
                return null;
            }
        }


        public static string UploadFile(string filePath, string url, string contextType, CookieContainer cookies, ref string errMsg)
        {
            string boundary = DateTime.Now.Ticks.ToString("X"); // 随机分隔线

            byte[] endBoundaryBytes = Encoding.ASCII.GetBytes("\r\n--" + boundary + "--\r\n");

            //创建即将post给对方的请求流
            Stream postStream = null;

            int pos = filePath.LastIndexOf("\\");
            string fileName = filePath.Substring(pos + 1);

            StringBuilder sb = new StringBuilder();
            sb.Append("--");
            sb.Append(boundary);
            sb.Append("\r\n");
            sb.Append("Content-Disposition: form-data; name=\"");
            sb.Append("file");
            sb.Append("\"; filename=\"");
            sb.Append(fileName);
            sb.Append("\"");
            sb.Append("\r\n");
            sb.Append("Content-Type: ");
            sb.Append("application/octet-stream");
            sb.Append("\r\n");
            sb.Append("\r\n");

            string strPostHeader = sb.ToString();
            byte[] postHeaderBytes = Encoding.UTF8.GetBytes(strPostHeader);

            // 文件读取
            FileStream fs = new FileStream(filePath, FileMode.Open, FileAccess.Read);
            byte[] bArr = new byte[fs.Length];
            fs.Read(bArr, 0, bArr.Length);
            fs.Close();

            //结尾加了一个换行\r\n的目的是因为确保下一个分割线另起一行，这个分隔符一定要换行展示不然会报错
            byte[] temp = Encoding.ASCII.GetBytes("\r\n");

            HttpWebRequest wRequest = (HttpWebRequest)WebRequest.Create(url);
            wRequest.Method = "POST";
            wRequest.KeepAlive = true;
            wRequest.AllowAutoRedirect = false;
            wRequest.CookieContainer = cookies;
            wRequest.Timeout = 300000;
            wRequest.ContentType = "multipart/form-data;boundary=" + boundary;

            postStream = wRequest.GetRequestStream();


            // 把头部转为数据流放入到请求流中去
            postStream.Write(postHeaderBytes, 0, postHeaderBytes.Length);

            // 将文件流转为数据流放入到请求流中去，这部分对应fiddler中的
            postStream.Write(bArr, 0, bArr.Length);

            postStream.Write(temp, 0, temp.Length);

            // 结尾加上结束分隔符对应fiddler的---acebdf13572468--
            postStream.Write(endBoundaryBytes, 0, endBoundaryBytes.Length);
            postStream.Close();

            HttpWebResponse _response = (HttpWebResponse)wRequest.GetResponse();
            StreamReader reader = new StreamReader(_response.GetResponseStream(), Encoding.UTF8);
            string content = reader.ReadToEnd();

            _response.Close();

            return content;
        }

        public static string GetTestData()
        {
            using (StreamReader fileStream = new StreamReader("E:\\testData.txt"))
            {
                StringBuilder stringBuilder = new StringBuilder();
                while (!fileStream.EndOfStream)
                {
                    stringBuilder.Append(fileStream.ReadLine());
                }
                return stringBuilder.ToString();
            }
        }
    }
}
