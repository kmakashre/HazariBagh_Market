import 'package:flutter/material.dart';

enum FilterMode { jobService, property }

class PropertyFilterHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  final String selectedType;
  final String selectedCategory;

  final Function(String) onTypeChanged;
  final Function(String) onCategoryChanged;

  final Color primaryColor;
  final FilterMode mode;

  final List<String> types;
  final List<String> categories;

  const PropertyFilterHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.selectedType,
    required this.selectedCategory,
    required this.onTypeChanged,
    required this.onCategoryChanged,
    required this.primaryColor,
    required this.mode,
    required this.types,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// 🔷 HEADER
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        /// 🎯 FILTER CARD
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 8),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.tune, color: primaryColor),
                  const SizedBox(width: 6),
                  const Text(
                    "Filter",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// 🔁 JOB / PROPERTY TYPE
              Text(
                mode == FilterMode.jobService
                    ? "Filter By Category"
                    : "Property Type",
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: types.map((e) {
                  return _chip(
                    label: e,
                    selected: selectedType == e,
                    onTap: () => onTypeChanged(e),
                  );
                }).toList(),
              ),

              const SizedBox(height: 14),

              /// 📂 CATEGORY
              const Text(
                "Category",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: categories.map((e) {
                  return _chip(
                    label: e,
                    selected: selectedCategory == e,
                    onTap: () => onCategoryChanged(e),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _chip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? primaryColor : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
