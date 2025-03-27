import 'package:travel_app/config.dart';

class CityModel {
  final String id;
  final String name;
  final String image;

  CityModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['_id'] ?? '',
      name: json['tenThanhPho'] ?? '',
      image: json['hinhAnh'] != null
          ? "${Config.baseImageURL}/${json['hinhAnh']}"
          : '',
    );
  }
}
