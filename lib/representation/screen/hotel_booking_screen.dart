import 'package:flutter/material.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/core/extension/date_ext.dart';
import 'package:travel_app/helpers/asset_helper.dart';
import 'package:travel_app/representation/screen/select_destination_screen.dart';
import 'package:travel_app/representation/screen/select_date_screen.dart';
import 'package:travel_app/representation/screen/guest_and_room_booking.dart';
import 'package:travel_app/representation/screen/hotel_screen.dart';
import 'package:travel_app/representation/widgets/button_widget.dart';
import 'package:travel_app/representation/widgets/item_booking_widget.dart';

class HotelBookingScreen extends StatefulWidget {
  const HotelBookingScreen({Key? key}) : super(key: key);

  static const String routeName = '/hotel_booking_screen';

  @override
  State<HotelBookingScreen> createState() => _HotelBookingScreenState();
}

class _HotelBookingScreenState extends State<HotelBookingScreen> {
  String? selectedDestination;
  String? dateSelected;
  String guestAndRoomDescription = '2 Guest, 1 Room';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotel Booking'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: kMediumPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemBookingWidget(
              icon: AssetHelper.icoLocation,
              title: 'Destination',
              description: selectedDestination ?? 'Select your destination',
              onTap: () async {
                final result = await Navigator.of(context).pushNamed(SelectDestinationScreen.routeName);
                if (result is String) {
                  setState(() {
                    selectedDestination = result;
                  });
                }
              },
            ),
            SizedBox(height: kMediumPadding * 2),
            ItemBookingWidget(
              icon: AssetHelper.icoCalendar,
              title: 'Select Date',
              description: dateSelected ?? 'Select your travel dates',
              onTap: () async {
                final result = await Navigator.of(context).pushNamed(SelectDateScreen.routeName);
                if (result is List<DateTime?> && result.length == 2 && result[0] != null && result[1] != null) {
                  setState(() {
                    dateSelected = '${result[0]!.getStartDate} - ${result[1]!.getEndDate}';
                  });
                }
              },
            ),
            SizedBox(height: kMediumPadding * 2),
            ItemBookingWidget(
              icon: AssetHelper.icoBed,
              title: 'Guest and Room',
              description: guestAndRoomDescription,
              onTap: () async {
                final result = await Navigator.of(context).pushNamed(GuestAndRoomBookingScreen.routeName);
                if (result is List<int> && result.length == 2) {
                  setState(() {
                    guestAndRoomDescription = '${result[0]} Guest, ${result[1]} Room';
                  });
                }
              },
            ),
            SizedBox(height: kMediumPadding * 2),
            ButtonWidget(
              title: 'Search',
              ontap: () {
                if (selectedDestination == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select a destination.')),
                  );
                  return;
                }
                Navigator.of(context).pushNamed(
                  HotelScreen.routeName,
                  arguments: {
                    'destination': selectedDestination,
                    'date': dateSelected,
                    'guestAndRoom': guestAndRoomDescription,
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
