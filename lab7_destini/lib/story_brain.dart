import 'story.dart';

class StoryBrain {
  // Biến theo dõi vị trí hiện tại trong câu chuyện
  int _storyNumber = 0;

  // Kho dữ liệu câu chuyện (Private)
  final List<Story> _storyData = [
    Story(
        storyTitle: 'Bạn xe bị hỏng lốp trên đường vắng. Một chiếc xe tải cũ kỹ dừng lại giúp đỡ.',
        choice1: 'Xin đi nhờ.',
        choice2: 'Chỉ hỏi mượn điện thoại.'),
    Story(
        storyTitle: 'Tài xế đưa điện thoại, nhưng không có sóng mạng.',
        choice1: 'Cố gắng đi bộ tìm sóng.',
        choice2: 'Chấp nhận lên xe đi nhờ.'),
    Story(
        storyTitle: 'Bạn lên xe. Tài xế hỏi bạn có thích nghe nhạc rock không.',
        choice1: 'Có, bật nhạc lên.',
        choice2: 'Không, tôi thích yên tĩnh.'),
    Story(
        storyTitle: 'Bạn đi bộ và tìm được đồn cảnh sát. Bạn đã an toàn!',
        choice1: 'Bắt đầu lại',
        choice2: ''),
    Story(
        storyTitle: 'Tài xế tức giận vì bạn không thích nhạc. Anh ta đuổi bạn xuống xe ở giữa rừng.',
        choice1: 'Bắt đầu lại',
        choice2: ''),
    Story(
        storyTitle: 'Nhạc nổi lên, hai người hát hò vui vẻ cho đến khi về thành phố an toàn.',
        choice1: 'Bắt đầu lại',
        choice2: '')
  ];

  String getStory() {
    return _storyData[_storyNumber].storyTitle;
  }

  String getChoice1() {
    return _storyData[_storyNumber].choice1;
  }

  String getChoice2() {
    return _storyData[_storyNumber].choice2;
  }

  void restart() {
    _storyNumber = 0;
  }

  // Logic điều hướng nhánh rẽ dựa trên lựa chọn 1 hoặc 2
  void nextStory(int choiceNumber) {
    if (choiceNumber == 1 && _storyNumber == 0) {
      _storyNumber = 2;
    } else if (choiceNumber == 2 && _storyNumber == 0) {
      _storyNumber = 1;
    } else if (choiceNumber == 1 && _storyNumber == 1) {
      _storyNumber = 3;
    } else if (choiceNumber == 2 && _storyNumber == 1) {
      _storyNumber = 2;
    } else if (choiceNumber == 1 && _storyNumber == 2) {
      _storyNumber = 5;
    } else if (choiceNumber == 2 && _storyNumber == 2) {
      _storyNumber = 4;
    }
    // Nếu storyNumber đang ở 3, 4, 5 (Đoạn kết), bất kỳ nút nào bấm cũng sẽ restart
    else if (_storyNumber == 3 || _storyNumber == 4 || _storyNumber == 5) {
      restart();
    }
  }

  // Hàm kiểm tra xem có nên hiển thị nút bấm thứ 2 hay không
  bool buttonShouldBeVisible() {
    // Chỉ hiện nút số 2 ở các nhánh cốt truyện đầu tiên
    if (_storyNumber == 0 || _storyNumber == 1 || _storyNumber == 2) {
      return true;
    } else {
      // Các màn hình kết thúc (3, 4, 5) sẽ trả về false để ẩn nút số 2 đi
      return false;
    }
  }
}