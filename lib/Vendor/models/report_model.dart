import 'package:flutter/material.dart';

class ReportModel {
  final String title;
  final String value;
  final IconData icon;
  final int colorCode;

  ReportModel({
    required this.title,
    required this.value,
    required this.icon,
    required this.colorCode,
  });
}
