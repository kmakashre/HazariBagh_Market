import 'package:flutter/material.dart';

class SupportProvider extends ChangeNotifier {
  int selectedTab = 0;

  void changeTab(int index) {
    selectedTab = index;
    notifyListeners();
  }
}
