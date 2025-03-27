import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel_app/Data/model/passenger_model.dart';
import '../../config.dart';
import 'shared_service.dart';
import '../Data/model/room_model.dart'; // Import model
import 'package:shared_preferences/shared_preferences.dart';

class RoomService {
  
  static Future<List<RoomType>> fetchRooms() async {
    final response = await http.get(Uri.parse("${Config.apiURL}/loaiPhong"));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((room) => RoomType.fromJson(room)).toList();
    } else {
      throw Exception("Failed to load rooms");
    }
  }
}
class APIService {
  static var client = http.Client();

  static Future<bool> register(String username, String email, String password) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(Config.apiURL + Config.registerAPI);

    var body = jsonEncode({
      'name': username,
      'email': email,
      'password': password,
    });

    try {
      var response = await client.post(
        url,
        headers: requestHeaders,
        body: body,
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        print("Registration failed: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Exception during registration: $e");
      return false;
    }
  }

static Future<bool> login(String email, String password) async {
  final response = await http.post(
    Uri.parse("${Config.apiURL}/khachhang/login"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"email": email, "password": password}),
  );

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);

    final token = jsonResponse['token'];
    final khachHang = jsonResponse['khachHang'];
    final userId = khachHang['id'];

    if (token != null && userId != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Lưu token & userId vào bộ nhớ
      await prefs.setString('token', token);
      await prefs.setString('userId', userId);

      print('Đăng nhập thành công! userId: $userId');
      return true;
    } else {
      print('Đăng nhập thất bại. Không có token hoặc userId.');
      return false;
    }
  } else {
    print('Đăng nhập thất bại. Mã lỗi ${response.statusCode}');
    return false;
  }
}



  static Future<String> getUserProfile() async {
    var loginDetails = await SharedService.loginDetails();

    if (loginDetails == null) {
      throw Exception("User not logged in");
    }

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails.token}',
    };

    var url = Uri.parse(Config.apiURL + Config.userProfileAPI);

    try {
      var response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        print("Failed to get user profile: ${response.body}");
        return "";
      }
    } catch (e) {
      print("Exception during getUserProfile: $e");
      return "";
    }
  }
}
