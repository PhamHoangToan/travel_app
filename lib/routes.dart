import 'package:flutter/material.dart';
import 'package:travel_app/Data/model/flight_model.dart';
import 'package:travel_app/Data/model/hotel_model.dart';
import 'package:travel_app/representation/screen/CustomerInformation_Flight_Screen.dart';
import 'package:travel_app/representation/screen/CustomerInformation_Screen.dart';
import 'package:travel_app/representation/screen/Flights_Screen.dart';
import 'package:travel_app/representation/screen/PassengerInfo_screen.dart';
import 'package:travel_app/representation/screen/Select_Destination_screen.dart';
import 'package:travel_app/representation/screen/account_screen.dart';
import 'package:travel_app/representation/screen/home_screen.dart';
import 'package:travel_app/representation/screen/login_screen.dart';
import 'package:travel_app/representation/screen/register_screen.dart';
import 'package:travel_app/representation/screen/select_room_screen.dart';
import 'package:travel_app/representation/screen/splash_screen.dart';
import 'package:travel_app/representation/screen/intro_screen.dart';
import 'package:travel_app/representation/screen/main_app.dart';
import 'package:travel_app/representation/screen/hotel_screen.dart';
import 'package:travel_app/representation/screen/hotel_booking_screen.dart';
import 'package:travel_app/representation/screen/select_date_screen.dart';
import 'package:travel_app/representation/screen/guest_and_room_booking.dart';
import 'package:travel_app/representation/screen/select_flight_screen.dart';
import 'package:travel_app/representation/screen/Flights_detail_screen.dart';
import 'package:travel_app/representation/screen/hotel_detail_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  IntroScreen.routeName: (context) => const IntroScreen(),
  MainApp.routeName: (context) => const MainApp(),
  HotelScreen.routeName: (context) => HotelScreen(),
  HotelBookingScreen.routeName: (context) => const HotelBookingScreen(),
  SelectDateScreen.routeName: (context) => SelectDateScreen(),
  SelectDestinationScreen.routeName: (context) => SelectDestinationScreen(),
  GuestAndRoomBookingScreen.routeName: (context) => GuestAndRoomBookingScreen(),
  FlightSearchScreen.routeName: (context) => FlightSearchScreen(),
  SelectFlightScreen.routeName: (context) => SelectFlightScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  AccountScreen.routeName:(context)=>AccountScreen(),
   CustomerInformation.routeName: (context) => const CustomerInformation(),
   PassengerInfoScreen.routeName:(context)=>PassengerInfoScreen(),
};


Route<dynamic>? generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case HotelDetailScreen.routeName:
      final arguments = settings.arguments;
      if (arguments is HotelModel) {
        return MaterialPageRoute(
          builder: (context) => HotelDetailScreen(hotelModel: arguments),
        );
      }
      break;

    case FlightsDetailScreen.routeName:
      final arguments = settings.arguments;
      if (arguments is FlightModel) {
        return MaterialPageRoute(
          builder: (context) => FlightsDetailScreen(flightModel: arguments),
        );
      }
      break;

    case CustomerinformationFlightScreen.routeName:
      final arguments = settings.arguments;
      if (arguments is FlightModel) {
        return MaterialPageRoute(
          builder: (context) => FlightsDetailScreen(flightModel: arguments),
        );
      }
      break;

    case SelectRoomScreen.routeName:
      final hotelId = settings.arguments as String?;
      if (hotelId != null) {
        return MaterialPageRoute(
          builder: (context) => SelectRoomScreen(hotelId: hotelId),
        );
      }
      break;

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
  return null;
}
