import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/Vendor/vendor Screens/auth/vendor_account_activation_screen.dart';
import 'package:hazari_bagh_market/Vendor/vendor Screens/auth/vendor_kyc_screen.dart';
import 'package:hazari_bagh_market/Vendor/vendor Screens/auth/vendor_type_screen.dart';

class VendorActivationScreen extends StatefulWidget {
  const VendorActivationScreen({super.key});

  @override
  State<VendorActivationScreen> createState() =>
      _VendorActivationScreenState();
}

class _VendorActivationScreenState extends State<VendorActivationScreen> {
  /// 🔐 STEP STATUS
  bool vendorTypeDone = false;
  bool aadhaarDone = false;
  bool bankDone = false;
  bool jobCreated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activate Account"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          /// 🔵 INFO BANNER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.blue,
            child: const Text(
              "Complete all steps to activate your vendor account",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                /// 1️⃣ VENDOR TYPE
                /// 1️⃣ VENDOR TYPE
                _stepTile(
                  title: "Vendor Type",
                  subtitle: "Select grocery, restaurant etc.",
                  icon: Icons.store,
                  isCompleted: vendorTypeDone,
                  isEnabled: true,
                  onTap: () async {
                    final result = await Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const VendorTypeScreen(),
                      ),
                    );

                    if (result == true) {
                      setState(() => vendorTypeDone = true);

                      // 🔥 AUTO OPEN AADHAAR SCREEN
                      final aadhaarResult = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VendorKYCScreen(),
                        ),
                      );

                      if (aadhaarResult == true) {
                        setState(() => aadhaarDone = true);
                      }
                    }
                  },
                ),


                /// 2️⃣ AADHAAR
                _stepTile(
                  title: "Aadhaar Card",
                  subtitle: "Upload Aadhaar details",
                  icon: Icons.credit_card,
                  isCompleted: aadhaarDone,
                  isEnabled: vendorTypeDone,
                  onTap: () async {
                    final result = await Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VendorKYCScreen(),
                      ),
                    );

                    if (result == true) {
                      setState(() => aadhaarDone = true);
                    }
                  },
                ),

                /// 3️⃣ BANK
                _stepTile(
                  title: "Bank Account",
                  subtitle: "Add bank details",
                  icon: Icons.account_balance,
                  isCompleted: bankDone,
                  isEnabled: aadhaarDone,
                  onTap: () async {
                    final result = await Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            VendorAccountActivationScreen(),
                      ),
                    );

                    if (result == true) {
                      setState(() => bankDone = true);
                    }
                  },
                ),

                const SizedBox(height: 12),
                _sectionTitle("Job Management"),

                /// 4️⃣ JOB CREATE
                _stepTile(
                  title: "Create Job",
                  subtitle: "Add job title, salary, location",
                  icon: Icons.work_outline,
                  isCompleted: jobCreated,
                  isEnabled: bankDone,
                  onTap: () async {
                    final result =
                    await _openDummyScreen(context, "Create Job");
                    if (result == true) {
                      setState(() => jobCreated = true);
                    }
                  },
                ),

                const SizedBox(height: 20),

                /// ✅ FINISH BUTTON
                if (vendorTypeDone &&
                    aadhaarDone &&
                    bankDone &&
                    jobCreated)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        "/vendorDashboard",
                      );
                    },
                    child: const Text("Go to Dashboard"),
                  ),
              ],
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
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        enabled: isEnabled,
        leading: CircleAvatar(
          backgroundColor: isCompleted
              ? Colors.green.withOpacity(0.15)
              : Colors.grey.shade200,
          child: Icon(
            icon,
            color: isCompleted ? Colors.green : Colors.grey,
          ),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: isCompleted
            ? const Icon(Icons.check_circle, color: Colors.green)
            : const Icon(Icons.lock_outline),
        onTap: isEnabled ? onTap : null,
      ),
    );
  }

  /// 🔹 SECTION TITLE
  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style:
        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// 🔹 TEMP SCREEN (REPLACE WITH REAL SCREEN)
  Future<bool?> _openDummyScreen(
      BuildContext context, String title) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DummyCompleteScreen(title: title),
      ),
    );
  }
}

/// 🧪 DUMMY SCREEN (REPLACE WITH REAL FORMS)
class DummyCompleteScreen extends StatelessWidget {
  final String title;
  const DummyCompleteScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context, true); // ✅ STEP COMPLETE
          },
          child: const Text("Complete & Go Back"),
        ),
      ),
    );
  }
}
