import 'package:zawj_app/database/sqflite.dart';
import 'package:zawj_app/models/user_model.dart';

class UserController {
  static Future<void> registerUser(UserModel user) async {
    print('UserController.registerUser called');
    print('   User: ${user.toMap()}');

    try {
      final exists = await DBHelper.isEmailExists(user.email ?? '');
      print('   Email exists: $exists');

      if (exists) {
        throw Exception('Email sudah terdaftar');
      }

      await DBHelper.registerUser(user);
      print('User registered successfully');
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  static Future<UserModel?> loginUser(String email, String password) async {
    try {
      return await DBHelper.loginUser(email: email, password: password);
    } catch (e) {
      print('Error login: $e');
      return null;
    }
  }
}
