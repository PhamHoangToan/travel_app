import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/config.dart';
import 'dart:convert';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/representation/widgets/app_bar_container.dart';
import 'package:travel_app/representation/widgets/button_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';


class SelectDateScreen extends StatelessWidget {
  static const String routeName = '/select_date_screen';
  DateTime? rangeStartDate;
  DateTime? rangeEndDate;
  final String hotelId = '123456';  // Example hotel ID, replace with dynamic data

  Future<void> bookHotel(DateTime? startDate, DateTime? endDate) async {
    if (startDate == null || endDate == null) return;

    final response = await http.post(
      Uri.parse(' ${Config.apiURL}/api/book'),  // Replace with your actual API URL
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'hotelId': hotelId,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
      }),
    );

    if (response.statusCode == 200) {
      // Successfully booked hotel
      final responseData = json.decode(response.body);
      print('Booking successful: ${responseData['message']}');
    } else {
      // Error occurred
      print('Error: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppBarContainerWidget(
      titleString: 'Select date',
      child: Column(
        children: [
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
          SizedBox(
            height: kMediumPadding * 1.5,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.only(
                  left: 30.0), // Điều chỉnh thêm khoảng cách từ bên trái
              child: SfDateRangePicker(
                view: DateRangePickerView.month,
                selectionMode: DateRangePickerSelectionMode.range,
                monthViewSettings: DateRangePickerMonthViewSettings(
                  firstDayOfWeek: 1,
                ),
                selectionColor: ColorPalette.yellowColor,
                selectionTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                startRangeSelectionColor: ColorPalette.yellowColor,
                endRangeSelectionColor: ColorPalette.yellowColor,
                rangeSelectionColor: ColorPalette.yellowColor.withOpacity(0.25),
                todayHighlightColor: ColorPalette.yellowColor,
                toggleDaySelection: true,
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  if (args.value is PickerDateRange) {
                    rangeStartDate = args.value.startDate;
                    rangeEndDate = args.value.endDate;
                  } else {
                    rangeStartDate = null;
                    rangeEndDate = null;
                  }
                },
                monthCellStyle: DateRangePickerMonthCellStyle(
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  todayTextStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.yellowColor,
                  ),
                  leadingDatesTextStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  trailingDatesTextStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          ButtonWidget(
            title: 'Select',
            ontap: () {
              // Send booking request to backend
              bookHotel(rangeStartDate, rangeEndDate);
              Navigator.of(context).pop([rangeStartDate, rangeEndDate]);
            },
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          ButtonWidget(
            title: 'Cancel',
            ontap: () {
              Navigator.of(context).pop([rangeStartDate, rangeEndDate]);
            },
          ),
        ],
      ),
    );
  }
}
