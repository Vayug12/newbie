import "package:flutter/material.dart";

class MyJobsScreen extends StatelessWidget {
  const MyJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: ListTile(
            title: const Text("AC Service - 2:00 PM"),
            subtitle: const Text("Upcoming"),
            trailing: FilledButton(onPressed: () {}, child: const Text("Mark Complete")),
          ),
        )
      ],
    );
  }
}
