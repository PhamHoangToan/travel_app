import 'package:travel_app/Data/model/Invoice_model.dart';
import 'package:travel_app/Data/model/flight_model.dart';
import 'package:travel_app/Data/model/passenger_model.dart';

class BookingDetails {
  final String id;
  final List<KhachHangModel> passengers;
  final FlightModel flightModel;
  final Invoice invoice;
  final double totalPrice;

  BookingDetails({
    required this.id,
    required this.passengers,
    required this.flightModel,
    required this.invoice,
    required this.totalPrice,
  });

  // ✅ Thêm phương thức toJson để chuyển đổi thành JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "passengers": passengers.map((p) => p.toJson()).toList(), // Convert list to JSON
      "flightModel": flightModel.toJson(),
      "invoice": invoice.toJson(),
      "totalPrice": totalPrice,
    };
  }

  // ✅ Cập nhật copyWith
  BookingDetails copyWith({
    String? id,
    List<KhachHangModel>? passengers,
    FlightModel? flightModel,
    Invoice? invoice,
    double? totalPrice,
  }) {
    return BookingDetails(
      id: id ?? this.id,
      passengers: passengers ?? this.passengers,
      flightModel: flightModel ?? this.flightModel,
      invoice: invoice ?? this.invoice,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
