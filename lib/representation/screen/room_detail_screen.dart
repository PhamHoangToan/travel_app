import 'package:flutter/material.dart';
import 'package:travel_app/Data/model/hotel_model.dart';
import 'package:travel_app/Data/model/room_model.dart';
import 'package:travel_app/representation/screen/hotel_payment_screen.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class RoomDetailScreen extends StatefulWidget {
  final RoomType room;
  final List<DateTime> bookedDates;
  final List<HotelModel> hotels;

  const RoomDetailScreen({
    Key? key,
    required this.room,
    required this.bookedDates,
    required this.hotels,
  }) : super(key: key);

  @override
  _RoomDetailScreenState createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  int _selectedRooms = 1;
  bool _showDatePicker = false; // Ẩn lịch chọn ngày ban đầu

  void _onDateRangeSelected(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      setState(() {
        _startDate = args.value.startDate;
        _endDate = args.value.endDate;
      });
    }
  }

  bool _isDateDisabled(DateTime date) {
    return widget.bookedDates.any((bookedDate) =>
        bookedDate.year == date.year &&
        bookedDate.month == date.month &&
        bookedDate.day == date.day);
  }

  @override
  Widget build(BuildContext context) {
    print("👉 Room idks: ${widget.room.idks}");

  print("👉 Hotels list size: ${widget.hotels.length}");
  for (var hotel in widget.hotels) {
    print("🏨 Hotel - id: '${hotel.id}', name: '${hotel.hotelName}'");
  }

  HotelModel selectedHotel = widget.hotels.firstWhere(
    (hotel) => hotel.id.trim() == widget.room.idks.trim(),
    orElse: () {
      print("❌ Không tìm thấy hotel cho idks: ${widget.room.idks}");
      return HotelModel(
        id: '',
        hotelImage: '',
        hotelName: 'Không tìm thấy',
        location: 'Không xác định',
        describe: 'Chưa có mô tả',
        awayKilometer: '0',
        star: 0,
        numberOfReview: 0,
        price: 0,
      );
    },
  );
    return Scaffold(
      appBar:
          AppBar(title: Text("Chi tiết phòng"), backgroundColor: Colors.blue),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hình ảnh phòng
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.room.hinhAnhPhong,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),

            // Tên phòng
            Text(widget.room.tenLp,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),

            // Giá phòng
            Text("Giá: ${widget.room.gia} VND / đêm",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red)),
            SizedBox(height: 8),

            // Số lượng giường
            Text("Số giường: ${widget.room.soLuongGiuong}",
                style: TextStyle(fontSize: 16)),

            // Máy lạnh
            Text("Máy lạnh: ${widget.room.mayLanh ? "Có" : "Không"}",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),

            // Chọn ngày đặt phòng (Hiện lịch khi nhấn)
            Text("Chọn ngày đặt phòng:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showDatePicker =
                      !_showDatePicker; // Hiển thị hoặc ẩn lịch chọn ngày
                });
              },
              child: Text("Chọn ngày"),
            ),

            // Hiển thị lịch chọn ngày nếu được bật
            if (_showDatePicker)
              Column(
                children: [
                  SizedBox(height: 8),
                  SfDateRangePicker(
                    selectionMode: DateRangePickerSelectionMode.range,
                    onSelectionChanged: _onDateRangeSelected,
                    enablePastDates: false,
                    selectableDayPredicate: (date) => !_isDateDisabled(date),
                  ),
                ],
              ),
            SizedBox(height: 16),

            // Số lượng phòng
            Text("Số lượng phòng:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<int>(
              value: _selectedRooms,
              onChanged: (value) {
                setState(() {
                  _selectedRooms = value!;
                });
              },
              items:
                  List.generate(widget.room.soLuongPhong, (index) => index + 1)
                      .map<DropdownMenuItem<int>>(
                        (value) => DropdownMenuItem<int>(
                            value: value, child: Text(value.toString())),
                      )
                      .toList(),
            ),
            SizedBox(height: 20),

            // Nút đặt phòng
            Center(
              child: ElevatedButton(
                onPressed: (_startDate != null && _endDate != null)
                    ? () {
                        if (selectedHotel.id == "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    "Không tìm thấy khách sạn để đặt phòng")),
                          );
                          return;
                        }

                        print('Gửi hotelId: ${selectedHotel.id}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HotelPaymentScreen(
                              room: widget.room,
                              hotel: selectedHotel,
                              startDate: _startDate!,
                              endDate: _endDate!,
                              numberOfRooms: _selectedRooms,
                            ),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Đặt phòng ngay",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
