using System;
using WebAPI.Tool;

namespace WebAPI.Models
{
    public class TokenModel
    {
        /// <summary>
        /// 请求token
        /// </summary>
        public string accessToken { get; set; }
        /// <summary>
        /// 请求token过期时间
        /// </summary>
        public string accessPastTime { get; set; }
        /// <summary>
        /// 刷新token
        /// </summary>
        public string refreshToken { get; set; }
        /// <summary>
        /// 刷新token过期时间
        /// </summary>
        public string refreshPastTime { get; set; }

        public TokenModel()
        {
            accessToken = Guid.NewGuid().ToString("N");
            accessPastTime = DateTime.Now.AddHours(Config.AccessTokenTime).ToString("yyyy-MM-dd HH:mm:ss");
            refreshToken = Guid.NewGuid().ToString("N");
            refreshPastTime = DateTime.Now.AddHours(Config.RefreshTokenTime).ToString("yyyy-MM-dd HH:mm:ss");
        }
    }
}