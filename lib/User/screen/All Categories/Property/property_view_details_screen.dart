import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Model/property_model.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../widgets/top_header.dart';
import '../../../provider/property_provider.dart';
import 'property_enquiry_screen.dart';

class PropertyDetailsScreen extends StatelessWidget {
  const PropertyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PropertyProvider>();
    final PropertyModel? property = provider.selectedProperty;
    final loc = AppLocalizations.of(context);

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (property == null) {
      return Scaffold(
        body: Center(
          child: Text(loc.getByKey('noPropertySelected')),
        ),
      );
    }

    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          /// 🔝 TOP HEADER
          const TopHeader(),

          /// 🔙 BACK BUTTON
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.04,
              vertical: h * 0.012,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => Navigator.pop(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.arrow_back,
                      color: theme.colorScheme.primary),
                  SizedBox(width: w * 0.02),
                  Text(
                    loc.back,
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// BODY
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Column(
                children: [

                  /// 🏠 PROPERTY CARD
                  Container(
                    padding: EdgeInsets.all(w * 0.04),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(w * 0.04),
                      boxShadow: isDark
                          ? []
                          : const [
                        BoxShadow(
                            color: Colors.black12, blurRadius: 8),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// IMAGE
                        ClipRRect(
                          borderRadius:
                          BorderRadius.circular(w * 0.035),
                          child: Image.asset(
                            property.image,
                            height: h * 0.28,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        SizedBox(height: h * 0.015),

                        /// TAGS + PRICE
                        Row(
                          children: [
                            _tag(
                              loc.getByKey(property.type),
                              theme.colorScheme.secondary,
                              w,
                            ),
                            SizedBox(width: w * 0.02),
                            _tag(
                              loc.verified,
                              Colors.green,
                              w,
                            ),
                            const Spacer(),
                            Text(
                              property.price,
                              style: theme.textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: h * 0.015),

                        _infoRow(
                          context,
                          Icons.location_on,
                          property.location,
                          w,
                        ),
                        _infoRow(
                          context,
                          Icons.square_foot,
                          property.area,
                          w,
                        ),
                        _infoRow(
                          context,
                          Icons.bed,
                          property.bedInfo,
                          w,
                        ),

                        SizedBox(height: h * 0.018),

                        /// DESCRIPTION
                        Text(
                          loc.description,
                          style: theme.textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: h * 0.006),
                        Text(
                          property.description,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: h * 0.02),

                  /// 📞 CONTACT INFO
                  Container(
                    padding: EdgeInsets.all(w * 0.035),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(w * 0.04),
                      boxShadow: isDark
                          ? []
                          : const [
                        BoxShadow(
                            color: Colors.black12, blurRadius: 6),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.contactInformation,
                          style: theme.textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: h * 0.012),

                        _contactRow(
                          context,
                          Icons.person,
                          property.contactName,
                        ),
                        _contactRow(
                          context,
                          Icons.phone,
                          property.contactPhone,
                        ),
                        _contactRow(
                          context,
                          Icons.email,
                          property.contactEmail,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: h * 0.016),

                  /// ⚠️ VERIFY NOTE
                  Container(
                    padding: EdgeInsets.all(w * 0.03),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(w * 0.03),
                    ),
                    child: Text(
                      loc.getByKey('verifyNote'),
                      style: theme.textTheme.bodySmall,
                    ),
                  ),

                  SizedBox(height: h * 0.025),

                  /// 🎯 ACTION BUTTONS
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.call),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(
                                vertical: h * 0.018),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {},
                          label: Text(loc.getByKey('callNow')),
                        ),
                      ),
                      SizedBox(width: w * 0.03),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.message),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: h * 0.018),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PropertyEnquiryScreen(
                                  propertyTitle: property.title,
                                  contactName: property.contactName,
                                ),
                              ),
                            );
                          },
                          label: Text(loc.getByKey('enquireNow')),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h * 0.03),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// TAG
  Widget _tag(String text, Color color, double w) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: w * 0.025,
        vertical: w * 0.01,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(w * 0.02),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: w * 0.03,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// INFO ROW
  Widget _infoRow(
      BuildContext context, IconData icon, String text, double w) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: w * 0.012),
      child: Row(
        children: [
          Icon(icon, size: w * 0.045, color: theme.iconTheme.color),
          SizedBox(width: w * 0.02),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  /// CONTACT ROW
  Widget _contactRow(
      BuildContext context, IconData icon, String text) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text, style: theme.textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
