using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Http;
using WebAPI.filters;
using WebAPI.Models;
using WebAPI.Tool;

namespace WebAPI.Controllers.v1
{
    [AuthFilter]
    [ActionFilter]
    public class MainController : BaseController
    {
        [AllowAnonymous]//屏蔽AuthFilter过滤器
        [HttpGet]
        public IHttpActionResult wxwebgrant()
        {
            MessageModel msg = new MessageModel();
            string code = HttpContext.Current.Request.QueryString["code"];
            if (code != null)
            {
                HttpContext.Current.Session["code"] = code;
            }
            else
            {
                Code.Result(ref msg, 编码.其他错误, "获取code失败");
                return GetResponseString(msg);
            }
            UserModel webgrant = new UserModel();
            try
            {
                webgrant.getWxWebGrantByCode(code, ref msg);

            }
            catch (Exception ex)
            {
                Code.Result(ref msg, 编码.程序错误, ex.Message);
            }
            if (msg.success == 1)
            {
                TokenModel token = new TokenModel();
                webgrant.token = token;
                HttpContext.Current.Session["UserModel"] = webgrant;
                msg.dateset = token;
            }
            return GetResponseString(msg);
        }

        [HttpPost]
        public IHttpActionResult login()
        {
            MessageModel msg = this.Request.Properties["msg"] as MessageModel;
            try
            {
                if (msg.clienttype == "wx")
                {
                    return RedirectWX();
                }
                else if (msg.clienttype == "web")
                {
                    UserModel webModel = new UserModel();
                    webModel.onlyid = GetRequestString("customid");
                    TokenModel token = new TokenModel();
                    webModel.token = token;
                    HttpContext.Current.Session["UserModel"] = webModel;
                    msg.dateset = token;
                    return GetResponseString(msg);
                }
                else
                {
                    Code.Result(ref msg, 编码.消息头错误, "无效的clienttype");
                    return GetResponseString(msg);
                }
            }
            catch (Exception e)
            {
                Code.Result(ref msg, 编码.程序错误, e.Message);
                return GetResponseString(msg);
            }
        }

        [HttpPost]
        public IHttpActionResult Token(dynamic p)
        {
            MessageModel msg = this.Request.Properties["msg"] as MessageModel;
            try
            {
                if (msg.clienttype == "wx" || msg.clienttype == "web")
                {
                    UserModel userModel = (UserModel)HttpContext.Current.Session["UserModel"];
                    if ((null != userModel && !string.IsNullOrEmpty(userModel.onlyid)) || Config.CeShi == "1")
                    {
                        TokenModel token = new TokenModel();
                        msg.dateset = token;
                        if (null != userModel)
                        {
                            userModel.token = token;
                        }
                        HttpContext.Current.Session["UserModel"] = userModel;
                    }
                    else
                    {
                        if (msg.clienttype == "wx")
                        {
                            return RedirectWX();
                        }
                        else
                        {
                            Code.Result(ref msg, 编码.用户身份错误, "用户未登录");
                        }
                    }
                }
                else if (msg.clienttype == "third")
                {
                    #region THIRD获取Token
                    TokenModel token = new TokenModel();
                    if (DataHelper.M_更新第三方Token(token, GetRequestString("customid")) == 1)
                    {
                        msg.dateset = token;
                    }
                    else
                    {
                        Code.Result(ref msg, 编码.程序错误, "获取token失败");
                    }
                    #endregion
                }
            }
            catch (Exception e)
            {
                Code.Result(ref msg, 编码.程序错误, e.Message);
            }
            return GetResponseString(msg);
        }

        [HttpPost]
        public IHttpActionResult process(dynamic p)
        {
            MessageModel msg= this.Request.Properties["msg"] as MessageModel;
            Dictionary<string, object> dic = new Dictionary<string, object>();
            try
            {
                if (msg.clienttype == "wx" || msg.clienttype == "web")
                {
                    UserModel userModel = (UserModel)HttpContext.Current.Session["UserModel"];
                    if ((null == userModel || string.IsNullOrEmpty(userModel.onlyid)) && Config.CeShi == "0")
                    {
                        if (msg.clienttype == "wx")
                        {
                            return RedirectWX();
                        }
                        else
                        {
                            Code.Result(ref msg, 编码.用户身份错误, "用户未登录");
                        }
                    }
                }

                if (msg.success == 1)
                {
                    dic = DataHelper.M_业务数据处理(ref msg, p);
                }
            }
            catch (Exception ex)
            {
                Code.Result(ref msg, 编码.程序错误, ex.Message);
            }
            return GetResponseString(msg, dic);
        }
    }
}
