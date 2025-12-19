import 'package:flutter/material.dart';
import '../screen/All Categories/Property/property_listing_screen.dart';
import '../screen/All Categories/agriculture_screen.dart';
import '../screen/All Categories/automobile_screen.dart';
import '../screen/All Categories/education_screen.dart';
import '../screen/All Categories/fashion/fashion_screen.dart';
import '../screen/All Categories/food/food_screen.dart';
import '../screen/All Categories/government_screen.dart';
import '../screen/All Categories/Grocery/grocery_screen.dart';
import '../screen/All Categories/hardware_screen.dart';
import '../screen/All Categories/home_purchase_screen.dart';
import '../screen/All Categories/hospital_screen.dart';
import '../screen/All Categories/job/jobs_services_screen.dart';
import '../screen/All Categories/plot_screen.dart';
import '../screen/All Categories/services_screen.dart';
import '../screen/All Categories/transport_screen.dart';
import '../screen/All Categories/travel_screen.dart';
import '../screen/All Categories/water_screen.dart';
import '../screen/All Categories/wholesale_screen.dart';
import '../screen/All Categories/hotel/hotel_screen.dart';

/// 🔹 MODEL
class HomeCategoryModel {
  final String image;
  final String titleKey; // 🔥 localization key
  final Widget screen;

  HomeCategoryModel({
    required this.image,
    required this.titleKey,
    required this.screen,
  });
}

/// 🔹 CATEGORY LIST
final List<HomeCategoryModel> homeCategories = [
  HomeCategoryModel(
    image: "assets/Icons/job.png",
    titleKey: "jobs",
    screen: const JobsServicesScreen(),
  ),
  HomeCategoryModel(
    image: "assets/Icons/rental.png",
    titleKey: "rentalProperty",
    screen: const PropertyListingScreen(),
  ),
  HomeCategoryModel(
    image: "assets/Icons/food.png",
    titleKey: "foodDelivery",
    screen: const FoodHomeScreen(),
  ),
  HomeCategoryModel(
    image: "assets/Icons/fashion.png",
    titleKey: "fashionStore",
    screen: const FashionScreen(),
  ),
  HomeCategoryModel(
    image: "assets/Icons/grocery.png",
    titleKey: "groceryStore",
    screen: const GroceryScreen(),
  ),
  HomeCategoryModel(
    image: "assets/Icons/hotel.png",
    titleKey: "hotelsRestaurants",
    screen: const HotelScreen(),
  ),
  HomeCategoryModel(
    image: "assets/Icons/20lWater.png",
    titleKey: "water",
    screen: const WaterScreen(),
  ),
  HomeCategoryModel(
    image: "assets/Icons/education.png",
    titleKey: "education",
    screen: const EducationScreen(),
  ),
  HomeCategoryModel(
    image: "assets/Icons/hospital.png",
    titleKey: "hospital",
    screen: const HospitalScreen(),
  ),
  HomeCategoryModel(
    image: "assets/Icons/wholesale.png",
    titleKey: "wholesale",
    screen: const WholesaleScreen(),
  ),
  HomeCategoryModel(
    image: "assets/Icons/tour.png",
    titleKey: "travel",
    screen: const TravelScreen(),
  ),
  HomeCategoryModel(
    image: "assets/Icons/hardware.png",
    titleKey: "hardware",
    screen: const HardwareScreen(),
  ),
  HomeCategoryModel(
    image: "assets/Icons/purchase.png",
    titleKey: "plotLand",
    screen: const PlotScreen(),
  ),
  HomeCategoryModel(
    image: "assets/images/purchaseFlat.png",
    titleKey: "purchaseHome",
    screen: const HomePurchaseScreen(),
  ),
  HomeCategoryModel(
    image: "assets/Icons/professional.png",
    titleKey: "services",
    screen: const ServicesScreen(),
  ),
  HomeCategoryModel(
    image: "assets/Icons/Automobile.png",
    titleKey: "automobile",
    screen: const AutomobileScreen(),
  ),
  HomeCategoryModel(
    image: "assets/Icons/Government.png",
    titleKey: "government",
    screen: const GovernmentScreen(),
  ),
  HomeCategoryModel(
    image: "assets/Icons/transporation.png",
    titleKey: "transport",
    screen: const TransportScreen(),
  ),
  HomeCategoryModel(
    image: "assets/Icons/agriculture.png",
    titleKey: "agriculture",
    screen: const AgricultureScreen(),
  ),
];
