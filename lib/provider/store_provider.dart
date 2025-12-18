import 'package:flutter/material.dart';
import '../Model/store_model.dart';

class StoreProvider extends ChangeNotifier {
  StoreModel? _selectedStore;

  /// ✅ GET SELECTED STORE
  StoreModel? get selectedStore => _selectedStore;

  /// ✅ SET / SELECT STORE
  void selectStore(StoreModel store) {
    _selectedStore = store;
    notifyListeners();
  }

  /// (Optional) CLEAR STORE
  void clearStore() {
    _selectedStore = null;
    notifyListeners();
  }
}
