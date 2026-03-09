import "package:flutter/material.dart";

import "../models/service_model.dart";
import "../models/vendor_model.dart";
import "../services/vendor_service.dart";

class VendorProvider extends ChangeNotifier {
  final VendorService _vendorService = VendorService();

  List<VendorModel> vendors = [];
  List<ServiceModel> services = [];
  bool loading = false;

  Future<void> fetchVendors() async {
    loading = true;
    notifyListeners();
    try {
      final data = await _vendorService.getVendors();
      final items = (data["data"]["items"] as List<dynamic>? ?? []);
      vendors = items.map((e) => VendorModel.fromJson(e as Map<String, dynamic>)).toList();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchServices() async {
    final data = await _vendorService.getServices();
    final items = (data["data"]["items"] as List<dynamic>? ?? []);
    services = items.map((e) => ServiceModel.fromJson(e as Map<String, dynamic>)).toList();
    notifyListeners();
  }
}
