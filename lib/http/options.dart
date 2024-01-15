///请求配置
class HttpOptions{
  ///连接服务器超时，单位ms
  static const int CONNECT_TIMEOUT=30000;
  ///接收超时，单位ms
  static const int RECEIVE_TIMEOUT=30000;
  ///地址前缀
  static const String BASE_URL='http://192.168.31.55:8080';
// static String BASE_URL =InternetAddress.lookup('localhost', type: InternetAddressType.IPv4).toString()+':8080';
}