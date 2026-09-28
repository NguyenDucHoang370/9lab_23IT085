import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MagicBallApp());
}

// App chính
class MagicBallApp extends StatelessWidget {
  const MagicBallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MagicBallPage(),
    );
  }
}

// Trang chính
class MagicBallPage extends StatefulWidget {
  const MagicBallPage({super.key});

  @override
  State<MagicBallPage> createState() => _MagicBallPageState();
}

class _MagicBallPageState extends State<MagicBallPage> {
  // Số của hình ảnh hiện tại
  int ballNumber = 1;

  // Chọn ngẫu nhiên một quả cầu từ 1 đến 5
  void getAnswer() {
    setState(() {
      ballNumber = Random().nextInt(5) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Lấy kích thước màn hình hiện tại
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Kích thước quả cầu thay đổi theo màn hình
    final ballSize = min(screenWidth * 0.75, screenHeight * 0.45);

    return Scaffold(
      backgroundColor: Colors.blue.shade300,

      appBar: AppBar(
        title: const Text('Ask Me Anything'),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Tiêu đề
                        const Text(
                          'Hãy hỏi một câu và nhấn nút!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 25),

                        // Hình quả cầu
                        SizedBox(
                          width: ballSize,
                          height: ballSize,
                          child: Image.asset(
                            'assets/ball$ballNumber.png',
                            fit: BoxFit.contain,
                          ),
                        ),

                        const SizedBox(height: 25),

                        // Nút nhận câu trả lời
                        SizedBox(
                          width: min(screenWidth * 0.75, 300),
                          child: ElevatedButton(
                            onPressed: getAnswer,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue.shade900,
                            ),
                            child: const Text(
                              'Nhận Câu Trả Lời',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}