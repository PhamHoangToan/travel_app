class KhachHangModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String cccd;
  final DateTime ngaySinh;
  final String? idDatPhong;
  String? token;

  KhachHangModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.cccd,
    required this.ngaySinh,
    this.idDatPhong,
    this.token,
  });

  factory KhachHangModel.fromJson(Map<String, dynamic> json) {
    return KhachHangModel(
      id: json['_id'],  // MongoDB trả về _id
      name: json['name'],
      email: json['email'],
      password: json['password'],
      cccd: json['cccd'],
      ngaySinh: DateTime.parse(json['ngaySinh']),
      idDatPhong: json['idDatPhong'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'cccd': cccd,
      'ngaySinh': ngaySinh.toIso8601String(),
      'idDatPhong': idDatPhong,
      'token': token,
    };
  }

  /// ✅ **Thêm phương thức copyWith() để cập nhật dữ liệu mà không thay đổi object gốc**
  KhachHangModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? cccd,
    DateTime? ngaySinh,
    String? idDatPhong,
    String? token,
  }) {
    return KhachHangModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      cccd: cccd ?? this.cccd,
      ngaySinh: ngaySinh ?? this.ngaySinh,
      idDatPhong: idDatPhong ?? this.idDatPhong,
      token: token ?? this.token,
    );
  }
}
