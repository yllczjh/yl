using WebAPI.Models;

namespace WebAPI.Tool
{
    public class Code
    {
        public static void Result(ref MessageModel msg, 编码 c, string str)
        {
            msg.success = (int)c;
            msg.msgtext = c.ToString() + "(" + str + ")";
        }

    }

    public enum 编码
    {
        成功 = 1,
        程序错误 = 0,
        用户身份错误 = 1001,
        Token错误 = 1002,
        消息头错误 = 1003,
        参数错误 = 1004,
        其他错误 = 9999
    }
}