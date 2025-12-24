import 'package:flutter/material.dart';

class WholesaleScreen extends StatefulWidget {
  const WholesaleScreen({super.key});

  @override
  State<WholesaleScreen> createState() => _WholesaleScreenState();
}

class _WholesaleScreenState extends State<WholesaleScreen> {
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
