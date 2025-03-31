import 'package:flutter/material.dart';
import 'package:travel_app/representation/screen/Flights_detail_screen.dart';
import 'package:travel_app/representation/widgets/button_widget.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/Data/model/flight_model.dart';

class ItemFlightWidget extends StatelessWidget {
  final FlightModel flightModel;

  const ItemFlightWidget({
    Key? key,
    required this.flightModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding / 2),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
      child: Column(
        children: [
          // Hiển thị hình ảnh chuyến bay
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(kDefaultPadding / 2),
              bottomRight: Radius.circular(kDefaultPadding / 2),
            ),
            child: Image.network(
              flightModel.image,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Image.network(
                "https://i.imgur.com/JfPrEvm.png",
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tên hãng bay
                Text(
                  flightModel.airlineName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: kDefaultPadding / 2),

                // Điểm khởi hành
                Text(
                  'Điểm đi: ${flightModel.departure}',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorPalette.subTitleColor,
                  ),
                ),
                const SizedBox(height: kDefaultPadding / 4),

                // Điểm đến
                Text(
                  'Điểm đến: ${flightModel.destination}',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorPalette.subTitleColor,
                  ),
                ),
                const SizedBox(height: kDefaultPadding / 2),

                // Số lượng ghế còn trống
                Text(
                  'Số ghế trống: ${flightModel.seatCount}',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorPalette.subTitleColor,
                  ),
                ),
                const SizedBox(height: kDefaultPadding / 2),

                // Nút đặt vé
               ButtonWidget(
  title: 'Book Now',
  ontap: () {
    Navigator.pushNamed(
      context,
      FlightsDetailScreen.routeName,
      arguments: {
        "origin": flightModel.departure,
        "destination": flightModel.destination,
        "departureDate": flightModel.departureTime.toString().split(" ")[0], // ✅ Lấy ngày từ DateTime
      },
    );
  },
),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
