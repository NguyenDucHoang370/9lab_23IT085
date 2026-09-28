import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  // Biến color bắt buộc phải truyền vào, cardChild và onPress là tùy chọn
  const ReusableCard({super.key, required this.color, this.cardChild, this.onPress});

  final Color color;
  final Widget? cardChild;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress, // Kích hoạt sự kiện khi người dùng chạm vào thẻ
      child: Container(
        margin: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: cardChild,
      ),
    );
  }
}