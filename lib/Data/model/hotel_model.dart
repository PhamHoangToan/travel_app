import 'package:travel_app/config.dart';

class HotelModel {
  final String id; // Thêm thuộc tính id
  final String hotelImage;
  final String hotelName;
  final String location;
  final String describe;
  final String awayKilometer;
  final double star;
  final int numberOfReview;
  final double price;

  HotelModel({
    required this.id,  // Đã khai báo id
    required this.hotelImage,
    required this.hotelName,
    required this.location,
    required this.describe,
    required this.awayKilometer,
    required this.star,
    required this.numberOfReview,
    required this.price,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['idks']?.toString() ?? json['hotelId']?.toString() ?? json['_id']?.toString() ?? '',
 // Thêm dòng này để lấy id từ JSON
      hotelImage: json['hinhAnh'] != null
          ? "${Config.baseImageURL}/${json['hinhAnh']}"
          : '',
      hotelName: json['tenKS'] ?? '',
      location: json['diaChi'] ?? '',
      describe: json['moTa'] ?? '',
      awayKilometer: json['awayKilometer'] ?? 'N/A',
      star: json['soSao']?.toDouble() ?? 0.0,
      numberOfReview: json['soPhong'] ?? 0,
      price: json['gia']?.toDouble() ?? 0.0,
    );
  }
}
