import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/widgets/top_header.dart';

import '../../../../Model/service_model.dart';
import '../../../../l10n/app_localizations.dart';


class ServiceListScreen extends StatelessWidget {
  final ServiceModel service;
  const ServiceListScreen({super.key, required this.service});

  static const Color primaryColor = Color(0xFF9C89B8);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Column(
          children: [

            const TopHeader(),

            /// 🔙 HEADER
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

                    Expanded(
                      child: Text(
                        loc.getByKey(service.title),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.w600,
                          color: colors.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// 📄 CARD CONTENT
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(w * 0.04),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: theme.brightness == Brightness.dark
                            ? Colors.black45
                            : Colors.black12,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// 🖼 IMAGE
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          service.image,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(height: 14),

                      /// 📝 DESCRIPTION
                      Text(
                        loc.getByKey(service.description),
                        style: TextStyle(
                          fontSize: 14,
                          color: colors.onSurface.withOpacity(0.85),
                        ),
                      ),

                      const SizedBox(height: 14),

                      /// 💰 PRICE
                      Text(
                        service.price,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),

                      const SizedBox(height: 18),

                      /// ⚡ ACTION BUTTONS
                      Row(
                        children: [

                          _actionBtn(
                            context,
                            Icons.call,
                            loc.getByKey('callNow'),
                            Colors.green,
                          ),
                          const SizedBox(width: 8),

                          _actionBtn(
                            context,
                            Icons.chat,
                            loc.getByKey('whatsapp'),
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
                              child: Text(
                                loc.getByKey('enquiry'),
                                style: const TextStyle(color: Colors.white),
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

  /// 🔘 SMALL ACTION BUTTON (Theme Aware)
  Widget _actionBtn(
      BuildContext context,
      IconData icon,
      String text,
      Color color,
      ) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(theme.brightness == Brightness.dark ? 0.25 : 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
