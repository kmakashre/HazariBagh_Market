import 'package:flutter/material.dart';
import '../../../Model/salon_model.dart';

class SalonCard extends StatelessWidget {
  final SalonModel salon;
  const SalonCard({super.key, required this.salon});

  static const Color primaryColor = Color(0xFF9C89B8);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(bottom: h * 0.018),
      padding: EdgeInsets.all(w * 0.035),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.04),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🔝 TOP ROW
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(w * 0.03),
                child: Image.network(
                  salon.image,
                  height: w * 0.22,
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
                      salon.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: w * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: h * 0.006),

                    /// RATING
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: w * 0.018,
                            vertical: h * 0.003,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                            BorderRadius.circular(w * 0.015),
                          ),
                          child: Row(
                            children: [
                              Text(
                                salon.rating,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: w * 0.032,
                                ),
                              ),
                              Icon(Icons.star,
                                  size: w * 0.035,
                                  color: Colors.white),
                            ],
                          ),
                        ),
                        SizedBox(width: w * 0.02),
                        Text(
                          salon.reviews,
                          style: TextStyle(
                            fontSize: w * 0.03,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: h * 0.006),

                    /// 📍 LOCATION
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            size: w * 0.045,
                            color: primaryColor),
                        SizedBox(width: w * 0.01),
                        Expanded(
                          child: Text(
                            salon.location,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: w * 0.03,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: h * 0.015),

          /// 🏷 SERVICES TAGS
          Wrap(
            spacing: w * 0.02,
            runSpacing: h * 0.01,
            children: salon.services
                .map(
                  (e) => Chip(
                label: Text(
                  e,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: w * 0.03,
                  ),
                ),
                backgroundColor:
                primaryColor.withOpacity(0.12),
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.015,
                  vertical: h * 0.002,
                ),
              ),
            )
                .toList(),
          ),

          SizedBox(height: h * 0.015),

          /// ⚡ ACTION BUTTONS
          Row(
            children: [
              _btn(
                icon: Icons.call,
                text: "Call",
                color: Colors.green,
                w: w,
                h: h,
              ),
              SizedBox(width: w * 0.02),
              _btn(
                icon: Icons.wallet_giftcard,
                text: "WhatsApp",
                color: Colors.green,
                w: w,
                h: h,
              ),
              SizedBox(width: w * 0.02),
              _btn(
                icon: Icons.chat,
                text: "Enquiry",
                color: Colors.blue,
                w: w,
                h: h,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 🔘 BUTTON
  Widget _btn({
    required IconData icon,
    required String text,
    required Color color,
    required double w,
    required double h,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: h * 0.012),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(w * 0.03),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: w * 0.045, color: color),
            SizedBox(width: w * 0.015),
            Text(
              text,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: w * 0.035,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
