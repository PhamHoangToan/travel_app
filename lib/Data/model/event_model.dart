class EventModel {
  final String id;
  final String tenSuKien;
  final DateTime ngayBatDau;
  final DateTime ngayKetThuc;
  final String noiDung;

  EventModel({
    required this.id,
    required this.tenSuKien,
    required this.ngayBatDau,
    required this.ngayKetThuc,
    required this.noiDung,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['_id'],
      tenSuKien: json['tenSuKien'],
      ngayBatDau: DateTime.parse(json['ngayBatDau']),
      ngayKetThuc: DateTime.parse(json['ngayKetThuc']),
      noiDung: json['noiDung'],
    );
  }
}
