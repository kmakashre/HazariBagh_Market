import 'package:flutter/material.dart';
class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({super.key});

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  final accountController = TextEditingController();
  final ifscController = TextEditingController();
  final bankNameController = TextEditingController();
  final holderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bank Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _field("Account Holder Name", holderController),
            _field("Bank Name", bankNameController),
            _field("Account Number", accountController,
                keyboard: TextInputType.number),
            _field("IFSC Code", ifscController),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (accountController.text.isEmpty ||
                      ifscController.text.isEmpty ||
                      bankNameController.text.isEmpty ||
                      holderController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                          Text("Please fill all bank details")),
                    );
                    return;
                  }

                  Navigator.pop(context, true); // ✅ BANK DONE
                },
                child: const Text("Save Bank Details"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController controller,
      {TextInputType keyboard = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText: label,
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
