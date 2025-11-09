import 'dart:async';
import 'dart:math';

class ApiService {
  static Future<String> sendMessage(String message) async {
    // Giả lập thời gian "AI đang trả lời"
    await Future.delayed(const Duration(seconds: 1));

    // Danh sách phản hồi mẫu
    final responses = [
      "Xin chào! Tôi là AI demo. Bạn cần tôi giúp gì?",
      "Đây là câu trả lời giả lập cho: \"$message\"",
      "Cảm ơn bạn đã nhắn tin! Hệ thống AI đang trong chế độ thử nghiệm.",
      "Tôi không chắc lắm, nhưng có vẻ như bạn đang muốn hỏi điều gì thú vị!",
      "Hãy tưởng tượng đây là câu trả lời từ AI nhé 🧠"
    ];

    // Trả ngẫu nhiên 1 câu
    return responses[Random().nextInt(responses.length)];
  }
}