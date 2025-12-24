import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../widgets/top_header.dart';
import '../../../provider/jobs_services_provider.dart';
import 'job_details_screen.dart';

/// 🎯 PRIMARY COLOR
const Color primaryColor = Color(0xFF84B3B6);

class JobsServicesScreen extends StatelessWidget {
  const JobsServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF5F7FA);
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1E293B);
    final subTextColor =
    isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    final shadow = [
      BoxShadow(
        color: isDark ? Colors.black54 : Colors.black12,
        blurRadius: 12,
        offset: const Offset(0, 6),
      ),
    ];

    final provider = context.watch<JobsServicesProvider>();
    final dataList = provider.filteredList;

    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          const TopHeader(),
          SizedBox(height: h * 0.015),

          /// 🔙 BACK
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => Navigator.pop(context),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios_new,
                      color: primaryColor, size: w * 0.045),
                  SizedBox(width: w * 0.02),
                  Text(
                    loc.back,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: w * 0.042,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: h * 0.015),

          /// 🟦 HEADER
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(w * 0.06),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF84B3B6),
                    Color(0xFF5FA0A4),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: shadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.jobsAndServices,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: w * 0.055,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: h * 0.008),
                  Text(
                    loc.jobsServicesDesc,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: w * 0.032,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: h * 0.02),

          /// 🔁 TOGGLE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: shadow,
              ),
              child: Row(
                children: [
                  _toggleTab(
                    title: loc.jobs,
                    isActive: provider.isJobsSelected,
                    onTap: provider.selectJobs,
                    h: h,
                  ),
                  const SizedBox(width: 8),
                  _toggleTab(
                    title: loc.services,
                    isActive: !provider.isJobsSelected,
                    onTap: provider.selectServices,
                    h: h,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: h * 0.02),

          /// 🎯 FILTER
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
            child: Container(
              padding: EdgeInsets.all(w * 0.04),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(22),
                boxShadow: shadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.tune,
                          color: primaryColor, size: w * 0.05),
                      SizedBox(width: w * 0.02),
                      Text(
                        loc.filterByCategory,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: textColor,
                          fontSize: w * 0.038,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h * 0.012),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _filterChip(context, loc.getByKey("all"), "all", isDark),
                      _filterChip(context, loc.getByKey("itSoftware"),
                          "itSoftware", isDark),
                      _filterChip(context, loc.getByKey("salesMarketing"),
                          "salesMarketing", isDark),
                      _filterChip(context, loc.getByKey("healthcare"),
                          "healthcare", isDark),
                      _filterChip(context, loc.getByKey("education"),
                          "education", isDark),
                      _filterChip(context, loc.getByKey("logistics"),
                          "logistics", isDark),
                    ],
                  ),
                ],
              ),
            ),
          ),

          /// 🧾 GRID
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(w * 0.04),
              itemCount: dataList.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.66,
              ),
              itemBuilder: (context, index) {
                return _jobServiceCard(
                  context,
                  w,
                  h,
                  dataList[index],
                  loc,
                  cardColor,
                  textColor,
                  subTextColor,
                  shadow,
                  isDark,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 🔘 TOGGLE TAB
  static Widget _toggleTab({
    required String title,
    required bool isActive,
    required VoidCallback onTap,
    required double h,
  }) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: h * 0.05,
          decoration: BoxDecoration(
            color: isActive ? primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 🎴 JOB CARD
  static Widget _jobServiceCard(
      BuildContext context,
      double w,
      double h,
      Map<String, String> job,
      AppLocalizations loc,
      Color cardColor,
      Color textColor,
      Color subTextColor,
      List<BoxShadow> shadow,
      bool isDark,
      ) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const JobDetailsScreen()),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: shadow,
        ),
        child: Column(
          children: [
            /// IMAGE
            ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.asset(
                'assets/images/electronics.jpg',
                height: h * 0.12, // 🔽 slightly reduced
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            /// CONTENT
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(w * 0.035),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.getByKey(job["titleKey"]!),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: w * 0.035,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      loc.getByKey(job["companyKey"]!),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: w * 0.028,
                        color: subTextColor,
                      ),
                    ),

                    const SizedBox(height: 6),

                    _jobRow(Icons.currency_rupee, job["salary"]!, w, isDark),
                    _jobRow(
                      Icons.work,
                      loc.getByKey(job["typeKey"]!),
                      w,
                      isDark,
                    ),

                    const Spacer(), // ⭐ MOST IMPORTANT

                    SizedBox(
                      height: h * 0.04,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const JobDetailsScreen(),
                          ),
                        ),
                        child: Text(
                          loc.viewDetails,
                          style: TextStyle(
                            fontSize: w * 0.03,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
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
  }

  static Widget _jobRow(
      IconData icon, String title, double w, bool isDark) {
    return Row(
      children: [
        Icon(icon, size: w * 0.032, color: primaryColor),
        SizedBox(width: w * 0.02),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: w * 0.027,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  static Widget _filterChip(
      BuildContext context, String title, String key, bool isDark) {
    final provider =
    Provider.of<JobsServicesProvider>(context, listen: false);
    final isActive = provider.selectedCategoryKey == key;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => provider.selectCategory(key),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: isActive
              ? primaryColor
              : isDark
              ? const Color(0xFF1F2937)
              : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : Colors.grey.shade800,
          ),
        ),
      ),
    );
  }
}
