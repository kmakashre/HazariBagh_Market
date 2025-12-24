import 'package:flutter/material.dart';

import '../../Model/hotel_category_model.dart';
import '../../Model/product_model.dart';


class HotelProvider extends ChangeNotifier {

  bool _isLoading = false;
  List<HotelCategoryModel> _categories = [];
  List<ProductModel> _allProducts = []; // Using ProductModel for simplicity

  bool get isLoading => _isLoading;
  List<HotelCategoryModel> get categories => _categories;

  HotelProvider() {
    _loadInitialData();
    _loadProductData();
  }

  /// 🏨 HOTEL/RESTAURANT CATEGORY DATA
  final List<HotelCategoryModel> _initialData = [
    HotelCategoryModel(title: "Hotels", image: "assets/images/bedroom.png"),
    HotelCategoryModel(title: "Restaurants", image: "assets/images/avin-cp-OlXUUQedQyM-unsplash.jpg"),
    HotelCategoryModel(title: "Cafes", image: "assets/images/bedroomSecond.png"),
    HotelCategoryModel(title: "Fine Dining", image: "assets/images/Beverages.jpg"),
    HotelCategoryModel(title: "Fast Food", image: "assets/images/clothe.jpg"),
    HotelCategoryModel(title: "Bakery", image: "assets/images/electronics.jpg"),
  ];

  /// 🍽 DUMMY PRODUCT DATA (Hotels/Restaurants)
  final List<ProductModel> _dummyProducts = [

    ProductModel(
      name: "fresh_tomatoes",
      image: "assets/images/avin-cp-OlXUUQedQyM-unsplash.jpg",
      price: "₹40/kg",
      category: "Vegetables",
      storeName: "sharma_store",
    ),

    ProductModel(
      name: "onions_local",
      image: "assets/images/vivek-sharma-rDDICrot22U-unsplash.jpg",
      price: "₹25/kg",
      category: "Vegetables",
      storeName: "sharma_store",
    ),

    ProductModel(
      name: "apples_shimla",
      image: "assets/images/priscilla-du-preez-CoqJGsFVJtM-unsplash.jpg",
      price: "₹150/kg",
      category: "Fruits",
      storeName: "sharma_store",
    ),

    ProductModel(
      name: "basmati_rice",
      image: "assets/images/rice.jpg",
      price: "₹120/kg",
      category: "Rice",
      storeName: "sharma_store",
    ),

    ProductModel(
      name: "potato_chips",
      image: "assets/images/snacks.jpg",
      price: "₹30",
      category: "Snacks",
      storeName: "delicious_food_point",
    ),

    ProductModel(
      name: "soda_pack",
      image: "assets/images/Beverages.jpg",
      price: "₹200",
      category: "Beverages",
      storeName: "delicious_food_point",
    ),

    ProductModel(
      name: "turmeric_powder",
      image: "assets/images/spices.jpg",
      price: "₹120/100g",
      category: "Spices",
      storeName: "sharma_store",
    ),

    ProductModel(
      name: "arhar_dal",
      image: "assets/images/pules.jpg",
      price: "₹110/kg",
      category: "Pulses",
      storeName: "sharma_store",
    ),
  ];




  // Asynchronous data load for categories
  Future<void> _loadInitialData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    _categories = _initialData;
    _isLoading = false;
    notifyListeners();
  }

  // Asynchronous data load for products
  Future<void> _loadProductData() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _allProducts = _dummyProducts;
  }

  /// METHOD TO FILTER PRODUCTS FOR HotelProductListScreen
  List<ProductModel> getProductsByCategory(String category) {
    // Filter the comprehensive list based on the category title
    return _allProducts.where((p) => p.category == category).toList();
  }
}