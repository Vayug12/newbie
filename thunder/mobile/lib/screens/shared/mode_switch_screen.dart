import "package:flutter/material.dart";

import "../../widgets/mode_switch_chip.dart";

class ModeSwitchScreen extends StatelessWidget {
  const ModeSwitchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: ModeSwitchChip());
  }
}
