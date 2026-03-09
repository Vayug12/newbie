import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../providers/vendor_provider.dart";
import "../../widgets/vendor_card.dart";
import "vendor_detail_screen.dart";

class VendorListScreen extends StatefulWidget {
  const VendorListScreen({super.key});

  @override
  State<VendorListScreen> createState() => _VendorListScreenState();
}

class _VendorListScreenState extends State<VendorListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VendorProvider>().fetchVendors();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VendorProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Vendors")),
      body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.vendors.length,
              itemBuilder: (_, index) {
                final vendor = provider.vendors[index];
                return VendorCard(
                  vendor: vendor,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => VendorDetailScreen(vendorId: vendor.id, name: vendor.name)),
                  ),
                );
              },
            ),
    );
  }
}
