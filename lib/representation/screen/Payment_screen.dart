import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:travel_app/Data/model/bookingDetails_model.dart';
import 'package:travel_app/Data/model/flight_model.dart';
import 'package:travel_app/representation/screen/PaymentSuccess_screen.dart';
import 'package:travel_app/services/booking_sevice.dart';

class PaymentScreen extends StatefulWidget {
  final FlightModel flightInfo;
  final BookingDetails bookingDetails;
  final String email;
  final String orderId;
  final double totalPrice;

  const PaymentScreen({
    Key? key,
    required this.flightInfo,
    required this.bookingDetails,
    required this.email,
    required this.orderId,
    required this.totalPrice,
  }) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPaymentMethod = "Ví điện tử"; // Mặc định chọn ví điện tử
  bool isLoading = false;

  /// 🎯 Gọi API thanh toán & nhận mã QR
 Future<void> processPayment() async {
  setState(() {
    isLoading = true;
  });

  try {
    String? qrCode = await BookingService.processPayment(widget.bookingDetails);
    
    if (qrCode != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaymentSuccessScreen(qrCodeData: qrCode)),
      );
    } else {
      print("❌ Lỗi thanh toán: API trả về null!");
    }
  } catch (e) {
    print("❌ Lỗi khi gọi API thanh toán: $e");
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thanh toán"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBookingDetails(),
            const SizedBox(height: 16),
            buildPaymentMethods(),
            const Spacer(),
            buildTotalPriceAndButton(),
          ],
        ),
      ),
    );
  }

  /// 🎫 Hiển thị chi tiết đặt chỗ
  Widget buildBookingDetails() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Chi tiết đặt chỗ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(
                "✈️ Chuyến bay: ${widget.flightInfo.departure} → ${widget.flightInfo.destination}"),
            Text("🏷️ Hãng bay: ${widget.flightInfo.airlineName}"),
            Text(
                "🎟 Loại vé: ${widget.flightInfo.ticketTypes.map((e) => e.name).join(', ')}"),
            const Divider(),
            const Text("👤 Hành khách:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ...widget.bookingDetails.passengers
                .map((p) => Text("• ${p.name} - ${p.email}")),
          ],
        ),
      ),
    );
  }

  /// 💳 Chọn phương thức thanh toán
  Widget buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Phương thức thanh toán",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Column(
          children: ["Ví điện tử", "Thẻ tín dụng", "Tiền mặt"].map((method) {
            return ListTile(
              leading: Radio<String>(
                value: method,
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),
              title: Text(method),
              onTap: () {
                setState(() {
                  selectedPaymentMethod = method;
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  /// 💰 Hiển thị tổng tiền & Nút thanh toán
  Widget buildTotalPriceAndButton() {
    return Column(
      children: [
        Text("Tổng tiền: ${(widget.totalPrice * 27000 ).toStringAsFixed(0)} VND",
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orange)),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: isLoading ? null : processPayment,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
            backgroundColor: Colors.green,
          ),
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : Text("Thanh toán bằng $selectedPaymentMethod"),
        ),
      ],
    );
  }
}
