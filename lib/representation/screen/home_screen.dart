import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/helpers/asset_helper.dart';
import 'package:travel_app/helpers/image_helper.dart';
import 'package:travel_app/representation/screen/flight_search_screen.dart';
import 'package:travel_app/representation/screen/account_screen.dart';
import 'package:travel_app/representation/screen/hotel_booking_screen.dart';
import 'package:travel_app/representation/widgets/app_bar_container.dart';
import 'package:travel_app/Data/model/city_model.dart';
import 'package:travel_app/representation/widgets/city_item_widget.dart';
import 'package:travel_app/services/city_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CityModel> cities = [];
  bool isLoading = true;
  String errorMessage = '';
  @override
  void initState() {
    super.initState();
    _fetchCities();
  }

  Future<void> _fetchCities() async {
    try {
      final fetchedCities = await CityService.fetchCities();
      setState(() {
        cities = fetchedCities;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return; // Tránh load lại screen

    setState(() {
      _selectedIndex = index;
    });

    // Điều hướng theo index
    switch (index) {
      case 0:
        Navigator.pushNamed(context, HomeScreen.routeName);
        break;
      case 1:
        // Navigator.pushNamed(context, ExploreScreen.routeName);
        break;
      case 2:
        Navigator.pushNamed(context, HotelBookingScreen.routeName);
        break;
      case 3:
        // Navigator.pushNamed(context, SavedScreen.routeName);
        break;
      case 4:
        Navigator.pushNamed(context, AccountScreen.routeName);
        break;
    }
  }

  Widget _builtItemCategory(
      Widget icon, Color color, Function() onTap, String title) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: kMediumPadding),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(kItemPadding),
            ),
            child: icon,
          ),
          SizedBox(height: kItemPadding),
          Text(title),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBarContainerWidget(
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Hi Toàn!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: kMediumPadding),
                  Text(
                    'Bạn muốn đi đâu!',
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorPalette.subTitleColor,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Icon(
                FontAwesomeIcons.bell,
                size: kDefaultIconSize,
                color: Colors.white,
              ),
              SizedBox(width: kTopPadding),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kItemPadding),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(kMinPadding),
                child: ImageHelper.loadFromAsset(AssetHelper.intro1),
              ),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(kTopPadding),
                    child: Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: Colors.black,
                      size: kDefaultPadding,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius:
                        BorderRadius.all(Radius.circular(kItemPadding)),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: kItemPadding),
                ),
              ),
              SizedBox(height: kDefaultPadding),
              Row(
                children: [
                  Expanded(
                    child: _builtItemCategory(
                      ImageHelper.loadFromAsset(
                        AssetHelper.icoHotels,
                        width: kDefaultPadding,
                        height: kDefaultPadding,
                      ),
                      Color(0xffFE9C5E),
                      () {
                        Navigator.of(context)
                            .pushNamed(HotelBookingScreen.routeName);
                      },
                      'Hotels',
                    ),
                  ),
                  SizedBox(width: kDefaultPadding),
                  Expanded(
                    child: _builtItemCategory(
                      ImageHelper.loadFromAsset(
                        AssetHelper.icoPlane,
                        width: kDefaultPadding,
                        height: kDefaultPadding,
                      ),
                      Color(0xffF77777),
                      () {
                        Navigator.of(context)
                            .pushNamed(FlightSearchScreen.routeName);
                      },
                      'Flights',
                    ),
                  ),
                  SizedBox(width: kDefaultPadding),
                  Expanded(
                    child: _builtItemCategory(
                      ImageHelper.loadFromAsset(
                        AssetHelper.icoHotelPlane,
                        width: kDefaultPadding,
                        height: kDefaultPadding,
                      ),
                      Color(0xff3EC8BC),
                      () {
                        // Do something when "All" is tapped
                      },
                      'All',
                    ),
                  ),
                ],
              ),
              SizedBox(height: kDefaultPadding),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Row(
                  children: [
                    Text(
                      'Popular Cities',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              SizedBox(height: kMediumPadding),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  children: [
                    if (isLoading)
                      const Center(child: CircularProgressIndicator())
                    else if (errorMessage.isNotEmpty)
                      Center(child: Text('Error: $errorMessage'))
                    else
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: kDefaultPadding,
                          mainAxisSpacing: kDefaultPadding,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: cities.length,
                        itemBuilder: (context, index) {
                          return CityItemWidget(city: cities[index]);
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // ✅ BottomNavigationBar ở đây!
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_outline),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Đặt chỗ của tôi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Đã lưu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
        ],
        selectedItemColor: ColorPalette.primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
