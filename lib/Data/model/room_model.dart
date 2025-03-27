import 'package:travel_app/config.dart';

class RoomType {
   final String id; 
  final String tenLp;
  final bool mayLanh;
  final String hinhAnhPhong;
  final double gia;
  final int soLuongGiuong;
  final int soLuongPhong;
  final String idks;
  final DateTime? ngayDat; // Ngày đặt phòng
  final DateTime? ngayTra; // Ngày trả phòng

  RoomType({
    required this.id,
    required this.tenLp,
    required this.mayLanh,
    required this.hinhAnhPhong,
    required this.gia,
    required this.soLuongGiuong,
    required this.soLuongPhong,
    required this.idks,
    this.ngayDat,
    this.ngayTra,
  });

  // Chuyển đổi từ JSON
  factory RoomType.fromJson(Map<String, dynamic> json) {
    String imageUrl = json['hinhAnhphong'] ?? ''; // Đường dẫn ảnh từ JSON

    // Nếu có ảnh, thêm tiền tố đường dẫn server
    if (imageUrl.isNotEmpty) {
      imageUrl = "${Config.baseImageURL}/$imageUrl";
    }

    return RoomType(
       id: json['_id'] ?? '', 
      tenLp: json['TenLp'] ?? '',  // Key phải đúng với API (TenLp)
      mayLanh: json['mayLanh'] ?? false,
      hinhAnhPhong: imageUrl,// Đường dẫn ảnh đã sửa
      gia: (json['gia'] ?? 0).toDouble(),
      soLuongGiuong: json['soLuongGiuong'] ?? 0,
      soLuongPhong: json['soLuongPhong'] ?? 0,
      idks: json['idks']?.toString() ?? json['hotelId']?.toString() ?? json['_id']?.toString() ?? '',
      ngayDat: json['ngayDat'] != null ? DateTime.parse(json['ngayDat']) : null,
      ngayTra: json['ngayTra'] != null ? DateTime.parse(json['ngayTra']) : null,
    );
  }

  // Chuyển đổi sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'TenLp': tenLp, // Đảm bảo key đúng
      'mayLanh': mayLanh,
      'hinhAnhphong': hinhAnhPhong, // Không thay đổi đường dẫn
      'gia': gia,
      'soLuongGiuong': soLuongGiuong,
      'soLuongPhong': soLuongPhong,
      'idks': idks,
      'ngayDat': ngayDat?.toIso8601String(), // Định dạng ngày ISO
      'ngayTra': ngayTra?.toIso8601String(),
    };
  }
}
