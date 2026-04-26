import "package:flutter/material.dart";
import "vendor_list_screen.dart";

class PestControlScreen extends StatefulWidget {
  const PestControlScreen({super.key});

  @override
  State<PestControlScreen> createState() => _PestControlScreenState();
}

class _PestControlScreenState extends State<PestControlScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _includeUtensilRemoval = false;
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
              title: const Text("Pest Control", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    "https://images.unsplash.com/photo-1628177142898-93e36e4e3a50?auto=format&fit=crop&q=80&w=1000",
                    fit: BoxFit.cover,
                  ),
                  Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.7)]))),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(color: Colors.green.withOpacity(0.05), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.green.withOpacity(0.1))),
                    child: Row(
                      children: [
                        const Icon(Icons.security, size: 20, color: Colors.green),
                        const SizedBox(width: 12),
                        const Expanded(child: Text("Odorless & Herbal treatments available", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.green))),
                        Switch(
                          value: _includeUtensilRemoval,
                          onChanged: (val) => setState(() => _includeUtensilRemoval = val),
                          activeColor: Colors.green,
                        ),
                        const Text("Utensil Removal", style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  labelColor: theme.colorScheme.primary,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: theme.colorScheme.primary,
                  tabs: const [
                    Tab(text: "Standard"),
                    Tab(text: "Full Home"),
                    Tab(text: "Specialized"),
                  ],
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildStandardSection(),
                _buildFullHomeSection(),
                _buildSpecializedSection(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomCTA(context),
    );
  }

  Widget _buildStandardSection() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionHeader("Common Pests"),
        _buildServiceItem(title: "Cockroach Control", subtitle: "Gel treatment & Spray", price: "₹499", icon: Icons.bug_report),
        _buildServiceItem(title: "Ant Control", subtitle: "Targeted syrup/gel", price: "₹349", icon: Icons.pest_control),
        _buildServiceItem(title: "General Insect Treatment", subtitle: "Spiders, silverfish, etc", price: "₹599", icon: Icons.pest_control_rodent),
        _buildServiceItem(title: "Lizard Control", price: "₹399", icon: Icons.visibility),
        _buildSectionHeader("Area Specific"),
        _buildServiceItem(title: "Kitchen & Bathroom Pest", price: "₹699", icon: Icons.bathtub),
        _buildServiceItem(title: "Cockroach Removal (Cabinets)", price: "₹399", icon: Icons.inventory),
        _buildServiceItem(title: "Sink & Drainage Treatment", price: "₹249", icon: Icons.waves),
        _buildServiceItem(title: "Room-by-Room Treatment", price: "₹299/room", icon: Icons.meeting_room),
      ],
    );
  }

  Widget _buildFullHomeSection() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionHeader("Residential Packages"),
        _buildServiceItem(title: "Full Home (1 BHK)", subtitle: "Complete general treatment", price: "₹1,299", icon: Icons.home),
        _buildServiceItem(title: "Full Home (2 BHK)", price: "₹1,699", icon: Icons.home),
        _buildServiceItem(title: "Full Home (3 BHK)", price: "₹2,199", icon: Icons.home),
        _buildServiceItem(title: "Apartment Pest Control", price: "Starting ₹899", icon: Icons.apartment),
        _buildServiceItem(title: "Villa / Bungalow Treatment", price: "Starting ₹3,999", icon: Icons.villa),
        _buildSectionHeader("Maintenance"),
        _buildServiceItem(title: "Preventive Protection", subtitle: "6 months warranty", price: "₹2,499", icon: Icons.verified),
        _buildServiceItem(title: "Disinfection Services", subtitle: "Anti-bacterial spray", price: "₹799", icon: Icons.sanitizer),
      ],
    );
  }

  Widget _buildSpecializedSection() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionHeader("Heavy Infestation"),
        _buildServiceItem(title: "Termite Control", subtitle: "Anti-termite injections", price: "₹3,499", icon: Icons.format_paint),
        _buildServiceItem(title: "Bed Bug Treatment", subtitle: "Heat & Spray treatment", price: "₹1,499", icon: Icons.bed),
        _buildServiceItem(title: "Wood Borer treatment", price: "₹1,999", icon: Icons.handyman),
        _buildServiceItem(title: "Rodent (Rat/Mouse) Control", price: "₹699", icon: Icons.pest_control_rodent),
        _buildSectionHeader("Specialized Fixes"),
        _buildServiceItem(title: "Mosquito Control", subtitle: "Fogging & Mist", price: "₹899", icon: Icons.air),
        _buildServiceItem(title: "Fly & Insect Control", price: "₹499", icon: Icons.vibration),
        _buildServiceItem(title: "Deep Infestation Treatment", subtitle: "Intense cleanup + treatment", price: "₹2,999", icon: Icons.warning),
        _buildServiceItem(title: "Herbal / Odorless Treatment", subtitle: "Safe for kids & pets", price: "₹1,099", icon: Icons.eco),
        _buildServiceItem(title: "Gel treatment after spray", price: "₹299", icon: Icons.bubble_chart),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.green)),
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
          color: isSelected ? Colors.green.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? Colors.green : Colors.grey.shade100, width: isSelected ? 2 : 1),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.green : Colors.green.shade700, size: 24),
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
            if (isSelected) const Icon(Icons.check_circle, color: Colors.green, size: 22),
            if (!isSelected) Text(price, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
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
        style: FilledButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(double.infinity, 54), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
        child: Text(_selectedItems.isEmpty ? "Book Now" : "Continue with ${_selectedItems.length} items", style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
