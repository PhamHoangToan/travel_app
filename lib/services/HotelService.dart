import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel_app/Data/model/hotel_model.dart';
import 'package:travel_app/config.dart';  // Đảm bảo import đúng model


Future<HotelModel> fetchHotelById(String hotelId) async {
  final url = Uri.parse('${Config.apiURL}/khachsan/$hotelId');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return HotelModel.fromJson(data);
  } else {
    throw Exception('Failed to load hotel');
  }
}

class HotelService {

  static Future<List<HotelModel>> fetchHotels() async {
final response = await http.get(Uri.parse("${Config.apiURL}/khachsan"));
    if (response.statusCode == 200) {
      List<dynamic> hotelsJson = json.decode(response.body);

      // Chuyển danh sách JSON thành danh sách các đối tượng HotelModel
      return hotelsJson.map((hotel) => HotelModel.fromJson(hotel)).toList();
    } else {
      throw Exception('Failed to load hotels');
    }
  }
}
Future<List<DateTime>> fetchBookedDates(String hotelId) async {
  final url = Uri.parse('${Config.apiURL}/bookings/hotel/$hotelId');
  print('fetchBookedDates url: $url');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    print('fetchBookedDates data: $data');
    List<DateTime> bookedDates = [];

    for (var item in data) {
      DateTime? startDate = item['ngayDat'] != null ? DateTime.parse(item['ngayDat']) : null;
      DateTime? endDate = item['ngayTra'] != null ? DateTime.parse(item['ngayTra']) : null;

      if (startDate != null && endDate != null) {
        // Add all dates in the range
        for (DateTime date = startDate; date.isBefore(endDate.add(Duration(days: 1))); date = date.add(Duration(days: 1))) {
          bookedDates.add(date);
        }
      }
    }

    return bookedDates;
  } else {
    throw Exception('Failed to load booked dates');
  }
}
