alter table 支付管理_参数配置 add 类名 varchar2(50);
update 支付管理_参数配置 set 类名='C_Pay_YinLian_Cloud' where 接口名称 in ('网上支付','银联支付','其他支付');
update 支付管理_参数配置 set 类名='C_Pay_WeiXin_Cloud' where 接口名称 ='微信支付';
update 支付管理_参数配置 set 类名='C_Pay_GZYYGHPT' where 接口名称 ='贵州预约挂号平台';
update 支付管理_参数配置 set 类名='C_Pay_Zhifubao_Cloud' where 接口名称 ='支付宝支付';