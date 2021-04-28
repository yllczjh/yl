using System.Web.Http;
using System.Web.Http.Dispatcher;
using WebAPI.Controllers;
using WebAPI.filters;

namespace WebAPI
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            // Web API 配置和服务
            //用重写IHttpControllerSelector的替换原先的IHttpControllerSelector
            config.Services.Replace(typeof(IHttpControllerSelector), new VersionConstrollerSelector(config));
            // Web API 路由
            config.MapHttpAttributeRoutes();
            //注册全局Filter
            //config.Filters.Add(new ActionFilter());


            config.Routes.MapHttpRoute(
              name: "DefaultApiV1",
              routeTemplate: "api/v1/{controller}/{action}/{id}",
              defaults: new { id = RouteParameter.Optional }
            );
            config.Routes.MapHttpRoute(
              name: "DefaultApiV11",
              routeTemplate: "api1/v1/{controller}/{id}",
              defaults: new { id = RouteParameter.Optional }
            );

            config.Routes.MapHttpRoute(
             name: "DefaultApiV2",
             routeTemplate: "api/v2/{controller}/{action}/{id}",
             defaults: new { id = RouteParameter.Optional }
            );
        }
    }
}
