import 'package:flutter/material.dart';
import 'package:travel_app/Data/model/hotel_model.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/helpers/image_helper.dart';
import 'package:travel_app/Data/model/room_model.dart'; // Import model
import 'package:travel_app/representation/screen/room_detail_screen.dart'; // Import detail screen

class ItemRoomBookingWidget extends StatelessWidget {
  const ItemRoomBookingWidget({
    Key? key,
    required this.room,
    required this.bookedDates,
    required this.hotels,
  }) : super(key: key);

  final RoomType room;
  final List<DateTime> bookedDates;
   final List<HotelModel> hotels;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(kItemPadding),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      room.tenLp,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: kMinPadding),
                    Text('Beds: ${room.soLuongGiuong}'),
                    Text('Available: ${room.soLuongPhong}'),
                    SizedBox(height: kMinPadding),
                    Row(
                      children: [
                        Icon(room.mayLanh ? Icons.ac_unit : Icons.wb_sunny, size: 20),
                        SizedBox(width: kMinPadding),
                        Text(room.mayLanh ? 'Air Conditioning' : 'No AC'),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: kDefaultPadding),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(kMinPadding)),
                child: Image.network(
                  room.hinhAnhPhong,
                  width: 120,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: 100),
                ),
              ),
            ],
          ),
          SizedBox(height: kDefaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price: \$${room.gia.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RoomDetailScreen(room: room,
                      bookedDates:bookedDates,
                      hotels: hotels,),
                    ),
                  );
                },
                child: Text('Choose'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
