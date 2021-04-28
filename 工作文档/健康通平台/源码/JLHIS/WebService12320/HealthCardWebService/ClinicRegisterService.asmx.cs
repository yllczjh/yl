using System.Web.Services;

namespace HealthCardWebService
{
    /// <summary>
    /// ClinicRegisterService 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    // [System.Web.Script.Services.ScriptService]
    public class ClinicRegisterService : System.Web.Services.WebService
    {
        private log4net.ILog log = log4net.LogManager.GetLogger("ClinicRegisterService");
        public ClinicRegisterService()
        {
            log4net.Config.XmlConfigurator.Configure(new System.IO.FileInfo(Server.MapPath("~/Web.config")));
        }
        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        /// <summary>
        /// 网络测试接口 提供给健康通平台调用
        /// </summary>
        /// <param name="xml"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true, Description = "提供给健康通用平台调用服务，通过内部功能号进行区分业务")]
        public string HealthCardService(string xml)
        {
            log.Info("Web Call inParam begin###########" + xml + "###########Web Call inParam end");
            string res_xml = string.Empty;
            res_xml= HealthCardManager.HttpHelper.HealthCardService(xml);
            log.Info("Web Call outParam begin========" + res_xml + "========Web Call outParam end");
            return res_xml;
        }
    }
}
