using LitJson;
using System;
using System.Net.Http;
using WebAPI.Tool;

namespace WebAPI.Models
{
    public class UserModel
    {
        public string onlyid { get; set; }//用户唯一标识 微信：openid  web：
        public TokenModel token { get; set; }
        public UserModel()
        {

        }

        public void getWxWebGrantByCode(string code,ref MessageModel msg)
        {
            try
            {
                string url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code";
                url = url.Replace("APPID", Config.AppID).Replace("SECRET", Config.AppSecret).Replace("CODE", code);
                string result; //请求结果
                using (var client = new HttpClient())
                {
                    result = client.GetAsync(url).Result.Content.ReadAsStringAsync().Result;
                }

                //保存access_token，用于收货地址获取
                JsonData jd = JsonMapper.ToObject(result);

                if (((System.Collections.IDictionary)jd).Contains("errcode"))
                {
                    Code.Result(ref msg, 编码.其他错误, $"请求微信用户信息错误,errcode:{jd["errcode"].ToString()}:errmsg:{jd["errmsg"].ToString()}");
                }
                this.onlyid = jd["openid"].ToString();
            }
            catch (Exception ex)
            {
                Code.Result(ref msg, 编码.程序错误, ex.Message);
            }
        }
    }
}