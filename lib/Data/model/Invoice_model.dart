class Invoice {
  final String id;
  final bool isRequested;
  final String details;
  final double totalPrice;

  Invoice({
    required this.id,
    required this.isRequested,
    required this.details,
    required this.totalPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isRequested': isRequested,
      'details': details,
      'totalPrice': totalPrice,
    };
  }

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      isRequested: json['isRequested'],
      details: json['details'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );
  }
}
