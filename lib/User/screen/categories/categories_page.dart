import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Model/home_model.dart';
import '../../../Model/store_model.dart';
import '../../../all_categories_screen.dart';
import '../../../l10n/app_localizations.dart';
import '../../../widgets/top_header.dart';
import '../../provider/store_provider.dart';
import '../all_store_screen.dart';
import 'add_to_cart_screen.dart';


class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  ///  COMMON METHOD (Card + Button dono ke liye)
  void _openStore(BuildContext context, StoreModel store) {
    Provider.of<StoreProvider>(context, listen: false).setStore(store);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ViewStoreScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          const TopHeader(),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(w * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// 🔹 CATEGORIES TITLE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        loc.categories,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AllCategoriesScreen(),
                          ),
                        ),
                        child: Text(
                          loc.viewAll,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF3670A3),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h * 0.01),

                  /// 🔹 CATEGORY GRID
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: homeCategories.length > 6
                        ? 6
                        : homeCategories.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final item = homeCategories[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => item.screen),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(item.image, height: w * 0.12),
                              SizedBox(height: w * 0.02),
                              Text(
                                loc.getByKey(item.titleKey), // ✅ FIX
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: w * 0.03,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: h * 0.02),

                  /// 🔹 EXPLORE STORES TITLE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          loc.nearbyStores, // ✅ localized
                          style: TextStyle(
                            fontSize: w * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AllStoreScreen(),
                          ),
                        ),
                        child: Text(
                          loc.viewAll,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h * 0.015),

                  /// 🔥 STORE CARD LIST
                  SizedBox(
                    height: h * 0.25,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: nearbyStores.length,
                      itemBuilder: (context, index) {
                        final store = nearbyStores[index];

                        return InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () => _openStore(context, store),
                          child: Container(
                            width: w * 0.40,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                /// 🖼 IMAGE
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(14),
                                    ),
                                    child: Image.asset(
                                      store.image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                /// 📄 CONTENT
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(w * 0.03),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context).getByKey( loc.getByKey(store.nameKey),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: w * 0.04,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              store.distance,
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: w * 0.032,
                                              ),
                                            ),
                                            Text(
                                              "${store.rating} ⭐",
                                              style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: w * 0.032,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),

                                        /// 🔘 BUTTON
                                        SizedBox(
                                          width: double.infinity,
                                          height: 40,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                              const Color(0xFF3670A3),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                            ),
                                            onPressed: () =>
                                                _openStore(context, store),
                                            child: Text(
                                              loc.visitStore,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
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
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: h * 0.03),

                  /// 🔹 BANNER
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      height: h * 0.18,
                      width: double.infinity,
                      child: Image.asset(
                        "assets/images/electronics.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.03),

                  /// 🔹 OFFER
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(w * 0.08),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Text(
                          loc.specialWeekend,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          loc.flatOff,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: h * 0.03),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
