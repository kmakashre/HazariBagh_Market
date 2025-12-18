import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../colors/AppColors.dart';
import '../../../provider/property_provider.dart';
import '../../../Model/property_model.dart';
import '../../../widgets/top_header.dart';
import 'property_view_details_screen.dart';

class PropertyListingScreen extends StatelessWidget {
  const PropertyListingScreen({super.key});

  /// 📱 BREAKPOINTS
  static const double mobileBreakpoint = 600;
  static const double mobileAspectRatio = 0.62;
  static const double desktopAspectRatio = 0.55;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PropertyProvider>();
    final size = MediaQuery.of(context).size;
    final w = size.width;

    final bool isMobile = w < mobileBreakpoint;
    final int crossAxisCount = isMobile ? 2 : 3;
    final double childRatio =
    isMobile ? mobileAspectRatio : desktopAspectRatio;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔝 TOP HEADER
          const TopHeader(),

          /// 🔙 BACK BUTTON
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 10),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_back,
                      color: AppColors.propertyAccent),
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

          /// 🔽 SCROLLABLE CONTENT
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(w * 0.035),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🏠 HEADER CARD
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.propertyAccent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Property Listing",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Find flats, homes, PGs and land in Hazaribagh",
                          style:
                          TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  /// 🔍 FILTER BOX
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 6),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.tune, size: 18),
                            SizedBox(width: 6),
                            Text(
                              "Filter",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        const Text(
                          "Property Type",
                          style: TextStyle(
                              fontSize: 12, color: AppColors.textGrey),
                        ),
                        const SizedBox(height: 6),

                        Wrap(
                          spacing: 10,
                          children: ["All", "For Rent", "For Sale"].map((type) {
                            return _filterChip(
                              title: type,
                              selected: provider.selectedType == type,
                              onTap: () => provider.setType(type),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 14),

                        const Text(
                          "Category",
                          style: TextStyle(
                              fontSize: 12, color: AppColors.textGrey),
                        ),
                        const SizedBox(height: 6),

                        Wrap(
                          spacing: 10,
                          runSpacing: 8,
                          children:
                          ["All", "Flats", "Home", "PG", "Land"].map((cat) {
                            return _filterChip(
                              title: cat,
                              selected: provider.selectedCategory == cat,
                              onTap: () => provider.setCategory(cat),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// ⚠ IMPORTANT NOTE
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.yellowNote,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Important: Always verify property details and documents before making any payment.",
                      style: TextStyle(fontSize: 11),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// 🏘 PROPERTY GRID
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.filteredProperties.length,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: childRatio,
                    ),
                    itemBuilder: (context, index) {
                      return _propertyCard(
                        context,
                        provider.filteredProperties[index],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🏠 PROPERTY CARD
  Widget _propertyCard(BuildContext context, PropertyModel property) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        context
            .read<PropertyProvider>()
            .setSelectedProperty(property);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const PropertyDetailsScreen(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 6),
          ],
        ),
        child: Column(
          children: [
            /// IMAGE
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    property.image,
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 6,
                  child: _tag(
                    property.type,
                    property.type == "For Rent"
                        ? Colors.blue
                        : AppColors.success,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: _tag("Verified", AppColors.success),
                ),
              ],
            ),

            /// CONTENT
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 8, 14, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          property.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 6),
                        _infoRow(Icons.location_on, property.location),
                        _infoRow(Icons.square_foot, property.area),
                        _infoRow(Icons.bed, property.bedInfo),
                      ],
                    ),

                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                property.price,
                                style: const TextStyle(
                                  color: AppColors.success,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            _ownerTag(),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          height: 32,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              AppColors.propertyAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            onPressed: () {
                              context
                                  .read<PropertyProvider>()
                                  .setSelectedProperty(property);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                  const PropertyDetailsScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "View Details",
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 SMALL WIDGETS
  Widget _filterChip({
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.propertyAccent
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color:
            selected ? AppColors.white : AppColors.black,
          ),
        ),
      ),
    );
  }

  Widget _tag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: [
          Icon(icon, size: 13, color: AppColors.textGrey),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ownerTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Text(
        "Owner",
        style: TextStyle(
          fontSize: 10,
          color: AppColors.success,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
