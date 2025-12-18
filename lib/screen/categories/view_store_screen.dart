import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../provider/store_provider.dart';
import '../../provider/cart_provider.dart';
import '../../widgets/top_header.dart';

class ViewStoreScreen extends StatelessWidget {
  const ViewStoreScreen({super.key});

  static const Color primaryColor = Color(0xFF3670A3);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    final storeProvider = Provider.of<StoreProvider>(context);
    final store = storeProvider.selectedStore;

    if (store == null) {
      return const Scaffold(
        body: Center(child: Text("No Store found")),
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
                  /// 🔙 BACK BUTTON
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
                            "Back to Store",
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

                  /// 🛍 PRODUCT TITLE
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Available Products",
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
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: w * 0.04,
                      mainAxisSpacing: w * 0.04,
                      childAspectRatio: 0.72,
                    ),
                    itemBuilder: (context, index) {
                      return _productCard(context, w, h);
                    },
                  ),

                  SizedBox(height: h * 0.03),

                  /// ⭐ CUSTOMER REVIEWS
                  _customerReviews(w, h),

                  SizedBox(height: h * 0.12),
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
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
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
              Positioned(
                bottom: h * 0.02,
                left: w * 0.04,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      store.name,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: w * 0.05,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: h * 0.006),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: w * 0.02,
                            vertical: h * 0.003,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                            BorderRadius.circular(w * 0.015),
                          ),
                          child: Text(
                            "${store.rating} ★",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: w * 0.03,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: w * 0.03),
                        Text(
                          "0.8 km away",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: w * 0.03,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
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
  Widget _productCard(BuildContext context, double w, double h) {
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
        children: [
          /// 🖼 IMAGE (Flexible height)
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(w * 0.045),
              ),
              child: Image.asset(
                "assets/images/clothe.jpg",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// 📦 CONTENT
          Padding(
            padding: EdgeInsets.all(w * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Product Name",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: w * 0.035,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: h * 0.006),

                Text(
                  "₹100",
                  style: GoogleFonts.inter(
                    fontSize: w * 0.032,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),

                SizedBox(height: h * 0.01),

                SizedBox(
                  width: double.infinity,
                  height: h * 0.042,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(w * 0.02),
                      ),
                    ),
                    onPressed: () {
                      Provider.of<CartProvider>(
                        context,
                        listen: false,
                      ).addItem({
                        "name": "Product Name",
                        "price": 100.0,
                        "qty": 1,
                        "image": "assets/images/clothe.jpg",
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Added to Cart")),
                      );
                    },
                    child: Text(
                      "Add to Cart",
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


  /// ================= CUSTOMER REVIEWS =================
  Widget _customerReviews(double w, double h) {
    return Column(
      children: [
        _reviewCard(
          name: "Rahul Kumar",
          time: "2 days ago",
          review: "Excellent store with great products and service!",
          rating: 5,
          w: w,
          h: h,
        ),
        _reviewCard(
          name: "Priya Singh",
          time: "1 week ago",
          review: "Good quality products at reasonable prices.",
          rating: 4,
          w: w,
          h: h,
        ),
        _reviewCard(
          name: "Amit Sharma",
          time: "2 weeks ago",
          review: "Very fresh products and quick delivery.",
          rating: 5,
          w: w,
          h: h,
        ),
      ],
    );
  }

  Widget _reviewCard({
    required String name,
    required String time,
    required String review,
    required int rating,
    required double w,
    required double h,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.01),
      padding: EdgeInsets.all(w * 0.035),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.04),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: w * 0.05,
                backgroundColor: primaryColor,
                child: Text(
                  name[0],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: w * 0.04,
                  ),
                ),
              ),
              SizedBox(width: w * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.inter(
                        fontSize: w * 0.038,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      time,
                      style: GoogleFonts.inter(
                        fontSize: w * 0.03,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(
                  5,
                      (index) => Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    size: w * 0.045,
                    color: Colors.orange,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: h * 0.01),
          Text(
            review,
            style: GoogleFonts.inter(
              fontSize: w * 0.035,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
