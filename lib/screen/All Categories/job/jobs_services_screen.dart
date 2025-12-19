import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/jobs_services_provider.dart';
import '../../../widgets/top_header.dart';
import '../../../l10n/app_localizations.dart';
import 'job_details_screen.dart';

/// 🎯 APP PRIMARY COLOR
const Color primaryColor = Color(0xFF84B3B6);

class JobsServicesScreen extends StatelessWidget {
  const JobsServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    final provider = context.watch<JobsServicesProvider>();
    final dataList = provider.filteredList;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          const TopHeader(),
          SizedBox(height: h * 0.015),

          /// 🔙 BACK
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.03),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Row(
                children: [
                  Icon(Icons.arrow_back,
                      color: primaryColor, size: w * 0.055),
                  SizedBox(width: w * 0.02),
                  Text(
                    loc.back,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: w * 0.045,
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
            padding: EdgeInsets.symmetric(horizontal: w * 0.03),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(w * 0.04),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(w * 0.04),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.jobsAndServices,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: w * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: h * 0.004),
                  Text(
                    loc.jobsServicesDesc,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.95),
                      fontSize: w * 0.03,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: h * 0.015),

          /// 🔁 JOB / SERVICES TOGGLE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.03),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                border: Border.all(color: primaryColor, width: 1.5),
                borderRadius: BorderRadius.circular(12),
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

          SizedBox(height: h * 0.015),

          /// 🎯 FILTER
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.03),
            child: Container(
              padding: EdgeInsets.all(w * 0.03),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(w * 0.04),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.tune, color: primaryColor),
                      const SizedBox(width: 6),
                      Text(
                        loc.filterByCategory,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        loc.viewAll,
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h * 0.01),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _filterChip(context, loc.all, "all"),
                      _filterChip(context, loc.itSoftware, "itSoftware"),
                      _filterChip(context, loc.salesMarketing, "salesMarketing"),
                      _filterChip(context, loc.healthcare, "healthcare"),
                      _filterChip(context, loc.education, "education"),
                      _filterChip(context, loc.logistics, "logistics"),
                    ],
                  ),
                ],
              ),
            ),
          ),

          /// 🧾 GRID
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(w * 0.03),
              itemCount: dataList.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.62,
              ),
              itemBuilder: (context, index) {
                return _jobServiceCard(
                  context,
                  w,
                  h,
                  dataList[index],
                  loc,
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
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: h * 0.012),
          decoration: BoxDecoration(
            color: isActive ? primaryColor : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
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
      ) {
    return InkWell(
      borderRadius: BorderRadius.circular(w * 0.04),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const JobDetailsScreen()),
        );
      },
      child: Container(
        padding: EdgeInsets.all(w * 0.025),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(w * 0.04),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 4),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(w * 0.03),
              child: Image.asset(
                'assets/images/electronics.jpg',
                height: h * 0.13,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: h * 0.008),

            Text(
              loc.getByKey(job["titleKey"]!),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: w * 0.034,
              ),
            ),

            Text(
              loc.getByKey(job["companyKey"]!),
              style: TextStyle(
                fontSize: w * 0.028,
                color: Colors.grey,
              ),
            ),

            SizedBox(height: h * 0.006),

            _jobRow(Icons.currency_rupee, job["salary"]!, w),
            _jobRow(Icons.work, loc.getByKey(job["typeKey"]!), w),
            _jobRow(Icons.category, loc.getByKey(job["categoryKey"]!), w),

            const Spacer(),

            SizedBox(
              height: h * 0.045,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w * 0.02),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> JobDetailsScreen()));
                },
                child: Text(
                  loc.viewDetails,
                  style: TextStyle(
                    fontSize: w * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _jobRow(IconData icon, String title, double w) {
    return Row(
      children: [
        Icon(icon, size: w * 0.03, color: primaryColor),
        SizedBox(width: w * 0.02),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: w * 0.026),
          ),
        ),
      ],
    );
  }

  static Widget _filterChip(
      BuildContext context, String title, String key) {
    final provider =
    Provider.of<JobsServicesProvider>(context, listen: false);
    final isActive = provider.selectedCategoryKey == key;

    return GestureDetector(
      onTap: () => provider.selectCategory(key),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
