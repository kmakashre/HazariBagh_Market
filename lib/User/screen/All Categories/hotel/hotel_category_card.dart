import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Model/hotel_category_model.dart';
import '../../../../l10n/app_localizations.dart';
import 'hotel_product_list_screen.dart';

class HotelCategoryCard extends StatelessWidget {
  final HotelCategoryModel category;
  final double width;

  const HotelCategoryCard({
    super.key,
    required this.category,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    /// 🎨 THEME
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HotelProductListScreen(
              /// 🔑 ALWAYS ENGLISH KEY
              categoryTitle: category.title,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(14),

          /// 🌙 DARK MODE = BORDER | ☀️ LIGHT MODE = SHADOW
          boxShadow: isDark
              ? []
              : const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
          border: isDark
              ? Border.all(
            color: colors.outline.withOpacity(0.2),
          )
              : null,
        ),
        child: Column(
          children: [
            /// 🖼 IMAGE
            Expanded(
              flex: 7,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
                child: Image.asset(
                  category.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            /// 📛 LOCALIZED TITLE
            Expanded(
              flex: 3,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    loc.getByKey(category.title),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: width * 0.032,
                      fontWeight: FontWeight.w600,
                      color: colors.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
