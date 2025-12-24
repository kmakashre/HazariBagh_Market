import 'package:flutter/material.dart';

class HomePurchaseScreen extends StatefulWidget {
  const HomePurchaseScreen({super.key});

  @override
  State<HomePurchaseScreen> createState() => _HomePurchaseScreenState();
}

class _HomePurchaseScreenState extends State<HomePurchaseScreen> {
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
