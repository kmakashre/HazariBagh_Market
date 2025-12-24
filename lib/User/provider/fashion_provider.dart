import 'package:flutter/material.dart';

import '../../Model/category_model.dart';
import '../../Model/service_model.dart';


class FashionProvider extends ChangeNotifier {

  /// 🔹 CATEGORIES (USE KEYS, NOT TEXT)
  final List<CategoryModel> categories = [
    CategoryModel(
      id: "womens",
      title: "womensFashion", // 🔑 KEY
      image: "assets/images/woman.jpg",
    ),
    CategoryModel(
      id: "mens",
      title: "mensFashion", // 🔑 KEY
      image: "assets/images/man.jpg",
    ),
  ];

  /// 🔹 SERVICES (USE KEYS)
  final List<ServiceModel> services = [

    // ===================== 👨 MEN =====================

    ServiceModel(
      categoryId: "mens",
      title: "mensParlour",
      image: "assets/images/MensParlour&Grooming.jpg",
      description: "mensParlourDesc",
      servicesOffered: [
        "hairCut",
        "hairStyling",
        "facial",
        "massage",
        "beardTrim",
        "manicure",
        "pedicure",
      ],
      price: "price200",
      buttonText: "bookAppointment",
      contactPhone: "+91 98765 43210",
      contactEmail: "mensparlour@salon.com",
      location: "locationMainMarket",
    ),

    ServiceModel(
      categoryId: "mens",
      title: "mensHairStudio",
      image: "assets/images/MensHair&BeardStudio.jpg",
      description: "mensHairStudioDesc",
      servicesOffered: [
        "hairCut",
        "beardStyling",
        "hairColoring",
        "headMassage",
        "hairSpa",
      ],
      price: "price250",
      buttonText: "bookNow",
      contactPhone: "+91 99887 66554",
      contactEmail: "mensstudio@groom.com",
      location: "locationRanchiRoad",
    ),

    // ===================== 👩 WOMEN =====================

    ServiceModel(
      categoryId: "womens",
      title: "womensSalon",
      image: "assets/images/WomensSalon&BeautyServices.jpg",
      description: "womensSalonDesc",
      servicesOffered: [
        "hairSpa",
        "makeup",
        "facial",
        "threading",
        "waxing",
      ],
      price: "price300",
      buttonText: "bookAppointment",
      contactPhone: "+91 91234 56789",
      contactEmail: "womenssalon@beauty.com",
      location: "locationBusStand",
    ),

    ServiceModel(
      categoryId: "womens",
      title: "bridalMakeup",
      image: "assets/images/BridalMakeup&Makeover.jpg",
      description: "bridalMakeupDesc",
      servicesOffered: [
        "bridalMakeup",
        "engagementMakeup",
        "partyMakeup",
        "hairStyling",
      ],
      price: "price2500",
      buttonText: "bookBridal",
      contactPhone: "+91 88888 77777",
      contactEmail: "bridal@makeup.com",
      location: "locationCityCenter",
    ),
  ];

  /// 🔹 FILTER BY CATEGORY
  List<ServiceModel> getServicesByCategory(String categoryId) {
    return services
        .where((service) => service.categoryId == categoryId)
        .toList();
  }
}
