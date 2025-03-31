import 'package:flutter/material.dart';
import 'package:travel_app/Data/model/Invoice_model.dart';
import 'package:travel_app/Data/model/bookingDetails_model.dart';
import 'package:travel_app/Data/model/flight_model.dart';
import 'package:travel_app/Data/model/passenger_model.dart';
import 'package:travel_app/representation/screen/CustomerInfo_screen.dart';
import 'package:travel_app/representation/screen/Payment_screen.dart';

class CustomerinformationFlightScreen extends StatefulWidget {
  static const String routeName = '/CustomerInformation_Screen';
  final BookingDetails bookingDetails;

  const CustomerinformationFlightScreen({Key? key, required this.bookingDetails})
      : super(key: key);

  @override
  State<CustomerinformationFlightScreen> createState() =>
      _CustomerInformationFlightScreenState();
}

class _CustomerInformationFlightScreenState extends State<CustomerinformationFlightScreen> {
  final TextEditingController passengerController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.bookingDetails.passengers.isNotEmpty) {
      passengerController.text = widget.bookingDetails.passengers[0].name;
      contactController.text = widget.bookingDetails.passengers[0].email;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookingDetails = widget.bookingDetails;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Thêm thông tin hành khách"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildFlightInfo(bookingDetails.flightModel),
            const SizedBox(height: 16),
            buildPassengerInfo(bookingDetails.passengers),
            const SizedBox(height: 16),
            buildLuggageInfo(),
            const SizedBox(height: 16),
            buildInvoiceRequest(bookingDetails.invoice),
            const SizedBox(height: 24),
            buildTotalPrice(context, bookingDetails.totalPrice),
          ],
        ),
      ),
    );
  }

  /// 🛫 Hiển thị thông tin chuyến bay
  Widget buildFlightInfo(FlightModel flightModel) {
    return buildContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(flightModel.departure, style: titleStyle),
              Text(flightModel.destination, style: titleStyle),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "${flightModel.airlineName} • ${flightModel.ticketTypes.map((e) => e.name).join(', ')}",
            style: subtitleStyle,
          ),
        ],
      ),
    );
  }

  /// 👤 Nhập thông tin hành khách
  /// 👤 Nhập thông tin hành khách
Widget buildPassengerInfo(List<KhachHangModel> passengers) {
  return buildSection(
    title: "Hành khách",
    child: Column(
      children: [
        for (int i = 0; i < passengers.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: TextEditingController(text: passengers[i].name),
                    onChanged: (value) {
                      setState(() {
                        passengers[i] = passengers[i].copyWith(name: value);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Tên hành khách",
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      passengers.removeAt(i);
                    });
                  },
                ),
              ],
            ),
          ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () async {
            final newPassenger = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomerInfoScreen(),
              ),
            );

            if (newPassenger != null) {
              setState(() {
                passengers.add(KhachHangModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: "${newPassenger['lastName']} ${newPassenger['firstName']}",
                  email: newPassenger['email'],
                  cccd: "",
                  ngaySinh: DateTime.now(),
                  password: "",
                ));
              });
            }
          },
          child: const Text("+ Thêm hành khách"),
        ),
      ],
    ),
  );
}


  /// ✈️ Hành lý (Luggage)
  Widget buildLuggageInfo() {
    return buildContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text("Hành lý", style: TextStyle(fontSize: 16)),
          Text("Từ 200,000 VND", style: TextStyle(fontSize: 16, color: Colors.orange)),
        ],
      ),
    );
  }

  /// 📄 Yêu cầu hóa đơn GTGT
  Widget buildInvoiceRequest(Invoice invoice) {
    return buildSection(
      title: "Yêu cầu hóa đơn GTGT",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(invoice.details),
          if (invoice.isRequested) const Text("Hóa đơn GTGT sẽ được gửi qua email của bạn."),
        ],
      ),
    );
  }

  /// 💰 Hiển thị tổng giá tiền
  Widget buildTotalPrice(BuildContext context, double totalPrice) {
    return Column(
      children: [
        const Text("Tổng giá tiền cho 1 người", style: titleStyle),
        Text("${(totalPrice*27000).toStringAsFixed(0)} VND", style: priceStyle),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: onContinuePressed,
          style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
          child: const Text("Tiếp tục"),
        ),
      ],
    );
  }

  /// 🎯 Xử lý khi nhấn "Tiếp tục"
  void onContinuePressed() {
  if (widget.bookingDetails.passengers.isEmpty ||
      widget.bookingDetails.passengers.any((p) => p.name.isEmpty)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin hành khách!")),
    );
    return;
  }

  // Điều hướng sang trang thanh toán
  Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => PaymentScreen(
      flightInfo: widget.bookingDetails.flightModel, // 🛠️ Thêm flightInfo
      bookingDetails: widget.bookingDetails, // 🛠️ Thêm bookingDetails
      email: widget.bookingDetails.passengers[0].email, // 🛠️ Thêm email
      orderId: widget.bookingDetails.id, // 🛠️ Thêm orderId
      totalPrice: widget.bookingDetails.totalPrice , // 🛠️ Thêm totalPrice
    ),
  ),
);

}


  /// 📌 Tạo khung hiển thị UI
  Widget buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: titleStyle),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  /// 📦 Container UI
  Widget buildContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 2, blurRadius: 5),
        ],
      ),
      child: child,
    );
  }

  /// 🗑️ Xóa bộ nhớ
  @override
  void dispose() {
    passengerController.dispose();
    contactController.dispose();
    super.dispose();
  }
}

/// 🔥 Style UI
const TextStyle titleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
const TextStyle subtitleStyle = TextStyle(color: Colors.grey);
const TextStyle priceStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange);
