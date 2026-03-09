import "package:flutter/material.dart";

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Card(child: ListTile(title: Text("Booking accepted"), subtitle: Text("Your booking for 10:30 was accepted"))),
        Card(child: ListTile(title: Text("Service reminder"), subtitle: Text("Technician arrives in 30 mins"))),
      ],
    );
  }
}
