import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/User/screen/store_details_screen.dart';

import '../../Model/store_model.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/top_header.dart';

class AllStoreScreen extends StatelessWidget {
  const AllStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    /// 🎨 THEME
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: colors.background,
      body: Column(
        children: [
          /// 🔝 TOP HEADER
          const TopHeader(),

          /// 🔙 BACK + TITLE
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.04,
              vertical: h * 0.015,
            ),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(8),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    size: w * 0.05,
                    color: colors.onBackground,
                  ),
                  SizedBox(width: w * 0.03),
                  Text(
                    loc.nearbyStores,
                    style: TextStyle(
                      fontSize: w * 0.05,
                      fontWeight: FontWeight.bold,
                      color: colors.onBackground,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 🏬 STORE LIST
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(w * 0.04),
              itemCount: nearbyStores.length,
              itemBuilder: (context, index) {
                final store = nearbyStores[index];

                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: Duration(milliseconds: 300 + index * 100),
                  builder: (_, value, child) => Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, (1 - value) * 40),
                      child: child,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration:
                          const Duration(milliseconds: 350),
                          pageBuilder: (_, animation, __) => FadeTransition(
                            opacity: animation,
                            child: const StoreDetailsScreen(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          /// 🖼 IMAGE
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              store.image,
                              height: h * 0.10,
                              width: w * 0.22,
                              fit: BoxFit.cover,
                            ),
                          ),

                          SizedBox(width: w * 0.03),

                          /// 📄 DETAILS
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// STORE NAME
                                Text(
                                  loc.getByKey(store.nameKey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: w * 0.04,
                                    fontWeight: FontWeight.bold,
                                    color: colors.onSurface,
                                  ),
                                ),

                                SizedBox(height: h * 0.004),

                                /// CATEGORY
                                Text(
                                  loc.getByKey(store.categoryKey),
                                  style: TextStyle(
                                    fontSize: w * 0.032,
                                    color: colors.onSurface.withOpacity(0.6),
                                  ),
                                ),

                                SizedBox(height: h * 0.006),

                                /// DISTANCE
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 14,
                                      color:
                                      colors.onSurface.withOpacity(0.6),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      store.distance,
                                      style: TextStyle(
                                        fontSize: w * 0.032,
                                        color: colors.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Icon(
                            Icons.arrow_forward_ios,
                            size: w * 0.04,
                            color: colors.onSurface.withOpacity(0.4),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
