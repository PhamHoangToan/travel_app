import 'package:flutter/material.dart';
import 'package:travel_app/Data/model/flight_model.dart';
import 'package:travel_app/helpers/asset_helper.dart';
import 'package:travel_app/representation/widgets/Item_flight_widget.dart';
import 'package:travel_app/representation/widgets/app_bar_container.dart';
import 'package:travel_app/services/FlightService.dart';class SelectFlightScreen extends StatefulWidget {
  SelectFlightScreen({Key? key}) : super(key: key);
  
  static const String routeName = '/select_flight_screen';

  @override
  State<SelectFlightScreen> createState() => _SelectFlightScreenState();
}

class _SelectFlightScreenState extends State<SelectFlightScreen> {
  final FlightService flightService = FlightService();
  List<FlightModel> flights = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFlights();
  }

  Future<void> fetchFlights() async {
    final fetchedFlights = await flightService.getFlightData();
    setState(() {
      flights = fetchedFlights;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBarContainerWidget(
      titleString: 'Flights', 
      child: isLoading
          ? Center(child: CircularProgressIndicator()) // Hiển thị vòng quay khi tải dữ liệu
          : flights.isEmpty
              ? Center(child: Text("No flights available"))
              : SingleChildScrollView(
                  child: Column(
                    children: flights.map((flight) {
                      return Column(
                        children: [
                          ItemFlightWidget(flightModel: flight),
                          SizedBox(height: 16),
                        ],
                      );
                    }).toList(),
                  ),
                ),
    );
  }
}
