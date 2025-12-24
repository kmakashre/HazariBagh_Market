import 'package:flutter/material.dart';

class StatusRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool active;

  const StatusRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(
            icon,
            color: active ? Colors.green : Colors.grey,
            size: w * 0.06,
          ),
          SizedBox(width: w * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: w * 0.038,
                        fontWeight: FontWeight.bold)),
                Text(subtitle,
                    style: TextStyle(
                        fontSize: w * 0.032, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
