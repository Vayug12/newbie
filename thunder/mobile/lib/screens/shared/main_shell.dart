import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../providers/mode_provider.dart";
import "../../widgets/mode_switch_chip.dart";
import "../customer/home_screen.dart";
import "../customer/my_bookings_screen.dart";
import "../vendor/vendor_dashboard_screen.dart";
import "../vendor/booking_requests_screen.dart";
import "../vendor/my_jobs_screen.dart";
import "../shared/profile_screen.dart";

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mode = context.watch<ModeProvider>().isVendorMode;

    final customerTabs = [
      const CustomerHomeScreen(),
      const MyBookingsScreen(),
      const ProfileScreen(),
    ];

    final vendorTabs = [
      const VendorDashboardScreen(),
      const BookingRequestsScreen(),
      const MyJobsScreen(),
      const ProfileScreen(),
    ];

    final tabs = mode ? vendorTabs : customerTabs;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          mode ? "Service Partner" : "Service Marketplace",
          style: theme.textTheme.titleLarge?.copyWith(
            letterSpacing: -0.5,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: ModeSwitchChip(),
          )
        ],
      ),
      body: tabs[_index.clamp(0, tabs.length - 1)],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _index.clamp(0, tabs.length - 1),
          onTap: (value) => setState(() => _index = value),
          elevation: 0,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: theme.colorScheme.primary,
          unselectedItemColor: Colors.grey.shade400,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          items: mode
              ? const [
                  BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), activeIcon: Icon(Icons.dashboard), label: "Dash"),
                  BottomNavigationBarItem(icon: Icon(Icons.notifications_outlined), activeIcon: Icon(Icons.notifications), label: "Inbox"),
                  BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), activeIcon: Icon(Icons.account_balance_wallet), label: "Earn"),
                  BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: "Profile"),
                ]
              : const [
                  BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined), activeIcon: Icon(Icons.calendar_today), label: "Bookings"),
                  BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: "Profile"),
                ],
        ),
      ),
    );
  }
}
