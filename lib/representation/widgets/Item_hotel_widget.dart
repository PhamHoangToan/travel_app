import 'package:flutter/material.dart';
import 'package:travel_app/Data/model/hotel_model.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/helpers/asset_helper.dart';
import 'package:travel_app/representation/screen/hotel_detail_screen.dart';
import 'package:travel_app/representation/widgets/button_widget.dart';
import 'package:travel_app/representation/widgets/dashline_widget.dart';

class ItemHotelWidget extends StatelessWidget {
  final HotelModel hotelModel;

  const ItemHotelWidget({Key? key, required this.hotelModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding / 2), // Giảm border radius
        color: Colors.white,
      ),
      margin: EdgeInsets.only(right: kDefaultPadding / 2), // Giảm margin
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width, // Chiều rộng toàn màn hình
            margin: EdgeInsets.only(right: kDefaultPadding / 2),
            child: Image.network(
              hotelModel.hotelImage, // Change this to Image.network
              height: 150, // Giữ chiều cao cố định
              fit: BoxFit.cover, // Đảm bảo hình ảnh bao phủ toàn bộ Container
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2,
              vertical: kDefaultPadding / 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotelModel.hotelName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14, // Giảm font size
                  ),
                ),
                SizedBox(
                  height: kDefaultPadding / 2,
                ),
                Row(
                  children: [
                    Image.asset(
                      AssetHelper.icoLocation,
                      width: 16, // Giảm kích thước icon
                      height: 16,
                    ),
                    SizedBox(
                      width: kMinPadding / 2,
                    ),
                    Expanded(
                      child: Text(
                        '${hotelModel.location} - ${hotelModel.awayKilometer} km from destination',
                        style: TextStyle(
                          fontSize: 12, // Giảm font size
                          color: ColorPalette.subTitleColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: kDefaultPadding / 2,
                ),
                Row(
                  children: [
                    Image.asset(
                      AssetHelper.icoStar,
                      width: 16, // Giảm kích thước icon
                      height: 16,
                    ),
                    SizedBox(
                      width: kMinPadding / 2,
                    ),
                    Text(
                      hotelModel.star.toString(),
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      ' - ${hotelModel.numberOfReview} reviews',
                      style: TextStyle(
                        fontSize: 12, // Giảm font size
                        color: ColorPalette.subTitleColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: kDefaultPadding / 2),
                DashlineWidget(),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$${hotelModel.price}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14, // Giảm font size
                            ),
                          ),
                          SizedBox(
                            height: kMinPadding / 2,
                          ),
                          Text(
                            '/night',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ButtonWidget(
                        title: 'Book',
                        ontap: () {
                          Navigator.of(context).pushNamed(HotelDetailScreen.routeName, arguments: hotelModel);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
