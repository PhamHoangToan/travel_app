import 'package:travel_app/Data/model/flight_model.dart';
import 'package:travel_app/Data/model/ticketType_model.dart';

class FlightDetail {
  final FlightModel flight;
  final List<TicketType> ticketTypes;

  FlightDetail({
    required this.flight,
    required this.ticketTypes,
  });
}
