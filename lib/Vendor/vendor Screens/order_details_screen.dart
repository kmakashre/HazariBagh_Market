import 'package:flutter/material.dart';
import '../../widgets/top_header.dart';
import 'order_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TopHeader(),

          SizedBox(height: h * 0.015),

          ///  BACK + TITLE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const OrdersScreen()));
                  },
                  child: Icon(Icons.arrow_back, size: w * 0.065),
                ),
                SizedBox(width: w * 0.03),
                Text(
                  "Back To Order",
                  style: TextStyle(
                    fontSize: w * 0.055,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: h * 0.02),

          /// MAIN CARD
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                child: Container(
                  padding: EdgeInsets.all(w * 0.04),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(w * 0.03),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                        color: Colors.black12,
                      )
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// ORDER HEADER
                      Text(
                        "Order Id- ORD001",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: w * 0.05,
                        ),
                      ),
                      SizedBox(height: h * 0.005),
                      Text(
                        "10 March 2025",
                        style: TextStyle(color: Colors.black54, fontSize: w * 0.04),
                      ),

                      SizedBox(height: h * 0.018),

                      /// CUSTOMER NAME
                      Text("Customer Name",
                          style: TextStyle(
                            fontSize: w * 0.045,
                            fontWeight: FontWeight.bold,
                          )),
                      Text("Rahul Kumar",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: w * 0.04,
                          )),
                      SizedBox(height: h * 0.015),

                      /// DELIVERY TYPE
                      Text(
                        "Delivery Type - Home",
                        style: TextStyle(fontSize: w * 0.04),
                      ),
                      SizedBox(height: h * 0.008),

                      /// PAYMENT METHOD
                      Text(
                        "Payment Method - Cash On Delivery",
                        style: TextStyle(fontSize: w * 0.04),
                      ),
                      SizedBox(height: h * 0.008),

                      /// ADDRESS
                      Text(
                        "Delivery Address - Vijay Nagar Indore, M.P",
                        style: TextStyle(fontSize: w * 0.04),
                      ),
                      SizedBox(height: h * 0.02),

                      /// ORDER ITEMS TITLE
                      Text(
                        "Order Items",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: w * 0.048,
                        ),
                      ),
                      SizedBox(height: h * 0.015),

                      /// ITEM 1
                      orderItemCard(
                        w: w,
                        h: h,
                        image:
                        "https://images.pexels.com/photos/264636/pexels-photo-264636.jpeg",
                        title: "Basmati Rice 5kg",
                        qty: "Qty: 2",
                        price: "₹900",
                      ),

                      SizedBox(height: h * 0.015),

                      /// ITEM 2
                      orderItemCard(
                        w: w,
                        h: h,
                        image:
                        "https://images.pexels.com/photos/264636/pexels-photo-264636.jpeg",
                        title: "Cooking Oil 5L",
                        qty: "Qty: 1",
                        price: "₹599",
                      ),

                      SizedBox(height: h * 0.025),

                      /// TOTAL AMOUNT
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order Total",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: w * 0.05),
                          ),
                          Text(
                            "₹1499",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w700,
                              fontSize: w * 0.05,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: h * 0.025),

                      /// BUTTONS
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade700,
                                padding: EdgeInsets.symmetric(
                                    vertical: h * 0.018),
                              ),
                              onPressed: () {},
                              child: Text("Mark as Packed",
                                  style: TextStyle(
                                      fontSize: w * 0.045,
                                      color: Colors.white)),
                            ),
                          ),

                          SizedBox(height: h * 0.015),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade400,
                                padding: EdgeInsets.symmetric(
                                    vertical: h * 0.018),
                              ),
                              onPressed: () {},
                              child: Text("Track Order",
                                  style: TextStyle(
                                      fontSize: w * 0.045,
                                      color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ORDER ITEM CARD (Responsive)
  Widget orderItemCard({
    required double w,
    required double h,
    required String image,
    required String title,
    required String qty,
    required String price,
  }) {
    return Container(
      padding: EdgeInsets.all(w * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.025),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: const Offset(0, 2),
            color: Colors.black12,
          )
        ],
      ),
      child: Row(
        children: [
          /// IMAGE
          Container(
            width: w * 0.16,
            height: w * 0.16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(w * 0.02),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(width: w * 0.03),

          /// TEXTS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: w * 0.04,
                    )),
                SizedBox(height: h * 0.005),
                Text(qty,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: w * 0.035,
                    )),
              ],
            ),
          ),

          /// PRICE
          Text(
            price,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
              fontSize: w * 0.045,
            ),
          ),
        ],
      ),
    );
  }
}
