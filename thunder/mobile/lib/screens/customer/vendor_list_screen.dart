import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../providers/vendor_provider.dart";
import "../../widgets/vendor_card.dart";
import "vendor_detail_screen.dart";

class VendorListScreen extends StatefulWidget {
  final List<String>? selectedServices;
  const VendorListScreen({super.key, this.selectedServices});

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
    final vendors = provider.vendors;
    final loading = provider.loading;
    final error = provider.error;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Service Providers"),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 64, color: Colors.redAccent),
                        const SizedBox(height: 16),
                        Text("Connection Error", style: theme.textTheme.titleLarge),
                        const SizedBox(height: 8),
                        Text(
                          error,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(height: 24),
                        FilledButton.icon(
                          onPressed: () => provider.fetchVendors(),
                          icon: const Icon(Icons.refresh),
                          label: const Text("Try Again"),
                        ),
                      ],
                    ),
                  ),
                )
              : vendors.isEmpty
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
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () => provider.fetchVendors(),
                        child: const Text("Retry"),
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
                            selectedServices: widget.selectedServices,
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
