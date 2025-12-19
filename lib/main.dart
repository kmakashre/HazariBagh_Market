import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/provider/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hazari_bagh_market/provider/auth_provider.dart';
import 'package:hazari_bagh_market/provider/bottom_nav_provider.dart';
import 'package:hazari_bagh_market/provider/cart_provider.dart';
import 'package:hazari_bagh_market/provider/chat_Provider.dart';
import 'package:hazari_bagh_market/provider/fashion_provider.dart';
import 'package:hazari_bagh_market/provider/food_provider.dart';
import 'package:hazari_bagh_market/provider/grocery_provider.dart';
import 'package:hazari_bagh_market/provider/home_provider.dart';
import 'package:hazari_bagh_market/provider/hotel_provider.dart';
import 'package:hazari_bagh_market/provider/jobs_services_provider.dart';
import 'package:hazari_bagh_market/provider/property_provider.dart';
import 'package:hazari_bagh_market/provider/store_provider.dart';
import 'package:hazari_bagh_market/provider/support_provider.dart';
import 'package:hazari_bagh_market/provider/theme_provider.dart';

import 'package:hazari_bagh_market/screen/splash_screen.dart';

import 'Vendor/VendorProvider/dashboard_provider.dart';
import 'Vendor/VendorProvider/vendor_bottom_nav_provider.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => StoreProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => JobsServicesProvider()),
        ChangeNotifierProvider(create: (_) => PropertyProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => VendorBottomNavProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => SupportProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => FashionProvider()),
        ChangeNotifierProvider(create: (_) => HotelProvider()),
        ChangeNotifierProvider(create: (_) => GroceryProvider()),
        ChangeNotifierProvider(create: (_) => FoodProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final languageProvider = context.watch<LanguageProvider>(); // ✅ ADD THIS

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      /// 🌍 LANGUAGE CONTROL (🔥 THIS IS THE KEY)
      locale: languageProvider.locale,

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,

      /// 🌗 THEME
      themeMode: themeProvider.themeMode,

      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.grey.shade200,
        fontFamily: 'Merriweather_48pt-MediumItalic',
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
        cardColor: Colors.grey.shade900,
        fontFamily: 'Merriweather_48pt-MediumItalic',
      ),

      home: const SplashScreen(),
    );
  }
}

