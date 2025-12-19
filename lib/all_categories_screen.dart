import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hazari_bagh_market/colors/AppColors.dart';

import '../../Model/home_model.dart';
import '../../widgets/top_header.dart';
import '../../l10n/app_localizations.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    /// 🔥 Localization instance
    final loc = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          /// 🔵 TOP HEADER
          const TopHeader(),

          SizedBox(height: h * 0.01),

          /// 🔙 BACK BAR
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(12),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: AppColors.darkOverlay,
                    size: w * 0.055,
                  ),
                  SizedBox(width: w * 0.02),
                  Text(
                    loc.back,
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

          /// 🔲 CATEGORY GRID
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(w * 0.04),
              itemCount: homeCategories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
              ),
              itemBuilder: (context, index) {
                final item = homeCategories[index];

                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: Duration(milliseconds: 250 + index * 80),
                  curve: Curves.easeOutBack,
                  builder: (_, value, child) => Transform.scale(
                    scale: value,
                    child: Opacity(opacity: value, child: child),
                  ),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration:
                        const Duration(milliseconds: 300),
                        pageBuilder: (_, animation, __) => FadeTransition(
                          opacity: animation,
                          child: item.screen,
                        ),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            item.image,
                            height: w * 0.13,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: h * 0.012),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              /// 🔥 LOCALIZED CATEGORY NAME
                              loc.getByKey(item.titleKey),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: w * 0.032,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
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
