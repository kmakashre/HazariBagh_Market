import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Model/property_model.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../widgets/top_header.dart';
import '../../../provider/property_provider.dart';
import 'property_view_details_screen.dart';

class PropertyListingScreen extends StatelessWidget {
  const PropertyListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PropertyProvider>();
    final loc = AppLocalizations.of(context);

    /// 📱 MediaQuery
    final mq = MediaQuery.of(context);
    final w = mq.size.width;
    final h = mq.size.height;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    /// 📐 Responsive Grid
    final bool isMobile = w < 600;
    final bool isTablet = w >= 600 && w < 900;

    final int crossAxisCount = isMobile
        ? 2
        : isTablet
        ? 3
        : 4;
    final double childRatio = isMobile ? 0.62 : 0.55;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          const TopHeader(),

          /// 🔙 Back Bar
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.04,
              vertical: h * 0.015,
            ),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Row(
                children: [
                  Icon(Icons.arrow_back, color: theme.colorScheme.primary),
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

          /// ✅ MAIN BODY
          Expanded(
            child: CustomScrollView(
              slivers: [
                /// 🔷 Header
                SliverToBoxAdapter(
                  child: ClipRect(
                    // ✅ overflow cut
                    child: IntrinsicHeight(
                      // ✅ force correct height
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.all(w * 0.02),
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
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    loc.getByKey('propertyListingTitle'),
                                    style: theme.textTheme.titleLarge!.copyWith(
                                      color: theme.colorScheme.onPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    loc.getByKey('propertyListingSubtitle'),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodySmall!.copyWith(
                                      color: theme.colorScheme.onPrimary
                                          .withOpacity(0.75),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                /// 🧰 FIXED FILTER CARD
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _FilterHeaderDelegate(
                    height: h * 0.26,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: w * 0.04,
                        vertical: h * 0.01,
                      ),
                      color: theme.scaffoldBackgroundColor,
                      child: Container(
                        padding: EdgeInsets.all(w * 0.025),
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: isDark
                              ? []
                              : const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 8,
                                  ),
                                ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.tune, size: 18),
                                const SizedBox(width: 6),
                                Text(
                                  loc.getByKey('filter'),
                                  style: theme.textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            _sectionTitle(
                              context,
                              loc.getByKey('propertyType'),
                            ),
                            const SizedBox(height: 6),

                            Wrap(
                              spacing: 10,
                              runSpacing: 8,
                              children: ['all', 'For Rent', 'For Sale'].map((
                                type,
                              ) {
                                return _filterChip(
                                  context: context,
                                  title: loc.getByKey(type),
                                  selected: provider.selectedType == type,
                                  onTap: () => provider.setType(type),
                                );
                              }).toList(),
                            ),

                            const SizedBox(height: 10),

                            _sectionTitle(context, loc.getByKey('category')),
                            const SizedBox(height: 6),

                            Wrap(
                              spacing: 10,
                              runSpacing: 8,
                              children: ['all', 'Flats', 'Home', 'PG', 'Land']
                                  .map((cat) {
                                    return _filterChip(
                                      context: context,
                                      title: loc.getByKey(cat),
                                      selected:
                                          provider.selectedCategory == cat,
                                      onTap: () => provider.setCategory(cat),
                                    );
                                  })
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                /// 🏘️ PROPERTY GRID
                SliverPadding(
                  padding: EdgeInsets.all(w * 0.04),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return _propertyCard(
                        context,
                        provider.filteredProperties[index],
                        loc,
                        w,
                        h,
                      );
                    }, childCount: provider.filteredProperties.length),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: w * 0.04,
                      mainAxisSpacing: w * 0.04,
                      childAspectRatio: childRatio,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 🧷 Sticky Header Delegate
class _FilterHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  _FilterHeaderDelegate({required this.height, required this.child});

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(elevation: overlapsContent ? 4 : 0, child: child);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

/// 🏠 Property Card
Widget _propertyCard(
  BuildContext context,
  PropertyModel property,
  AppLocalizations loc,
  double w,
  double h,
) {
  final theme = Theme.of(context);

  return InkWell(
    borderRadius: BorderRadius.circular(16),
    onTap: () {
      context.read<PropertyProvider>().setSelectedProperty(property);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PropertyDetailsScreen()),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              property.image,
              height: h * 0.18,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(w * 0.03),
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
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      _infoRow(context, Icons.location_on, property.location),
                      _infoRow(context, Icons.square_foot, property.area),
                      _infoRow(context, Icons.bed, property.bedInfo),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: h * 0.045,
                    child: ElevatedButton(
                      onPressed: () {},
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

/// 🔘 Filter Chip
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
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
      decoration: BoxDecoration(
        color: selected
            ? theme.colorScheme.primary
            : theme.dividerColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: theme.textTheme.bodySmall!.copyWith(
          color: selected
              ? theme.colorScheme.onPrimary
              : theme.textTheme.bodyMedium!.color,
        ),
      ),
    ),
  );
}

Widget _infoRow(BuildContext context, IconData icon, String text) {
  final theme = Theme.of(context);
  return Row(
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
  );
}

Widget _sectionTitle(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(
      context,
    ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
  );
}
