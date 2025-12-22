import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/widgets/top_header.dart';
import '../../../colors/AppColors.dart';
import '../../../Model/service_model.dart';

class ServiceListScreen extends StatelessWidget {
  final ServiceModel service;
  const ServiceListScreen({super.key, required this.service});

  static const Color primaryColor = Color(0xFF9C89B8);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [

            const TopHeader(),

            ///  HEADER
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 10),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: primaryColor,
                      size: w * 0.06,
                    ),
                    SizedBox(width: w * 0.02),

                    /// 🔤 SERVICE NAME
                    Expanded(
                      child: Text(
                        service.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// 📄 CARD
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(w * 0.04),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 6),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// IMAGE
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          service.image,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// DESCRIPTION
                      Text(
                        service.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textDark,
                        ),
                      ),

                      const SizedBox(height: 14),

                      /// PRICE
                      Text(
                        service.price,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),

                      const SizedBox(height: 16),

                      /// ACTION BUTTONS
                      Row(
                        children: [

                          _actionBtn(Icons.call, "Call", Colors.green),
                          const SizedBox(width: 8),

                          _actionBtn(
                            Icons.chat,
                            "WhatsApp",
                            Colors.green.shade700,
                          ),
                          const SizedBox(width: 8),

                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Send Enquiry",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔘 SMALL ACTION BUTTON
  Widget _actionBtn(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(fontSize: 11, color: color),
          ),
        ],
      ),
    );
  }
}
