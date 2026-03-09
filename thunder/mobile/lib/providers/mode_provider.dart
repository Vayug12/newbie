import "package:flutter/material.dart";

class ModeProvider extends ChangeNotifier {
  bool _vendorMode = false;

  bool get isVendorMode => _vendorMode;

  void toggleMode() {
    _vendorMode = !_vendorMode;
    notifyListeners();
  }
}
