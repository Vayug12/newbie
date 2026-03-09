import "package:flutter/material.dart";

import "../models/vendor_model.dart";

class VendorCard extends StatelessWidget {
  final VendorModel vendor;
  final VoidCallback onTap;

  const VendorCard({super.key, required this.vendor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text(vendor.name),
        subtitle: Text(vendor.phone),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
