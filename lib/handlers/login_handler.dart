import 'package:flutter/material.dart';
import 'package:zawj_app/controller/userController.dart';
import 'package:zawj_app/database/preference.dart';

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
      await PreferenceHandler.storingIsLogin(true);
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
