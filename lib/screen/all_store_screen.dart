import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:hazari_bagh_market/screen/store_details_screen.dart';
import '../../widgets/top_header.dart';
import '../Model/store_model.dart';
import '../colors/AppColors.dart';
import '../provider/store_provider.dart';

class AllStoreScreen extends StatelessWidget {
  const AllStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            const TopHeader(),

            SizedBox(height: h * 0.01),

            /// 🔙 BACK + TITLE
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.03),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back,
                        color: AppColors.darkOverlay, size: w * 0.055),
                    SizedBox(width: w * 0.02),
                    Text(
                      "Back",
                      style: GoogleFonts.inter(
                        color: AppColors.darkOverlay,
                        fontSize: w * 0.045,
                        fontWeight: FontWeight.w600,
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

                  return GestureDetector(
                    onTap: () {
                      /// ✅ SAVE STORE
                      context.read<StoreProvider>().selectStore(store);

                      /// ✅ NAVIGATE
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const StoreDetailsScreen(),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                          /// IMAGE
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

                          /// DETAILS
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  store.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: w * 0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  store.category,
                                  style: TextStyle(
                                    fontSize: w * 0.032,
                                    color: Colors.grey,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      size: 14,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(store.distance),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Icon(
                            Icons.arrow_forward_ios,
                            size: w * 0.04,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
