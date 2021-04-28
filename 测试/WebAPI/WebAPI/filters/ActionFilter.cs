using Newtonsoft.Json;
using System;
using System.IO;
using System.Linq;
using System.Net.Http.Headers;
using System.Text;
using System.Web.Http.Controllers;
using System.Web.Http.Filters;
using WebAPI.Models;
using WebAPI.Tool;

namespace WebAPI.Controllers
{
    public class ActionFilter : ActionFilterAttribute
    {
        private static readonly string key = "enterTime";
        /// <summary>
        /// 在Action方法运行之前调用
        /// </summary>
        /// <param name="actionContext"></param>
        public override void OnActionExecuting(HttpActionContext actionContext)
        {
            //1.如果保留如下代码，则会运行.net framework定义好的行为验证，如果希望自定义行为验证，则删除如下代码
            // base.OnActionExecuting(actionContext);
            string actionName = actionContext.ActionDescriptor.ActionName.ToLower();//process、login、token
            try
            {
                dynamic p = null;
                if (actionContext.ActionArguments.ContainsKey("p"))
                {
                    p = actionContext.ActionArguments["p"];
                }

                HttpRequestHeaders headers = actionContext.Request.Headers;
                RequestModel req = new RequestModel();
                req.clienttype = GetValue("clienttype", headers);
                req.code = GetValue("code", headers);
                req.customid = GetValue("customid", headers);
                req.msgid = GetValue("msgid", headers);
                req.reqtime = GetValue("reqtime", headers);
                req.sign = GetValue("sign", headers);
                req.token = GetValue("token", headers);
                req.param = JsonConvert.SerializeObject(p);

                Log.Info(actionName + "请求", JsonConvert.SerializeObject(req));
            }
            catch (System.Exception e)
            {
                Log.Error(actionName, e.Message);
            }
            actionContext.Request.Properties[key] = DateTime.Now.ToBinary();
        }

        /// <summary>
        /// 在Action方法运行之后调用
        /// </summary>
        /// <param name="actionExecutedContext"></param>
        public override void OnActionExecuted(HttpActionExecutedContext actionExecutedContext)
        {
            //1.如果保留如下代码，则会运行.net framework定义好的行为验证，如果希望自定义行为验证，则删除如下代码
            base.OnActionExecuted(actionExecutedContext);
            string actionName = actionExecutedContext.ActionContext.ActionDescriptor.ActionName.ToLower();//process、login、token

            try
            {
                object beginTime = null;
                double costTime = -1;
                if (actionExecutedContext.Request.Properties.TryGetValue(key, out beginTime))
                {
                    DateTime time = DateTime.FromBinary(Convert.ToInt64(beginTime));
                    costTime = (DateTime.Now - time).TotalMilliseconds;
                }
                string executeResult = GetResponseValues(actionExecutedContext)+"&响应时间："+ costTime;

                Log.Info(actionName + "响应", executeResult);
            }
            catch (System.Exception e)
            {
                Log.Error(actionName, e.Message);
            }
        }

        private string GetValue(string name, HttpRequestHeaders headers)
        {
            if (headers.Contains(name))
            {
                return headers.GetValues(name).First();
            }
            else
            {
                return "NOT_FOUND";
            }
        }

        private string GetResponseValues(HttpActionExecutedContext actionExecutedContext)
        {
            Stream stream = actionExecutedContext.Response.Content.ReadAsStreamAsync().Result;
            Encoding encoding = Encoding.UTF8;
            /*
            这个StreamReader不能关闭，也不能dispose， 关了就傻逼了
            因为你关掉后，后面的管道  或拦截器就没办法读取了
            */
            var reader = new StreamReader(stream, encoding);
            string result = reader.ReadToEnd();
            /*
            这里也要注意：   stream.Position = 0; 
            当你读取完之后必须把stream的位置设为开始
            因为request和response读取完以后Position到最后一个位置，交给下一个方法处理的时候就会读不到内容了。
            */
            stream.Position = 0;
            return result;
        }
    }
}