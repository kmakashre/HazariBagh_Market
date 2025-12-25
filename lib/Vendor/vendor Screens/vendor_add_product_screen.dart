import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../VendorProvider/product_provider.dart';
import '../models/product_model.dart';

class VendorAddProductScreen extends StatefulWidget {
  const VendorAddProductScreen({super.key});

  @override
  State<VendorAddProductScreen> createState() =>
      _VendorAddProductScreenState();
}

class _VendorAddProductScreenState extends State<VendorAddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final shopCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final stockCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  String selectedCategory = "Select Category";
  File? productImage;

  final ImagePicker picker = ImagePicker();

  final categories = [
    "Grocery",
    "Restaurant",
    "Electronics",
    "Clothing",
    "Services",
  ];

  /// 🔐 Permission + Image Picker
  Future<void> pickImage(ImageSource source) async {
    try {
      if (source == ImageSource.camera) {
        final status = await Permission.camera.request();
        if (!status.isGranted) return;
      }

      final XFile? image = await picker.pickImage(
        source: source,
        imageQuality: 70,
      );

      if (image != null) {
        setState(() {
          productImage = File(image.path);
        });
      }
    } catch (e) {
      debugPrint("Image pick error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final provider = context.read<ProductProvider>();

    return Scaffold(

      body: SingleChildScrollView(
        padding: EdgeInsets.all(w * 0.05),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              /// 📸 IMAGE PICKER
              GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (_) => _imagePickerSheet(),
                ),
                child: Container(
                  height: 170,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300),
                    image: productImage != null
                        ? DecorationImage(
                      image: FileImage(productImage!),
                      fit: BoxFit.cover,
                    )
                        : null,
                  ),
                  child: productImage == null
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_outlined,
                          size: 42, color: Colors.grey.shade600),
                      const SizedBox(height: 8),
                      Text(
                        "Add Product Image",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                      : Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit,
                          color: Colors.white, size: 18),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              _inputField(
                controller: shopCtrl,
                label: "Shop Name",
                icon: Icons.store,
              ),
              const SizedBox(height: 14),

              _inputField(
                controller: nameCtrl,
                label: "Product Name",
                icon: Icons.shopping_bag,
              ),
              const SizedBox(height: 14),

              _inputField(
                controller: priceCtrl,
                label: "Price (₹)",
                icon: Icons.currency_rupee,
                keyboard: TextInputType.number,
              ),
              const SizedBox(height: 14),

              _inputField(
                controller: stockCtrl,
                label: "Stock Quantity",
                icon: Icons.inventory,
                keyboard: TextInputType.number,
              ),
              const SizedBox(height: 14),

              DropdownButtonFormField<String>(
                value: selectedCategory,
                validator: (v) =>
                v == "Select Category" ? "Select category" : null,
                items: [
                  const DropdownMenuItem(
                    value: "Select Category",
                    child: Text("Select Category"),
                  ),
                  ...categories.map(
                        (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  ),
                ],
                onChanged: (v) => setState(() => selectedCategory = v!),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 14),

              TextFormField(
                controller: descCtrl,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 30),

              /// ✅ SUBMIT
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B73A8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;

                    if (productImage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please add product image"),
                        ),
                      );
                      return;
                    }

                    provider.addProduct(
                      ProductModel(
                        id: DateTime.now().toString(),
                        shopName: shopCtrl.text,
                        name: nameCtrl.text,
                        price: double.parse(priceCtrl.text),
                        stock: int.parse(stockCtrl.text),
                        category: selectedCategory,
                        description: descCtrl.text,
                        imagePath: productImage!.path,
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Product Added Successfully"),
                      ),
                    );

                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Add Product",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 📸 Bottom Sheet
  Widget _imagePickerSheet() {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text("Camera"),
            onTap: () {
              Navigator.pop(context);
              pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text("Gallery"),
            onTap: () {
              Navigator.pop(context);
              pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboard = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      validator: (v) => v!.isEmpty ? "Required" : null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
