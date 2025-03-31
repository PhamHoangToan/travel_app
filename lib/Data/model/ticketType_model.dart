class TicketTypeModel {
  final String name;
  final String description;
  final double pricePerPerson;

  TicketTypeModel({
    required this.name,
    required this.description,
    required this.pricePerPerson,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'pricePerPerson': pricePerPerson,
    };
  }

  // Convert from JSON
  factory TicketTypeModel.fromJson(Map<String, dynamic> json) {
    return TicketTypeModel(
      name: json['name'],
      description: json['description'],
      pricePerPerson: (json['pricePerPerson'] as num).toDouble(),
    );
  }
}
