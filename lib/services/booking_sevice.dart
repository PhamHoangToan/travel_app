import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:travel_app/Data/model/bookingDetails_model.dart';
import 'package:travel_app/Data/model/flight_model.dart';
import '../../config.dart';
class BookingService {

  // 🎯 API đặt vé
  static Future<bool> bookFlight(BookingDetails booking) async {
    try {
      final Uri url = Uri.parse("${Config.apiURL}/book-flight");

      // Kiểm tra flightId, nếu không hợp lệ thì gửi cả flightInfo
      bool isValidFlightId = booking.flightModel.idflight != null &&
          booking.flightModel.idflight.trim().length ==
              24; // ObjectId MongoDB có 24 ký tự

      final Map<String, dynamic> requestBody = {
        "flightId": isValidFlightId
            ? booking.flightModel.idflight.trim()
            : "", // Chỉ gửi nếu hợp lệ
        "passengers": booking.passengers.map((p) => p.toJson()).toList(),
        "totalPrice": booking.totalPrice,
      };

      // Nếu flightId không hợp lệ, gửi thêm flightInfo
      if (!isValidFlightId) {
        print("⚠️ flightId không hợp lệ, gửi thêm flightInfo...");
        requestBody["flightInfo"] = {
          "airlineName": booking.flightModel.airlineName ?? "Unknown Airline",
          "departure": booking.flightModel.departure ?? "Unknown",
          "destination": booking.flightModel.destination ?? "Unknown",
          "departureTime": booking.flightModel.departureTime.toIso8601String(),
          "arrivalTime": booking.flightModel.arrivalTime.toIso8601String(),
          "seatClass": booking.flightModel.seatClass ?? "Economy",
          "seatCount": booking.flightModel.seatCount ?? 0,
          "ticketPrice": booking.flightModel.ticketPrice ?? 0.0,
          "flightStatus": booking.flightModel.flightStatus ?? "Scheduled",
          "image": booking.flightModel.image ?? "",
          "ticketTypes": booking.flightModel.ticketTypes ?? [],
        };
      }

      print("📌 Gửi dữ liệu đặt vé: ${jsonEncode(requestBody)}"); // Debug log

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

       if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print("✅ Đặt vé thành công! Flight ID mới: ${responseData['flightId']}");

      // 🔥 Cập nhật flightId mới từ API
      booking.flightModel.idflight= responseData['flightId'];

      return true;
    } else {
      print("❌ API lỗi: ${response.statusCode} - ${response.body}");
      return false;
    }
    } catch (e) {
      print("❌ Lỗi kết nối hoặc xử lý: $e");
      return false;
    }
  }

  // 🎯 API thanh toán
  static Future<String?> processPayment(BookingDetails bookingDetails) async {
  String apiUrl = "${Config.apiURL}/success";

  if (bookingDetails.flightModel == null ||
      bookingDetails.flightModel?.idflight == null) {
    print("❌ Lỗi: flightModel hoặc flightId bị null!");
    return null;
  }

  print("📌 Đang gửi yêu cầu lấy thông tin chuyến bay từ MongoDB...");
  print("📌 flightId gửi đi: ${bookingDetails.flightModel?.idflight}");

  // 🛠 Load lại thông tin chuyến bay từ database
  final flightResponse = await http.get(
    Uri.parse("${Config.apiURL}/${bookingDetails.flightModel!.idflight}"),
    headers: {"Content-Type": "application/json"},
  );

  if (flightResponse.statusCode == 200) {
    var flightData = jsonDecode(flightResponse.body);
  bookingDetails = BookingDetails( // ✅ Gán lại toàn bộ object
    id: bookingDetails.id,
    passengers: bookingDetails.passengers,
    flightModel: FlightModel.fromJson(flightData),
    invoice: bookingDetails.invoice,
    totalPrice: bookingDetails.totalPrice,
  ); // Cập nhật dữ liệu mới
    print("✅ Tải lại chuyến bay thành công: ${bookingDetails.flightModel}");
  } else {
    print("⚠️ Không tìm thấy chuyến bay trong DB!");
    return null;
  }

  print("📌 Đang gửi yêu cầu thanh toán với dữ liệu: ${jsonEncode(bookingDetails.toJson())}");

  try {
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "flightId": bookingDetails.flightModel!.idflight,
        "email": bookingDetails.passengers[0].email,
        "orderId": bookingDetails.id,
        "totalPrice": bookingDetails.totalPrice,
        "paymentMethod": "Ví điện tử",
      }),
    );

    print("📥 Response: ${response.statusCode} - ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['qrCode'];
    } else {
      print("❌ Lỗi API: ${response.body}");
      return null;
    }
  } catch (e) {
    print("❌ Lỗi kết nối: $e");
    return null;
  }
}
}