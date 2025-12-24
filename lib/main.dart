import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'User/provider/auth_provider.dart';
import 'User/provider/bottom_nav_provider.dart';
import 'User/provider/cart_provider.dart';
import 'User/provider/chat_Provider.dart';
import 'User/provider/fashion_provider.dart';
import 'User/provider/food_provider.dart';
import 'User/provider/grocery_provider.dart';
import 'User/provider/home_provider.dart';
import 'User/provider/hotel_provider.dart';
import 'User/provider/jobs_services_provider.dart';
import 'User/provider/language_provider.dart';
import 'User/provider/payment_provider.dart';
import 'User/provider/property_provider.dart';
import 'User/provider/store_provider.dart';
import 'User/provider/support_provider.dart';
import 'User/provider/theme_provider.dart';
import 'User/screen/splash_screen.dart';
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
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
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

