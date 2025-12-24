import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Model/grocery_model.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../widgets/top_header.dart';
import '../../../provider/grocery_provider.dart';
import 'product_list_screen.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({super.key});

  /// 🧺 GROCERY CARD (Theme Aware)
  Widget _groceryCard(
      BuildContext context,
      GroceryItem item,
      double w,
      ) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductListScreen(
              categoryKey: item.title, // 🔑 ENGLISH KEY ONLY
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: theme.brightness == Brightness.dark
                  ? Colors.black45
                  : Colors.black12,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            /// 🖼 IMAGE
            Expanded(
              flex: 7,
              child: ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(14)),
                child: Image.asset(
                  item.image,
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
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    loc.getByKey(item.title.toLowerCase()),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: w * 0.032,
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

  @override
  Widget build(BuildContext context) {
    final groceryProvider = context.watch<GroceryProvider>();
    final groceryItems = groceryProvider.groceryItems;
    final isLoading = groceryProvider.isLoading;

    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: Column(
        children: [
          /// 🔝 TOP HEADER
          const TopHeader(),

          SizedBox(height: h * 0.02),

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
                        color: colors.onSurface,
                      ),
                      SizedBox(width: w * 0.02),
                      Text(
                        "Back",
                        style: TextStyle(
                          color: colors.onSurface,
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

          /// 🧺 GROCERY GRID
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(w * 0.04),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                itemCount: groceryItems.length,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: w * 0.04,
                  mainAxisSpacing: w * 0.04,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  return _groceryCard(
                    context,
                    groceryItems[index],
                    w,
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
