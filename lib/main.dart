import 'package:book_clubs/features/auth/screens/auth_check_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BookClubApp());
}

class BookClubApp extends StatelessWidget {
  const BookClubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFBB8CC), // Color rosa de fondo
        primaryColor: const Color(0xFFFBB8CC),
        fontFamily: 'Roboto', 
      ),
      home: const AuthCheckScreen(),
    );
  }
}