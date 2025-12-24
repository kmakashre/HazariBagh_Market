import 'package:flutter/material.dart';

import '../../Model/hotel_category_model.dart';
import '../../Model/restaurant_model.dart';


class FoodProvider extends ChangeNotifier {

  bool _isLoading = false;
  List<HotelCategoryModel> _categories = [
  ]; // The grid items (Hotel, Restaurant, Cafe, etc.)

  List<RestaurantModel> _allRestaurants = [
  ]; // The comprehensive list of all restaurants/hotels

  bool get isLoading => _isLoading;

  List<HotelCategoryModel> get categories => _categories;

  List<RestaurantModel> get allRestaurants =>
      _allRestaurants; // Optional getter for all items

  FoodProvider() {
    _loadInitialData(); // Load categories
    _loadRestaurantData(); // Load all restaurants/hotels
  }

  /// 🏨 HOTEL/RESTAURANT CATEGORY DATA
  final List<HotelCategoryModel> _initialCategoryData = [
    // Ensure the title here exactly matches the 'category' in RestaurantModel
    HotelCategoryModel(
        title: "All", image: "assets/images/avin-cp-OlXUUQedQyM-unsplash.jpg"),
    HotelCategoryModel(title: "Hotel", image: "assets/images/bedroom.png"),
    HotelCategoryModel(
        title: "Restaurant", image: "assets/images/Beverages.jpg"),
    HotelCategoryModel(title: "Fast Food", image: "assets/images/clothe.jpg"),
    HotelCategoryModel(title: "Cafe", image: "assets/images/electronics.jpg"),
    HotelCategoryModel(title: "Bakery",
        image: "assets/images/eric-prouzet-52DMHPBAvXY-unsplash.jpg"),
    HotelCategoryModel(title: "Bar",
        image: "assets/images/giorgio-trovato-fczCr7MdE7U-unsplash.jpg"),
    HotelCategoryModel(title: "Sweets", image: "assets/images/grocery.jpg"),
  ];

  /// 🍽 DUMMY RESTAURANT/HOTEL DATA (Simulating API fetch)
  final List<RestaurantModel> _dummyRestaurantData = [
    RestaurantModel(
      id: 'h1',
      nameKey: 'hotelGrandPalace',
      typeKey: 'luxuryBuffet',
      image: "assets/images/hotel.jpg",
      rating: "4.8",
      time: "5-10 min",
      distance: "2.1 km",
      categoryKey: 'hotel',
    ),

    RestaurantModel(
      id: 'r1',
      nameKey: 'spiceParadise',
      typeKey: 'indianMughlaiBiryani',
      image: "assets/images/kitchan.png",
      rating: "4.5",
      time: "20–30 min",
      distance: "0.8 km",
      categoryKey: 'restaurant',
    ),

    RestaurantModel(
      id: 'f1',
      nameKey: 'pizzaCorner',
      typeKey: 'fastFoodPizza',
      image: "assets/images/oil.jpg",
      rating: "4.3",
      time: "25–35 min",
      distance: "1.2 km",
      categoryKey: 'fastFood',
    ),
  ];



  // Asynchronous data load for categories
  Future<void> _loadInitialData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    _categories = _initialCategoryData;
    _isLoading = false;
    notifyListeners();
  }

  // Asynchronous data load for all restaurants/hotels
  Future<void> _loadRestaurantData() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _allRestaurants = _dummyRestaurantData;
  }

  // Future method to refresh data (e.g., pulling down to refresh)
  Future<void> refreshItems() async {
    await _loadInitialData();
    await _loadRestaurantData();
  }

  /// METHOD TO FILTER RESTAURANTS FOR RestaurantListScreen
  List<RestaurantModel> getRestaurantsByCategory(String categoryKey) {
    if (categoryKey == 'all') {
      return _allRestaurants;
    }

    return _allRestaurants
        .where((r) => r.categoryKey == categoryKey)
        .toList();
  }
}