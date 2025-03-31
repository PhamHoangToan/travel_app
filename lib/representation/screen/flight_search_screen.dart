import 'package:flutter/material.dart';
import 'package:travel_app/representation/screen/select_flight_screen.dart';


class FlightSearchScreen extends StatefulWidget {
  static const String routeName = '/Flight_Screen';
  @override
  _FlightSearchScreenState createState() => _FlightSearchScreenState();
}

class _FlightSearchScreenState extends State<FlightSearchScreen> {
  String departureLocation = "SGN"; // Mặc định là TP.HCM
  List<String> arrivalLocations = [];
  TextEditingController departureDateController = TextEditingController();

  void _addArrivalLocation(String location) {
    setState(() {
      if (!arrivalLocations.contains(location)) {
        arrivalLocations.add(location);
      }
    });
  }

  void _searchFlights() {
    if (arrivalLocations.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectFlightScreen(
            departure: departureLocation,
            destinations: arrivalLocations,
            departureDate: departureDateController.text,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vui lòng chọn ít nhất một điểm đến")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tìm kiếm chuyến bay"),
      backgroundColor: Colors.blue,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: TextEditingController(text: departureLocation),
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'From',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Select Arrival Location'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text('Tokyo'),
                          onTap: () {
                            _addArrivalLocation('NRT'); // Mã sân bay Tokyo
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text('London'),
                          onTap: () {
                            _addArrivalLocation('LHR'); // Mã sân bay London
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
              readOnly: true,
              controller: TextEditingController(
                  text: arrivalLocations.isNotEmpty
                      ? arrivalLocations.join(", ")
                      : 'Select Arrival Locations'),
              decoration: InputDecoration(
                labelText: 'To',
                suffixIcon: Icon(Icons.flight_land),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: departureDateController,
              decoration: InputDecoration(
                labelText: 'Departure Date',
                border: OutlineInputBorder(),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2026),
                );
                if (pickedDate != null) {
                  setState(() {
                    departureDateController.text =
                        pickedDate.toIso8601String().split('T')[0];
                  });
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _searchFlights,
              child: Text("Search Flights"),
            ),
          ],
        ),
      ),
    );
  }
}
