import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel_app/Data/model/event_model.dart';
import 'package:travel_app/config.dart';


class EventService {
  // Đổi thành IP backend của bạn nếu cần

  static Future<List<EventModel>> getEventsByCity(String thanhPhoId) async {
    try {
       final response = await http.get(Uri.parse("${Config.apiURL}/sukien/thanhpho/$thanhPhoId"));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        return data.map((item) => EventModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
