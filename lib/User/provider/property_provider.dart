import 'package:flutter/material.dart';

import '../../Model/property_model.dart';

class PropertyProvider extends ChangeNotifier {
  bool _isLoading = false;

  String selectedType = "All";
  String selectedCategory = "All";

  PropertyModel? _selectedProperty;

  bool get isLoading => _isLoading;
  PropertyModel? get selectedProperty => _selectedProperty;

  final List<PropertyModel> _allProperties = [
    PropertyModel(
      title: "2 BHK Flat",
      price: "₹8,000 / month",
      image: "assets/images/bedroom.png",
      type: "For Rent",
      category: "Flats",
      location: "Civil Lines, Hazaribagh",
      area: "600 sq.ft",
      bedInfo: "2 Beds • 2 Bath",
      description:
      "Spacious 2 BHK flat located in a prime area, suitable for families.",
      contactName: "Mr. Raj Singh",
      contactEmail: "raj.singh@gmail.com",
      contactPhone: "+91 9876543210",
    ),
    PropertyModel(
      title: "Independent Home",
      price: "₹45 Lakhs",
      image: "assets/images/kitchan.png",
      type: "For Sale",
      category: "Home",
      location: "Matwari, Hazaribagh",
      area: "1200 sq.ft",
      bedInfo: "3 Beds • 3 Bath",
      description:
      "Independent house with parking and garden, ideal for large families.",
      contactName: "City Brokers",
      contactEmail: "citybrokers@gmail.com",
      contactPhone: "+91 9123456789",
    ),
    PropertyModel(
      title: "PG for Girls",
      price: "₹4,500 / month",
      image: "assets/images/bedroomSecond.png",
      type: "For Rent",
      category: "PG",
      location: "Canary Hill Road",
      area: "Single Room",
      bedInfo: "1 Bed",
      description:
      "Safe and affordable PG accommodation for girls near main road.",
      contactName: "Sushma Kumari (Owner)",
      contactEmail: "sushma.pg@gmail.com",
      contactPhone: "+91 9988776655",
    ),
  ];

  /// 🔍 FILTERED PROPERTIES
  List<PropertyModel> get filteredProperties {
    return _allProperties.where((p) {
      final typeMatch =
          selectedType == "All" || p.type == selectedType;
      final categoryMatch =
          selectedCategory == "All" || p.category == selectedCategory;
      return typeMatch && categoryMatch;
    }).toList();
  }

  void setType(String type) {
    selectedType = type;
    notifyListeners();
  }

  void setCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  void setSelectedProperty(PropertyModel property) {
    _selectedProperty = property;
    notifyListeners();
  }
}
