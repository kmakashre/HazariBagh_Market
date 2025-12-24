import 'package:flutter/material.dart';

class VendorOffersScreen extends StatelessWidget {
  const VendorOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Offers")),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          ListTile(
            title: Text("10% OFF"),
            subtitle: Text("Valid till 30 Sep"),
            trailing: Icon(Icons.edit),
          ),
          ListTile(
            title: Text("Buy 1 Get 1"),
            subtitle: Text("Weekend Offer"),
            trailing: Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}
