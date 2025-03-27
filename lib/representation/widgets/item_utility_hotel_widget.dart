import 'package:flutter/material.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/helpers/asset_helper.dart';
import 'package:travel_app/helpers/image_helper.dart';

class ItemUtilityHotelWidget extends StatelessWidget {
  ItemUtilityHotelWidget({Key? key}) : super(key: key);

  final List<Map<String, String>> listUtility = [
    {
      'icon': AssetHelper.icoWifi,
      'name': 'Free\nWifi',
    },
    {
      'icon': AssetHelper.icoRefund,
      'name': 'Non-\nRefundable',
    },
    {
      'icon': AssetHelper.icoBreakFast,
      'name': 'Free\nBreakfast',
    },
    {
      'icon': AssetHelper.icoNoSmoke,
      'name': 'Non\nSmoking',
    },
  ];

  Widget _buildItemUtilityHotel(String icon, String title, double iconSize, double fontSize) {
    return Column(
      children: [
        ImageHelper.loadFromAsset(
          icon,
          width: iconSize,
          height: iconSize,
        ),
        SizedBox(
          height: kMinPadding,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: fontSize),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final iconSize = size.width * 0.12;
    final fontSize = size.width * 0.03;

    return Padding(
      padding: EdgeInsets.only(
        top: kDefaultPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: listUtility
            .map((e) => _buildItemUtilityHotel(e['icon']!, e['name']!, iconSize, fontSize))
            .toList(),
      ),
    );
  }
}
