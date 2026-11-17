import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _tokenKey = "auth_token";
  // Llaves para guardar la única cuenta permitida temporalmente
  static const String _registeredEmailKey = "registered_email";
  static const String _registeredPasswordKey = "registered_password";

  // --- MÉTODOS DE REGISTRO ---
  Future<void> registerUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_registeredEmailKey, email);
    await prefs.setString(_registeredPasswordKey, password);
  }

  Future<String?> getRegisteredEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_registeredEmailKey);
  }

  Future<String?> getRegisteredPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_registeredPasswordKey);
  }

  // --- MÉTODOS DE SESIÓN ACTIVA (TOKEN) ---
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}
