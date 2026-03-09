import "package:flutter/material.dart";

import "../models/booking_model.dart";
import "../services/booking_service.dart";

class BookingProvider extends ChangeNotifier {
  final BookingService _bookingService = BookingService();

  List<BookingModel> bookings = [];
  bool loading = false;

  Future<void> fetchBookings(String token) async {
    loading = true;
    notifyListeners();
    try {
      final data = await _bookingService.getBookings(token);
      final items = (data["data"]["items"] as List<dynamic>? ?? []);
      bookings = items.map((e) => BookingModel.fromJson(e as Map<String, dynamic>)).toList();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
