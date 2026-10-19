import 'package:flutter/material.dart';
import 'package:book_club/features/library/screens/library_screen.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'BOOK\nCLUB',
          style: TextStyle(
            color: Color(0xFFF49CB3),
            fontWeight: FontWeight.w900,
            fontSize: 20,
            height: 1.0,
          ),
        ),
        actions: [
          const Center(
            child: Text(
              'USER NAME',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Color(0xFFF49CB3)),
            onPressed: () {}, 
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.add, color: Color(0xFFF49CB3), size: 30),
                const Text('CLUB', style: TextStyle(fontSize: 16)),
                
                // NUEVO: Envolvemos BIBLIOTECA en un GestureDetector
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LibraryScreen()),
                    );
                  },
                  child: const Text('BIBLIOTECA', style: TextStyle(fontSize: 16)),
                ),
                
                // PERFIL sigue subrayado aquí porque estamos en esta pantalla
                Container(
                  padding: const EdgeInsets.only(bottom: 2),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFF49CB3), width: 2),
                    ),
                  ),
                  child: const Text(
                    'PERFIL',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundColor: Color(0xFFF49CB3),
                        child: Icon(Icons.person, size: 60, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'NAME',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'nombre_usuario',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(color: Color(0xFFF49CB3), thickness: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Mis Reseñas',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.arrow_forward_ios, color: Color(0xFFF49CB3)),
                  ],
                ),
                const SizedBox(height: 20),
                _buildReviewCard(
                  bookTitle: 'RULES FOR ROMANCE',
                  author: 'BY OLIVIA NADAL',
                  color: Colors.greenAccent,
                ),
                const Divider(color: Color(0xFFF49CB3), thickness: 1),
                _buildReviewCard(
                  bookTitle: 'ANOTHER HOT SUMMER',
                  author: 'BY OLIVIA NADAL',
                  color: const Color(0xFF1E3B4D),
                  titleColor: Colors.white,
                ),
                const Divider(color: Color(0xFFF49CB3), thickness: 1),
                _buildReviewCard(
                  bookTitle: 'LOVE RIGHT NEXT DOOR',
                  author: '',
                  color: const Color(0xFFFDF0D5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard({
    required String bookTitle,
    required String author,
    required Color color,
    Color titleColor = Colors.black,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 120,
            color: color,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  bookTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(
                    5,
                    (index) => const Icon(Icons.star, color: Colors.amber, size: 20),
                  ),
                ),
                const SizedBox(height: 5),
                const Text('Fecha', style: TextStyle(fontSize: 14)),
                const SizedBox(height: 10),
                const Text(
                  'Descripción',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}