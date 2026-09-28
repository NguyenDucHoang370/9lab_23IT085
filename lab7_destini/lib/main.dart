import 'package:flutter/material.dart';
import 'story_brain.dart';

void main() => runApp(const DestiniApp());

class DestiniApp extends StatelessWidget {
  const DestiniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // Giao diện tối phù hợp với ảnh nền
      home: const StoryPage(),
    );
  }
}

// Khởi tạo đối tượng StoryBrain toàn cục
StoryBrain storyBrain = StoryBrain();

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Cài đặt ảnh nền tràn viền
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
        constraints: const BoxConstraints.expand(), // Ép Container mở rộng tối đa
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Hiển thị nội dung cốt truyện
              Expanded(
                flex: 12,
                child: Center(
                  child: Text(
                    storyBrain.getStory(),
                    style: const TextStyle(fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              // Nút lựa chọn 1 (Màu đỏ)
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      setState(() {
                        storyBrain.nextStory(1); // Chuyển logic theo nhánh 1
                      });
                    },
                    child: Text(
                      storyBrain.getChoice1(),
                      style: const TextStyle(fontSize: 20.0, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20.0),

              // Nút lựa chọn 2 (Màu xanh) - Được bọc bởi Visibility
              Expanded(
                flex: 2,
                child: Visibility(
                  // Widget này sẽ bị tàng hình nếu hàm này trả về false
                  visible: storyBrain.buttonShouldBeVisible(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextButton(
                      style: TextButton.styleFrom(backgroundColor: Colors.blue),
                      onPressed: () {
                        setState(() {
                          storyBrain.nextStory(2); // Chuyển logic theo nhánh 2
                        });
                      },
                      child: Text(
                        storyBrain.getChoice2(),
                        style: const TextStyle(fontSize: 20.0, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
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