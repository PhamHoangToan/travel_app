import 'package:flutter/material.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/helpers/asset_helper.dart';
import 'package:travel_app/helpers/image_helper.dart';

class ItemGuestAndRoom extends StatefulWidget {
  const ItemGuestAndRoom({
    Key? key,
    required this.title,
    required this.icon,
    required this.inniData,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final String icon;
  final int inniData;
  final Function(int value) onChanged;

  @override
  State<ItemGuestAndRoom> createState() => _ItemGuestAndRoomState();
}

class _ItemGuestAndRoomState extends State<ItemGuestAndRoom> {
  late TextEditingController _textEditingController;
  late int number;

  @override
  void initState() {
    super.initState();
    number = widget.inniData;
    _textEditingController = TextEditingController(text: number.toString());
  }

  void _updateNumber(int newValue) {
    if (newValue > 0) {
      setState(() {
        number = newValue;
        _textEditingController.text = number.toString();
        widget.onChanged(number); // Notify parent widget
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kTopPadding),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(bottom: kMediumPadding),
      padding: EdgeInsets.all(kMediumPadding),
      child: Row(
        children: [
          ImageHelper.loadFromAsset(widget.icon, width: 40, height: 40),
          SizedBox(width: kDefaultPadding),
          Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18),
          ),
          Spacer(),
          GestureDetector(
            onTap: () => _updateNumber(number - 1),
            child: ImageHelper.loadFromAsset(AssetHelper.icoMinus, width: 35, height: 35),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: 80,
            child: TextField(
              controller: _textEditingController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
              onChanged: (value) {
                final parsed = int.tryParse(value);
                if (parsed != null) {
                  _updateNumber(parsed);
                }
              },
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () => _updateNumber(number + 1),
            child: ImageHelper.loadFromAsset(AssetHelper.icoAdd, width: 35, height: 35),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
