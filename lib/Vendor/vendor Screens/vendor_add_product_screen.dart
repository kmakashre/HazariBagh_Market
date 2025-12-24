import 'package:flutter/material.dart';

class VendorAddProductScreen extends StatefulWidget {
  const VendorAddProductScreen({super.key});

  @override
  State<VendorAddProductScreen> createState() =>
      _VendorAddProductScreenState();
}

class _VendorAddProductScreenState
    extends State<VendorAddProductScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController priceCtrl = TextEditingController();
  final TextEditingController stockCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();

  String selectedCategory = "Select Category";

  final List<String> categories = [
    "Grocery",
    "Restaurant",
    "Electronics",
    "Clothing",
    "Services",
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      padding: EdgeInsets.all(w * 0.05),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🧾 TITLE
            Text(
              "Add New Product",
              style: TextStyle(
                fontSize: w * 0.055,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            /// 🖼 IMAGE PICKER (UI ONLY)
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo, size: 36),
                  SizedBox(height: 6),
                  Text("Add Product Image"),
                ],
              ),
            ),

            const SizedBox(height: 20),

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

            /// 📂 CATEGORY
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCategory,
                  isExpanded: true,
                  items: [
                    const DropdownMenuItem(
                      value: "Select Category",
                      child: Text("Select Category"),
                    ),
                    ...categories.map(
                          (cat) => DropdownMenuItem(
                        value: cat,
                        child: Text(cat),
                      ),
                    )
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 14),

            /// 📝 DESCRIPTION
            TextFormField(
              controller: descCtrl,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Description",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// ✅ SUBMIT
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B73A8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Product Added Successfully"),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Add Product",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
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
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
