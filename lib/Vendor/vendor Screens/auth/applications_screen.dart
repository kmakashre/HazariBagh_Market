import 'package:flutter/material.dart';

class ApplicationsScreen extends StatelessWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Applications")),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (_, i) => ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: Text("Applicant ${i + 1}"),
          subtitle: const Text("Delivery Executive"),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pushNamed(context, "/applicantProfile");
          },
        ),
      ),
    );
  }
}
