import 'dart:convert';
import 'package:http/http.dart' as http;



class KhachHangModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String cccd;
  final DateTime ngaySinh;
  final String? idDatPhong;
   String? token;   // Optional field for referencing DonDatPhong

  KhachHangModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.cccd,
    required this.ngaySinh,
    this.idDatPhong,
    this.token
  });

  factory KhachHangModel.fromJson(Map<String, dynamic> json) {
    return KhachHangModel(
      id: json['_id'],  // Assuming MongoDB returns _id
      name: json['name'],
      email: json['email'],
      password: json['password'],
      cccd: json['cccd'],
      ngaySinh: DateTime.parse(json['ngaySinh']),
      idDatPhong: json['idDatPhong'],
      token: json['token'],  // This may be null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'cccd': cccd,
      'ngaySinh': ngaySinh.toIso8601String(),  // Convert to ISO string
      'idDatPhong': idDatPhong,
       'token': token,  // May be null
    };
  }

  // Static method for registering passenger via API
  
}
