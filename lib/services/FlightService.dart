// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class AmadeusService {
//   final String clientId = "u7IJu1aamWaShkbeg7jV5IvlJlNZJ8wy";
//   final String clientSecret = "b7R0Vn6jteeJYLuC";
//   String? accessToken;

//   Future<void> _getAccessToken() async {
//     final response = await http.post(
//       Uri.parse("https://test.api.amadeus.com/v1/security/oauth2/token"),
//       headers: {"Content-Type": "application/x-www-form-urlencoded"},
//       body: "grant_type=client_credentials&client_id=$clientId&client_secret=$clientSecret",
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       accessToken = data["access_token"];
//     } else {
//       throw Exception("Failed to obtain access token");
//     }
//   }

//   Future<List<dynamic>> getFlights(String origin, String destination, String departureDate) async {
//     if (accessToken == null) {
//       await _getAccessToken();
//     }

//     final url = Uri.parse(
//         "https://test.api.amadeus.com/v2/shopping/flight-offers?originLocationCode=$origin&destinationLocationCode=$destination&departureDate=$departureDate&adults=1&currencyCode=USD");

//     final response = await http.get(url, headers: {
//       "Authorization": "Bearer $accessToken",
//     });

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data["data"];
//     } else {
//       print("Error fetching flights: ${response.body}");
//       return [];
//     }
//   }
//    Future<List<dynamic>> getFlightsMultipleDestinations(String origin, List<String> destinations, String departureDate) async {
//     List<dynamic> allFlights = [];

//     for (String destination in destinations) {
//       final flights = await getFlights(origin, destination, departureDate);
//       allFlights.addAll(flights);
//     }

//     return allFlights;
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
class FlightService {
  final String clientId = "u7IJu1aamWaShkbeg7jV5IvlJlNZJ8wy";
    final String clientSecret = "b7R0Vn6jteeJYLuC";
  final String baseUrl = "https://test.api.amadeus.com";
  String? accessToken; // Lưu access token tạm thời

  /// 🔹 **Lấy access token từ Amadeus API**
  Future<void> fetchAccessToken() async {
    final url = Uri.parse("$baseUrl/v1/security/oauth2/token");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: "grant_type=client_credentials&client_id=$clientId&client_secret=$clientSecret",
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      accessToken = data["access_token"];
      print("✅ Access Token mới: $accessToken");
    } else {
      throw Exception("❌ Lỗi khi lấy Access Token: ${response.body}");
    }
  }

  /// 🔹 **Gọi API tìm chuyến bay**
  Future<List<dynamic>> searchFlights(String origin, String destination, String date) async {
    if (accessToken == null) {
      await fetchAccessToken(); // Lấy token nếu chưa có
    }

    final url = Uri.parse("$baseUrl/v2/shopping/flight-offers?"
        "originLocationCode=$origin&destinationLocationCode=$destination&departureDate=$date&adults=1");

    final response = await http.get(
      url,
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["data"] ?? [];
    } else {
      print("❌ Lỗi khi fetch chuyến bay: ${response.body}");
      throw Exception("Failed to fetch flights: ${response.body}");
    }
  }
}


// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class AviationStackService {
//   final String apiKey = "d54a3bb7c7fa41f48b05bf97c4023e5d";
//   final String baseUrl = "http://api.aviationstack.com/v1";

//   Future<List<dynamic>> searchFlights(String origin, String destination, String date) async {
//     final url = Uri.parse("$baseUrl/flights?access_key=$apiKey&dep_iata=$origin&arr_iata=$destination&flight_date=$date");
    
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data["data"] ?? [];
//     } else {
//       throw Exception("Failed to fetch flights: ${response.body}");
//     }
//   }

//   Future<Map<String, dynamic>?> trackFlight(String flightIata) async {
//     final url = Uri.parse("$baseUrl/flights?access_key=$apiKey&flight_iata=$flightIata");
    
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data["data"]?.isNotEmpty == true ? data["data"][0] : null;
//     } else {
//       throw Exception("Failed to track flight: ${response.body}");
//     }
//   }

//   Future<List<dynamic>> getRealTimeFlights(String airlineIata) async {
//     final url = Uri.parse("$baseUrl/flights?access_key=$apiKey&airline_iata=$airlineIata&flight_status=active");
    
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data["data"] ?? [];
//     } else {
//       throw Exception("Failed to fetch real-time flights: ${response.body}");
//     }
//   }
// }
