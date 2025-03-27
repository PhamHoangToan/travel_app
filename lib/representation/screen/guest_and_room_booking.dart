import 'package:flutter/material.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/helpers/asset_helper.dart';
import 'package:travel_app/representation/widgets/app_bar_container.dart';
import 'package:travel_app/representation/widgets/button_widget.dart';
import 'package:travel_app/representation/widgets/item_Guest_And_Room.dart';

class GuestAndRoomBookingScreen extends StatefulWidget {
  const GuestAndRoomBookingScreen({Key? key}) : super(key: key);
  static const String routeName = '/guest_and_room_booking';

  @override
  State<GuestAndRoomBookingScreen> createState() => _GuestAndRoomBookingScreen();
}

class _GuestAndRoomBookingScreen extends State<GuestAndRoomBookingScreen> {
  int guestCount = 2;
  int roomCount = 1;

  @override
  Widget build(BuildContext context) {
    return AppBarContainerWidget(
      titleString: 'Add Guest And Room',
      child: Column(
        children: [
          SizedBox(height: kMediumPadding * 1.5),
          // Guest Item
          ItemGuestAndRoom(
            icon: AssetHelper.icoGuest,
            inniData: guestCount,
            title: 'Guest',
            onChanged: (int value) {
              setState(() {
                guestCount = value; // Update guest count
              });
            },
          ),
          SizedBox(height: kMediumPadding), // Space between items
          // Room Item
          ItemGuestAndRoom(
            icon: AssetHelper.icoRoom,
            inniData: roomCount,
            title: 'Room',
            onChanged: (int value) {
              setState(() {
                roomCount = value; // Update room count
              });
            },
          ),
          ButtonWidget(
            title: 'Select',
            ontap: () {
              Navigator.of(context).pop([guestCount, roomCount]); // Pass values back
            },
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          ButtonWidget(
            title: 'Cancel',
            ontap: () {
              Navigator.of(context).pop(); // Close without returning values
            },
          ),
        ],
      ),
    );
  }
}
