import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Model/property_model.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../widgets/top_header.dart';
import '../../../provider/property_provider.dart';
import 'property_view_details_screen.dart';

class PropertyListingScreen extends StatelessWidget {
  const PropertyListingScreen({super.key});

  static const double mobileBreakpoint = 600.0;
  static const double mobileAspectRatio = 0.62;
  static const double desktopAspectRatio = 0.55;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PropertyProvider>();
    final loc = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;
    final w = size.width;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bool isMobile = w < mobileBreakpoint;
    final int crossAxisCount = isMobile ? 2 : 3;
    final double childRatio =
    isMobile ? mobileAspectRatio : desktopAspectRatio;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          const TopHeader(),

          /// 🔙 BACK BAR
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 12),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => Navigator.pop(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.arrow_back,
                      color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    loc.getByKey('back'),
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.04,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// 🔷 PAGE HEADER
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.primary.withOpacity(0.85),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.getByKey('propertyListingTitle'),
                          style: theme.textTheme.titleLarge!.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          loc.getByKey('propertyListingSubtitle'),
                          style: theme.textTheme.bodySmall!.copyWith(
                            color: theme.colorScheme.onPrimary.withOpacity(0.75),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// 🧰 FILTER CARD
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: isDark
                          ? []
                          : const [
                        BoxShadow(
                            color: Colors.black12, blurRadius: 8),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.tune,
                                size: 18,
                                color: theme.iconTheme.color),
                            const SizedBox(width: 8),
                            Text(
                              loc.getByKey('filter'),
                              style: theme.textTheme.titleSmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        _sectionTitle(context, loc.getByKey('propertyType')),
                        const SizedBox(height: 8),

                        Wrap(
                          spacing: 10,
                          runSpacing: 8,
                          children: ['all', 'For Rent', 'For Sale'].map((type) {
                            return _filterChip(
                              context: context,
                              title: loc.getByKey(type),
                              selected: provider.selectedType == type,
                              onTap: () => provider.setType(type),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 16),

                        _sectionTitle(context, loc.getByKey('category')),
                        const SizedBox(height: 8),

                        Wrap(
                          spacing: 10,
                          runSpacing: 8,
                          children:
                          ['all', 'Flats', 'Home', 'PG', 'Land'].map((cat) {
                            return _filterChip(
                              context: context,
                              title: loc.getByKey(cat),
                              selected:
                              provider.selectedCategory == cat,
                              onTap: () => provider.setCategory(cat),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 🏘️ PROPERTY GRID
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.filteredProperties.length,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: childRatio,
                    ),
                    itemBuilder: (context, index) {
                      return _propertyCard(
                        context,
                        provider.filteredProperties[index],
                        loc,
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
  Widget _propertyCard(
      BuildContext context, PropertyModel property, AppLocalizations loc) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        context.read<PropertyProvider>().setSelectedProperty(property);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const PropertyDetailsScreen(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isDark
              ? []
              : const [
            BoxShadow(color: Colors.black12, blurRadius: 8),
          ],
        ),
        child: Column(
          children: [
            /// IMAGE
            ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                property.image,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          property.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        _infoRow(context, Icons.location_on,
                            property.location),
                        _infoRow(context, Icons.square_foot,
                            property.area),
                        _infoRow(context, Icons.bed,
                            property.bedInfo),
                      ],
                    ),

                    SizedBox(
                      width: double.infinity,
                      height: 34,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
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
                        child: Text(
                          loc.getByKey('viewDetails'),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
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

  /// 🔘 FILTER CHIP
  Widget _filterChip({
    required BuildContext context,
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:
        const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
        decoration: BoxDecoration(
          color: selected
              ? theme.colorScheme.primary
              : theme.dividerColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: theme.textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w500,
            color: selected
                ? theme.colorScheme.onPrimary
                : theme.textTheme.bodyMedium!.color,
          ),
        ),
      ),
    );
  }

  Widget _infoRow(
      BuildContext context, IconData icon, String text) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: [
          Icon(icon, size: 14, color: theme.iconTheme.color),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .bodySmall!
          .copyWith(fontWeight: FontWeight.w600),
    );
  }
}
