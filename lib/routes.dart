import 'package:flutter/material.dart';
import 'package:travel_app/Data/model/bookingDetails_model.dart';
import 'package:travel_app/Data/model/flight_model.dart';
import 'package:travel_app/Data/model/hotel_model.dart';
import 'package:travel_app/representation/screen/CustomerInformation_Flight_Screen.dart';
import 'package:travel_app/representation/screen/CustomerInformation_Screen.dart';
import 'package:travel_app/representation/screen/flight_search_screen.dart';
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
import 'package:travel_app/representation/screen/CustomerInfo_screen.dart';
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
  CustomerInfoScreen.routeName: (context) => CustomerInfoScreen(),
  SelectFlightScreen.routeName: (context) {
    return SelectFlightScreen(
      departure: "SGN",
      destinations: ["HAN"],
      departureDate: "2025-04-01",
    );
  },
  FlightsDetailScreen.routeName: (context) => FlightsDetailScreen(
        origin: 'SGN',
        destination: 'HAN',
        departureDate: '2025-04-01',
      ),
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
      if (settings.arguments is HotelModel) {
        return MaterialPageRoute(
          builder: (context) => HotelDetailScreen(hotelModel: settings.arguments as HotelModel),
        );
      }
      break;

    case FlightsDetailScreen.routeName:
      if (settings.arguments is Map<String, String>) {
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (context) => FlightsDetailScreen(
            origin: args['origin'] ?? 'Unknown',
            destination: args['destination'] ?? 'Unknown',
            departureDate: args['departureDate'] ?? 'Unknown',
          ),
        );
      }
      break;

    case CustomerinformationFlightScreen.routeName:
      if (settings.arguments is BookingDetails) {
        return MaterialPageRoute(
          builder: (context) => CustomerinformationFlightScreen(
            bookingDetails: settings.arguments as BookingDetails,
          ),
        );
      }
      break;

    case SelectRoomScreen.routeName:
      if (settings.arguments is String) {
        return MaterialPageRoute(
          builder: (context) => SelectRoomScreen(hotelId: settings.arguments as String),
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
