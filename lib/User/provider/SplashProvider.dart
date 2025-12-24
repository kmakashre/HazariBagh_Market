import 'package:flutter/material.dart';

class SplashProvider extends ChangeNotifier {
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  Future<void> initializeApp() async {
    await Future.delayed(const Duration(seconds: 3));
    _isLoaded = true;
    notifyListeners();
  }
}
