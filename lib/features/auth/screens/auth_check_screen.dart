import 'package:flutter/material.dart';
import '../../../core/local_storage_service.dart';
import 'login_screen.dart';
import '../../profile/screens/profile_screen.dart';

class AuthCheckScreen extends StatefulWidget {
  const AuthCheckScreen({super.key});

  @override
  State<AuthCheckScreen> createState() => _AuthCheckScreenState();
}

class _AuthCheckScreenState extends State<AuthCheckScreen> {
  final LocalStorageService _storage = LocalStorageService();

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    final token = await _storage.getToken();

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      // Si hay token, enviamos al Perfil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    } else {
      // Si no hay token, enviamos al Login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFBB8CC), // Color rosa del tema
      body: Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}