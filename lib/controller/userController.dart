import 'package:zawj_app/database/sqflite.dart';
import 'package:zawj_app/models/user_model.dart';

class UserController {
  static Future<void> registerUser(UserModel user) async {
    try {
      final exists = await DBHelper.isEmailExists(user.email ?? '');

      if (exists) {
        throw Exception('Email sudah terdaftar');
      }

      await DBHelper.registerUser(user);
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserModel?> loginUser(String email, String password) async {
    try {
      return await DBHelper.loginUser(email: email, password: password);
    } catch (e) {
      return null;
    }
  }
}
