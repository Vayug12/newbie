import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../providers/vendor_provider.dart";
import "../../widgets/service_card.dart";

class ServiceCategoriesScreen extends StatefulWidget {
  const ServiceCategoriesScreen({super.key});

  @override
  State<ServiceCategoriesScreen> createState() => _ServiceCategoriesScreenState();
}

class _ServiceCategoriesScreenState extends State<ServiceCategoriesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VendorProvider>().fetchServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VendorProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text("Service Categories")),
      body: ListView.builder(
        itemCount: provider.services.length,
        itemBuilder: (_, index) => ServiceCard(service: provider.services[index]),
      ),
    );
  }
}
