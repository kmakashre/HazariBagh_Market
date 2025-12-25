import 'package:flutter/material.dart';
import '../models/report_model.dart';

class VendorReportsProvider with ChangeNotifier {
  final List<ReportModel> _summaryCards = [
    ReportModel(
      title: "Total Sales",
      value: "₹52,340",
      icon: Icons.percent,
      colorCode: Colors.green.value,
    ),
    ReportModel(
      title: "Total Orders",
      value: "1,245",
      icon: Icons.shop,
      colorCode: Colors.blue.value,
    ),
    ReportModel(
      title: "Today Revenue",
      value: "₹1,280",
      icon: Icons.r_mobiledata,
      colorCode: Colors.orange.value,
    ),
    ReportModel(
      title: "Monthly Revenue",
      value: "₹18,900",
      icon: Icons.ac_unit,
      colorCode: Colors.purple.value,
    ),
  ];

  final Map<String, String> _salesSummary = {
    "Today Orders": "24",
    "Completed Orders": "1,180",
    "Cancelled Orders": "65",
  };

  List<ReportModel> get summaryCards => _summaryCards;
  Map<String, String> get salesSummary => _salesSummary;

  /// 🔄 Future API Call
  Future<void> fetchReports() async {
    // API integration later
    notifyListeners();
  }
}
