import 'package:zawj_app/database/sqflite.dart';
import 'package:zawj_app/models/user_model.dart';

class UserController {
  static Future<int> registerUser(UserModel user) async {
    return await DBHelper.registerUser(user);
  }

  static Future<UserModel?> loginUser(String email, String password) async {
    return await DBHelper.loginUser(email: email, password: password);
  }

  static Future<bool> isEmailExists(String email) async {
    return await DBHelper.isEmailExists(email);
  }
}
