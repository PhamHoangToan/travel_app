import 'package:flutter/material.dart';
import 'package:travel_app/representation/screen/Flights_detail_screen.dart';
import 'package:travel_app/representation/widgets/button_widget.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/Data/model/flight_model.dart';

class ItemFlightWidget extends StatelessWidget {
  final FlightModel flightModel;

  const ItemFlightWidget({
    Key? key,
    required this.flightModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding / 2),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      margin: EdgeInsets.only(right: kDefaultPadding / 2),
      child: Column(
        children: [
          // Display flight image (Fixed)
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(kDefaultPadding / 2),
              bottomRight: Radius.circular(kDefaultPadding / 2),
            ),
            child: Image.network(
              flightModel.image, // Flight image from URL
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Image.network(
                'https://i.imgur.com/yMbF4Zt.png', // Default image if loading fails
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(kDefaultPadding / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display airline name
                Text(
                  flightModel.airlineName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: kDefaultPadding / 2),

                // Display departure location
                Text(
                  'Departure: ${flightModel.departure}',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorPalette.subTitleColor,
                  ),
                ),
                SizedBox(height: kDefaultPadding / 4),

                // Display destination location
                Text(
                  'Destination: ${flightModel.destination}',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorPalette.subTitleColor,
                  ),
                ),
                SizedBox(height: kDefaultPadding / 2),

                // Display available seats
                Text(
                  'Available Seats: ${flightModel.seatCount}',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorPalette.subTitleColor,
                  ),
                ),
                SizedBox(height: kDefaultPadding / 2),

                // Button to book flight
                ButtonWidget(
                  title: 'Book Now',
                  ontap: () {
                    Navigator.of(context).pushNamed(
                      FlightsDetailScreen.routeName,
                      arguments: flightModel,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
