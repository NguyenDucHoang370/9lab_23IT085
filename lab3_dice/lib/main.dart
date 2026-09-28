import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white, // Nền trắng theo ảnh
        appBar: AppBar(
          title: const Text(
            'Dice',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0, // Bỏ bóng đổ của thanh tiêu đề
          centerTitle: true,
        ),
        body: const DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  // Cần 2 biến trạng thái cho 2 viên xúc xắc riêng biệt
  int leftDiceNumber = 4;
  int rightDiceNumber = 6;

  // Hàm lắc cả 2 viên xúc xắc cùng lúc
  void changeDiceFaces() {
    setState(() {
      leftDiceNumber = Random().nextInt(6) + 1;
      rightDiceNumber = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // Sử dụng Row để xếp 2 phần tử nằm ngang thay vì dọc
      child: Row(
        children: [
          // Expanded thứ nhất: chứa xúc xắc trái
          Expanded(
            // TextButton biến hình ảnh thành nút bấm có hiệu ứng gợn sóng
            child: TextButton(
              onPressed: () {
                changeDiceFaces();
              },
              child: Image.asset('assets/dice$leftDiceNumber.png'),
            ),
          ),

          // Expanded thứ hai: chứa xúc xắc phải
          Expanded(
            child: TextButton(
              onPressed: () {
                changeDiceFaces();
              },
              child: Image.asset('assets/dice$rightDiceNumber.png'),
            ),
          ),
        ],
      ),
    );
  }
}