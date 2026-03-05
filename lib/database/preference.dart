import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHandler {
  static const String _isLogin = 'isLogin';

  //create
  static Future<void> storingIsLogin(bool isLogin) async {
    final preference = await SharedPreferences.getInstance();
    await preference.setBool(_isLogin, isLogin);
  }

  //read
  static Future<bool?> getIsLogin() async {
    final preference = await SharedPreferences.getInstance();
    return preference.getBool(_isLogin);
  }

  //delete
  static Future<void> deleteIsLogin() async {
    final preference = await SharedPreferences.getInstance();
    await preference.remove(_isLogin);
  }
}
