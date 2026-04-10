import "package:flutter/material.dart";

class PlumberDetailScreen extends StatelessWidget {
  const PlumberDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Plumbing Services", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    "https://images.unsplash.com/photo-1585704032915-c3400ca199e7?auto=format&fit=crop&q=80&w=1000",
                    fit: BoxFit.cover,
                  ),
                  Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.7)]))),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSectionHeader("Major Installations"),
                _buildServiceItem(title: "Water Tank Setup", subtitle: "Cleaning & Installations", price: "Starting ₹799", icon: Icons.water_damage),
                _buildServiceItem(title: "Motor Installation", subtitle: "Pump setup and wiring", price: "Starting ₹499", icon: Icons.electric_bolt),
                
                _buildSectionHeader("Fixtures & Fittings"),
                _buildServiceItem(title: "Tap & Mixer", subtitle: "Repair / Installation / Uninstallation", price: "₹149", icon: Icons.water_drop),
                _buildServiceItem(title: "Basin & Sink", subtitle: "Installation / Leakage fix", price: "₹249", icon: Icons.wash),
                _buildServiceItem(title: "Toilet Work", subtitle: "Seat fix / Flush repair", price: "₹299", icon: Icons.bathroom),
                _buildServiceItem(title: "Bath / Shower", subtitle: "Mixer repair / Pipe fix", price: "₹349", icon: Icons.shower),
                _buildServiceItem(title: "Bath Accessories", subtitle: "Soap dish, towel rail, etc", price: "₹99", icon: Icons.accessibility_new),

                _buildSectionHeader("Repairs & Maintenance"),
                _buildServiceItem(title: "Drainage & Blockage", subtitle: "Pipe cleaning & unblocking", price: "₹399", icon: Icons.delete_sweep),
                _buildServiceItem(title: "Leakage & Connections", subtitle: "Pipe repair & joint fixes", price: "₹199", icon: Icons.plumbing),
                _buildServiceItem(title: "All Services Plumber", subtitle: "General checkup & multiple fixes", price: "₹499", icon: Icons.build_circle),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomCTA(context),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
    );
  }

  Widget _buildServiceItem({required String title, String? subtitle, required String price, required IconData icon}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade100)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: Colors.blue, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                if (subtitle != null) Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
              ],
            ),
          ),
          Text(price, style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.black)),
        ],
      ),
    );
  }

  Widget _buildBottomCTA(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 48),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]),
      child: FilledButton(
        onPressed: () {},
        style: FilledButton.styleFrom(minimumSize: const Size(double.infinity, 54), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
        child: const Text("Continue", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
