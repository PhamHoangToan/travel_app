import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';

class AppBarContainerWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarContainerWidget({
    Key? key,
    required this.child,
    this.title,
    this.titleString,
    this.implementLeading = false,
    this.implementTrailing = false,
  }) : super(key: key);

  final Widget child;
  final Widget? title;
  final String? titleString;
  final bool implementLeading;
  final bool implementTrailing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: preferredSize.height,
            child: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              elevation: 0,
              toolbarHeight: 90,
              backgroundColor: Colors.white,
              title: title ??
                  Row(
                    children: [
                      if (implementLeading)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(kMediumPadding),
                            ),
                            color: Colors.blue, // Đổi thành màu xanh
                          ),
                          padding: EdgeInsets.all(kItemPadding),
                          child: Icon(
                            FontAwesomeIcons.arrowLeft,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      Expanded(
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                titleString ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white, // Đổi thành màu trắng cho dễ đọc
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (implementTrailing)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(kMediumPadding),
                            color: Colors.blue, // Đổi thành màu xanh
                          ),
                          padding: EdgeInsets.all(kItemPadding),
                          child: Icon(
                            FontAwesomeIcons.bars,
                            color: Colors.white,
                            size: kDefaultFontSize,
                          ),
                        ),
                    ],
                  ),
              flexibleSpace: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue, // Đổi nền thành màu xanh
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 156),
            padding: EdgeInsets.symmetric(horizontal: kMediumPadding),
            child: child,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(186);
}
