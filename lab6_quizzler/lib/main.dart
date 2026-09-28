import 'package:flutter/material.dart';

void main() => runApp(const QuizzlerApp());

// 1. Lớp tĩnh bọc khung ứng dụng
class QuizzlerApp extends StatelessWidget {
  const QuizzlerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900, // Nền tối giúp nổi bật các nút bấm
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

// 2. Lớp động quản lý giao diện và logic trò chơi
class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // Danh sách lưu trữ các biểu tượng Đúng (Tick xanh) / Sai (X đỏ)
  List<Icon> scoreKeeper = [];

  // Danh sách các đối tượng Câu hỏi (Mô phỏng cơ sở dữ liệu)
  List<Question> questionBank = [
    Question(q: 'Con bò có 4 chân.', a: true),
    Question(q: 'Mặt trời mọc ở hướng Tây.', a: false),
    Question(q: 'Đà Nẵng là thủ đô của Việt Nam.', a: false),
    Question(q: 'Flutter sử dụng ngôn ngữ lập trình Dart.', a: true),
    Question(q: 'HTML là một ngôn ngữ lập trình.', a: false),
  ];

  // Biến theo dõi câu hỏi hiện tại
  int questionNumber = 0;

  // Hàm xử lý logic khi người dùng chọn đáp án
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = questionBank[questionNumber].questionAnswer;

    setState(() {
      // 1. Kiểm tra đáp án và thêm icon tương ứng vào mảng điểm số
      if (userPickedAnswer == correctAnswer) {
        scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
      } else {
        scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
      }

      // 2. Chuyển sang câu hỏi tiếp theo hoặc reset game nếu đã hết câu hỏi
      if (questionNumber < questionBank.length - 1) {
        questionNumber++;
      } else {
        // Reset trạng thái về ban đầu
        questionNumber = 0;
        scoreKeeper.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch, // Ép các nút bấm tràn hết chiều ngang
      children: [
        // Phần hiển thị câu hỏi (Sử dụng Expanded với flex: 5 để chiếm nhiều không gian nhất)
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBank[questionNumber].questionText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        // Nút ĐÚNG
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green, // Màu xanh cho đáp án Đúng
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              onPressed: () {
                checkAnswer(true);
              },
              child: const Text(
                'Đúng',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
        ),

        // Nút SAI
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red, // Màu đỏ cho đáp án Sai
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              onPressed: () {
                checkAnswer(false);
              },
              child: const Text(
                'Sai',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
        ),

        // Hàng chứa các biểu tượng điểm số (Tick / Cross)
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

// 3. Khai báo Lớp (Class) mô phỏng cấu trúc dữ liệu Câu hỏi
class Question {
  String questionText;
  bool questionAnswer;

  // Constructor sử dụng named parameters
  Question({required String q, required bool a})
      : questionText = q,
        questionAnswer = a;
}