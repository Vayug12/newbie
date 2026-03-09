import "package:flutter/material.dart";

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Card(child: ListTile(title: Text("Today"), trailing: Text("Rs 1,200"))),
        Card(child: ListTile(title: Text("This week"), trailing: Text("Rs 6,800"))),
        Card(child: ListTile(title: Text("This month"), trailing: Text("Rs 25,600"))),
      ],
    );
  }
}
