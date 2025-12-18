import 'package:flutter/material.dart';
import '../Model/grocery_model.dart';
import '../Model/product_model.dart';

class GroceryProvider extends ChangeNotifier {

  bool _isLoading = false;
  List<GroceryItem> _groceryItems = [];

  List<ProductModel> _allProducts = [];

  bool get isLoading => _isLoading;
  List<GroceryItem> get groceryItems => _groceryItems;

  GroceryProvider() {
    _loadInitialData();
    _loadProductData();
  }

  ///  GROCERY CATEGORY DATA
  final List<GroceryItem> _initialData = [
    GroceryItem(title: "Vegetables", image: "assets/images/grocery.jpg"),
    GroceryItem(title: "Fruits", image: "assets/images/Fruits.jpg"),
    GroceryItem(title: "Rice", image: "assets/images/rice.jpg"),
    // 🔑 Note: Corrected case/spelling for exact matching
    GroceryItem(title: "Wheat", image: "assets/images/whete.jpg"),
    GroceryItem(title: "Oil", image: "assets/images/oil.jpg"),
    // 🔑 Note: Corrected case/spelling for exact matching
    GroceryItem(title: "Milk", image: "assets/images/grocery.jpg"),
    GroceryItem(title: "Snacks", image: "assets/images/snacks.jpg"),
    // 🔑 Note: Corrected case/spelling for exact matching
    GroceryItem(title: "Beverages", image: "assets/images/Beverages.jpg"),
    GroceryItem(title: "Spices", image: "assets/images/spices.jpg"),
    // 🔑 Note: Corrected case/spelling for exact matching
    GroceryItem(title: "Pulses", image: "assets/images/pules.jpg"),
  ];

  /// 🥦 DUMMY PRODUCT DATA (Simulating API fetch for actual items)
  final List<ProductModel> _dummyProducts = [

    // ------------------- VEGETABLES -------------------
    ProductModel(
      name: "Fresh Tomatoes",
      image: "assets/images/avin-cp-OlXUUQedQyM-unsplash.jpg",
      price: "₹40/kg",
      category: "Vegetables",
      storeName: "Gupta Grocery Store",
    ),
    ProductModel(
      name: "Onions (Local)",
      image: "assets/images/vivek-sharma-rDDICrot22U-unsplash.jpg",
      price: "₹25/kg",
      category: "Vegetables",
      storeName: "Gupta Grocery Store",
    ),

    // --------------------- FRUITS ---------------------
    ProductModel(
      name: "Apples (Shimla)",
      image: "assets/images/priscilla-du-preez-CoqJGsFVJtM-unsplash.jpg",
      price: "₹150/kg",
      category: "Fruits",
      storeName: "Sharma Grocery Store",
    ),

    // --------------------- RICE ---------------------
    ProductModel(
      name: "Basmati Rice",
      image: "assets/images/rice.jpg",
      price: "₹120/kg",
      category: "Rice",
      storeName: "Sharma Grocery Store",
    ),

    // --------------------- SNACKS ---------------------
    ProductModel(
      name: "Potato Chips",
      image: "assets/images/snacks.jpg",
      price: "₹30",
      category: "Snacks",
      storeName: "Delicious Food Point",
    ),

    // --------------------- BEVERAGES ---------------------
    ProductModel(
      name: "Soda Pack",
      image: "assets/images/Beverages.jpg",
      price: "₹200",
      category: "Beverages",
      storeName: "Delicious Food Point",
    ),

    // --------------------- SPICES ---------------------
    ProductModel(
      name: "Turmeric Powder",
      image: "assets/images/spices.jpg",
      price: "₹120/100g",
      category: "Spices",
      storeName: "Misra Grocery Store",
    ),

    // --------------------- PULSES ---------------------
    ProductModel(
      name: "Arhar Dal",
      image: "assets/images/pules.jpg",
      price: "₹110/kg",
      category: "Pulses",
      storeName: "Misra Grocery Store",
    ),
  ];



  // Asynchronous data load for categories
  Future<void> _loadInitialData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    _groceryItems = _initialData;
    _isLoading = false;
    notifyListeners();
  }

  // Asynchronous data load for products
  Future<void> _loadProductData() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _allProducts = _dummyProducts;
  }

  // Future method to refresh data (e.g., pulling down to refresh)
  Future<void> refreshItems() async {
    await _loadInitialData();
    await _loadProductData();
  }

  /// METHOD TO FILTER PRODUCTS FOR ProductListScreen
  List<ProductModel> getProductsByCategory(String category) {
    // Filter the comprehensive list based on the category title
    return _allProducts.where((p) => p.category == category).toList();
  }
}