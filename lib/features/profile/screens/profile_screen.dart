import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // pra el archivo de la imagen
import '../../library/screens/library_screen.dart'; 
import '../../../core/local_storage_service.dart';
import 'reviews_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final LocalStorageService _storage = LocalStorageService();
  String _userEmail = "Cargando..."; // valor inicial dinámico
  File? _image; // var para almacenar la foto elegida
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Función para cargar el usuario desde el almacenamiento
  Future<void> _loadUserData() async {
    final email = await _storage.getRegisteredEmail();
    if (mounted) {
      setState(() {
        // Mostramos la primera parte del correo como nombre de usuario
        _userEmail = email != null ? email.split('@')[0] : "Usuario";
      });
    }
  }

  // Función para abrir la galería o cámara
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Menú inferior para elegir entre cámara o galería
  void _showImageSourceActionSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Elegir de la galería'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Tomar una foto'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBB8CC), // Fondo general rosa
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'BOOK\nCLUB',
          style: TextStyle(
            color: Color(0xFFFBB8CC),
            fontWeight: FontWeight.w900,
            fontSize: 20,
            height: 1.0,
          ),
        ),
        actions: [
          Center(
            child: Text(
              _userEmail.toUpperCase(), // Mostramos el nombre real del usuario
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Color(0xFFFBB8CC)),
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
                const Icon(Icons.add, color: Color(0xFFFBB8CC), size: 30),
                const Text('CLUB', style: TextStyle(fontSize: 16)),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LibraryScreen()),
                    );
                  },
                  child: const Text('BIBLIOTECA', style: TextStyle(fontSize: 16)),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 2),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFFBB8CC), width: 2),
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
                      // Avatar presionable
                      GestureDetector(
                        onTap: _showImageSourceActionSheet, // Abre el menú al tocar
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage: _image != null ? FileImage(_image!) : null,
                          child: _image == null
                              ? const Icon(Icons.person, size: 60, color: Color(0xFFFBB8CC))
                              : null,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _userEmail.toUpperCase(),
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '@$_userEmail',
                        style: const TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(color: Colors.white, thickness: 1),
                
                // Botón interactivo hacia las reseñas (CRUD)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ReviewsScreen()),
                      );
                  },
                  child: Container(
                    color: Colors.transparent, // Hace todo el row clickeable
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Mis Reseñas',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Estos quedarán de adorno por ahora en el perfil principal
                _buildReviewCard(
                  bookTitle: 'RULES FOR ROMANCE',
                  color: Colors.greenAccent,
                ),
                const Divider(color: Colors.white, thickness: 1),
                _buildReviewCard(
                  bookTitle: 'ANOTHER HOT SUMMER',
                  color: const Color(0xFF1E3B4D),
                  titleColor: Colors.white,
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