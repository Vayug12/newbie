import "package:flutter/material.dart";

import "../models/user_model.dart";
import "../services/auth_service.dart";

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  String? _token;
  UserModel? _user;
  bool _loading = false;

  String? get token => _token;
  UserModel? get user => _user;
  bool get isLoggedIn => _token != null;
  bool get loading => _loading;

  Future<String?> sendOtp(String phone) async {
    _loading = true;
    notifyListeners();
    try {
      final data = await _authService.sendOtp(phone);
      return data["data"]?["otpForDev"] as String?;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> verifyOtp(String phone, String otp) async {
    _loading = true;
    notifyListeners();
    try {
      final data = await _authService.verifyOtp(phone, otp);
      _token = data["data"]["token"];
      _user = UserModel.fromJson(data["data"]["user"]);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void logout() {
    _token = null;
    _user = null;
    notifyListeners();
  }
}
