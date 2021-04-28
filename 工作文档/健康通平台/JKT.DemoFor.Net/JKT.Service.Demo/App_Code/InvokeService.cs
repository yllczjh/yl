using System;
using System.Reflection;
using System.Configuration;
using System.Web;
using System.Net;
using System.IO;
using System.Web.Services.Description;
using System.Xml.Serialization;
using System.CodeDom;
using System.CodeDom.Compiler;
using System.Xml;

namespace JKT.Service.Demo
{
    /// <summary>
    /// 调用健康通平台提供的 WebServices
    /// </summary>
    public class InvokeService
    {
        /// <summary>
        /// 信息推送接口
        /// </summary>
        public void PushInfo()
        {
            try
            {
                //设置请求的业务参数
                string req_bxml = @"<REQ>
                                      <HOS_ID>医院ID，健康通平台分配，唯一</HOS_ID>
                                      <DATA_TIME>当前系统时间</DATA_TIME>
                                      <HOSP_PATIENT_ID>用户院内ID</HOSP_PATIENT_ID>
                                      <PATIENT_IDCARD_TYPE>用户证件类型，按健康通平台接口规范传值</PATIENT_IDCARD_TYPE>
                                      <PATIENT_IDCARD_NO>用户证件号码</PATIENT_IDCARD_NO>
                                      <PATIENT_CARD_TYPE>用户卡类型，按健康通平台接口规范传值</PATIENT_CARD_TYPE>
                                      <PATIENT_CARD_NO>用户卡号</PATIENT_CARD_NO>
                                      <PATIENT_NAME>用户真实姓名</PATIENT_NAME>
                                      <PATIENT_SEX>用户性别，int类型</PATIENT_SEX>
                                      <PATIENT_AGE>用户年龄，int类型</PATIENT_AGE>
                                      <ORDER_ID>健康通平台订单号，唯一</ORDER_ID>
                                      <HOSP_ORDER_ID>院内订单号，唯一</HOSP_ORDER_ID>
                                      <DEPT_NAME>科室名称</DEPT_NAME>
                                      <DOCTOR_NAME>医生名称</DOCTOR_NAME>
                                      <REG_DT>挂号日期</REG_DT>
                                      <PUSH_TYPE>推送类型,1-缴费通知 2-排队提醒 3-检查/检验报告提醒</PUSH_TYPE>
                                      <PUSH_ID>推送的ID，院内唯一的排队ID、检查/检验报告ID或缴费登记号</PUSH_ID>
                                      <PUSH_CONTENT>推送内容</PUSH_CONTENT>
                                    </REQ>";

                //设置请求参数
                string key = ConfigurationManager.AppSettings["Key"].ToString();
                string req_xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
                req_xml += @"<ROOT>
                               <FUN_CODE><![CDATA[{0}]]></FUN_CODE>
                               <USER_ID><![CDATA[{1}]]></USER_ID>
                               <SIGN_TYPE><![CDATA[{2}]]></SIGN_TYPE>
                               <SIGN><![CDATA[{3}]]></SIGN>
                               <REQ_ENCRYPTED><![CDATA[{4}]]></REQ_ENCRYPTED>
                             </ROOT>";
                string fun_code = "7001";  //信息推送接口功能号，健康通平台定义，唯一
                string user_id = ConfigurationManager.AppSettings["UserId"].ToString();
                string req_encrypted = Common.EncryptForAES(req_bxml, key);
                string req_sign = Common.GetRequsetSign(fun_code, user_id, req_encrypted, key);
                req_xml = string.Format(req_xml, fun_code, user_id, "MD5", req_sign, req_encrypted);

                //动态调用健康通平台提供的WebServices服务
                string jktUrl = ConfigurationManager.AppSettings["JktUrl"].ToString();
                string className = ConfigurationManager.AppSettings["ClassName"].ToString();
                string methodName = ConfigurationManager.AppSettings["MethodName"].ToString();
                object[] args = new object[] { req_xml };

                string res_xml = InvokeWebService(jktUrl, className, methodName, args).ToString();

                //获取健康通平台的返回参数
                XmlDocument root = new XmlDocument();
                root.LoadXml(res_xml);

                int res_code = Convert.ToInt32(root.SelectSingleNode("ROOT/RETURN_CODE").InnerText);
                string res_msg = root.SelectSingleNode("ROOT/RETURN_MSG").InnerText;
                string res_sign = root.SelectSingleNode("ROOT/SIGN").InnerText;
                string res_sign_type = root.SelectSingleNode("ROOT/SIGN_TYPE").InnerText;
                string res_encrypted = root.SelectSingleNode("ROOT/RES_ENCRYPTED").InnerText;

                //对请求串进行md5验签
                string sign = Common.GetResponseSign(res_code, res_msg, res_encrypted, key);
                if (res_sign != sign || res_sign_type != "MD5")
                {
                    //签名不正确
                }

                if (res_code != 0)
                {
                    //返回不正确，异常信息：res_msg
                }

                //获取健康通平台的返回业务参数
                string res_bxml = Common.DecryptForAES(res_encrypted, key);

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 动态调用 WebServices
        /// </summary>
        /// <param name="url"></param>
        /// <param name="namespace"></param>
        /// <param name="className"></param>
        /// <param name="methodName"></param>
        /// <param name="args"></param>
        /// <returns></returns>
        public static object InvokeWebService(string url, string className, string methodName, object[] args)
        {
            string @namespace = string.Empty;
            object ret = null;
            string url_old = url;
            try
            {
                if (string.IsNullOrEmpty(@namespace))
                {
                    @namespace = "EnterpriseServerBase.WebService.DynamicWebCalling";
                }
                if (string.IsNullOrEmpty(className))
                {
                    string[] parts = url.Split('/');
                    string[] pps = parts[parts.Length - 1].Split('.');
                    className = pps[0];
                }
                string dllName = "";
                if (HttpContext.Current == null)
                {
                    dllName = HttpRuntime.AppDomainAppPath;
                }
                dllName = dllName + "bin\\" + className + ".dll";
                if (!url.ToUpper().Contains("?WSDL"))
                {
                    url = url + "?wsdl";
                }

                // if (!File.Exists(dllName)) {
                WebClient client = new WebClient();
                Stream stream = client.OpenRead(url);
                ServiceDescription description = ServiceDescription.Read(stream);
                ServiceDescriptionImporter importer = new ServiceDescriptionImporter();//创建客户端代理代理类。
                importer.ProtocolName = "Soap"; //指定访问协议。
                importer.Style = ServiceDescriptionImportStyle.Client; //生成客户端代理。
                importer.CodeGenerationOptions = CodeGenerationOptions.GenerateProperties | CodeGenerationOptions.GenerateNewAsync;
                importer.AddServiceDescription(description, "", ""); //添加WSDL文档。

                CodeNamespace nmspace = new CodeNamespace(); //命名空间
                nmspace.Name = @namespace;
                CodeCompileUnit unit = new CodeCompileUnit();
                unit.Namespaces.Add(nmspace);

                importer.Import(nmspace, unit);
                CodeDomProvider provider = CodeDomProvider.CreateProvider("CSharp");

                CompilerParameters parameter = new CompilerParameters();
                parameter.GenerateExecutable = false;
                parameter.GenerateInMemory = true;

                //输出程序集到本地
                //parameter.OutputAssembly = dllName;//输出程序集的名称
                parameter.ReferencedAssemblies.Add("System.dll");
                parameter.ReferencedAssemblies.Add("System.XML.dll");
                parameter.ReferencedAssemblies.Add("System.Web.Services.dll");
                parameter.ReferencedAssemblies.Add("System.Data.dll");

                CompilerResults result = provider.CompileAssemblyFromDom(parameter, unit);

                if (result.Errors.HasErrors)
                {
                    throw new Exception("webservices 编译错误:" + result.Output[6]);
                }

                System.Reflection.Assembly assembly = result.CompiledAssembly;

                Type t = assembly.GetType(@namespace + "." + className, true, true);
                object _WebClientInstance = Activator.CreateInstance(t);
                MethodInfo method = t.GetMethod(methodName);
                ret = method.Invoke(_WebClientInstance, args);
            }
            catch (TimeoutException ex)
            {  //超时
                throw new Exception("超时\t" + ex.InnerException.Message, new Exception(ex.InnerException.StackTrace));
            }
            catch (Exception e)
            {
                if (e.InnerException == null)
                    throw new Exception("webservices 客服端生成错误：\r\nMessage：" + e.Message + "\r\nurl：" + url_old);
                else
                    throw new Exception("webservices 客服端生成错误：\r\nMessage：" + e.Message + "\r\nInnerException：" + e.InnerException.InnerException.Message + "\r\nurl：" + url_old);
            }
            return ret;
        }


    }
}

