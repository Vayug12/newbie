import "package:flutter/material.dart";

class ApplianceRepairScreen extends StatefulWidget {
  final String initialCategory;
  const ApplianceRepairScreen({super.key, this.initialCategory = "AC"});

  @override
  State<ApplianceRepairScreen> createState() => _ApplianceRepairScreenState();
}

class _ApplianceRepairScreenState extends State<ApplianceRepairScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final List<String> _plans = ["Standard", "Weekly Checkup", "Monthly Maintenance", "Annual Plan"];
  String _selectedPlan = "Standard";

  final List<String> _brands = ["Samsung", "LG", "Whirlpool", "Haier", "Bosch", "Panasonic", "Voltas", "Blue Star", "Croma", "Other"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    // Set initial tab based on initialCategory
    int initialIndex = 0;
    switch (widget.initialCategory) {
      case "AC": initialIndex = 0; break;
      case "Washing Machine": initialIndex = 1; break;
      case "Refrigerator": initialIndex = 2; break;
      case "Geyser": initialIndex = 3; break;
      case "Water Purifier": initialIndex = 4; break;
      case "Air Cooler": initialIndex = 5; break;
    }
    _tabController.index = initialIndex;
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
            expandedHeight: 180,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Appliances & Repair", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    "https://images.unsplash.com/photo-1581092921461-7d156820ef3c?auto=format&fit=crop&q=80&w=1000",
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
                _buildBrandSelector(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Service Plan", style: TextStyle(fontWeight: FontWeight.bold)),
                      DropdownButton<String>(
                        value: _selectedPlan,
                        items: _plans.map((p) => DropdownMenuItem(value: p, child: Text(p, style: const TextStyle(fontSize: 13)))).toList(),
                        onChanged: (val) => setState(() => _selectedPlan = val!),
                      ),
                    ],
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: theme.colorScheme.primary,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: theme.colorScheme.primary,
                  tabs: const [
                    Tab(text: "AC"),
                    Tab(text: "Washing Machine"),
                    Tab(text: "Refrigerator"),
                    Tab(text: "Geyser"),
                    Tab(text: "Water Purifier"),
                    Tab(text: "Air Cooler"),
                  ],
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildACSection(),
                _buildWashingMachineSection(),
                _buildFridgeSection(),
                _buildGeyserSection(),
                _buildPurifierSection(),
                _buildCoolerSection(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomCTA(context),
    );
  }

  Widget _buildBrandSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text("Select Brand", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: _brands.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text(_brands[index], style: const TextStyle(fontSize: 12)),
                  selected: false,
                  onSelected: (val) {},
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildACSection() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildServiceItem(title: "AC Regular Service", subtitle: "Filter cleaning, cooling check", price: "₹449", icon: Icons.ac_unit),
        _buildServiceItem(title: "AC Repair & Diagnosis", subtitle: "Noise or performance issues", price: "₹299", icon: Icons.build),
        _buildServiceItem(title: "Gas Refill", subtitle: "Standard gas top-up (up to 100g)", price: "₹999", icon: Icons.gas_meter),
        _buildServiceItem(title: "Installation", subtitle: "Professional mounting & testing", price: "₹1,200", icon: Icons.install_desktop),
        _buildServiceItem(title: "Uninstallation", price: "₹500", icon: Icons.remove_circle_outline),
        _buildServiceItem(title: "AC Plumbing / Drain Fix", subtitle: "Leakage or pipe issues", price: "₹199", icon: Icons.plumbing),
      ],
    );
  }

  Widget _buildWashingMachineSection() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildServiceItem(title: "Deep Cleaning / Descaling", price: "₹399", icon: Icons.local_laundry_service),
        _buildServiceItem(title: "Repair Service", subtitle: "Spin or motor issues", price: "₹349", icon: Icons.settings),
        _buildServiceItem(title: "Installation", price: "₹299", icon: Icons.add_to_home_screen),
        _buildServiceItem(title: "Uninstallation", price: "₹199", icon: Icons.remove_from_queue),
      ],
    );
  }

  Widget _buildFridgeSection() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionHeader("Single / Double / Side-by-Side"),
        _buildServiceItem(title: "Internal Cleaning", price: "₹299", icon: Icons.kitchen),
        _buildServiceItem(title: "General Repair", price: "₹399", icon: Icons.build),
        _buildServiceItem(title: "Power Issue Fix", subtitle: "Not turning on / wiring", price: "₹499", icon: Icons.power),
        _buildServiceItem(title: "Excess Cooling Repair", subtitle: "Thermostat issues", price: "₹449", icon: Icons.severe_cold),
        _buildServiceItem(title: "Installation", price: "₹349", icon: Icons.input),
        _buildServiceItem(title: "Uninstallation", price: "₹249", icon: Icons.output),
      ],
    );
  }

  Widget _buildGeyserSection() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildServiceItem(title: "Geyser Service/Cleaning", price: "₹249", icon: Icons.hot_tub),
        _buildServiceItem(title: "Repairing", price: "₹299", icon: Icons.healing),
        _buildServiceItem(title: "Installation", price: "₹399", icon: Icons.plumbing),
        _buildServiceItem(title: "Uninstallation", price: "₹249", icon: Icons.no_meeting_room),
      ],
    );
  }

  Widget _buildPurifierSection() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildServiceItem(title: "RO/Purifier Cleaning", price: "₹199", icon: Icons.water_drop),
        _buildServiceItem(title: "Repair & Filter Replace", price: "₹499", icon: Icons.filter_alt),
        _buildServiceItem(title: "Full Check up", price: "₹99", icon: Icons.fact_check),
        _buildServiceItem(title: "Installation", price: "₹349", icon: Icons.water),
      ],
    );
  }

  Widget _buildCoolerSection() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildServiceItem(title: "Cooler Cleaning", price: "₹149", icon: Icons.cleaning_services),
        _buildServiceItem(title: "Motor Repair / Replacement", price: "₹349", icon: Icons.electric_bolt),
        _buildServiceItem(title: "Full Check up", price: "₹99", icon: Icons.fact_check),
        _buildServiceItem(title: "Installation / Setup", price: "₹199", icon: Icons.window),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.indigo)),
    );
  }

  Widget _buildServiceItem({required String title, String? subtitle, required String price, required IconData icon}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade100)),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueGrey, size: 24),
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
          Text(price, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
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
