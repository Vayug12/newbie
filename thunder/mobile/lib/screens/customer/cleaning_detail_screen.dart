import "package:flutter/material.dart";
import "vendor_list_screen.dart";
import "booking_screen.dart";

class CleaningDetailScreen extends StatefulWidget {
  const CleaningDetailScreen({super.key});

  @override
  State<CleaningDetailScreen> createState() => _CleaningDetailScreenState();
}

class _CleaningDetailScreenState extends State<CleaningDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final List<String> _frequencies = ["One-time", "Weekly", "Monthly", "Yearly"];
  String _selectedFrequency = "One-time";

  // Track selected services
  final Set<String> _selectedServiceTitles = {};
  int _totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _toggleService(String title, String priceStr) {
    setState(() {
      final price = int.parse(priceStr.replaceAll(RegExp(r"[^0-9]"), ""));
      if (_selectedServiceTitles.contains(title)) {
        _selectedServiceTitles.remove(title);
        _totalPrice -= price;
      } else {
        _selectedServiceTitles.add(title);
        _totalPrice += price;
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
              title: const Text("Cleaning Services", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    "https://images.unsplash.com/photo-1527515637462-cff94eecc1ac?auto=format&fit=crop&q=80&w=1000",
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.blue.withOpacity(0.05),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, size: 14, color: Colors.blue),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Prices may vary based on your location (Saket, New Delhi)",
                      style: TextStyle(fontSize: 11, color: Colors.blue, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Select Frequency", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      DropdownButton<String>(
                        value: _selectedFrequency,
                        items: _frequencies.map((f) => DropdownMenuItem(value: f, child: Text(f))).toList(),
                        onChanged: (val) => setState(() => _selectedFrequency = val!),
                      ),
                    ],
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  labelColor: theme.colorScheme.primary,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: theme.colorScheme.primary,
                  tabs: const [
                    Tab(text: "Home"),
                    Tab(text: "Bathroom"),
                    Tab(text: "Kitchen"),
                  ],
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildHomeCleaning(context),
                _buildBathroomCleaning(context),
                _buildKitchenCleaning(context),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomCTA(context),
    );
  }

  Widget _buildHomeCleaning(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildServiceItem(
          title: "Full Home Cleaning",
          subtitle: "Deep cleaning of rooms, kitchen, and bathrooms",
          price: "₹1999",
          icon: Icons.home,
        ),
        _buildServiceItem(
          title: "Sofa Cleaning",
          subtitle: "Dirt and stain removal from fabric/leather",
          price: "₹599",
          icon: Icons.chair,
        ),
        _buildServiceItem(
          title: "Carpet Cleaning",
          subtitle: "Shampooing and deep extraction",
          price: "₹399",
          icon: Icons.layers,
        ),
      ],
    );
  }

  Widget _buildBathroomCleaning(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionHeader("Sub-Services"),
        _buildServiceItem(title: "Washbasin Clean", price: "₹99", icon: Icons.waves),
        _buildServiceItem(title: "Bathroom Door Clean", price: "₹79", icon: Icons.door_front_door),
        _buildServiceItem(title: "Bathroom Mirror Clean", price: "₹49", icon: Icons.visibility_outlined),
        _buildServiceItem(title: "Exhaust Fan Cleaning", price: "₹129", icon: Icons.air),
        _buildServiceItem(title: "Tiles and Floor Scrubbing", price: "₹249", icon: Icons.grid_on),
        _buildServiceItem(title: "Fittings & Fixtures", subtitle: "Commode, shower set, taps", price: "₹199", icon: Icons.bathtub),
        const Divider(height: 32),
        _buildSectionHeader("Full Service"),
        _buildServiceItem(title: "Full Bathroom Deep Cleaning", price: "₹499", icon: Icons.cleaning_services, isPremium: true),
        _buildServiceItem(title: "Combo: 2 Bathrooms", subtitle: "Save 15%", price: "₹849", icon: Icons.auto_awesome, isPremium: true),
      ],
    );
  }

  Widget _buildKitchenCleaning(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionHeader("Appliances & Specifics"),
        _buildServiceItem(title: "Gas Stove Cleaning", price: "₹149", icon: Icons.gas_meter),
        _buildServiceItem(title: "Chimney Cleaning", price: "₹349", icon: Icons.fireplace),
        _buildServiceItem(title: "Fridge Deep Cleaning", price: "₹299", icon: Icons.kitchen),
        _buildServiceItem(title: "Tap and Sink Polishing", price: "₹99", icon: Icons.water_drop),
        _buildSectionHeader("Structure"),
        _buildServiceItem(title: "Cabinets & Trolleys Internal", price: "₹399", icon: Icons.inventory),
        _buildServiceItem(title: "Kitchen Windows & Tiles", price: "₹249", icon: Icons.window),
        _buildServiceItem(title: "Exhaust / Kitchen Fan", price: "₹149", icon: Icons.air),
        const Divider(height: 32),
        _buildSectionHeader("Full Service"),
        _buildServiceItem(title: "Full Kitchen Deep Cleaning", price: "₹899", icon: Icons.soup_kitchen, isPremium: true),
        _buildServiceItem(title: "Kitchen + Tiles Combo", subtitle: "Most Popular", price: "₹1,099", icon: Icons.star, isPremium: true),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
    );
  }

  Widget _buildServiceItem({
    required String title,
    String? subtitle,
    required String price,
    required IconData icon,
    bool isPremium = false,
  }) {
    final isSelected = _selectedServiceTitles.contains(title);
    return GestureDetector(
      onTap: () => _toggleService(title, price),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.indigo.withOpacity(0.1) : (isPremium ? Colors.indigo.withOpacity(0.05) : Colors.white),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? Colors.indigo : (isPremium ? Colors.indigo.withOpacity(0.2) : Colors.grey.shade200), width: isSelected ? 2 : 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.indigo : (isPremium ? Colors.indigo.withOpacity(0.1) : Colors.grey.shade100),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: isSelected ? Colors.white : (isPremium ? Colors.indigo : Colors.grey.shade700), size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      if (isPremium) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(4)),
                          child: const Text("BEST VALUE", style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ],
                    ],
                  ),
                  if (subtitle != null) Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(price, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Colors.black)),
                Text(isSelected ? "Added" : "Add", style: TextStyle(color: isSelected ? Colors.green : Colors.indigo, fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomCTA(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Total Price", style: TextStyle(color: Colors.grey, fontSize: 12)),
              Text("₹$_totalPrice", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: FilledButton(
              onPressed: _selectedServiceTitles.isEmpty
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookingScreen(
                            selectedServices: _selectedServiceTitles.toList(),
                          ),
                        ),
                      );
                    },
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text("Continue", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
