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
        title: Text(mode ? "Vendor" : "Customer"),
        actions: const [Padding(padding: EdgeInsets.only(right: 12), child: ModeSwitchChip())],
      ),
      body: tabs[_index.clamp(0, tabs.length - 1)],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index.clamp(0, mode ? 3 : 2),
        onTap: (value) => setState(() => _index = value),
        items: mode
            ? const [
                BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
                BottomNavigationBarItem(icon: Icon(Icons.event_note), label: "Requests"),
                BottomNavigationBarItem(icon: Icon(Icons.work), label: "Jobs"),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
              ]
            : const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.book_online), label: "Bookings"),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
              ],
      ),
    );
  }
}
