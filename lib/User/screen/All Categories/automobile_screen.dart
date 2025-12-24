import 'package:flutter/material.dart';

class AutomobileScreen extends StatefulWidget {
  const AutomobileScreen({super.key});

  @override
  State<AutomobileScreen> createState() => _AutomobileScreenState();
}

class _AutomobileScreenState extends State<AutomobileScreen> {
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
