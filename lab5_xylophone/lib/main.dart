import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // Import thư viện phát âm thanh

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const XylophoneApp());
}
class XylophoneApp extends StatelessWidget {
  const XylophoneApp({super.key});

  // Hàm tái sử dụng để phát âm thanh dựa vào số nguyên truyền vào
  void playSound(int noteNumber) {
    final player = AudioPlayer();
    // AssetSource tự động trỏ vào thư mục assets/
    player.play(AssetSource('note$noteNumber.wav'));
  }

  // Hàm tái sử dụng để vẽ phím đàn (tránh lặp lại code 7 lần)
  Expanded buildKey({required Color color, required int soundNumber}) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color, // Màu sắc sinh động theo yêu cầu
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // Loại bỏ bo góc mặc định của TextButton
          ),
        ),
        onPressed: () {
          playSound(soundNumber);
        },
        child: const SizedBox.shrink(), // Phím đàn chỉ có màu, không cần text
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black, // Nền đen làm nổi bật màu phím đàn
        body: SafeArea(
          // Column sắp xếp các phím đàn theo chiều dọc
          child: Column(
            // Kéo dãn các Widget con (phím đàn) ra sát 2 bên mép màn hình
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildKey(color: Colors.red, soundNumber: 1),
              buildKey(color: Colors.orange, soundNumber: 2),
              buildKey(color: Colors.yellow, soundNumber: 3),
              buildKey(color: Colors.green, soundNumber: 4),
              buildKey(color: Colors.teal, soundNumber: 5),
              buildKey(color: Colors.blue, soundNumber: 6),
              buildKey(color: Colors.purple, soundNumber: 7),
            ],
          ),
        ),
      ),
    );
  }
}