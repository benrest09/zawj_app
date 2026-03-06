import 'package:flutter/material.dart';
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
    print(' RegisterHandler.register called');
    print('   Input nama: "$nama"');
    print('   Input email: "$email"');
    print('   Input password: "$password"');

    if (nama.isEmpty || email.isEmpty || password.isEmpty) {
      _showSnackBar(context, 'Semua data harus diisi', Colors.red);
      return false;
    }

    if (password != confirmPassword) {
      _showSnackBar(context, 'Password dan konfirmasi tidak sama', Colors.red);
      return false;
    }

    if (password.length < 6) {
      _showSnackBar(context, 'Password minimal 6 karakter', Colors.red);
      return false;
    }

    try {
      final newUser = UserModel(
        nama: nama.trim(),
        email: email.trim(),
        password: password,
      );

      print('📦 Created UserModel:');
      print('   nama: "${newUser.nama}"');
      print('   email: "${newUser.email}"');
      print('   password: "${newUser.password}"');

      await UserController.registerUser(newUser);

      _showSnackBar(
        context,
        'Registrasi berhasil! Silakan login',
        Colors.green,
      );
      onSuccess();
      return true;
    } catch (e) {
      print('❌ Register error: $e');
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
