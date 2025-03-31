import 'package:flutter/material.dart';
import 'package:travel_app/Data/model/flight_model.dart';
import 'package:travel_app/Data/model/bookingDetails_model.dart';

class FlightDataProvider extends ChangeNotifier {
  FlightModel? _selectedFlight;
  BookingDetails? _bookingDetails;
  String _selectedTicketType = '';

  void setFlightData(FlightModel flightModel, BookingDetails bookingDetails) {
    _selectedFlight = flightModel;
    _bookingDetails = bookingDetails;
    notifyListeners();
  }

  void setSelectedTicketType(String ticketType) {
    _selectedTicketType = ticketType;
    notifyListeners();
  }

  FlightModel? get selectedFlight => _selectedFlight;
  BookingDetails? get bookingDetails => _bookingDetails;
  String get selectedTicketType => _selectedTicketType;
}
