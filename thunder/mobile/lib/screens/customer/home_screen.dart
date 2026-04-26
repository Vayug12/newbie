import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../providers/vendor_provider.dart";
import "../../providers/location_provider.dart";
import "../../widgets/category_item.dart";
import "../../widgets/promo_banner.dart";
import "../../widgets/search_field.dart";
import "../../widgets/vendor_card.dart";
import "service_categories_screen.dart";
import "vendor_list_screen.dart";
import "cleaning_detail_screen.dart";
import "plumber_detail_screen.dart";
import "appliance_repair_screen.dart";
import "pest_control_screen.dart";
import "carpenter_detail_screen.dart";
import "salon_detail_screen.dart";
import "festival_detail_screen.dart";

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final vendors = context.watch<VendorProvider>().vendors;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Location Header
                  Row(
                    children: [
                      Icon(Icons.location_on, color: theme.colorScheme.primary, size: 20),
                      const SizedBox(width: 8),
                      Consumer<LocationProvider>(
                        builder: (context, location, child) => Text(
                          location.currentAddress,
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down, size: 18),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Welcome Message
                  Text(
                    "What service do you\nneed today?",
                    style: theme.textTheme.headlineMedium?.copyWith(
                      height: 1.2,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Search Bar
                  const SearchField(),
                ],
              ),
            ),
          ),
          
          // Promo Carousel (Single for now)
          SliverToBoxAdapter(
            child: SizedBox(
              height: 160,
              child: PageView(
                controller: PageController(viewportFraction: 0.9),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: PromoBanner(
                      title: "AC Repair & Service",
                      subtitle: "Starting at ₹499 • 20% Off",
                      baseColor: const Color(0xFF6366F1),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ApplianceRepairScreen()),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: PromoBanner(
                      title: "Home Deep Cleaning",
                      subtitle: "Professional experts only",
                      baseColor: const Color(0xFF10B981),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CleaningDetailScreen()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Categories Grid
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text("Quick Services", style: theme.textTheme.titleLarge),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.7,
                    children: [
                      CategoryItem(
                        label: "Cleaning",
                        icon: Icons.cleaning_services,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const CleaningDetailScreen()),
                        ),
                      ),
                      CategoryItem(
                        label: "Appliances",
                        icon: Icons.tv,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ApplianceRepairScreen()),
                        ),
                      ),
                      CategoryItem(
                        label: "Plumber",
                        icon: Icons.plumbing,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const PlumberDetailScreen()),
                        ),
                      ),
                      CategoryItem(
                        label: "Carpenter",
                        icon: Icons.carpenter,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const CarpenterDetailScreen()),
                        ),
                      ),
                      CategoryItem(
                        label: "Salon",
                        icon: Icons.content_cut,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SalonDetailScreen()),
                        ),
                      ),
                      CategoryItem(
                        label: "Electrician",
                        icon: Icons.electric_bolt,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ApplianceRepairScreen()),
                        ),
                      ),
                      CategoryItem(
                        label: "Painter",
                        icon: Icons.format_paint,
                        onTap: () => _navigateToCategories(context),
                      ),
                      CategoryItem(
                        label: "Pest Control",
                        icon: Icons.bug_report,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const PestControlScreen()),
                        ),
                      ),
                      CategoryItem(
                        label: "Festival",
                        icon: Icons.celebration,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const FestivalDetailScreen()),
                        ),
                      ),
                      CategoryItem(
                        label: "View All",
                        icon: Icons.grid_view,
                        onTap: () => _navigateToCategories(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Recommended Vendors
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Recommended for You", style: theme.textTheme.titleLarge),
                          TextButton(
                            onPressed: () => _navigateToVendors(context),
                            child: const Text("View All"),
                          ),
                        ],
                      ),
                    );
                  }
                  final vendor = vendors[(index - 1) % vendors.length];
                  return VendorCard(
                    vendor: vendor,
                    onTap: () => _navigateToVendors(context),
                  );
                },
                childCount: vendors.isEmpty ? 1 : (vendors.length + 1).clamp(0, 5),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  void _navigateToCategories(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ServiceCategoriesScreen()),
    );
  }

  void _navigateToVendors(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const VendorListScreen()),
    );
  }
}
