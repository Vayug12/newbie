import "package:flutter/material.dart";

import "../models/booking_model.dart";

class BookingTile extends StatelessWidget {
  final BookingModel booking;

  const BookingTile({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("${booking.date} at ${booking.time}"),
        subtitle: Text("Status: ${booking.status}"),
        trailing: Text(booking.paymentStatus),
      ),
    );
  }
}
