import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../providers/auth_provider.dart";
import "../../services/booking_service.dart";

class BookingScreen extends StatefulWidget {
  final String vendorId;

  const BookingScreen({super.key, required this.vendorId});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _serviceIdController = TextEditingController();
  final _dateController = TextEditingController(text: "2026-03-10");
  final _timeController = TextEditingController(text: "10:30");
  final BookingService _bookingService = BookingService();

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Book Service")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _serviceIdController, decoration: const InputDecoration(labelText: "Service ID")),
            const SizedBox(height: 12),
            TextField(controller: _dateController, decoration: const InputDecoration(labelText: "Date (YYYY-MM-DD)")),
            const SizedBox(height: 12),
            TextField(controller: _timeController, decoration: const InputDecoration(labelText: "Time (HH:mm)")),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () async {
                  await _bookingService.createBooking(
                    token: auth.token!,
                    vendorId: widget.vendorId,
                    serviceId: _serviceIdController.text.trim(),
                    date: _dateController.text.trim(),
                    time: _timeController.text.trim(),
                  );
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Booking requested")));
                  Navigator.pop(context);
                },
                child: const Text("Confirm Booking"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
