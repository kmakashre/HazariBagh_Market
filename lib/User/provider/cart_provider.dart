import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> cartItems = [];

  /// --- CHECKOUT FIELDS ---
  String? selectedAddress;
  String paymentMethod = "Cash On Delivery"; // Default

  /// --- ORDER SUMMARY FIELDS (for PlacedOrderScreen) ---
  // Tracks details of the last item added (as per your original logic)
  Map<String, dynamic>? lastAddedProduct;

  // Tracks a summary of the entire order (better for PlacedOrderScreen in a multi-item cart)
  Map<String, dynamic>? lastOrderSummary;


  /// Total cart item count (Number of unique items in the cart)
  int get cartCount => cartItems.length;

  /// Add item to cart
  void addItem(Map<String, dynamic> item) {
    // Check if the item already exists in the cart (to update quantity instead of adding duplicate entry)
    final existingItemIndex = cartItems.indexWhere(
            (cartItem) => cartItem["name"] == item["name"] && cartItem["store"] == item["store"]);

    if (existingItemIndex != -1) {
      // If found, just increase quantity
      cartItems[existingItemIndex]["qty"]++;
    } else {
      // If not found, add a new unique entry
      cartItems.add({
        "name": item["name"] ?? "Unknown Item",
        "price": item["price"] ?? 0.0,
        "mrp": item["mrp"] ?? 0.0,
        "qty": item["qty"] ?? 1, // Use provided qty or default to 1
        "image": item["image"] ?? "",
        "store": item["store"] ?? "",
      });
    }

    // Set fields required by PlacedOrderScreen
    lastAddedProduct = item;

    // 🔑 Generate a summary of the current order for the PlacedOrderScreen
    _generateOrderSummary();

    notifyListeners();
  }

  // 🔑 Helper method to create a summary map for the PlacedOrderScreen
  void _generateOrderSummary() {
    lastOrderSummary = {
      "items": cartItems,
      "subtotal": subtotal,
      "deliveryFee": deliveryFee,
      "total": total,
      "address": selectedAddress,
      "paymentMethod": paymentMethod,
    };
  }


  /// Select Address
  void setAddress(String address) {
    selectedAddress = address;
    // Update summary when address changes
    _generateOrderSummary();
    notifyListeners();
  }

  /// Set Payment Method
  void setPaymentMethod(String method) {
    paymentMethod = method;
    // Update summary when method changes
    _generateOrderSummary();
    notifyListeners();
  }

  /// Remove item from cart
  void removeItem(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems.removeAt(index);
      _generateOrderSummary();
      notifyListeners();
    }
  }

  /// Increase quantity
  void increaseQty(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems[index]["qty"]++;
      _generateOrderSummary();
      notifyListeners();
    }
  }

  /// Decrease quantity
  void decreaseQty(int index) {
    if (index >= 0 &&
        index < cartItems.length &&
        cartItems[index]["qty"] > 1) {
      cartItems[index]["qty"]--;
      _generateOrderSummary();
      notifyListeners();
    }
  }

  /// Subtotal
  double get subtotal {
    double total = 0;
    for (var item in cartItems) {
      // Ensure the price field is treated as a numeric type (double or int)
      final price = item["price"] is num ? item["price"] : double.tryParse(item["price"].toString()) ?? 0.0;
      final qty = item["qty"] is int ? item["qty"] : int.tryParse(item["qty"].toString()) ?? 1;

      total += (price * qty);
    }
    return total;
  }

  /// Delivery Fee (Fixed ₹40)
  double get deliveryFee => cartItems.isNotEmpty ? 40.0 : 0.0; // Use 40.0 for consistency

  /// Grand Total
  double get total => subtotal + deliveryFee;

  /// Clear Cart (After a successful order submission)
  void clearCart() {
    cartItems.clear();
    lastAddedProduct = null;
    lastOrderSummary = null;
    notifyListeners();
  }
}