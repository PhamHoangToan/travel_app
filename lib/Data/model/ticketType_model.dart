class TicketType {
  final String name;
  final String description;
  final double pricePerPerson;
  final int handLuggageKg;
  final int? checkedLuggageKg;
  final String details;

  TicketType({
    required this.name,
    required this.description,
    required this.pricePerPerson,
    required this.handLuggageKg,
    this.checkedLuggageKg,
    required this.details,
  });
}
