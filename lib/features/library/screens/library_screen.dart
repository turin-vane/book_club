import 'package:flutter/material.dart';
import '../../profile/screens/profile_screen.dart'; 

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

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
          // Barra de navegación superior
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.add, color: Color(0xFFF49CB3), size: 30),
                const Text('CLUB', style: TextStyle(fontSize: 16)),
                // BIBLIOTECA ahora está seleccionada (subrayada)
                Container(
                  padding: const EdgeInsets.only(bottom: 2),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFF49CB3), width: 2),
                    ),
                  ),
                  child: const Text(
                    'BIBLIOTECA',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                // PERFIL ahora es un botón q regresa
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileScreen()),
                    );
                  },
                  child: const Text('PERFIL', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                // Barra de búsqueda
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black, width: 1.5),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(2, 2),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: '',
                      prefixIcon: Icon(Icons.search, color: Colors.black, size: 20),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(color: Color(0xFFF49CB3), thickness: 1),
                
                // Sección: MIS FAVORITOS
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'MIS FAVORITOS',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 160,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildBookCover(color: const Color(0xFFE2E4D8), title: 'No More\nOverthinking'),
                      const SizedBox(width: 15),
                      _buildBookCover(color: const Color(0xFF1E3B4D), title: 'ANOTHER\nHOT\nSUMMER', titleColor: Colors.white),
                      const SizedBox(width: 15),
                      _buildBookCover(color: const Color(0xFFE2E4D8), title: 'No More\nOverthinking'),
                    ],
                  ),
                ),
                const Divider(color: Color(0xFFF49CB3), thickness: 1),

                // Sección: ACTIVIDAD RECIENTE
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'ACTIVIDAD RECIENTE',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildBookCoverWithStars(color: Colors.greenAccent, title: 'RULES FOR\nROMANCE'),
                      const SizedBox(width: 15),
                      _buildBookCoverWithStars(color: const Color(0xFF130944), title: 'Starborn', titleColor: Colors.orangeAccent),
                    ],
                  ),
                ),
                const Divider(color: Color(0xFFF49CB3), thickness: 1),

                // Sección: LEYENDO
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'LEYENDO',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 160,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildBookCover(color: Colors.greenAccent, title: 'RULES FOR\nROMANCE'),
                      const SizedBox(width: 15),
                      _buildBookCover(color: Colors.greenAccent, title: 'RULES FOR\nROMANCE'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget para portadas simples
  Widget _buildBookCover({required Color color, required String title, Color titleColor = Colors.black}) {
    return Container(
      width: 110,
      color: color,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: titleColor, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Widget para portadas con estrellas debajo (Actividad Reciente)
  Widget _buildBookCoverWithStars({required Color color, required String title, Color titleColor = Colors.black}) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 160,
          color: color,
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: titleColor, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
            (index) => const Icon(Icons.star, color: Colors.amber, size: 18),
          ),
        ),
      ],
    );
  }
}