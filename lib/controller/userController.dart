import 'package:zawj_app/database/sqflite.dart';
import 'package:zawj_app/models/user_model.dart';

class Usercontroller {
  static Future<void> registerPengguna(UserModel pengguna) async {
    final dbs = await DBHelper.db();
    await dbs.insert('pengguna', pengguna.toMap());
    print(pengguna.toMap());
  }

  static Future<List<UserModel>> getAllPengguna() async {
    final dbs = await DBHelper.db();
    final List<Map<String, dynamic>> results = await dbs.query("user");
    return results.map((e) => UserModel.fromMap(e)).toList();
  }
}
