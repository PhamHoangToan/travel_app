import 'package:flutter/material.dart';
import 'package:travel_app/representation/widgets/custom_bottom_nav_bar.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  static const String routeName = '/account_screen';

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int _selectedIndex = 4;

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    setState(() {
      _selectedIndex = index;
    });

    // Điều hướng đến các màn hình khác nếu cần
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home_screen');
        break;
      case 1:
        // Navigator.pushNamed(context, '/explore_screen');
        break;
      case 2:
        Navigator.pushNamed(context, '/hotel_booking_screen');
        break;
      case 3:
        // Navigator.pushNamed(context, '/saved_screen');
        break;
      case 4:
        // Đang ở tài khoản
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              _buildHeader(),

              const SizedBox(height: 10),

              // Bronze Priority
              _buildBronzePriority(),

              const SizedBox(height: 10),

              // Payment Options
              _buildSectionTitle('Lựa chọn thanh toán của tôi'),
              _buildOptionItem(Icons.credit_card, 'Thẻ của tôi', 'Thanh toán siêu tốc chỉ trong 1 chạm', () {}),

              const SizedBox(height: 10),

              // Rewards
              _buildSectionTitle('Phần thưởng của tôi'),
              _buildOptionItem(Icons.monetization_on, '0', 'Đổi Xu lấy Mã Ưu đãi, khám phá thêm nhiều cách khác', () {}),
              _buildOptionItem(Icons.assignment, 'Nhiệm vụ của tôi', 'Hoàn thành nhiệm vụ kiếm nhiều phần thưởng', () {}),
              _buildOptionItem(Icons.bookmark, 'Mã giảm giá của tôi', 'Xem danh sách mã giảm giá', () {}),
              _buildOptionItem(Icons.percent, 'Reward Zone', 'Xem tiến độ hoặc bắt đầu nhiệm vụ mới', () {}),

              const SizedBox(height: 10),

              // Member features
              _buildSectionTitle('Tính năng dành cho thành viên'),
              _buildOptionItem(Icons.person_outline, 'Thông tin hành khách', 'Quản lý thông tin hành khách và địa chỉ đã lưu', () {
                Navigator.pushNamed(context, '/customer_information');
              }),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  // ---------------- COMPONENTS ----------------

  Widget _buildHeader() {
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Box + Icon Row
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Bay Trung Quốc ngắm Hoa Anh Đ...',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              _iconWithDot(Icons.percent),
              const SizedBox(width: 10),
              _iconWithDot(Icons.chat_bubble_outline),
              const SizedBox(width: 10),
              const Icon(Icons.settings, color: Colors.white),
            ],
          ),

          const SizedBox(height: 20),

          // User Info
          Row(
            children: [
              // Avatar placeholder
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'th',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Name + Edit
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'toàn hoàng', // Giả lập parse lỗi html => fix
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Đã đăng nhập bằng Google',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '0 Bài viết',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.edit, color: Colors.white),
            ],
          ),

          const SizedBox(height: 10),

          // View Profile Button
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Xem hồ sơ của tôi'),
          ),
        ],
      ),
    );
  }

  Widget _buildBronzePriority() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.emoji_events, color: Colors.brown),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              "You're our Bronze Priority",
              style: TextStyle(fontSize: 14),
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildOptionItem(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 28, color: Colors.grey.shade600),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _iconWithDot(IconData icon) {
    return Stack(
      children: [
        const Icon(Icons.circle, color: Colors.transparent, size: 24), // giữ layout ổn định
        Icon(icon, color: Colors.white),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
