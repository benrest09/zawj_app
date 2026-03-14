// File: lib/handlers/login_handler.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zawj_app/controller/userController.dart';

class LoginHandler {
  static Future<bool> login({
    required BuildContext context,
    required String email,
    required String password,
    required VoidCallback onSuccess,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      _showSnackBar(context, 'Email dan password harus diisi', Colors.red);
      return false;
    }

    final user = await UserController.loginUser(email, password);

    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('user_id', user.id!);
      await prefs.setString('user_email', user.email ?? '');
      await prefs.setString('user_nama', user.nama ?? '');

      _showSnackBar(context, 'Login berhasil!', Colors.green);
      onSuccess();
      return true;
    } else {
      _showSnackBar(context, 'Email atau password salah', Colors.red);
      return false;
    }
  }

  static void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
