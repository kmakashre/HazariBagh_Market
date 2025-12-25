import 'package:flutter/material.dart';

class ApplicantProfileScreen extends StatelessWidget {
  const ApplicantProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Applicant Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Name: Rahul Kumar", style: TextStyle(fontSize: 18)),
            Text("Age: 24"),
            Text("Experience: 2 Years"),
            Text("Location: Indore"),
            SizedBox(height: 20),
            ElevatedButton(onPressed: null, child: Text("Accept")),
            ElevatedButton(onPressed: null, child: Text("Reject")),
          ],
        ),
      ),
    );
  }
}
