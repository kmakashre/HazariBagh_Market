import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../l10n/app_localizations.dart';
import '../../../widgets/top_header.dart';
import '../../provider/store_provider.dart';
import '../../provider/cart_provider.dart';


class ViewStoreScreen extends StatelessWidget {
  const ViewStoreScreen({super.key});

  static const Color primaryColor = Color(0xFF3670A3);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final loc = AppLocalizations.of(context);

    final storeProvider = Provider.of<StoreProvider>(context);
    final store = storeProvider.selectedStore;

    if (store == null) {
      return Scaffold(
        body: Center(child: Text(loc.noDataFound)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          const TopHeader(),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  /// 🔙 BACK
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: w * 0.04,
                      vertical: h * 0.01,
                    ),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back, size: w * 0.055),
                          SizedBox(width: w * 0.02),
                          Text(
                            loc.getByKey('back'),
                            style: GoogleFonts.inter(
                              fontSize: w * 0.04,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// 🏬 STORE CARD
                  _storeTopCard(store, w, h),

                  SizedBox(height: h * 0.015),

                  /// 🛍 PRODUCTS TITLE
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        loc.getByKey('products'),
                        style: GoogleFonts.inter(
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.012),

                  /// 🧩 PRODUCT GRID
                  GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: w * 0.04,
                      mainAxisSpacing: w * 0.04,
                      childAspectRatio: 0.72,
                    ),
                    itemBuilder: (context, index) {
                      return _productCard(context, w, h, loc);
                    },
                  ),

                  SizedBox(height: h * 0.1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= STORE TOP CARD =================
  Widget _storeTopCard(store, double w, double h) {
    return Container(
      margin: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.045),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(w * 0.045),
            ),
            child: Image.asset(
              store.image,
              height: h * 0.26,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(w * 0.04),
            child: Column(
              children: [
                _storeInfo(Icons.location_on, store.address, w),
                SizedBox(height: h * 0.01),
                _storeInfo(Icons.phone, store.phone, w),
                SizedBox(height: h * 0.01),
                _storeInfo(Icons.access_time, store.time, w),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _storeInfo(IconData icon, String text, double w) {
    return Row(
      children: [
        Icon(icon, size: w * 0.045, color: Colors.grey.shade700),
        SizedBox(width: w * 0.02),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(fontSize: w * 0.035),
          ),
        ),
      ],
    );
  }

  /// ================= PRODUCT CARD =================
  Widget _productCard(
      BuildContext context, double w, double h, AppLocalizations loc) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.045),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
            BorderRadius.vertical(top: Radius.circular(w * 0.045)),
            child: Image.asset(
              "assets/images/clothe.jpg",
              height: h * 0.18,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(w * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loc.getByKey('fresh_tomatoes'),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: w * 0.035,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: h * 0.004),
                Text(
                  "₹100",
                  style: GoogleFonts.inter(
                    fontSize: w * 0.032,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: h * 0.012),

                SizedBox(
                  width: double.infinity,
                  height: h * 0.045,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(w * 0.02),
                      ),
                    ),
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false).addItem({
                        "name": loc.getByKey('fresh_tomatoes'),
                        "price": 100.0,
                        "qty": 1,
                        "image": "assets/images/clothe.jpg",
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(loc.getByKey('added_to_cart')),
                        ),
                      );
                    },
                    child: Text(
                      loc.getByKey('add'),
                      style: GoogleFonts.inter(
                        fontSize: w * 0.032,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
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
