import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/Data/model/Invoice_model.dart';
import 'package:travel_app/Data/model/bookingDetails_model.dart';
import 'package:travel_app/Data/model/flight_model.dart';
import 'package:travel_app/Data/model/passenger_model.dart';
import 'package:travel_app/Data/model/ticketType_model.dart';
import 'package:travel_app/Data/provider/flight_data_provider.dart';
import 'package:travel_app/helpers/asset_helper.dart';
import 'package:travel_app/representation/screen/CustomerInformation_Flight_Screen.dart';

class FlightsDetailScreen extends StatefulWidget {
  const FlightsDetailScreen({Key? key, required this.flightModel})
      : super(key: key);
  static const String routeName = '/Flights_detail_screen';

  final FlightModel flightModel;

  @override
  State<FlightsDetailScreen> createState() => _FlightsDetailScreenState();
}

class _FlightsDetailScreenState extends State<FlightsDetailScreen> {
  String selectedTicketType = 'Original';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.blue.shade50,
            ),
          ),
          Positioned(
            top: size.height * 0.05,
            left: size.width * 0.05,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.all(size.width * 0.03),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(size.width * 0.05),
                ),
                child: Icon(
                  FontAwesomeIcons.arrowLeft,
                  size: size.width * 0.05,
                ),
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            maxChildSize: 0.9,
            minChildSize: 0.4,
            builder: (context, scrollController) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size.width * 0.1),
                    topRight: Radius.circular(size.width * 0.1),
                  ),
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    SizedBox(height: size.height * 0.02),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: size.height * 0.02),
                      child: Container(
                        height: size.height * 0.005,
                        width: size.width * 0.15,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.02),
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                    // Trip Details
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.flightModel.departure,
                          style: TextStyle(
                              fontSize: size.width * 0.045,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.arrow_forward, size: size.width * 0.05),
                        Text(
                          widget.flightModel.destination,
                          style: TextStyle(
                              fontSize: size.width * 0.045,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.flightModel.departureTime.day} ${widget.flightModel.departureTime.month} ${widget.flightModel.departureTime.year}',
                          style: TextStyle(fontSize: size.width * 0.04),
                        ),
                        Text(
                          '${widget.flightModel.arrivalTime.difference(widget.flightModel.departureTime).inMinutes ~/ 60}h ${widget.flightModel.arrivalTime.difference(widget.flightModel.departureTime).inMinutes % 60}m · Direct',
                          style: TextStyle(fontSize: size.width * 0.04),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey.shade400,
                      height: size.height * 0.04,
                      thickness: 1,
                    ),
                    // Ticket Options
                    Text(
                      'Select Your Ticket Type',
                      style: TextStyle(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.02),
                    // Ticket Type List
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.flightModel.ticketTypes.length,
                      itemBuilder: (context, index) {
                        final ticketType =
                            widget.flightModel.ticketTypes[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: size.height * 0.02),
                          padding: EdgeInsets.all(size.width * 0.04),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(size.width * 0.05),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ticketType.name,
                                style: TextStyle(
                                    fontSize: size.width * 0.045,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: size.height * 0.01),
                              Text(
                                ticketType.description,
                                style: TextStyle(fontSize: size.width * 0.04),
                              ),
                              SizedBox(height: size.height * 0.02),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${ticketType.pricePerPerson} VND / person',
                                    style: TextStyle(
                                        fontSize: size.width * 0.045,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Setting the flight data using Provider
                                      Provider.of<FlightDataProvider>(context,
                                              listen: false)
                                          .setFlightData(
                                        FlightModel(
                                          airlineName: 'Vietnam Airlines',
                                          departure: 'Ho Chi Minh City',
                                          destination: 'Hanoi',
                                          departureTime: DateTime.now(),
                                          arrivalTime: DateTime.now()
                                              .add(Duration(hours: 2)),
                                          seatClass: 'Economy',
                                          seatCount: 150,
                                          ticketPrice: 1000,
                                          flightStatus: 'On Time',
                                          image: AssetHelper.flight1,
                                          ticketTypes: [
                                            TicketType(
                                              name: 'Economy Class',
                                              description:
                                                  'Basic seat with limited benefits',
                                              pricePerPerson: 1000,
                                              handLuggageKg: 7,
                                              checkedLuggageKg: 20,
                                              details:
                                                  'Standard economy class seat with free meals.',
                                            ),
                                            TicketType(
                                              name: 'Business Class',
                                              description:
                                                  'More space and extra services',
                                              pricePerPerson: 2500,
                                              handLuggageKg: 10,
                                              checkedLuggageKg: 30,
                                              details:
                                                  'Business class seat with additional perks like access to lounge.',
                                            ),
                                          ],
                                        ),
                                        BookingDetails(
                                          id: 'BK001',
                                          passengers: [
                                            KhachHangModel(
                                              id: 'P001',
                                              name: 'Nguyen Van A',
                                              email: 'test@gmail.com',
                                              cccd: '-025825822', 
                                              ngaySinh:DateTime(2000),
                                              password: '12345'
                                            ),
                                            KhachHangModel(
                                              id: 'P002',
                                              name: 'Tran Thi B',
                                              email: 'test@gmail.com',
                                              password: '12344', 
                                              cccd: '-025825822', 
                                              ngaySinh:DateTime(2000)
                                            ),
                                          ],
                                          flightModel: FlightModel(
                                            airlineName: 'Vietnam Airlines',
                                            departure: 'Ho Chi Minh City',
                                            destination: 'Hanoi',
                                            departureTime:
                                                DateTime(2024, 12, 10, 14, 30),
                                            arrivalTime:
                                                DateTime(2024, 12, 10, 16, 30),
                                            seatClass: 'Economy',
                                            seatCount: 150,
                                            ticketPrice: 1200.0,
                                            flightStatus: 'On Time',
                                            image: 'assets/images/flight1.png',
                                            ticketTypes: [
                                              TicketType(
                                                name: 'Economy Class',
                                                description:
                                                    'Basic seat with limited benefits',
                                                pricePerPerson: 1200.0,
                                                handLuggageKg: 7,
                                                checkedLuggageKg: 20,
                                                details:
                                                    'Standard economy class seat with free meals.',
                                              ),
                                            ],
                                          ),
                                          invoice: Invoice(
                                            isRequested: true,
                                            details:
                                                "Flight upgrade request: Business Class, additional baggage requested.",
                                          ),
                                          totalPrice: 2400.0,
                                        ),
                                      );

                                      // Navigating to CustomerInformationScreen
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CustomerinformationFlightScreen(
                                            bookingDetails:
                                                Provider.of<FlightDataProvider>(
                                                        context,
                                                        listen: false)
                                                    .bookingDetails!,
                                          ),
                                        ),
                                      );

                                      // Updating the selected ticket type
                                      setState(() {
                                        selectedTicketType =
                                            'Economy Class'; // Replace this with actual logic for selected ticket type
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: selectedTicketType ==
                                              'Economy Class' // Replace this with your actual condition
                                          ? Colors.blue
                                          : Colors.grey.shade300,
                                    ),
                                    child: Text('Choose'),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
