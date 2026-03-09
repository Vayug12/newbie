import "package:flutter/material.dart";

import "../models/service_model.dart";

class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback? onTap;

  const ServiceCard({super.key, required this.service, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(service.name),
        subtitle: Text("${service.duration} mins"),
        trailing: Text("Rs ${service.price.toStringAsFixed(0)}"),
      ),
    );
  }
}
