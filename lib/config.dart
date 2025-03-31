class Config {
  static const String appName = "Travel App";
  static const String apiHost = "192.168.0.107:3000";
  static const String apiBasePath = "/api";

  static const String apiURL = "http://" + apiHost + apiBasePath;
  static const String registerAPI = "/khachhang/register";
  static const String loginAPI = "/khachhang/login";
  static const String userProfileAPI = "/user/profile";
  static const String donDatPhongAPI = "/don-dat-phong";
  static const String baseImageURL = "http://$apiHost/uploads";
}
