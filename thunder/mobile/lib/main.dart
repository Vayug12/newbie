import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:provider/provider.dart";

import "core/theme.dart";
import "providers/auth_provider.dart";
import "providers/booking_provider.dart";
import "providers/mode_provider.dart";
import "providers/vendor_provider.dart";
import "screens/auth/login_screen.dart";
import "screens/shared/main_shell.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(const ServiceMarketplaceApp());
}

class ServiceMarketplaceApp extends StatelessWidget {
  const ServiceMarketplaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ModeProvider()),
        ChangeNotifierProvider(create: (_) => VendorProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Service Marketplace",
        theme: AppTheme.lightTheme,
        home: Consumer<AuthProvider>(
          builder: (_, auth, __) => auth.isLoggedIn ? const MainShell() : const LoginScreen(),
        ),
      ),
    );
  }
}
