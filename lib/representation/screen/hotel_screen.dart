import 'package:flutter/material.dart';
import 'package:travel_app/Data/model/hotel_model.dart';
import 'package:travel_app/representation/widgets/app_bar_container.dart';
import 'package:travel_app/representation/widgets/Item_hotel_widget.dart';
import 'package:travel_app/services/HotelService.dart';

class HotelScreen extends StatefulWidget {
  HotelScreen({Key? key}) : super(key: key);
  static const String routeName = '/hotel_screen';

  @override
  _HotelScreenState createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  late Future<List<HotelModel>> hotels;
  late String selectedDestination;
  late String selectedDate;
  late String guestAndRoomDescription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Lấy thông tin từ arguments
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    selectedDestination = args['destination'] ?? '';
    selectedDate = args['date'] ?? '';
    guestAndRoomDescription = args['guestAndRoom'] ?? '';

    hotels = HotelService.fetchHotels();
  }

  @override
  Widget build(BuildContext context) {
    return AppBarContainerWidget(
      titleString: 'Hotels',
      child: FutureBuilder<List<HotelModel>>(
        future: hotels,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hotels available.'));
          } else {
            List<HotelModel> listHotel = snapshot.data!;

            // Lọc khách sạn theo destination, date và guestAndRoomDescription
            listHotel = listHotel.where((hotel) {
              bool matchesDestination = hotel.location == selectedDestination;
              // Thêm điều kiện lọc ngày và số lượng khách
              return matchesDestination;
            }).toList();

            return SingleChildScrollView(
              child: Column(
                children: listHotel.map((hotel) {
                  return Column(
                    children: [
                      ItemHotelWidget(hotelModel: hotel),
                      SizedBox(height: 16),
                    ],
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
