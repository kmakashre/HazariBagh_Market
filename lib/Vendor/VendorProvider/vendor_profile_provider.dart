import 'dart:io';
import 'package:flutter/material.dart';

class VendorProfileProvider with ChangeNotifier {
  String shopName = "Ramesh General Store";
  String phone = "9876543210";
  File? profileImage;

  void updateProfile({
    String? shop,
    String? phoneNo,
    File? image,
  }) {
    if (shop != null) shopName = shop;
    if (phoneNo != null) phone = phoneNo;
    if (image != null) profileImage = image;
    notifyListeners();
  }
}
