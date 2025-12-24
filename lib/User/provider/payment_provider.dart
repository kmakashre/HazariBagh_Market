import 'package:flutter/material.dart';

class PaymentProvider extends ChangeNotifier {
  int _selectedPayment = 0; // 0 = COD, 1 = UPI, 2 = CARD

  int get selectedPayment => _selectedPayment;

  void selectPayment(int value) {
    _selectedPayment = value;
    notifyListeners();
  }

  String getPaymentKey() {
    switch (_selectedPayment) {
      case 1:
        return 'upi';
      case 2:
        return 'card';
      default:
        return 'cod';
    }
  }
}
