import 'package:flutter/material.dart';
import '../models/order_model.dart';

class OrderProvider extends ChangeNotifier {
  final List<OrderModel> _orders = [
    OrderModel(
      customer: "Rahul Sharma",
      orderId: "#ORD1023",
      amount: "₹450",
      status: "Pending",
    ),
    OrderModel(
      customer: "Amit Verma",
      orderId: "#ORD1024",
      amount: "₹320",
      status: "Pending",
    ),
    OrderModel(
      customer: "Neha Singh",
      orderId: "#ORD1025",
      amount: "₹560",
      status: "Delivered",
    ),
  ];

  List<OrderModel> get orders => _orders;

  /// ✅ Accept Order
  void acceptOrder(int index) {
    _orders[index].status = "Delivered";
    notifyListeners();
  }

  /// ❌ Reject Order
  void rejectOrder(int index) {
    _orders[index].status = "Cancelled";
    notifyListeners();
  }
}
