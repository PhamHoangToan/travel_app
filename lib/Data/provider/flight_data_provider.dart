import 'package:flutter/foundation.dart';
import 'package:travel_app/Data/model/flight_model.dart';
import 'package:travel_app/Data/model/bookingDetails_model.dart';

class FlightDataProvider extends ChangeNotifier {
  FlightModel? flightModel;
  BookingDetails? bookingDetails;

  void setFlightData(FlightModel flight, BookingDetails booking) {
    flightModel = flight;
    bookingDetails = booking;
    notifyListeners(); // Thông báo màn hình mới
  }
}
