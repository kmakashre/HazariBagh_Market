import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/User/screen/All%20Categories/property_filter_header.dart';
import '../../../l10n/app_localizations.dart';

class PropertyListingScreen extends StatefulWidget {
  const PropertyListingScreen({super.key});

  @override
  State<PropertyListingScreen> createState() => _PropertyListingScreenState();
}

class _PropertyListingScreenState extends State<PropertyListingScreen> {
  String propertyType = "All";
  String category = "All";

  /// 🏠 Property Screen Color
  static const Color propertyPrimaryColor = Color(0xFF8D6E63); // Brown shade

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context); // ✅ CORRECT PLACE

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            PropertyFilterHeader(
              title: loc.getByKey('propertyListingTitle'),
              subtitle: loc.getByKey('propertyListingSubtitle'),

              /// ✅ REQUIRED MODE
              mode: FilterMode.property,

              /// 🎨 Screen specific color
              primaryColor: propertyPrimaryColor,

              /// ✅ LOCAL STATE
              selectedType: propertyType,
              selectedCategory: category,

              /// 🔁 CALLBACKS
              onTypeChanged: (value) {
                setState(() => propertyType = value);
              },
              onCategoryChanged: (value) {
                setState(() => category = value);
              },

              /// 🏷️ FILTER OPTIONS
              types: const ["All", "For Rent", "For Sale"],
              categories: const ["All", "Flat", "House", "PG", "Land"],
            ),
          ],
        ),
      ),
    );
  }
}
