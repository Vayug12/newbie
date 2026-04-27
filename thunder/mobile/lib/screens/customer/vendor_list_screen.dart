import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../providers/vendor_provider.dart";
import "../../widgets/vendor_card.dart";
import "vendor_detail_screen.dart";

class VendorListScreen extends StatelessWidget {
  final List<String>? selectedServices;
  const VendorListScreen({super.key, this.selectedServices});


  @override
  Widget build(BuildContext context) {
    final vendors = context.watch<VendorProvider>().vendors;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Service Providers"),
      ),
      body: vendors.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text(
                    "No vendors found nearby",
                    style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: vendors.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final vendor = vendors[index];
                return VendorCard(
                  vendor: vendor,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VendorDetailScreen(
                        vendor: vendor,
                        selectedServices: selectedServices,
                      ),
                    ),
                  ),

                );
              },
            ),
    );
  }
}
