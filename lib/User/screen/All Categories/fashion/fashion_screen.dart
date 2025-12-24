import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/User/screen/All%20Categories/fashion/service_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:hazari_bagh_market/widgets/top_header.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../provider/fashion_provider.dart';

class FashionScreen extends StatefulWidget {
  const FashionScreen({super.key});

  @override
  State<FashionScreen> createState() => _FashionScreenState();
}

class _FashionScreenState extends State<FashionScreen>
    with SingleTickerProviderStateMixin {
  /// PRIMARY THEME COLOR
  static const Color themeColor = Color(0xFF9C89B8);

  String selectedCategoryId = "mens";

  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FashionProvider>();
    final loc = AppLocalizations.of(context);
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor =
    isDark ? const Color(0xFF0F172A) : Colors.grey.shade100;
    final cardColor =
    isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor =
    isDark ? Colors.grey.shade300 : Colors.grey.shade700;

    final services =
    provider.getServicesByCategory(selectedCategoryId);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            const TopHeader(),

            Expanded(
              child: FadeTransition(
                opacity: _fade,
                child: SlideTransition(
                  position: _slide,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: h * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: h * 0.01),

                        /// 🔙 BACK
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Row(
                              children: [
                                Icon(Icons.arrow_back,
                                    color: themeColor, size: w * 0.06),
                                SizedBox(width: w * 0.02),
                                Text(
                                  loc.back,
                                  style: TextStyle(
                                    fontSize: w * 0.045,
                                    fontWeight: FontWeight.w600,
                                    color: themeColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// 🔵 BANNER
                        Padding(
                          padding: EdgeInsets.all(w * 0.03),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: w * 0.05, vertical: h * 0.025),
                            decoration: BoxDecoration(
                              color: themeColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  loc.getByKey('fashionStore'),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: w * 0.055,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: h * 0.008),
                                Text(
                                  loc.getByKey('fashionSubtitle'),
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: w * 0.035,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// 📂 CATEGORIES
                        _sectionTitle(loc.categories, w),
                        SizedBox(height: h * 0.015),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                          child: Row(
                            children: provider.categories.map((cat) {
                              final isSelected =
                                  selectedCategoryId == cat.id;

                              return Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedCategoryId = cat.id;
                                    });
                                  },
                                  child: Container(
                                    margin:
                                    const EdgeInsets.only(right: 10),
                                    height: h * 0.14,
                                    decoration: BoxDecoration(
                                      color: cardColor,
                                      borderRadius:
                                      BorderRadius.circular(14),
                                      border: Border.all(
                                        color: isSelected
                                            ? themeColor
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          child: Image.asset(
                                            cat.image,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(12),
                                            gradient: LinearGradient(
                                              begin:
                                              Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                                Colors.black
                                                    .withOpacity(0.6),
                                                Colors.transparent,
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 12,
                                          bottom: 12,
                                          child: Text(
                                            loc.getByKey(cat.title),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: w * 0.04,
                                              fontWeight:
                                              FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        SizedBox(height: h * 0.03),

                        /// 🛍 SERVICES
                        _sectionTitle(loc.services, w),
                        SizedBox(height: h * 0.015),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics:
                            const NeverScrollableScrollPhysics(),
                            itemCount: services.length,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.75,
                            ),
                            itemBuilder: (context, index) {
                              final service = services[index];

                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          ServiceListScreen(
                                              service: service),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: cardColor,
                                    borderRadius:
                                    BorderRadius.circular(14),
                                    boxShadow: [
                                      BoxShadow(
                                        color: isDark
                                            ? Colors.black45
                                            : Colors.black12,
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 7,
                                        child: ClipRRect(
                                          borderRadius:
                                          const BorderRadius.vertical(
                                              top:
                                              Radius.circular(14)),
                                          child: Image.asset(
                                            service.image,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Center(
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(8),
                                            child: Text(
                                              loc
                                                  .getByKey(
                                                  service.title)
                                                  .toUpperCase(),
                                              textAlign:
                                              TextAlign.center,
                                              style: TextStyle(
                                                fontSize: w * 0.028,
                                                fontWeight:
                                                FontWeight.w600,
                                                color: themeColor,
                                              ),
                                            ),
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, double w) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.04),
      child: Text(
        title,
        style: TextStyle(
          color: themeColor,
          fontSize: w * 0.045,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
