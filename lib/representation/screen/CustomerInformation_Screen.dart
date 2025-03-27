import 'package:flutter/material.dart';

class CustomerInformation extends StatefulWidget {
  const CustomerInformation({Key? key}) : super(key: key);

  static const String routeName = '/customer_information';

  @override
  State<CustomerInformation> createState() => _CustomerInformationState();
}

class _CustomerInformationState extends State<CustomerInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8), // Màu nền trắng nhẹ
      appBar: AppBar(
        backgroundColor: const Color(0xFF00ADEF), // Màu xanh dương
        title: const Text(
          'Thông tin hành khách',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/account_screen',
              (Route<dynamic> route) => false,
            ); // Quay lại màn hình trước
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tiêu đề
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.person, color: Colors.black54),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Thông tin hành khách đã lưu',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Xử lý thêm hành khách ở đây
                            print('Thêm hành khách');
                            Navigator.pushNamed(
                                context, '/PassengerInfo_screen');
                          },
                          child: const Text(
                            '+ Thêm',
                            style: TextStyle(
                              color: Color(0xFF00ADEF),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),

                  // Item 1
                  ListTile(
                    leading:
                        const Icon(Icons.person_outline, color: Colors.black38),
                    title: const Text(
                      'Hoang Toan Pham',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_horiz, color: Colors.black38),
                      onPressed: () {
                        // Hiển thị popup menu hoặc chức năng khác
                        print('Tùy chọn khác cho Hoang Toan Pham');
                      },
                    ),
                  ),
                  const Divider(height: 1),

                  // Item 2
                  ListTile(
                    leading:
                        const Icon(Icons.person_outline, color: Colors.black38),
                    title: const Text(
                      'toàn hoàng',
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_horiz, color: Colors.black38),
                      onPressed: () {
                        print('Tùy chọn khác cho toàn hoàng');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
