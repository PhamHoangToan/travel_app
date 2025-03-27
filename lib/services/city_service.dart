import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel_app/Data/model/city_model.dart';
import '../../config.dart';
class CityService {
   // ✅ Đổi IP theo backend của bạn

  static Future<List<CityModel>> fetchCities() async {
    try {
      final response = await http.get(Uri.parse("${Config.apiURL}/thanhpho"));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => CityModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load cities');
      }
    } catch (e) {
      throw Exception('Error fetching cities: $e');
    }
  }
}
