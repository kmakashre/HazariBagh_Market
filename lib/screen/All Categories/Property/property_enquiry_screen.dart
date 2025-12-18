import 'package:flutter/material.dart';
import '../../../colors/AppColors.dart';
import '../../../widgets/top_header.dart';

class PropertyEnquiryScreen extends StatelessWidget {
  final String propertyTitle;
  final String contactName;

  const PropertyEnquiryScreen({
    super.key,
    required this.propertyTitle,
    required this.contactName,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Column(
        children: [
          /// 🔝 TOP HEADER
          const TopHeader(),

          /// 🔙 BACK BUTTON
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => Navigator.pop(context),
              child: Row(
                children: [
                  const Icon(
                    Icons.arrow_back,
                    color: AppColors.propertyAccent,
                  ),
                  SizedBox(width: w * 0.02),
                  const Text(
                    "Back",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.propertyAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 📄 FORM CONTENT
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                w * 0.05,
                0,
                w * 0.05,
                w * 0.08,
              ),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputField(
                    title: "Your Name",
                    hintText: "Enter your name",
                    keyboardType: TextInputType.name,
                    maxLines: 1,
                  ),
                  SizedBox(height: h * 0.025),

                  _buildInputField(
                    title: "Phone Number",
                    hintText: "+91 9876543210",
                    keyboardType: TextInputType.phone,
                    maxLines: 1,
                  ),
                  SizedBox(height: h * 0.025),

                  _buildInputField(
                    title: "Message",
                    hintText: "I'm interested in this property",
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                  ),
                  SizedBox(height: h * 0.025),

                  /// 🏠 PROPERTY CONTEXT
                  _buildPropertyContextBox(w),
                  SizedBox(height: h * 0.05),

                  /// 🚀 SEND BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.propertyAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        debugPrint(
                            "Enquiry Sent for $propertyTitle to $contactName");
                      },
                      child: const Text(
                        "Send Enquiry",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 INPUT FIELD
  Widget _buildInputField({
    required String title,
    required String hintText,
    required TextInputType keyboardType,
    required int maxLines,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: AppColors.textGrey,
              fontStyle: FontStyle.italic,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
              const BorderSide(color: AppColors.border, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
              const BorderSide(color: AppColors.border, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
              const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  /// 🔹 PROPERTY CONTEXT BOX
  Widget _buildPropertyContextBox(double w) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Property: $propertyTitle",
            style: TextStyle(
              fontSize: w * 0.04,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Contact: $contactName",
            style: TextStyle(
              fontSize: w * 0.035,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}
