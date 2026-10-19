import 'package:flutter/material.dart';
import 'features/profile/screens/profile_screen.dart'; 

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
        scaffoldBackgroundColor: const Color(0xFFFBB8CC),
        primaryColor: const Color(0xFFFBB8CC),
        fontFamily: 'Roboto', 
      ),
      home: const ProfileScreen(), 
    );
  }
}