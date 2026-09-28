import 'package:flutter/material.dart';

void main() {
  runApp(const MidCardApp());
}

class MidCardApp extends StatelessWidget {
  const MidCardApp({super.key});

  // build() dùng để xây dựng giao diện của Widget.

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.deepOrange,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //1 Ảnh đại diện
              const CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('images/logo.png'),
              ),

              //2. Tên hiển thị
              const Text(
                'ThinkPad E14',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //3.Chức danh
              Text(
                'FLUTTER DEVELOPER',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.deepOrange.shade100,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.5,
                ),
              ),
              // Đường gạch ngang phân cách
              SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(color: Colors.deepOrange.shade100),
              ),

              // Thẻ số điện thoại
              Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 25.0,
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.phone,
                    color: Colors.deepOrange, // Icon màu cam
                  ),
                  title: Text(
                    '+84 332 579 171',
                    style: TextStyle(
                      color: Colors.deepOrange.shade900,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              // Thẻ Email
              Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 25.0,
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.email,
                    color: Colors.deepOrange, // Icon màu cam
                  ),
                  title: Text(
                    'hoangnd.23it@vku.udn.vn',
                    style: TextStyle(
                      color: Colors.deepOrange.shade900,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ), //SafeArea giúp nội dung không bị che bởi  thanh trạng thái hoặc vùng đặc biệt của điện thoại.
      ),
    );
  }
}
