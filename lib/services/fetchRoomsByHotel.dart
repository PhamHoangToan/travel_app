import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel_app/Data/model/room_model.dart';
import 'package:travel_app/config.dart';

Future<List<RoomType>> fetchRoomsByHotel(String hotelId) async {
  print('Fetching rooms for hotel ID: $hotelId');

  try {
    final response = await http.get(Uri.parse("${Config.apiURL}/hotel/$hotelId"));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => RoomType.fromJson(json)).toList();
    } else {
      print('Failed to load rooms. Status code: ${response.statusCode}');
      throw Exception('Failed to load rooms');
    }
  } catch (e) {
    print('Error fetching rooms: $e');
    throw Exception('Failed to fetch rooms');
  }
}
