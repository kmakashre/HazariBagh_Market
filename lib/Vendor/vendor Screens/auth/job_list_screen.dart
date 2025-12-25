import 'package:flutter/material.dart';
class JobListScreen extends StatelessWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Jobs")),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (_, i) => Card(
          child: ListTile(
            title: Text("Delivery Boy"),
            subtitle: Text("₹12,000 / month"),
            trailing: const Icon(Icons.people),
            onTap: () {
              Navigator.pushNamed(context, "/applications");
            },
          ),
        ),
      ),
    );
  }
}
