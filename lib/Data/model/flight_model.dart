import 'package:travel_app/Data/model/ticketType_model.dart';

class FlightModel {
  late String idflight; // 🆕 Thêm ID vào model
  final String airlineName;
  final String departure;
  final String destination;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final String seatClass;
  final int seatCount;
  final double ticketPrice;
  final String flightStatus;
  final String image;
  final List<TicketTypeModel> ticketTypes;

  FlightModel({
    required this.idflight,  // 🆕 Bắt buộc truyền ID khi tạo object
    required this.airlineName,
    required this.departure,
    required this.destination,
    required this.departureTime,
    required this.arrivalTime,
    required this.seatClass,
    required this.seatCount,
    required this.ticketPrice,
    required this.flightStatus,
    required this.image,
    required this.ticketTypes,
  });

  // ✅ Cập nhật phương thức toJson() để bao gồm ID
  Map<String, dynamic> toJson() {
    return {
      "id": idflight, // 🆕 Thêm ID vào JSON
      "airlineName": airlineName,
      "departure": departure,
      "destination": destination,
      "departureTime": departureTime.toIso8601String(),
      "arrivalTime": arrivalTime.toIso8601String(),
      "seatClass": seatClass,
      "seatCount": seatCount,
      "ticketPrice": ticketPrice,
      "flightStatus": flightStatus,
      "image": image,
      "ticketTypes": ticketTypes.map((ticket) => ticket.toJson()).toList(),
    };
  }
   factory FlightModel.fromJson(Map<String, dynamic> json) {
    return FlightModel(
      idflight: json["_id"] ?? json["id"], // Lấy đúng key từ MongoDB
      airlineName: json["airlineName"],
      departure: json["departure"],
      destination: json["destination"],
      departureTime: DateTime.parse(json["departureTime"]),
      arrivalTime: DateTime.parse(json["arrivalTime"]),
      seatClass: json["seatClass"],
      seatCount: json["seatCount"],
      ticketPrice: json["ticketPrice"].toDouble(),
      flightStatus: json["flightStatus"],
      image: json["image"],
      ticketTypes: (json["ticketTypes"] as List)
          .map((ticket) => TicketTypeModel.fromJson(ticket))
          .toList(),
    );
  }
}
