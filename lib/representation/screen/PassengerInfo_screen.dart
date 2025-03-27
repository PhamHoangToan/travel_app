import 'package:flutter/material.dart';

class PassengerInfoScreen extends StatefulWidget {
  const PassengerInfoScreen({super.key});
   static const String routeName = '/PassengerInfo_screen';
  @override
  State<PassengerInfoScreen> createState() => _PassengerInfoScreenState();
}

class _PassengerInfoScreenState extends State<PassengerInfoScreen> {
  String selectedTitle = 'Ông';
  String countryCode = '+84';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin hành khách đã lưu'),
        backgroundColor: const Color(0xFF00ADEF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
          Navigator.pushNamed(context, '/customer_information');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Thông tin bắt buộc
            _buildSectionTitle('Thông tin bắt buộc'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _buildDropdownRow(
                    label: 'Danh xưng',
                    value: selectedTitle,
                    items: ['Ông', 'Bà', 'Khác'],
                    onChanged: (value) {
                      setState(() {
                        selectedTitle = value!;
                      });
                    },
                  ),
                  _buildDoubleTextField('Tên', 'Hoang Toan', 'Họ', 'Pham'),
                  _buildDateField('Ngày sinh', '13 tháng 9 2003'),
                ],
              ),
            ),
            const Divider(height: 32, thickness: 8, color: Color(0xFFF5F5F5)),

            // Thông tin bổ sung
            _buildSectionTitle('Thông tin bổ sung'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _buildPhoneField(),
                  _buildTextField('Địa chỉ email', 'phamhoangtoan@gmail.com'),
                ],
              ),
            ),
            const Divider(height: 32, thickness: 8, color: Color(0xFFF5F5F5)),

            // Hành khách thân thiết
            ExpansionTile(
              title: const Text('Hành khách Thân thiết'),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('Thêm tài khoản'),
                  ),
                ),
              ],
            ),
            const Divider(height: 32, thickness: 8, color: Color(0xFFF5F5F5)),

            // Các loại giấy tờ
            _buildExpandableItem('Hộ chiếu'),
            _buildExpandableItem('CMND'),
            _buildExpandableItem('Bằng lái'),
            _buildExpandableItem('Các giấy tờ tuỳ thân khác'),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      color: const Color(0xFFF5F5F5),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildDropdownRow({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: label,
                border: const OutlineInputBorder(),
              ),
              value: value,
              onChanged: onChanged,
              items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoubleTextField(String label1, String hint1, String label2, String hint2) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        children: [
          Expanded(child: _buildTextField(label1, hint1)),
          const SizedBox(width: 16),
          Expanded(child: _buildTextField(label2, hint2)),
        ],
      ),
    );
  }

  Widget _buildDateField(String label, String date) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          hintText: date,
          suffixIcon: const Icon(Icons.calendar_today_outlined),
          border: const OutlineInputBorder(),
        ),
        onTap: () {
          // Mở date picker nếu cần
        },
      ),
    );
  }

  Widget _buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Mã quốc gia',
                border: OutlineInputBorder(),
              ),
              value: countryCode,
              onChanged: (value) {
                setState(() {
                  countryCode = value!;
                });
              },
              items: ['+84', '+1', '+61']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildTextField('Số di động', '387646729'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildExpandableItem(String title) {
    return ExpansionTile(
      title: Text(title),
      trailing: const Icon(Icons.keyboard_arrow_down),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              _buildTextField('Số giấy tờ', ''),
              _buildDateField('Ngày cấp', ''),
              _buildTextField('Nơi cấp', ''),
            ],
          ),
        ),
      ],
    );
  }
}
