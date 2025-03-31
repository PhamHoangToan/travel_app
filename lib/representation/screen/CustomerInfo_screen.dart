import 'package:flutter/material.dart';

class CustomerInfoScreen extends StatefulWidget {
  static const String routeName = '/CustomerInfor_Screen';

  @override
  _CustomerInfoScreenState createState() => _CustomerInfoScreenState();
}

class _CustomerInfoScreenState extends State<CustomerInfoScreen> {
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cccdController = TextEditingController();
  final TextEditingController ngaySinhController = TextEditingController();

  Widget _buildTextField(String label, TextEditingController controller, TextInputType keyboardType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue),
            ),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin liên hệ"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField("Họ", lastNameController, TextInputType.text),
              SizedBox(height: 12),
              _buildTextField("Tên Đệm & Tên", firstNameController, TextInputType.text),
              SizedBox(height: 12),
              _buildTextField("Số điện thoại", phoneController, TextInputType.phone),
              SizedBox(height: 12),
              _buildTextField("Email", emailController, TextInputType.emailAddress),
              SizedBox(height: 12),
              _buildTextField("CCCD", cccdController, TextInputType.text),
              SizedBox(height: 12),
              _buildTextField("Ngày sinh", ngaySinhController, TextInputType.datetime),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'lastName': lastNameController.text,
                      'firstName': firstNameController.text,
                      'phone': phoneController.text,
                      'email': emailController.text,
                      'cccd': cccdController.text,
                      'ngaySinh': ngaySinhController.text,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Lưu",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}