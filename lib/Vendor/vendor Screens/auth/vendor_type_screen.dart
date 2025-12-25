import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/Vendor/vendor%20Screens/auth/vendor_activation_screen.dart';
import 'package:hazari_bagh_market/Vendor/vendor%20Screens/auth/vendor_kyc_screen.dart';
import 'package:image_picker/image_picker.dart';
import '../../vendorColors/AppColors.dart';

class VendorTypeScreen extends StatefulWidget {
  const VendorTypeScreen({super.key});

  @override
  State<VendorTypeScreen> createState() => _VendorTypeScreenState();
}

class _VendorTypeScreenState extends State<VendorTypeScreen> {
  final shopNameController = TextEditingController();
  final gstController = TextEditingController();
  final fssaiController = TextEditingController();
  final otherVendorController = TextEditingController();

  File? shopImage;
  final ImagePicker picker = ImagePicker();

  final List<String> vendorTypes = [
    'Grocery',
    'Restaurant',
    'Medical',
    'Clothing',
    'Electronics',
    'Bakery',
    'Other',
  ];

  List<String> selectedVendorTypes = [];
  String? customVendorType;

  // ---------------- UTILS ----------------
  void dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  // ---------------- IMAGE PICKER ----------------
  void showImagePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile =
    await picker.pickImage(source: source, imageQuality: 70);
    if (pickedFile != null) {
      setState(() => shopImage = File(pickedFile.path));
    }
  }

  // ---------------- INPUT STYLE ----------------
  InputDecoration inputStyle(String label, bool isDark) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor:
      isDark ? const Color(0xFF0F172A) : Colors.grey.shade100,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.darkBg : AppColors.lightBg;
    final textColor = isDark ? Colors.white : Colors.black87;

    return GestureDetector(
      onTap: dismissKeyboard,
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgColor,
          title: const Text("Vendor Details"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// SHOP NAME
                  TextField(
                    controller: shopNameController,
                    decoration: inputStyle("Shop Name", isDark),
                  ),

                  const SizedBox(height: 20),

                  /// VENDOR TYPES
                  const Text(
                    "Vendor Types",
                    style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 8,
                    children: vendorTypes.map((type) {
                      final isSelected =
                      selectedVendorTypes.contains(type);
                      return FilterChip(
                        label: Text(type),
                        selected: isSelected,
                        onSelected: (value) {
                          setState(() {
                            value
                                ? selectedVendorTypes.add(type)
                                : selectedVendorTypes.remove(type);
                          });
                        },
                      );
                    }).toList(),
                  ),

                  if (selectedVendorTypes.contains('Other')) ...[
                    const SizedBox(height: 12),
                    TextField(
                      controller: otherVendorController,
                      decoration:
                      inputStyle("Other Vendor Type", isDark),
                      onChanged: (v) => customVendorType = v,
                    ),
                  ],

                  const SizedBox(height: 20),

                  /// SHOP IMAGE
                  InkWell(
                    onTap: showImagePicker,
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey.shade200,
                        image: shopImage != null
                            ? DecorationImage(
                          image: FileImage(shopImage!),
                          fit: BoxFit.cover,
                        )
                            : null,
                      ),
                      child: shopImage == null
                          ? const Center(
                        child: Icon(Icons.add_a_photo),
                      )
                          : null,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// GST
                  TextField(
                    controller: gstController,
                    decoration: inputStyle("GST Number", isDark),
                  ),

                  const SizedBox(height: 12),

                  /// FSSAI
                  TextField(
                    controller: fssaiController,
                    decoration:
                    inputStyle("FSSAI License Number", isDark),
                  ),

                  const SizedBox(height: 28),

                  /// SAVE & CONTINUE
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        dismissKeyboard();

                        if (shopNameController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please enter shop name")),
                          );
                          return;
                        }

                        if (selectedVendorTypes.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please select vendor type")),
                          );
                          return;
                        }

                        if (selectedVendorTypes.contains('Other') &&
                            (customVendorType == null || customVendorType!.trim().isEmpty)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please enter other vendor type")),
                          );
                          return;
                        }

                        /// ✅ STEP COMPLETE
                        Navigator.pop(context, true);
                      },

                      child: const Text(
                        "Save & Continue",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
