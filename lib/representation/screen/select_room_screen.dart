import 'package:flutter/material.dart';
import 'package:travel_app/Data/model/room_model.dart';
import 'package:travel_app/Data/model/hotel_model.dart';
import 'package:travel_app/representation/widgets/item_room_booking_widget.dart';
import 'package:travel_app/services/HotelService.dart';
import 'package:travel_app/services/fetchRoomsByHotel.dart';


class SelectRoomScreen extends StatefulWidget {
  static const String routeName = '/select_room_screen';
  final String hotelId;

  const SelectRoomScreen({Key? key, required this.hotelId}) : super(key: key);

  @override
  _SelectRoomScreenState createState() => _SelectRoomScreenState();
}

class _SelectRoomScreenState extends State<SelectRoomScreen> {
  late Future<List<RoomType>> _roomsFuture;
  late Future<HotelModel> _hotelFuture;
  late Future<List<DateTime>> _bookedDatesFuture;

  @override
  void initState() {
    super.initState();
    _roomsFuture = fetchRoomsByHotel(widget.hotelId);
    _hotelFuture = fetchHotelById(widget.hotelId);
    _bookedDatesFuture = fetchBookedDates(widget.hotelId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Available Rooms")),
      body: FutureBuilder<List<RoomType>>(
        future: _roomsFuture,
        builder: (context, roomsSnapshot) {
          if (roomsSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (roomsSnapshot.hasError) {
            return Center(child: Text("Error loading rooms"));
          } else if (!roomsSnapshot.hasData || roomsSnapshot.data!.isEmpty) {
            return Center(child: Text("No rooms available"));
          }

          final rooms = roomsSnapshot.data!;

          return FutureBuilder<HotelModel>(
            future: _hotelFuture,
            builder: (context, hotelSnapshot) {
              if (hotelSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (hotelSnapshot.hasError) {
                return Center(child: Text("Error loading hotel info"));
              }

              final hotel = hotelSnapshot.data!;

              return FutureBuilder<List<DateTime>>(
                future: _bookedDatesFuture,
                builder: (context, bookedDatesSnapshot) {
                  if (bookedDatesSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (bookedDatesSnapshot.hasError) {
                    return Center(child: Text("Error loading booked dates"));
                  }

                  final bookedDates = bookedDatesSnapshot.data!;

                  return ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: rooms.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ItemRoomBookingWidget(
                          room: rooms[index],
                          bookedDates: bookedDates,
                          hotels: [hotel], // Hoặc truyền list hotels nếu có nhiều khách sạn
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
