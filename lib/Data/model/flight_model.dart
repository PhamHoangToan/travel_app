import 'package:travel_app/Data/model/ticketType_model.dart';

class FlightModel {
  final String airlineName;
  final String departure;
  final String destination;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final String seatClass;
  final int seatCount;
  final double ticketPrice;
  final String flightStatus;
  final String image;
  final List<TicketType> ticketTypes;

  FlightModel({
    required this.airlineName,
    required this.departure,
    required this.destination,
    required this.departureTime,
    required this.arrivalTime,
    required this.seatClass,
    required this.seatCount,
    required this.ticketPrice,
    required this.flightStatus,
    required this.image,
    required this.ticketTypes,
  });
}