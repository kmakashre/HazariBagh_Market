import 'package:flutter/material.dart';

class PlotScreen extends StatefulWidget {
  const PlotScreen({super.key});

  @override
  State<PlotScreen> createState() => _PlotScreenState();
}

class _PlotScreenState extends State<PlotScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: const Center(
        child: Text(
          "Data Not Found",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

}
