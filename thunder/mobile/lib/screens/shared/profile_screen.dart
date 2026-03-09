import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../providers/auth_provider.dart";

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(user?.name ?? "User"),
            subtitle: Text(user?.phone ?? ""),
          ),
        ),
        FilledButton(
          onPressed: () => context.read<AuthProvider>().logout(),
          child: const Text("Logout"),
        )
      ],
    );
  }
}
