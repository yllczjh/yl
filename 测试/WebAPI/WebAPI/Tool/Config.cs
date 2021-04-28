namespace WebAPI.Tool
{
    public class Config
    {
        private static string GetAppSetting(string key)
        {
            return System.Configuration.ConfigurationManager.AppSettings[key];
        }

        public static string AppID
        {
            get { return GetAppSetting("appId"); }
        }
        public static string AppSecret
        {
            get { return GetAppSetting("appSecret"); }
        }
        public static int AccessTokenTime
        {
            get { return int.Parse(GetAppSetting("accessTokenTime")); }
        }
        public static int RefreshTokenTime
        {
            get { return int.Parse(GetAppSetting("refreshTokenTime")); }
        }
        public static string BaseURL
        {
            get { return GetAppSetting("baseURL"); }
        }

        //=======【日志级别】===================================
        /* 日志等级，0.不输出日志；1.只输出错误信息; 2.输出错误和正常信息; 3.输出错误信息、正常信息和调试信息
        */
        public static int LogLevel
        {
            get { return int.Parse(GetAppSetting("logLevel")); }
        }
        public static string CeShi
        {
            get { return GetAppSetting("ceshi"); }
        }
        public static string Login
        {
            get { return GetAppSetting("login"); }
        }
    }
}