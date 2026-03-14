import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zawj_app/controller/userController.dart';
import 'package:zawj_app/models/user_model.dart';

class RegisterHandler {
  static Future<bool> register({
    required BuildContext context,
    required String nama,
    required String email,
    required String password,
    required String confirmPassword,
    required VoidCallback onSuccess,
  }) async {
    if (nama.isEmpty || email.isEmpty || password.isEmpty) {
      _showSnackBar(context, 'Semua data harus diisi', Colors.red);
      return false;
    }

    if (password != confirmPassword) {
      _showSnackBar(context, 'Password dan konfirmasi tidak sama', Colors.red);
      return false;
    }

    try {
      final newUser = UserModel(
        nama: nama.trim(),
        email: email.trim(),
        password: password,
        createdAt: DateTime.now().toIso8601String(),
      );

      final userId = await UserController.registerUser(newUser);

      if (userId > 0) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('user_id', userId);
        await prefs.setString('user_email', newUser.email);
        await prefs.setString('user_nama', newUser.nama);

        _showSnackBar(context, 'Registrasi berhasil!', Colors.green);
        onSuccess();
        return true;
      } else {
        _showSnackBar(context, 'Gagal registrasi', Colors.red);
        return false;
      }
    } catch (e) {
      _showSnackBar(context, 'Gagal: ${e.toString()}', Colors.red);
      return false;
    }
  }

  static void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
