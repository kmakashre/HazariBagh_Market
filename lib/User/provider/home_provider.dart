import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  int bannerIndex = 0;

  void changeBanner(int index) {
    bannerIndex = index;
    notifyListeners();
  }
}
