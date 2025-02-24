import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:myapp/pages/darling_page.dart';

class BiometricauthPage extends StatefulWidget {
  const BiometricauthPage({super.key});

  @override
  State<BiometricauthPage> createState() => _BiometricauthPageState();
}

class _BiometricauthPageState extends State<BiometricauthPage> {
  final LocalAuthentication auth = LocalAuthentication();

  // to instantly turn on this cheakAuth function as the file load
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => checkAuth()); // Call auth on load
  }

  Future<void> checkAuth() async {
    bool isAvailable;
    isAvailable = await auth.canCheckBiometrics;
    print(isAvailable);
    // cheak biometrics now
    if (isAvailable) {
      bool result = await auth.authenticate(
          localizedReason: 'Scan your Finger to proceed',
          options: const AuthenticationOptions(
            stickyAuth: true,
          ));
      if (result) {
        if (!mounted) return; // Prevent navigation after widget is disposed
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DarlingPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Authentication failed!")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Biometric authentication is not available.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
    );
  }
}
