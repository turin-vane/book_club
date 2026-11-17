import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../../../core/local_storage_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  final LocalStorageService _storage = LocalStorageService();

  void _registrarse() async {
    if (_usernameController.text.isEmpty || 
        _emailController.text.isEmpty || 
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Completa todos los campos"), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() { _isLoading = true; });

    await Future.delayed(const Duration(seconds: 2)); // Simulación de API
    
    await _storage.registerUser(
      _emailController.text.trim(), 
      _passwordController.text.trim()
    );

    if (!mounted) return;
    setState(() { _isLoading = false; });

    // Regresa a la pantalla de Login tras registrarse
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Registro exitoso, por favor inicia sesión"), backgroundColor: Colors.green),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              
              // Botón de retroceso
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 20),
              
              const Text(
                'CREA TU CUENTA',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 40),
              
              CustomTextField(
                controller: _usernameController,
                hintText: 'Nombre de usuario',
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: _emailController,
                hintText: 'usuario@correo.com',
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: _passwordController,
                hintText: 'Contraseña',
                isPassword: true,
              ),
              const SizedBox(height: 40),
              
              _isLoading
                  ? const Center(child: CircularProgressIndicator(color: Colors.white))
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      onPressed: _registrarse,
                      child: const Text(
                        'CREAR CUENTA',
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