import "package:flutter/material.dart";
import "vendor_list_screen.dart";
import "booking_screen.dart";

class SalonDetailScreen extends StatefulWidget {
  const SalonDetailScreen({super.key});

  @override
  State<SalonDetailScreen> createState() => _SalonDetailScreenState();
}

class _SalonDetailScreenState extends State<SalonDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Set<String> _selectedItems = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Salon at Home", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    "https://images.unsplash.com/photo-1560066984-138dadb4c035?auto=format&fit=crop&q=80&w=1000",
                    fit: BoxFit.cover,
                  ),
                  Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.7)]))),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: TabBar(
              controller: _tabController,
              labelColor: theme.colorScheme.primary,
              unselectedLabelColor: Colors.grey,
              indicatorColor: theme.colorScheme.primary,
              tabs: const [
                Tab(text: "Women"),
                Tab(text: "Men"),
                Tab(text: "Packages"),
              ],
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildWomenSection(),
                _buildMenSection(),
                _buildPackagesSection(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomCTA(context),
    );
  }

  Widget _buildWomenSection() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionHeader("Face & Skin"),
        _buildServiceItem(title: "Cleanup / Facial", subtitle: "Fruit, Gold, Diamond, Hydra", price: "₹499", icon: Icons.face),
        _buildServiceItem(title: "Detan & Bleach", subtitle: "Face and body treatment", price: "₹299", icon: Icons.auto_fix_high),
        _buildServiceItem(title: "Waxing Rica / Roll-on", subtitle: "Full body or specific areas", price: "₹399", icon: Icons.waves),
        _buildServiceItem(title: "Threading", subtitle: "Eyebrows, upper lip, forehead", price: "₹49", icon: Icons.remove_red_eye_outlined),
        
        _buildSectionHeader("Hair Services"),
        _buildServiceItem(title: "Haircut & Styling", subtitle: "Styling, curls, blow dry", price: "₹349", icon: Icons.content_cut),
        _buildServiceItem(title: "Hair Spa & Colour", subtitle: "Root touch-up / Global", price: "₹799", icon: Icons.color_lens),
        _buildServiceItem(title: "Keratin / Botox / Smoothening", price: "₹2,499", icon: Icons.auto_awesome),
        
        _buildSectionHeader("Nails & Makeup"),
        _buildServiceItem(title: "Manicure & Pedicure", subtitle: "Basic / Spa pedicure", price: "₹599", icon: Icons.dry_cleaning),
        _buildServiceItem(title: "Nail Extensions & Art", subtitle: "Gel, Acrylic", price: "₹999", icon: Icons.star_outline),
        _buildServiceItem(title: "Makeup & Saree Draping", subtitle: "Party, Engagement, Bridal", price: "₹1,499", icon: Icons.palette_outlined),
      ],
    );
  }

  Widget _buildMenSection() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionHeader("Grooming"),
        _buildServiceItem(title: "Haircut & Styling", price: "₹199", icon: Icons.content_cut),
        _buildServiceItem(title: "Beard Trimming & Shaving", price: "₹99", icon: Icons.face_retouching_natural),
        _buildServiceItem(title: "Hair Colour", price: "₹299", icon: Icons.color_lens),
        
        _buildSectionHeader("Face & Spa"),
        _buildServiceItem(title: "Facial / Cleanup", price: "₹399", icon: Icons.face),
        _buildServiceItem(title: "Detan & Bleach", price: "₹249", icon: Icons.auto_fix_normal),
        _buildServiceItem(title: "Head Massage & Hair Spa", price: "₹299", icon: Icons.self_improvement),
        
        _buildSectionHeader("Other"),
        _buildServiceItem(title: "Men's Mani-Pedi", price: "₹499", icon: Icons.wash),
        _buildServiceItem(title: "Kids Haircut", price: "₹149", icon: Icons.child_care),
      ],
    );
  }

  Widget _buildPackagesSection() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionHeader("Combos & Deals"),
        _buildServiceItem(title: "Waxing + Facial + Mani-Pedi", subtitle: "Save 20%", price: "₹1,499", icon: Icons.card_giftcard),
        _buildServiceItem(title: "Family Grooming Package", subtitle: "For 3 members", price: "₹999", icon: Icons.groups),
        _buildSectionHeader("Special Events"),
        _buildServiceItem(title: "Pre-Bridal Package", price: "₹4,999", icon: Icons.auto_fix_high),
        _buildServiceItem(title: "Stress Relief Therapy", subtitle: "Neck & Back massage", price: "₹599", icon: Icons.spa),
        _buildServiceItem(title: "Deep Tissue / Ayurvedic Massage", price: "₹1,299", icon: Icons.favorite_border),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
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
          color: isSelected ? Colors.deepPurple.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? Colors.deepPurple : Colors.grey.shade100, width: isSelected ? 2 : 1),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.deepPurple : Colors.deepPurple.shade300, size: 24),
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
            if (isSelected) const Icon(Icons.check_circle, color: Colors.deepPurple, size: 22),
            if (!isSelected) Text(price, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple)),
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
              builder: (_) => BookingScreen(
                selectedServices: _selectedItems.toList(),
              ),
            ),
          );
        },
        style: FilledButton.styleFrom(backgroundColor: Colors.deepPurple, minimumSize: const Size(double.infinity, 54), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
        child: Text(_selectedItems.isEmpty ? "Continue" : "Continue with ${_selectedItems.length} items", style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
