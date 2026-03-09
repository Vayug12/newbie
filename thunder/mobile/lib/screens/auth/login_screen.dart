import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../providers/auth_provider.dart";
import "otp_screen.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: "Phone Number"),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: auth.loading
                    ? null
                    : () async {
                        final otp = await context.read<AuthProvider>().sendOtp(_phoneController.text.trim());
                        if (!context.mounted) return;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OtpScreen(phone: _phoneController.text.trim(), devOtp: otp),
                          ),
                        );
                      },
                child: Text(auth.loading ? "Sending..." : "Send OTP"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
