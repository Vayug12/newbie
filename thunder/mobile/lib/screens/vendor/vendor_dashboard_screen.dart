import "package:flutter/material.dart";

class VendorDashboardScreen extends StatelessWidget {
  const VendorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Card(child: ListTile(title: Text("Today jobs"), subtitle: Text("3 scheduled"))),
        Card(child: ListTile(title: Text("Pending requests"), subtitle: Text("2 requests"))),
        Card(child: ListTile(title: Text("Earnings"), subtitle: Text("Rs 5,400 this week"))),
      ],
    );
  }
}
