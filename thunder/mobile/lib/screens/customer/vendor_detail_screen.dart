import "package:flutter/material.dart";

import "booking_screen.dart";

class VendorDetailScreen extends StatelessWidget {
  final String vendorId;
  final String name;

  const VendorDetailScreen({super.key, required this.vendorId, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Rating: 4.5"),
            const Text("Experience: 5 years"),
            const Text("Price starts from Rs 499"),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => BookingScreen(vendorId: vendorId)),
              ),
              child: const Text("Book Appointment"),
            )
          ],
        ),
      ),
    );
  }
}
