import 'package:flutter/material.dart';
import 'package:travel_app/Data/model/hotel_model.dart';
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
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    selectedDestination = args['destination'] ?? '';
    selectedDate = args['date'] ?? '';
    guestAndRoomDescription = args['guestAndRoom'] ?? '';

    hotels = HotelService.fetchHotels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotels'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 16.0), // Thêm khoảng cách giữa AppBar và nội dung
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

              listHotel = listHotel.where((hotel) {
                bool matchesDestination = hotel.location == selectedDestination;
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
      ),
    );
  }
}