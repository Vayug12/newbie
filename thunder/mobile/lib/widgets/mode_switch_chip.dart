import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../providers/mode_provider.dart";

class ModeSwitchChip extends StatelessWidget {
  const ModeSwitchChip({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ModeProvider>();
    return FilterChip(
      selected: mode.isVendorMode,
      onSelected: (_) => context.read<ModeProvider>().toggleMode(),
      label: Text(mode.isVendorMode ? "Vendor Mode" : "Customer Mode"),
    );
  }
}
