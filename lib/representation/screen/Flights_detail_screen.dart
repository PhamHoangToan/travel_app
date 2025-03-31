import 'package:flutter/material.dart';
import 'package:travel_app/Data/model/Invoice_model.dart';
import 'package:travel_app/Data/model/bookingDetails_model.dart';
import 'package:travel_app/Data/model/flight_model.dart';
import 'package:travel_app/Data/model/ticketType_model.dart';
import 'package:travel_app/representation/screen/CustomerInformation_Flight_Screen.dart';
import 'package:travel_app/services/FlightService.dart';
import 'package:travel_app/services/booking_sevice.dart';

class FlightsDetailScreen extends StatefulWidget {
  static const String routeName = '/flights_detail_screen';

  final String origin;
  final String destination;
  final String departureDate;

  const FlightsDetailScreen({
    Key? key,
    required this.origin,
    required this.destination,
    required this.departureDate,
  }) : super(key: key);

  @override
  _FlightsDetailScreenState createState() => _FlightsDetailScreenState();
}

class _FlightsDetailScreenState extends State<FlightsDetailScreen> {
  final FlightService flightService = FlightService();
  List<dynamic> flights = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFlights();
  }

  Future<void> fetchFlights() async {
    try {
      final data = await flightService.searchFlights(
          widget.origin, widget.destination, widget.departureDate);

      setState(() {
        flights = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Lỗi: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Flight Details"),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : flights.isEmpty
              ? Center(child: Text("No flights available"))
              : ListView.builder(
                  itemCount: flights.length,
                  itemBuilder: (context, index) {
                    final flight = flights[index];
                    final duration = flight["itineraries"][0]["duration"];
                    final price = flight["price"]["total"];
                    final currency = flight["price"]["currency"];
                    final departure = flight["itineraries"][0]["segments"][0]
                        ["departure"]["iataCode"];
                    final arrival = flight["itineraries"][0]["segments"][0]
                        ["arrival"]["iataCode"];
                    final flightNumber =
                        flight["itineraries"][0]["segments"][0]["flightNumber"];
                    final airline =
                        flight["itineraries"][0]["segments"][0]["carrierCode"];

                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Flight: $airline $flightNumber",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            SizedBox(height: 8),
                            Text("Route: $departure → $arrival",
                                style: TextStyle(fontSize: 16)),
                            Text("Duration: $duration",
                                style: TextStyle(fontSize: 16)),
                            Text("Price: $price $currency",
                                style:
                                    TextStyle(fontSize: 16, color: Colors.red)),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () async {
                                // ✅ Chuyển đổi `String` thành `DateTime`
                                DateTime departureDateTime =
                                    DateTime.parse(widget.departureDate);
                                DateTime arrivalDateTime =
                                    departureDateTime.add(Duration(
                                        hours:
                                            2)); // Giả sử thời gian bay là 2 giờ

                                final flightModel = FlightModel(
                                  idflight: DateTime.now().millisecondsSinceEpoch.toString(),
                                  airlineName: airline, // Hãng hàng không
                                  departure: departure, // Nơi khởi hành
                                  destination: arrival, // Điểm đến
                                  departureTime:
                                      departureDateTime, // ✅ Đúng kiểu `DateTime`
                                  arrivalTime:
                                      arrivalDateTime, // ✅ Đúng kiểu `DateTime`
                                  seatClass:
                                      "Economy", // Hoặc có thể cho người dùng chọn
                                  ticketPrice: double.parse(
                                      price), // ✅ Chuyển đổi giá thành số
                                  seatCount:
                                      1, // ✅ Số lượng ghế (tạm thời đặt 1)
                                  flightStatus:
                                      "Scheduled", // ✅ Trạng thái chuyến bay
                                  image:
                                      "https://example.com/flight.jpg", // ✅ Hình ảnh minh họa
                                  ticketTypes: [
                                    TicketTypeModel(
                                        name: "Economy",
                                        pricePerPerson: double.parse(price),
                                        description: ''), // ✅ Định dạng đúng
                                    TicketTypeModel(
                                        name: "Business",
                                        pricePerPerson:
                                            double.parse(price) * 1.5,
                                        description: ''),
                                  ],
                                );

                                // ✅ Tạo `Invoice` object
                                final invoice = Invoice(
                                  id: "INV-98765", // Mã hóa đơn
                                  isRequested:
                                      false, // Trạng thái yêu cầu hóa đơn
                                  details:
                                      "Flight booking invoice", // Chi tiết hóa đơn
                                  totalPrice:
                                      flightModel.ticketPrice, // Tổng tiền
                                );

                                // ✅ Tạo `BookingDetails` object
                                final booking = BookingDetails(
                                  id: "BKG123456", // ID đặt vé
                                  passengers: [], // Danh sách hành khách
                                  flightModel: flightModel, // Đối tượng `flightModel`
                                  invoice: invoice, // ✅ Đúng kiểu `Invoice`
                                  totalPrice:
                                      flightModel.ticketPrice, // Tổng tiền
                                );

                                // ✅ Chuyển sang màn hình nhập thông tin khách hàng
                                Navigator.pushNamed(
                                  context,
                                  CustomerinformationFlightScreen.routeName,
                                  arguments: booking,
                                );

                                // ✅ Xử lý đặt vé
                                bool success = await BookingService.bookFlight(booking);
                                if (success) {
                                  print("✅ Đặt vé thành công!");
                                } else {
                                  print("❌ Đặt vé thất bại!");
                                  debugPrint(booking.toJson().toString()); 
                                }
                              },
                              child: Text("Book Now"),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
