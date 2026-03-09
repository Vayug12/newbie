import "package:flutter/material.dart";

class BookingRequestsScreen extends StatelessWidget {
  const BookingRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: ListTile(
            title: const Text("House Cleaning - 10:30"),
            subtitle: const Text("Requested by customer"),
            trailing: Wrap(
              spacing: 8,
              children: [
                OutlinedButton(onPressed: () {}, child: const Text("Reject")),
                FilledButton(onPressed: () {}, child: const Text("Accept")),
              ],
            ),
          ),
        )
      ],
    );
  }
}
