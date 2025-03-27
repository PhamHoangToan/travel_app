import 'package:flutter/material.dart';
import 'package:travel_app/helpers/asset_helper.dart';

class ItemGuestAndRoom extends StatelessWidget {
  final String icon;
  final int inniData;
  final String title;
  final Function(int) onChanged; // Callback function to update count

  const ItemGuestAndRoom({
    Key? key,
    required this.icon,
    required this.inniData,
    required this.title,
    required this.onChanged, // Add onChanged parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(icon), // Display the icon
        Text(title), // Display the title
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            if (inniData > 1) {
              onChanged(inniData - 1); // Decrease the count
            }
          },
        ),
        Text('$inniData'), // Display the current count
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            onChanged(inniData + 1); // Increase the count
          },
        ),
      ],
    );
  }
}
