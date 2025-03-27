import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/Data/model/hotel_model.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/helpers/asset_helper.dart';
import 'package:travel_app/helpers/image_helper.dart';
import 'package:travel_app/representation/screen/select_room_screen.dart';
import 'package:travel_app/representation/widgets/button_widget.dart';
import 'package:travel_app/representation/widgets/item_utility_hotel_widget.dart';

class HotelDetailScreen extends StatefulWidget {
  const HotelDetailScreen({Key? key, required this.hotelModel}) : super(key: key);
  static const String routeName = '/hotel_detail_screen';
  final HotelModel hotelModel;

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Hiển thị ảnh khách sạn
          Positioned.fill(
            child: widget.hotelModel.hotelImage.isNotEmpty
                ? Image.network(
                    widget.hotelModel.hotelImage,
                    fit: BoxFit.cover,
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
                    errorBuilder: (context, error, stackTrace) {
                      return ImageHelper.loadFromAsset(
                        AssetHelper.hotel1, // Hình ảnh thay thế khi lỗi
                        fit: BoxFit.cover,
                      );
                    },
                  )
                : ImageHelper.loadFromAsset(
                    AssetHelper.hotel1, // Hình ảnh mặc định nếu không có URL
                    fit: BoxFit.cover,
                  ),
          ),
          // Nút quay lại
          Positioned(
            top: size.height * 0.05,
            left: size.width * 0.05,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.all(size.width * 0.03),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(size.width * 0.05),
                ),
                child: Icon(
                  FontAwesomeIcons.arrowLeft,
                  size: size.width * 0.04,
                ),
              ),
            ),
          ),
          // Nút yêu thích
          Positioned(
            top: size.height * 0.05,
            right: size.width * 0.05,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(size.width * 0.03),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(size.width * 0.05),
                ),
                child: Icon(
                  FontAwesomeIcons.solidHeart,
                  size: size.width * 0.04,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          // Nội dung khách sạn
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            maxChildSize: 0.8,
            minChildSize: 0.3,
            builder: (context, scrollController) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size.width * 0.1),
                    topRight: Radius.circular(size.width * 0.1),
                  ),
                ),
                child: Column(
                  children: [
                    // Thanh kéo
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: size.height * 0.02),
                      child: Container(
                        height: size.height * 0.005,
                        width: size.width * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(size.width * 0.02),
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        children: [
                          // Tiêu đề và giá
                          Row(
                            children: [
                              Text(
                                widget.hotelModel.hotelName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.05,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '\$${widget.hotelModel.price}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.05,
                                ),
                              ),
                              Text('/night'),
                            ],
                          ),
                          SizedBox(height: size.height * 0.02),
                          // Địa chỉ
                          Row(
                            children: [
                              ImageHelper.loadFromAsset(
                                AssetHelper.icoLocation,
                                width: size.width * 0.05,
                              ),
                              SizedBox(width: size.width * 0.02),
                              Text(widget.hotelModel.location),
                            ],
                          ),
                          SizedBox(height: size.height * 0.02),
                          // Đánh giá
                          Row(
                            children: [
                              ImageHelper.loadFromAsset(
                                AssetHelper.icoStar,
                                width: size.width * 0.05,
                              ),
                              SizedBox(width: size.width * 0.02),
                              Text('${widget.hotelModel.star}/5'),
                              Text(
                                ' (${widget.hotelModel.numberOfReview} reviews)',
                                style: TextStyle(
                                  color: ColorPalette.subTitleColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.02),
                          // Thông tin mô tả
                          Text(
                            'Information',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.05,
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Text(
                            widget.hotelModel.describe,
                            style: TextStyle(
                              color: ColorPalette.subTitleColor,
                              fontSize: size.width * 0.04,
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          ItemUtilityHotelWidget(),
                          SizedBox(height: size.height * 0.02),
                          // Vị trí
                          Text(
                            'Location',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.05,
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Text(
                            widget.hotelModel.location,
                          ),
                          SizedBox(height: size.height * 0.02),
                          // Bản đồ
                          ImageHelper.loadFromAsset(
                            AssetHelper.map,
                            height: size.height * 0.3,
                          ),
                          SizedBox(height: size.height * 0.04),
                          // Nút chọn phòng
                          ButtonWidget(
                            title: 'Select room',
                            ontap: () {
                              Navigator.of(context)
                                  .pushNamed(SelectRoomScreen.routeName,
                                   arguments: widget.hotelModel.id, );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
