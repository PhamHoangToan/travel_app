// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:travel_app/Data/model/flight_model.dart';

// class FlightService {
//   final String aviationStackApiKey = ""; // API Key của AviationStack 276cc911ac57f20bfeb47801de535dbc
//   final String duffelApiKey = "duffel_test_s7GGxYxGqelv4S4d_blfBCW_jumgO9QMncOSWCriCYY"; // API Key của Duffel
//   final String airLabsApiKey = "your_airlabs_api_key"; // API Key của AirLabs

//   // Lấy dữ liệu chuyến bay từ cả hai API
//   Future<List<FlightModel>> getFlightData() async {
//     List<FlightModel> flights = [];

//     // Lấy chuyến bay từ AviationStack
//     List<FlightModel> aviationFlights = await _getAviationStackFlights();
//     flights.addAll(aviationFlights);

//     // Lấy chuyến bay từ Duffel API
//     List<FlightModel> duffelFlights = await _getDuffelFlights();
//     flights.addAll(duffelFlights);
//   print("Flights: ${flights.length}");
//     return flights;
//   }

//   // 🛫 Lấy dữ liệu chuyến bay từ AviationStack API
//   Future<List<FlightModel>> _getAviationStackFlights() async {
//     final String url = "http://api.aviationstack.com/v1/flights?access_key=$aviationStackApiKey";

//     try {
//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         List flights = data['data'];

//         return Future.wait(flights.map((flight) async {
//           String airlineCode = flight['airline']?['iata'] ?? 'VN'; // Lấy mã IATA, nếu null thì mặc định 'VN'
//           String logoUrl = await getAirlineLogo(airlineCode);

//           return FlightModel(
//             airlineName: flight['airline']?['name'] ?? 'Unknown Airline',
//             departure: flight['departure']?['airport'] ?? 'Unknown',
//             destination: flight['arrival']?['airport'] ?? 'Unknown',
//             departureTime: _parseDateTime(flight['departure']?['estimated']),
//             arrivalTime: _parseDateTime(flight['arrival']?['estimated']),
//             seatClass: 'Economy',
//             seatCount: 100,
//             ticketPrice: 1000,
//             flightStatus: flight['flight_status'] ?? 'Unknown',
//             image: logoUrl, // Ảnh từ API AirLabs
//             ticketTypes: [],
//           );
//         }).toList());
//       } else {
//         print("Failed to load flights: ${response.statusCode}");
//         return [];
//       }
//     } catch (e) {
//       print("Error: $e");
//       return [];
//     }
//   }

//   // ✈️ Lấy dữ liệu chuyến bay từ Duffel API
//   Future<List<FlightModel>> _getDuffelFlights() async {
//     final String url = "https://api.duffel.com/air/offer_requests";
//     final Map<String, dynamic> requestBody = {
//   "data": {
//     "slices": [
//       {
//         "origin": "SGN",
//         "destination": "HAN",
//         "departure_date": "2025-04-01"
//       }
//     ],
//     "passengers": [
//       {
//         "id": "pas_0001",
//         "type": "adult"
//       }
//     ],
//     "cabin_class": "economy",
//     "currency": "USD"
//   }
// };

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {
//           "Authorization": "Bearer $duffelApiKey",
//           "Content-Type": "application/json",
//           'Duffel-Version': 'v2',
//           "Accept": "application/json"
//         },
//         body: jsonEncode(requestBody),
//       );
//          print("Duffel Response: ${response.body}");
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         List offers = data['data'] ?? [];

//         return Future.wait(offers.map((offer) async {
//           var firstSegment = offer['slices'][0]['segments'][0];
//           String airlineCode = firstSegment['operating_carrier']['iata_code'] ?? 'VN';
//           String logoUrl = await getAirlineLogo(airlineCode);

//           return FlightModel(
//             airlineName: firstSegment['operating_carrier']['name'] ?? 'Unknown Airline',
//             departure: firstSegment['departure']['airport']['name'] ?? 'Unknown',
//             destination: firstSegment['arrival']['airport']['name'] ?? 'Unknown',
//             departureTime: _parseDateTime(firstSegment['departure']['at']),
//             arrivalTime: _parseDateTime(firstSegment['arrival']['at']),
//             seatClass: offer['cabin_class'] ?? 'Economy',
//             seatCount: 100,
//             ticketPrice: double.parse(offer['total_amount'] ?? '1000'),
//             flightStatus: 'Available',
//             image: logoUrl, // Ảnh từ API AirLabs
//             ticketTypes: [],
//           );
//         }).toList());
//       } else {
//         print("Duffel API failed: ${response.statusCode} - ${response.body}");
//         return [];
//       }
//     } catch (e) {
//       print("Duffel API error: $e");
//       return [];
//     }
//   }

//   // 🔍 Lấy logo hãng bay từ API AirLabs
//   Future<String> getAirlineLogo(String iataCode) async {
//     final String url = "https://airlabs.co/api/v9/airlines?api_key=$airLabsApiKey&code=$iataCode";

//     try {
//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['response'] != null && data['response'].isNotEmpty) {
//           return data['response'][0]['logo'] ?? _defaultLogoUrl();
//         }
//       }
//     } catch (e) {
//       print("Error getting airline logo: $e");
//     }
//     return _defaultLogoUrl(); // Ảnh mặc định nếu không tìm thấy
//   }


//   DateTime _parseDateTime(String? dateTimeStr) {
//     if (dateTimeStr == null) return DateTime.now();
//     return DateTime.tryParse(dateTimeStr) ?? DateTime.now();
//   }

 
//   String _defaultLogoUrl() {
//     return 'https://i.imgur.com/yMbF4Zt.png';
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel_app/Data/model/flight_model.dart';

class FlightService {
  final String aviationStackApiKey = "ca12279298msh52ceb4d4798c703p1459eejsn1548a7cebcc5"; // Replace with your AviationStack API Key

  // Fetch flight data from AviationStack API
  Future<List<FlightModel>> getFlightData() async {
    final String url = "http://api.aviationstack.com/v1/flights?access_key=$aviationStackApiKey";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List flights = data['data'];

        return flights.map((flight) {
          return FlightModel(
            airlineName: flight['airline']?['name'] ?? 'Unknown Airline',
            departure: flight['departure']?['airport'] ?? 'Unknown',
            destination: flight['arrival']?['airport'] ?? 'Unknown',
            departureTime: _parseDateTime(flight['departure']?['estimated']),
            arrivalTime: _parseDateTime(flight['arrival']?['estimated']),
            seatClass: 'Economy',
            seatCount: 100,
            ticketPrice: 1000,
            flightStatus: flight['flight_status'] ?? 'Unknown',
            image: 'default_image_url', // Replace with actual image URL if available
            ticketTypes: [],
          );
        }).toList();
      } else {
        print("Failed to load flights: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  DateTime _parseDateTime(String? dateTimeStr) {
    if (dateTimeStr == null) return DateTime.now();
    return DateTime.tryParse(dateTimeStr) ?? DateTime.now();
  }
}
