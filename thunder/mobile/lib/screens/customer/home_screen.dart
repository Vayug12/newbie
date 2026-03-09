import "package:flutter/material.dart";

import "service_categories_screen.dart";
import "vendor_list_screen.dart";

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: ListTile(
            title: const Text("Browse Categories"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ServiceCategoriesScreen()),
            ),
          ),
        ),
        Card(
          child: ListTile(
            title: const Text("Find Nearby Vendors"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const VendorListScreen()),
            ),
          ),
        )
      ],
    );
  }
}
