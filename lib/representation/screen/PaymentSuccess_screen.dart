import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final String qrCodeData;

  const PaymentSuccessScreen({Key? key, required this.qrCodeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 📌 Kiểm tra nếu qrCodeData là base64 hay chỉ là dữ liệu QR
    bool isBase64 = qrCodeData.startsWith("data:image/png;base64,");

    Uint8List? qrCodeBytes;
    if (isBase64) {
      String base64Str = qrCodeData.split(",")[1]; // Loại bỏ "data:image/png;base64,"
      qrCodeBytes = base64Decode(base64Str);
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Thanh toán thành công"), backgroundColor: Colors.green),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 80, color: Colors.green),
              const SizedBox(height: 16),
              const Text("Thanh toán thành công!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text("Quét mã QR này để kiểm tra vé điện tử"),
              const SizedBox(height: 16),

              // 📌 Hiển thị mã QR từ dữ liệu hoặc từ ảnh base64
              if (!isBase64) 
                QrImageView(
                  data: qrCodeData,
                  version: QrVersions.auto,
                  size: 200.0,
                )
              else 
                Image.memory(qrCodeBytes!, width: 200, height: 200), // Hiển thị ảnh QR từ base64

              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text("Về trang chủ"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
