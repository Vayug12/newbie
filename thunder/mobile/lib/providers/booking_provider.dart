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

  Future<bool> createBooking({
    required String token,
    required String vendorId,
    required String serviceId,
    required String date,
    required String time,
  }) async {
    loading = true;
    notifyListeners();
    try {
      await _bookingService.createBooking(
        token: token,
        vendorId: vendorId,
        serviceId: serviceId,
        date: date,
        time: time,
      );
      return true;
    } catch (e) {
      debugPrint("Booking Error: $e");
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}

