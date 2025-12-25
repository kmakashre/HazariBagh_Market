import 'package:flutter/material.dart';
import 'kyc_form_screen.dart';

class VendorKYCScreen extends StatefulWidget {
  const VendorKYCScreen({super.key});

  @override
  State<VendorKYCScreen> createState() => _VendorKYCScreenState();
}

class _VendorKYCScreenState extends State<VendorKYCScreen> {
  String? aadhaarImage;
  String? panImage;
  String? bankImage;

  bool get isAllDone =>
      aadhaarImage != null && panImage != null && bankImage != null;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        title: const Text("Complete KYC"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _kycTile(
            title: "Aadhaar Card",
            icon: Icons.credit_card,
            imagePath: aadhaarImage,
            primary: primary,
            onTap: () async {
              final result = await _open(context, "Aadhaar Card");
              if (result != null) {
                setState(() => aadhaarImage = result);
              }
            },
          ),

          _kycTile(
            title: "PAN Card",
            icon: Icons.badge,
            imagePath: panImage,
            primary: primary,
            onTap: () async {
              final result = await _open(context, "PAN Card");
              if (result != null) {
                setState(() => panImage = result);
              }
            },
          ),

          _kycTile(
            title: "Bank Account",
            icon: Icons.account_balance,
            imagePath: bankImage,
            primary: primary,
            onTap: () async {
              final result = await _open(context, "Bank Account");
              if (result != null) {
                setState(() => bankImage = result);
              }
            },
          ),

          const SizedBox(height: 30),

          /// ✅ SAVE & CONTINUE
          SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isAllDone ? primary : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: isAllDone
                  ? () {
                /// 🔥 IMPORTANT FIX
                Navigator.pop(context, true);
              }
                  : () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                    Text("Please complete all KYC documents"),
                  ),
                );
              },
              child: const Text(
                "Save & Continue",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> _open(BuildContext context, String title) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => KYCFormScreen(title: title),
      ),
    );
  }

  Widget _kycTile({
    required String title,
    required IconData icon,
    required String? imagePath,
    required Color primary,
    required VoidCallback onTap,
  }) {
    final done = imagePath != null;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: done ? Colors.green : Colors.grey.shade300,
        ),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor:
          done ? Colors.green.shade100 : primary.withOpacity(0.12),
          child: Icon(icon, color: done ? Colors.green : primary),
        ),
        title: Text(title),
        subtitle: Text(
          done ? "Uploaded successfully" : "Tap to upload document",
          style: TextStyle(
            color: done ? Colors.green : Colors.grey,
          ),
        ),
        trailing: done
            ? const Icon(Icons.check_circle, color: Colors.green)
            : const Icon(Icons.arrow_forward_ios, size: 18),
      ),
    );
  }
}
