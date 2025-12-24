import 'package:flutter/material.dart';

import '../../Model/store_model.dart';

class StoreProvider extends ChangeNotifier {
  StoreModel? _selectedStore;

  /// GETTER
  StoreModel? get selectedStore => _selectedStore;

  /// SET STORE
  void setStore(StoreModel store) {
    _selectedStore = store;
    notifyListeners();
  }

  /// CLEAR STORE (optional)
  void clearStore() {
    _selectedStore = null;
    notifyListeners();
  }
}
