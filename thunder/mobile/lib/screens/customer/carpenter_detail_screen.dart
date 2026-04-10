import "package:flutter/material.dart";

class CarpenterDetailScreen extends StatelessWidget {
  const CarpenterDetailScreen({super.key});

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
              title: const Text("Carpenter Services", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    "https://images.unsplash.com/photo-1533090161767-e6ffed986c88?auto=format&fit=crop&q=80&w=1000",
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
                _buildSectionHeader("Furniture Repair & Fixes"),
                _buildServiceItem(title: "Cupboard & Drawer Repair", subtitle: "Locks, latches, channels, hinges", price: "₹149", icon: Icons.straighten),
                _buildServiceItem(title: "Bed / Sofa Repair", subtitle: "Noise, support, joint tightening", price: "₹299", icon: Icons.bed),
                _buildServiceItem(title: "Chair & Table Repair", price: "₹199", icon: Icons.chair),
                _buildServiceItem(title: "Sliding Wardrobe & Soft Close", subtitle: "Hydraulic repair & adjustments", price: "₹349", icon: Icons.sync),
                
                _buildSectionHeader("Doors & Windows"),
                _buildServiceItem(title: "Door Installation / Repair", subtitle: "Alignment, noise, jam fixes", price: "₹249", icon: Icons.door_front_door),
                _buildServiceItem(title: "Door Lock & Closer", subtitle: "Fitting or replacement", price: "₹199", icon: Icons.lock),
                _buildServiceItem(title: "Window Frame Repair", price: "₹299", icon: Icons.window),

                _buildSectionHeader("Kitchen & Storage"),
                _buildServiceItem(title: "Kitchen Cabinet Fixing", subtitle: "Modular kitchen adjustments", price: "₹399", icon: Icons.kitchen),
                _buildServiceItem(title: "Shelf & Rack Installation", subtitle: "Wooden units, TV units, etc", price: "₹249", icon: Icons.inventory),
                
                _buildSectionHeader("Standard Installations"),
                _buildServiceItem(title: "Curtain Rod & Brackets", price: "₹99", icon: Icons.horizontal_rule),
                _buildServiceItem(title: "Mirror & Bathroom Fitting", price: "₹149", icon: Icons.visibility),
                _buildServiceItem(title: "Wall Hanger & Stand Fitting", price: "₹79", icon: Icons.dry_cleaning),

                _buildSectionHeader("Custom Work"),
                _buildServiceItem(title: "Multiple Small Fixes Bundle", price: "₹499", icon: Icons.build_circle),
                _buildServiceItem(title: "Consultation & Inspection", price: "₹99", icon: Icons.search),
                _buildServiceItem(title: "Modification & Resizing", price: "Starts ₹499", icon: Icons.edit),
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
      child: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.brown)),
    );
  }

  Widget _buildServiceItem({required String title, String? subtitle, required String price, required IconData icon}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade100)),
      child: Row(
        children: [
          Icon(icon, color: Colors.brown.shade400, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                if (subtitle != null) Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
              ],
            ),
          ),
          Text(price, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.brown)),
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
        style: FilledButton.styleFrom(backgroundColor: Colors.brown, minimumSize: const Size(double.infinity, 54), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
        child: const Text("Continue", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
