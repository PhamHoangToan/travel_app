import 'package:flutter/material.dart';
import 'package:travel_app/Data/model/flight_model.dart';
import 'package:travel_app/representation/widgets/item_flight_widget.dart';

import 'package:travel_app/services/FlightService.dart'; 

class SelectFlightScreen extends StatefulWidget {
  static const String routeName = '/select_flight_screen';

  final String departure;
  final List<String> destinations;
  final String departureDate;

  const SelectFlightScreen({
    Key? key,
    required this.departure,
    required this.destinations,
    required this.departureDate,
  }) : super(key: key);

  @override
  _SelectFlightScreenState createState() => _SelectFlightScreenState();
}

class _SelectFlightScreenState extends State<SelectFlightScreen> {
  final  FlightService  flightService =  FlightService (); // ✅ Đổi thành AmadeusService
  List<FlightModel> flights = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFlights();
  }

  /// 🔹 **Hàm gọi API để lấy danh sách chuyến bay**
 Future<void> fetchFlights() async {
  try {
    List<FlightModel> fetchedFlights = [];

    for (String destination in widget.destinations) {
      final flightData = await flightService.searchFlights(
        widget.departure, destination, widget.departureDate
      );

      print("🔹 Dữ liệu từ API ($widget.departure ➝ $destination): $flightData");

      if (flightData.isEmpty) {
        print("⚠️ Không có chuyến bay từ ${widget.departure} đến $destination!");
        continue;
      }

      fetchedFlights.addAll(flightData.map((flight) {
        return FlightModel(
            idflight: flight['idflight'] ?? DateTime.now().millisecondsSinceEpoch.toString(), 
          airlineName: flight['validatingAirlineCodes']?[0] ?? 'Unknown Airline',
          departure: flight['itineraries'][0]['segments'][0]['departure']['iataCode'] ?? 'Unknown',
          destination: flight['itineraries'][0]['segments'].last['arrival']['iataCode'] ?? 'Unknown',
          departureTime: DateTime.tryParse(flight['itineraries'][0]['segments'][0]['departure']['at']) ?? DateTime.now(),
          arrivalTime: DateTime.tryParse(flight['itineraries'][0]['segments'].last['arrival']['at']) ?? DateTime.now(),
          seatClass: "Economy",
          seatCount: 100,
          ticketPrice: double.tryParse(flight['price']['total'] ?? "1000.0") ?? 1000.0,
          flightStatus: "Available",
          image: "https://i.imgur.com/JfPrEvm.png",
          ticketTypes: [],
        );
      }));
    }

    print("✅ Tổng số chuyến bay tìm thấy: ${fetchedFlights.length}");

    setState(() {
      flights = fetchedFlights;
      isLoading = false;
    });
  } catch (e) {
    print("❌ Lỗi khi fetch chuyến bay: $e");
    setState(() {
      isLoading = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chọn chuyến bay"),
      backgroundColor: Colors.blue,),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : flights.isEmpty
              ? const Center(child: Text("Không có chuyến bay nào!"))
              : ListView.builder(
                  itemCount: flights.length,
                  itemBuilder: (context, index) {
                    return ItemFlightWidget(flightModel: flights[index]);
                  },
                ),
    );
  }
}
