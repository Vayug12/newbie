import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../providers/auth_provider.dart";
import "../../providers/booking_provider.dart";
import "../../widgets/booking_tile.dart";

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token = context.read<AuthProvider>().token;
      if (token != null) {
        context.read<BookingProvider>().fetchBookings(token);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookingProvider>();

    return provider.loading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: provider.bookings.length,
            itemBuilder: (_, index) => BookingTile(booking: provider.bookings[index]),
          );
  }
}
