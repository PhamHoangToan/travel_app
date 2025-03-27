import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/helpers/asset_helper.dart';
import 'package:travel_app/helpers/image_helper.dart';
import 'package:travel_app/representation/screen/select_flight_screen.dart';
import 'package:travel_app/representation/widgets/app_bar_container.dart';

class FlightSearchScreen extends StatefulWidget {
  const FlightSearchScreen({Key? key}) : super(key: key);
  static const String routeName = '/Flight_Screen';

  @override
  State<FlightSearchScreen> createState() => _FlightSearchScreenState();
}

class _FlightSearchScreenState extends State<FlightSearchScreen> {
  String? departureLocation;
  String? arrivalLocation;
  DateTime? departureDate;
  DateTime? returnDate;
  int adults = 1;
  int children = 0;
  int infants = 0;
  String seatClass = 'Economy';
  bool isRoundTrip = false;

  int economySeats = 0;
  int businessSeats = 0;
  int firstClassSeats = 0;

  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime(2101);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isDeparture
          ? (departureDate ?? initialDate)
          : (returnDate ?? initialDate),
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      setState(() {
        if (isDeparture) {
          departureDate = pickedDate;
        } else {
          returnDate = pickedDate;
        }
      });
    }
  }

  Widget _buildPassengerSelection(
      String label, int count, ValueChanged<int> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 14)),
        Row(
          children: [
            IconButton(
              icon: _resizeImage(AssetHelper.icoMinus),
              onPressed: count > 0
                  ? () {
                      onChanged(count - 1);
                    }
                  : null,
            ),
            Text('$count', style: TextStyle(fontSize: 14)),
            IconButton(
              icon: _resizeImage(AssetHelper.icoAdd),
              onPressed: () {
                onChanged(count + 1);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSeatClassSelection(
      String label, int seatCount, ValueChanged<int> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 14)),
        Row(
          children: [
            IconButton(
              icon: _resizeImage(AssetHelper.icoMinus),
              onPressed: seatCount > 0
                  ? () {
                      onChanged(seatCount - 1);
                    }
                  : null,
            ),
            Text('$seatCount', style: TextStyle(fontSize: 14)),
            IconButton(
              icon: _resizeImage(AssetHelper.icoAdd),
              onPressed: () {
                onChanged(seatCount + 1);
              },
            ),
          ],
        ),
      ],
    );
  }

  // Function to resize images dynamically
  Widget _resizeImage(String assetName) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize =
        screenWidth < 350 ? 24 : 30; // Adjust the size based on screen width
    return ImageHelper.loadFromAsset(
      assetName,
      width: iconSize,
      height: iconSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBarContainerWidget(
        implementLeading: true,
        titleString: 'Flight Search',
        child: Container(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: Text('One-way',
                      style: TextStyle(fontSize: screenWidth < 350 ? 12 : 14)),
                  selected: !isRoundTrip,
                  onSelected: (selected) {
                    setState(() {
                      isRoundTrip = false;
                    });
                  },
                ),
                SizedBox(width: 10),
                ChoiceChip(
                  label: Text('Round trip',
                      style: TextStyle(fontSize: screenWidth < 350 ? 12 : 14)),
                  selected: isRoundTrip,
                  onSelected: (selected) {
                    setState(() {
                      isRoundTrip = true;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Select Departure Location'),
                    content: Column(
                      children: [
                        ListTile(
                          title: Text('Paris'),
                          onTap: () {
                            setState(() {
                              departureLocation = 'Paris';
                            });
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text('New York'),
                          onTap: () {
                            setState(() {
                              departureLocation = 'New York';
                            });
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
                  text: departureLocation ?? 'Select Departure Location'),
              decoration: InputDecoration(
                labelText: 'From',
                suffixIcon: _resizeImage(AssetHelper.icoNavigator),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Select Arrival Location'),
                    content: Column(
                      children: [
                        ListTile(
                          title: Text('Tokyo'),
                          onTap: () {
                            setState(() {
                              arrivalLocation = 'Tokyo';
                            });
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text('London'),
                          onTap: () {
                            setState(() {
                              arrivalLocation = 'London';
                            });
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
                  text: arrivalLocation ?? 'Select Arrival Location'),
              decoration: InputDecoration(
                labelText: 'To',
                suffixIcon: _resizeImage(AssetHelper.icoNavigator),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () => _selectDate(context, true),
              child: AbsorbPointer(
                child: TextField(
                  controller: TextEditingController(
                      text: departureDate != null
                          ? dateFormat.format(departureDate!)
                          : 'Select Departure Date'),
                  decoration: InputDecoration(
                    labelText: 'Departure Date',
                    suffixIcon: _resizeImage(AssetHelper.icoCalendar),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            if (isRoundTrip) ...[
              GestureDetector(
                onTap: () => _selectDate(context, false),
                child: AbsorbPointer(
                  child: TextField(
                    controller: TextEditingController(
                        text: returnDate != null
                            ? dateFormat.format(returnDate!)
                            : 'Select Return Date'),
                    decoration: InputDecoration(
                      labelText: 'Return Date',
                      suffixIcon: _resizeImage(AssetHelper.icoCalendar),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
            // Display Passengers with selected count
            ExpansionTile(
              title: Text(
                  'Passengers: Adults ($adults), Children ($children), Infants ($infants)',
                  style: TextStyle(fontSize: 14)),
              leading: _resizeImage(AssetHelper.icoUser),
              children: [
                _buildPassengerSelection('Adults', adults, (value) {
                  setState(() {
                    adults = value;
                  });
                }),
                _buildPassengerSelection('Children', children, (value) {
                  setState(() {
                    children = value;
                  });
                }),
                _buildPassengerSelection('Infants', infants, (value) {
                  setState(() {
                    infants = value;
                  });
                }),
              ],
            ),
            SizedBox(height: 16),
            // Display Seat Classes with selected count
            ExpansionTile(
              title: Text(
                  'Seat Class: Economy ($economySeats), Business ($businessSeats), First Class ($firstClassSeats)',
                  style: TextStyle(fontSize: 14)),
              leading: _resizeImage(AssetHelper.icoSeat),
              children: [
                _buildSeatClassSelection('Economy', economySeats, (value) {
                  setState(() {
                    economySeats = value;
                  });
                }),
                _buildSeatClassSelection('Business', businessSeats, (value) {
                  setState(() {
                    businessSeats = value;
                  });
                }),
                _buildSeatClassSelection('First Class', firstClassSeats,
                    (value) {
                  setState(() {
                    firstClassSeats = value;
                  });
                }),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('Search Flights', style: TextStyle(fontSize: 14)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 120, vertical: 12),
                textStyle: TextStyle(fontSize: 14),
              ),
              onPressed: () {
                // You need to use 'onPressed' instead of 'ontap'
                Navigator.of(context).pushNamed(SelectFlightScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
