using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text.RegularExpressions;
using System.Web.Http;
using System.Web.Http.Controllers;
using System.Web.Http.Dispatcher;

namespace WebAPI.Controllers
{
    public class VersionConstrollerSelector : IHttpControllerSelector
    {
        private readonly HttpConfiguration _conf;
        public VersionConstrollerSelector(HttpConfiguration configuration)
        {
            _conf = configuration;
        }
        /// <summary>
        /// 获取所有Controller
        /// </summary>
        /// <returns></returns>
        public IDictionary<string, HttpControllerDescriptor> GetControllerMapping()
        {
            Dictionary<String, HttpControllerDescriptor> dict = new Dictionary<string, HttpControllerDescriptor>();
            foreach (var item in _conf.Services.GetAssembliesResolver().GetAssemblies())
            {//循环所有程序集
                //获取所有继承自ApiController的非抽象类
                var controllerTypes = item.GetTypes()
                    .Where(y => !y.IsAbstract && typeof(ApiController)
                    .IsAssignableFrom(y)).ToArray();
                foreach (var ctrlType in controllerTypes)
                {//循环程序集中类型
                    //从namespace中提取出版本号
                    var match = Regex.Match(ctrlType.Namespace, GetType().Namespace + @".v(\d+)");
                    if (match.Success)
                    {//匹配成功
                        //获取版本号
                        string verNum = match.Groups[1].Value;
                        //从控制器总名称中拿到控制器名称（例:  HomeController中获取Home）
                        string ctrlName = Regex.Match(ctrlType.Name, "(.+)Controller").Groups[1].Value;
                        //声明集合中的键
                        String key = (ctrlName + "v" + verNum).ToLower();
                        //存储集合值（控制器信息）
                        dict[key] = new HttpControllerDescriptor(_conf, ctrlName, ctrlType);
                    }
                }
            }
            return dict;
        }

        /// <summary>
        /// 进行匹配Controller
        /// </summary>
        /// <param name="request">http请求信息</param>
        /// <returns>匹配成功返回控制器信息，匹配失败返回null</returns>
        public HttpControllerDescriptor SelectController(HttpRequestMessage request)
        {
            //获取所有的Controller集合
            var controllers = GetControllerMapping();
            //获取路由数据
            var routeData = request.GetRouteData();
            //从路由中获取当前controller的名称 
            var controllerName = routeData.Values["Controller"] as String;
            //如果请求头中存在ApiVerson信息则总其中获取版本号否则从url中获取版本号
            //下面是两种方式获取版本号
            string verNum = "";
            try
            {
                //从报文头中获取版本号（当没有这个参数的时候走catch）
                verNum = request.Headers.GetValues("ApiVersion").Single();
            }
            catch (Exception)
            {
                //从url中获取版本号
                verNum = Regex.Match(request.RequestUri.PathAndQuery, @"api/v(\d+)").Groups[1].Value;
            }
            //获取版本号 
            var key = (controllerName + "v" + verNum).ToLower();//获取Personv2    
            //返回控制器信息
            return controllers.ContainsKey(key) ? controllers[key] : null;
        }
    }
}