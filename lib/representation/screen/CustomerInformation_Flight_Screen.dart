import 'package:flutter/material.dart';
import 'package:travel_app/Data/model/Invoice_model.dart';
import 'package:travel_app/Data/model/bookingDetails_model.dart';
import 'package:travel_app/Data/model/flight_model.dart';
import 'package:travel_app/Data/model/passenger_model.dart';

class CustomerinformationFlightScreen extends StatefulWidget {
  static const String routeName = '/CustomerInformation_Screen';
  final BookingDetails bookingDetails;

  const CustomerinformationFlightScreen({Key? key, required this.bookingDetails})
      : super(key: key);

  @override
  State<CustomerinformationFlightScreen> createState() =>
      _CustomerinformationScreenState();
}

class _CustomerinformationScreenState extends State<CustomerinformationFlightScreen> {
  final TextEditingController passengerController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  get bookingDetails => null;

  @override
  void initState() {
    super.initState();
    if (widget.bookingDetails.passengers.isNotEmpty) {
      passengerController.text = widget.bookingDetails.passengers[0].name;
    }
    // Assuming email will also be pre-populated from the first passenger
    // contactController.text = widget.bookingDetails.passengers[0].email;
  }

  @override
  Widget build(BuildContext context) {
    final bookingDetails = widget.bookingDetails;
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildFlightInfo(bookingDetails.flightModel),
              const SizedBox(height: 16),
              buildPassengerInfo(bookingDetails.passengers),
              const SizedBox(height: 16),
              buildEssentialInfo(),
              const SizedBox(height: 16),
              buildInvoiceRequest(bookingDetails.invoice),
              const SizedBox(height: 24),
              buildTotalPrice(context, bookingDetails.totalPrice),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blue,
      title: const Text("Thêm thông tin hành khách"),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget buildFlightInfo(FlightModel flightModel) {
    return buildContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(flightModel.departure,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              Text(flightModel.destination,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
        //  Text(flightModel.departureTime),
          const SizedBox(height: 8),
          Text("${flightModel.airlineName} • ${flightModel.ticketTypes}",
              style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget buildPassengerInfo(List<KhachHangModel> passengers) {
    return buildSection(
      title: "Hành khách",
      child: Column(
        children: passengers
            .asMap()
            .entries
            .map(
              (entry) => TextField(
                controller: entry.key == 0 ? passengerController : null,
                decoration: InputDecoration(
                  labelText: "Hành khách ${entry.key + 1}",
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget buildContactInfo(KhachHangModel passenger) {
    return buildSection(
      title: "Liên hệ",
      child: Column(
        children: [
          TextField(
            controller: contactController,
            decoration: const InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
          ),
          const SizedBox(height: 8),
          
        ],
      ),
    );
  }

  Widget buildEssentialInfo() {
    return buildContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text("Hành lý", style: TextStyle(fontSize: 16)),
          Text("Từ 200,000 VND",
              style: TextStyle(fontSize: 16, color: Colors.orange)),
        ],
      ),
    );
  }

  Widget buildInvoiceRequest(Invoice invoice) {
    return buildSection(
      title: "Yêu cầu hóa đơn GTGT",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(invoice.details),
          if (invoice.isRequested)
            const Text("Hóa đơn GTGT sẽ được gửi qua email của bạn."),
        ],
      ),
    );
  }

  Widget buildTotalPrice(BuildContext context, double totalPrice) {
    return Column(
      children: [
        const Text("Tổng giá tiền cho 1 người",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text("${totalPrice.toStringAsFixed(0)} VND",
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orange)),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            final passenger = passengerController.text;
            final contact = contactController.text;

            if (passenger.isEmpty || contact.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Vui lòng điền đầy đủ thông tin!")),
              );
            } else {
              // Update the booking details with new passenger and contact info
              final updatedBookingDetails = widget.bookingDetails.copyWith(
                id: widget
                    .bookingDetails.id, // Ensure the existing ID is retained
                passengers: [
                  KhachHangModel(
                    id: widget.bookingDetails.id,
                    name: passenger,
                    email: contact, // Assuming the contact is the email
                    
                    password: contact, cccd: passenger, ngaySinh: DateTime(2000), // Assuming phone is the same as contact
                  ),
                ],
              );

              // Optionally, pass updatedBookingDetails back to another screen or use it as needed
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text("Thông tin đã lưu: $passenger - $contact")),
              );
            }
          },
          child: const Text("Tiếp tục"),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
          ),
        )
      ],
    );
  }

  Widget buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget buildContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  void dispose() {
    passengerController.dispose();
    contactController.dispose();
    super.dispose();
  }
}
