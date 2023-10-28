import 'package:flutter/material.dart' show ChangeNotifier;

class LodingProvider with ChangeNotifier {
  bool _isApiCalled = false;

  bool get isApiCalled => _isApiCalled;

  setloadingStatus(bool state) {
    _isApiCalled = state;
    notifyListeners();
  }
}
