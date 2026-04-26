import "package:flutter/material.dart";
import "vendor_list_screen.dart";

class FestivalDetailScreen extends StatefulWidget {
  const FestivalDetailScreen({super.key});

  @override
  State<FestivalDetailScreen> createState() => _FestivalDetailScreenState();
}

class _FestivalDetailScreenState extends State<FestivalDetailScreen> {
  final Set<String> _selectedItems = {};

  void _toggleService(String title) {
    setState(() {
      if (_selectedItems.contains(title)) {
        _selectedItems.remove(title);
      } else {
        _selectedItems.add(title);
      }
    });
  }

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
              title: const Text("Festival Services", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    "https://images.unsplash.com/photo-1511993226955-ce0484725350?auto=format&fit=crop&q=80&w=1000",
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
                _buildSectionHeader("Lighting & Decoration"),
                _buildServiceItem(title: "Balcony & Railing Lights", subtitle: "Safe installation and testing", price: "Starting ₹299", icon: Icons.light),
                _buildServiceItem(title: "Room & Mandir Setup", subtitle: "Decorative lights for pooja area", price: "Starting ₹199", icon: Icons.temple_hindu),
                _buildServiceItem(title: "Outdoor / Garden Lighting", subtitle: "Weatherproof setup", price: "₹499", icon: Icons.yard),
                _buildServiceItem(title: "Christmas & Custom Setup", subtitle: "As per your design/theme", price: "₹349", icon: Icons.celebration),
                _buildServiceItem(title: "Removal After Use", subtitle: "Safe dismantling & packing", price: "₹149", icon: Icons.cleaning_services),
                
                _buildSectionHeader("Electrical & Load"),
                _buildServiceItem(title: "Extra Plug Points", subtitle: "Temporary or permanent points", price: "₹149/pt", icon: Icons.power),
                _buildServiceItem(title: "Load Handling & Wiring", subtitle: "Main line setup for heavy decor", price: "₹399", icon: Icons.electrical_services),
                _buildServiceItem(title: "Extension & Connection", subtitle: "Safe board & wiring setup", price: "₹99", icon: Icons.settings_input_component),

                _buildSectionHeader("Structural & Walls"),
                _buildServiceItem(title: "Wooden Frame & Panels", subtitle: "Hanging support & structures", price: "Starting ₹599", icon: Icons.carpenter),
                _buildServiceItem(title: "Wall Makeover / Panels", subtitle: "Decorative wall installation", price: "₹899", icon: Icons.vignette),
                _buildServiceItem(title: "Painting Touch-up", subtitle: "Quick touch-up before event", price: "₹799", icon: Icons.format_paint),
                
                _buildSectionHeader("Event Packages"),
                _buildServiceItem(title: "Full Festival Setup", subtitle: "Lighting + Structure + Cleaning", price: "₹1,999", icon: Icons.auto_awesome),
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
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange)),
    );
  }

  Widget _buildServiceItem({required String title, String? subtitle, required String price, required IconData icon}) {
    final isSelected = _selectedItems.contains(title);
    return InkWell(
      onTap: () => _toggleService(title),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? Colors.orange : Colors.grey.shade100, width: isSelected ? 2 : 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: isSelected ? Colors.orange.withOpacity(0.1) : Colors.orange.withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: Colors.orange, size: 24),
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
            if (isSelected) const Icon(Icons.check_circle, color: Colors.orange, size: 22),
            if (!isSelected) Text(price, style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomCTA(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 48),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]),
      child: FilledButton(
        onPressed: _selectedItems.isEmpty ? null : () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VendorListScreen(selectedServices: _selectedItems.toList()),
            ),
          );
        },
        style: FilledButton.styleFrom(backgroundColor: Colors.orange, minimumSize: const Size(double.infinity, 54), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
        child: Text(_selectedItems.isEmpty ? "Book Now" : "Continue with ${_selectedItems.length} items", style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
