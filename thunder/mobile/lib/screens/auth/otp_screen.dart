import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../providers/auth_provider.dart";

class OtpScreen extends StatefulWidget {
  final String phone;
  final String? devOtp;

  const OtpScreen({super.key, required this.phone, this.devOtp});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Verify OTP")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("OTP sent to ${widget.phone}"),
            if (widget.devOtp != null) Text("Dev OTP: ${widget.devOtp}"),
            const SizedBox(height: 16),
            TextField(
              controller: _otpController,
              decoration: const InputDecoration(labelText: "Enter OTP"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: auth.loading
                    ? null
                    : () async {
                        await context.read<AuthProvider>().verifyOtp(widget.phone, _otpController.text.trim());
                        if (!context.mounted) return;
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                child: Text(auth.loading ? "Verifying..." : "Verify"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
