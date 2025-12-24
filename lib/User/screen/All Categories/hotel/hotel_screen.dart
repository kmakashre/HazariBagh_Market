import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../widgets/top_header.dart';
import '../../../provider/hotel_provider.dart';
import 'hotel_category_card.dart';

class HotelScreen extends StatelessWidget {
  const HotelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// 🔑 PROVIDER
    final hotelProvider = context.watch<HotelProvider>();
    final w = MediaQuery.of(context).size.width;
    final loc = AppLocalizations.of(context);

    /// 🎨 THEME
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🔝 TOP HEADER
          const TopHeader(),

          /// 🔙 BACK BUTTON
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.03),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: colors.primary,
                      ),
                      SizedBox(width: w * 0.02),
                      Text(
                        loc.back,
                        style: TextStyle(
                          color: colors.primary,
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// 🏨 HOTEL CATEGORIES GRID
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(w * 0.04),
              child: hotelProvider.isLoading
                  ? Center(
                child: CircularProgressIndicator(
                  color: colors.primary,
                ),
              )
                  : GridView.builder(
                itemCount: hotelProvider.categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: w * 0.04,
                  mainAxisSpacing: w * 0.04,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  return HotelCategoryCard(
                    category: hotelProvider.categories[index],
                    width: w,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
