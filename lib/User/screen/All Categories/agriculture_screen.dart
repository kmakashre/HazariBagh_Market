import 'package:flutter/material.dart';

class AgricultureScreen extends StatefulWidget {
  const AgricultureScreen({super.key});

  @override
  State<AgricultureScreen> createState() => _AgricultureScreenState();
}

class _AgricultureScreenState extends State<AgricultureScreen> {
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
