import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
// import 'package:shared_preferences/shared_preferences.dart';

class MessageProvider with ChangeNotifier {
  String _message = "Hello, Flutter!";
  bool _isLoading = false;

  String get message => _message;
  bool get isLoading => _isLoading;

  // MessageProvider() {
  //   loadMessage(); // โหลดข้อความจาก Local Storage เมื่อเริ่มต้น
  // }

  // Future<void> loadMessage() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   _message = prefs.getString('savedMessage') ?? "Hello, Flutter!";
  //   notifyListeners();
  // }

  // Future<void> saveMessage(String newMessage) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   print(prefs);

  //   await prefs.setString('savedMessage', newMessage);
  //   _message = newMessage;
  //   notifyListeners();
  // }

  Future<void> fetchMessage() async {
    _isLoading = true;
    notifyListeners();

    try {
      final random = Random();
      int num = random.nextInt(100);
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$num'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // await saveMessage(data['title']);
        _message = data['title'];
      } else {
        _message = "Failed to fetch message";
      }
    } catch (e) {
      _message = "Error: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateMessage(String newMessage) {
    _message = newMessage;
    notifyListeners(); // แจ้งให้ UI อัปเดตเมื่อข้อความเปลี่ยนแปลง
  }
}
