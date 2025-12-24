import 'package:flutter/material.dart';

import '../../../../colors/AppColors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../widgets/top_header.dart';


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
    final loc = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF0F172A) : AppColors.bgLight;
    final cardColor = isDark ? const Color(0xFF1E293B) : AppColors.white;
    final textColor = isDark ? Colors.white : AppColors.textDark;
    final subTextColor =
    isDark ? Colors.grey.shade400 : AppColors.textLight;
    final borderColor =
    isDark ? Colors.grey.shade600 : AppColors.border;

    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          const TopHeader(),

          /// 🔙 BACK HEADER
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
                  Text(
                    loc.back,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.propertyAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 📄 FORM
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: w * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputField(
                    title: loc.getByKey('fullName'),
                    hintText: loc.getByKey('fullNameHint'),
                    keyboardType: TextInputType.name,
                    maxLines: 1,
                    cardColor: cardColor,
                    textColor: textColor,
                    borderColor: borderColor,
                  ),
                  SizedBox(height: w * 0.05),

                  _buildInputField(
                    title: loc.getByKey('phoneNumber'),
                    hintText: '+91-XXXXXXXXXX',
                    keyboardType: TextInputType.phone,
                    maxLines: 1,
                    cardColor: cardColor,
                    textColor: textColor,
                    borderColor: borderColor,
                  ),
                  SizedBox(height: w * 0.05),

                  _buildInputField(
                    title: loc.description,
                    hintText: loc.descriptionHint,
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                    cardColor: cardColor,
                    textColor: textColor,
                    borderColor: borderColor,
                  ),
                  SizedBox(height: w * 0.05),

                  _buildPropertyContextBox(
                    context,
                    w,
                    cardColor,
                    textColor,
                    subTextColor,
                  ),
                  SizedBox(height: w * 0.1),

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
                        debugPrint("Enquiry Sent for $propertyTitle");
                      },
                      child: Text(
                        loc.getByKey('enquireNow'),
                        style: const TextStyle(
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
    required Color cardColor,
    required Color textColor,
    required Color borderColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontStyle: FontStyle.italic,
            ),
            filled: true,
            fillColor: cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: borderColor),
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

  /// 🏠 PROPERTY INFO
  Widget _buildPropertyContextBox(
      BuildContext context,
      double w,
      Color cardColor,
      Color textColor,
      Color subTextColor,
      ) {
    final loc = AppLocalizations.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${loc.propertyListing}: $propertyTitle",
            style: TextStyle(
              fontSize: w * 0.04,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "${loc.contactInformation}: $contactName",
            style: TextStyle(
              fontSize: w * 0.035,
              color: subTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
