import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zawj_app/models/user_model.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> db() async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'find_my_zawj.db');

    print('Database path: $path');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        print('Creating database with table user...');
        await db.execute('''
          CREATE TABLE user (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE,
            password TEXT NOT NULL
          )
        ''');
      },
    );
  }

  static Future<int> registerUser(UserModel user) async {
    print('registerUser called');
    print('   User data: ${user.toMap()}');

    final database = await db();
    print('   Database: ${database != null ? "OK" : "NULL"}');

    final data = user.toMap();
    print('   Inserting data: $data');

    final result = await database.insert('user', data);
    print('   Insert result: $result');

    return result;
  }

  static Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    final database = await db();
    final results = await database.query(
      'user',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
      limit: 1,
    );
    if (results.isNotEmpty) {
      return UserModel.fromMap(results.first);
    }
    return null;
  }

  static Future<bool> isEmailExists(String email) async {
    final database = await db();
    final results = await database.query(
      'user',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );
    return results.isNotEmpty;
  }
}
