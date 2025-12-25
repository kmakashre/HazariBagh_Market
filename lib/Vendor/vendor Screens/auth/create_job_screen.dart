import 'package:flutter/material.dart';

class CreateJobScreen extends StatelessWidget {
  const CreateJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Job")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          TextField(decoration: InputDecoration(labelText: "Job Title")),
          TextField(decoration: InputDecoration(labelText: "Category")),
          TextField(decoration: InputDecoration(labelText: "Location")),
          TextField(decoration: InputDecoration(labelText: "Salary")),
          TextField(
            decoration: InputDecoration(labelText: "Job Description"),
            maxLines: 4,
          ),
          SizedBox(height: 20),
          ElevatedButton(onPressed: null, child: Text("Post Job")),
        ],
      ),
    );
  }
}
