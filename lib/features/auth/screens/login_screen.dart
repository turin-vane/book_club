import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../../profile/screens/profile_screen.dart'; // Importa la pantalla a donde irá al loguearse
import 'register_screen.dart';
import '../../../core/local_storage_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  final LocalStorageService _storage = LocalStorageService();

  void _iniciarSesion() async {
    // Validacion basica vacia
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ingresa tu usuario y contraseña"), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // 1. Obtener la cuenta registrada
    final registeredEmail = await _storage.getRegisteredEmail();
    final registeredPassword = await _storage.getRegisteredPassword();

    if (!mounted) return;
    setState(() { _isLoading = false; });

    // 2. Verificar si existe una cuenta
    if (registeredEmail == null || registeredEmail.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No existe ninguna cuenta. Regístrate primero."), backgroundColor: Colors.red),
      );
      return;
    }

    // 3. Validar las credenciales
    if (_emailController.text.trim() == registeredEmail && 
        _passwordController.text.trim() == registeredPassword) {
      
      // Credenciales correctas: Guardamos el token de sesión activa
      await _storage.saveToken("sesion_activa_book_club");
      
      if (!mounted) return;
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Correo o contraseña incorrectos"), backgroundColor: Colors.red),
      );
    }
  }
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView( // Para evitar errores si el teclado tapa la pantalla
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 80),
              
              // Título Principal
              const Text(
                'BIENVENIDO A\nBOOK\nCLUB',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 40),
              
              // Subtítulo
              const Text(
                'INICIAR SESIÓN',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              
              // Campos de texto personalizados
              CustomTextField(
                controller: _emailController,
                hintText: 'usuario@correo.com',
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: _passwordController,
                hintText: '****************',
                isPassword: true,
              ),
              const SizedBox(height: 40),
              
              // Botón Entrar
              _isLoading
                  ? const Center(child: CircularProgressIndicator(color: Colors.white))
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black, // Color del texto
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      onPressed: _iniciarSesion,
                      child: const Text(
                        'ENTRAR',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
              
              const SizedBox(height: 15),
              
              // Botón Registrarse
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.push( 
                    context,
                   MaterialPageRoute(builder: (context) => const RegisterScreen()),
                  );
                },
                child: const Text(
                  'REGISTRARSE',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}