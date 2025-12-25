import 'package:flutter/material.dart';
import 'bank_details_screen.dart';

class VendorAccountActivationScreen extends StatefulWidget {
  const VendorAccountActivationScreen({super.key});

  @override
  State<VendorAccountActivationScreen> createState() =>
      _VendorAccountActivationScreenState();
}

class _VendorAccountActivationScreenState
    extends State<VendorAccountActivationScreen> {
  bool bankDone = false;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Activate Account",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          /// 🔵 TOP INFO
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: primary,
            child: Row(
              children: const [
                Icon(Icons.account_balance,
                    color: Colors.white, size: 34),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Please add your bank details to activate your account",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// 🏦 BANK DETAILS STEP
          _stepTile(
            title: "Bank Details",
            subtitle: "Account number, IFSC & bank name",
            icon: Icons.account_balance,
            primary: primary,
            isCompleted: bankDone,
            isEnabled: true,
            onTap: () async {
              final done = await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder: (_) => const BankDetailsScreen(),
                ),
              );

              if (done == true) {
                setState(() => bankDone = true);
              }
            },
          ),

          const Spacer(),

          /// 🚀 ACTIVATE BUTTON
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: bankDone
                    ? () {
                  Navigator.pushReplacementNamed(
                    context,
                    "/vendorDashboard",
                  );
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Activate Account",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 STEP TILE
  Widget _stepTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isCompleted,
    required bool isEnabled,
    required Color primary,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCompleted
              ? Colors.green
              : primary.withOpacity(0.3),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: isCompleted
              ? Colors.green.withOpacity(0.15)
              : primary.withOpacity(0.12),
          child: Icon(
            icon,
            color: isCompleted ? Colors.green : primary,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: isCompleted
            ? const Icon(Icons.check_circle, color: Colors.green)
            : const Icon(Icons.arrow_forward_ios, size: 18),
      ),
    );
  }
}
