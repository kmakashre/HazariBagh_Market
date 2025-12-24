import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  List<Map<String, dynamic>> messages = [
    {
      "msg": "Hello! How can I help you today?",
      "time": "10:30 AM",
      "isMe": false,
    }
  ];

  void sendMessage(String message) {
    messages.add({
      "msg": message,
      "time": "${DateTime.now().hour}:${DateTime.now().minute}",
      "isMe": true,
    });

    notifyListeners();
  }
}
