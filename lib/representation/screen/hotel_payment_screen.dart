import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart'; // <-- Thêm dòng này
import 'package:travel_app/Data/model/hotel_model.dart';
import 'package:travel_app/Data/model/room_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:travel_app/config.dart';

class HotelPaymentScreen extends StatefulWidget {
  final RoomType room;
  final DateTime startDate;
  final DateTime endDate;
  final int numberOfRooms;
  final HotelModel hotel;

  const HotelPaymentScreen({
    Key? key,
    required this.room,
    required this.hotel,
    required this.startDate,
    required this.endDate,
    required this.numberOfRooms,
  }) : super(key: key);

  @override
  _HotelPaymentScreenState createState() => _HotelPaymentScreenState();
}

class _HotelPaymentScreenState extends State<HotelPaymentScreen> {
  String selectedPaymentMethod = "credit_card";
  bool isLoading = false;
  String? userId; // <-- Thêm biến userId

  @override
  void initState() {
    super.initState();
    _loadUserId(); // <-- Gọi hàm lấy userId khi màn hình khởi tạo
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });

    if (userId == null) {
      // Nếu không tìm thấy userId thì báo lỗi hoặc điều hướng đăng nhập
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không tìm thấy thông tin người dùng, vui lòng đăng nhập lại!')),
      );
      Navigator.pop(context);
    }
  }

  int get totalDays {
    int days = widget.endDate.difference(widget.startDate).inDays;
    return days == 0 ? 1 : days;
  }

  double get totalPrice {
    return widget.room.gia * totalDays * widget.numberOfRooms;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Thanh Toán",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          _buildBodyContent(),
          if (isLoading) _buildLoadingOverlay(),
        ],
      ),
    );
  }

  Widget _buildBodyContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          _buildBookingInfo(),
          const SizedBox(height: 20),
          _buildPaymentMethods(),
          const SizedBox(height: 30),
          _buildConfirmButton(),
        ],
      ),
    );
  }

  Widget _buildBookingInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Mã đặt phòng: #A12345",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Khách sạn: ${widget.hotel.hotelName}",
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 5),
        Text(
          "Ngày nhận phòng: ${DateFormat('dd/MM/yyyy').format(widget.startDate)}",
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          "Ngày trả phòng: ${DateFormat('dd/MM/yyyy').format(widget.endDate)}",
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        Text(
          "Số ngày ở: $totalDays ngày",
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          "Số lượng phòng: ${widget.numberOfRooms}",
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        const Text(
          "Tổng tiền thanh toán",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          NumberFormat.currency(locale: 'vi_VN', symbol: 'VND').format(totalPrice),
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Chọn phương thức thanh toán:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _paymentOptionTile(
          label: "Thẻ tín dụng / Thẻ ghi nợ",
          value: "credit_card",
          icon: Icons.credit_card,
          color: Colors.blue,
        ),
        _paymentOptionTile(
          label: "Ví điện tử",
          value: "e_wallet",
          icon: Icons.account_balance_wallet,
          color: Colors.green,
        ),
        _paymentOptionTile(
          label: "Thanh toán khi nhận phòng",
          value: "cash",
          icon: Icons.attach_money,
          color: Colors.orange,
        ),
      ],
    );
  }

  Widget _paymentOptionTile({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(label),
      trailing: Radio<String>(
        value: value,
        groupValue: selectedPaymentMethod,
        onChanged: (val) {
          setState(() {
            selectedPaymentMethod = val!;
          });
        },
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Center(
      child: ElevatedButton(
        onPressed: isLoading ? null : _handlePayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          "Xác nhận thanh toán",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Future<void> _handlePayment() async {
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không tìm thấy thông tin khách hàng')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      print("hotelId debug: ${widget.hotel.id}");
      final response = await http.post(
        Uri.parse('${Config.apiURL}${Config.donDatPhongAPI}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "userId": userId, // <-- Lấy từ SharedPreferences
          "hotelId": widget.hotel.id, // id của khách sạn truyền vào
          "roomId": widget.room.id, 
          "roomType": widget.room.tenLp,// id của phòng truyền vào
          "numberOfRooms": widget.numberOfRooms,
          "startDate": widget.startDate.toIso8601String(),
          "endDate": widget.endDate.toIso8601String(),
          "totalPrice": totalPrice,
          "paymentMethod": selectedPaymentMethod,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đặt phòng thành công! Chờ admin duyệt')),
        );
        Navigator.pushNamedAndRemoveUntil(context, '/home_screen', (route) => false);
      } else {
        final error = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: ${error['message']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Có lỗi xảy ra: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.3),
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
