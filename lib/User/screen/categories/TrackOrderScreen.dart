import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../widgets/top_header.dart';
import '../status_row.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  static const Color primaryColor = Color(0xFF3670A3);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final loc = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TopHeader(),

            SizedBox(height: h * 0.01),

            /// 🔙 BACK + TITLE
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back,
                        color: primaryColor, size: w * 0.055),
                    SizedBox(width: w * 0.02),
                    Text(
                      loc.getByKey('back'),
                      style: TextStyle(
                        fontSize: w * 0.045,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: h * 0.02),

            /// 🗺 MAP
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Container(
                height: h * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(w * 0.04),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/map.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.all(w * 0.03),
                child: Text(
                  loc.getByKey('live_tracking'),
                  style: TextStyle(
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: h * 0.02),

            /// 🚴 DELIVERY BOY
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Container(
                padding: EdgeInsets.all(w * 0.035),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(w * 0.04),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: w * 0.06,
                      child: Icon(Icons.person, size: w * 0.06),
                    ),
                    SizedBox(width: w * 0.03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loc.getByKey('delivery_person_name'),
                            style: TextStyle(
                              fontSize: w * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            loc.getByKey('delivery_boy'),
                            style: TextStyle(
                              fontSize: w * 0.032,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.call, color: primaryColor, size: w * 0.06),
                  ],
                ),
              ),
            ),

            SizedBox(height: h * 0.025),

            /// 📦 ORDER STATUS
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Container(
                padding: EdgeInsets.all(w * 0.035),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(w * 0.04),
                ),
                child: Column(
                  children: [
                    StatusRow(
                      icon: Icons.check_circle,
                      title: loc.getByKey('ordered'),
                      subtitle: loc.getByKey('today'),
                      active: true,
                    ),
                    StatusRow(
                      icon: Icons.inventory,
                      title: loc.getByKey('packed'),
                      subtitle: loc.getByKey('pending'),
                      active: true,
                    ),
                    StatusRow(
                      icon: Icons.local_shipping,
                      title: loc.getByKey('out_for_delivery'),
                      subtitle: loc.getByKey('driver_on_way'),
                      active: false,
                    ),
                    StatusRow(
                      icon: Icons.home,
                      title: loc.getByKey('delivered'),
                      subtitle: loc.getByKey('pending'),
                      active: false,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: h * 0.03),

            /// ❌ CANCEL
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: SizedBox(
                width: double.infinity,
                height: h * 0.065,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {},
                  child: Text(
                    loc.getByKey('cancel_order'),
                    style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: h * 0.08),
          ],
        ),
      ),
    );
  }
}
