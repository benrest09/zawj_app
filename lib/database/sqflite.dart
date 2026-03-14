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

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        /// ================= USER TABLE =================
        await db.execute('''
        CREATE TABLE user(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nama TEXT NOT NULL,
          email TEXT NOT NULL UNIQUE,
          password TEXT NOT NULL,
          created_at TEXT
        )
        ''');

        /// ================= PROFILE TABLE =================
        await db.execute('''
        CREATE TABLE user_profiles(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER,

          nama_lengkap TEXT,
          jenis_kelamin TEXT,

          tanggal_lahir TEXT,
          usia INTEGER,
          tempat_lahir TEXT,

          domisili TEXT,
          suku TEXT,
          kewarganegaraan TEXT,

          pendidikan TEXT,
          pekerjaan TEXT,
          bidang_pekerjaan TEXT,
          penghasilan TEXT,

          target_nikah TEXT,

          wali_tahu INTEGER,
          bersedia_pindah INTEGER,

          tentang_saya TEXT,

          status_nikah TEXT,
          punya_anak INTEGER,
          jumlah_anak INTEGER,

          mau_poligami TEXT,

          sholat TEXT,
          kajian_rutin TEXT,
          hafalan_quran TEXT,

          bercadar INTEGER,
          panjang_hijab TEXT,

          foto_ktp TEXT,
          akte_cerai TEXT,
          bukti_sedekah TEXT,

          setuju_tidak_komunikasi_diluar_sistem INTEGER,
          setuju_satu_taaruf_satu_waktu INTEGER,
          setuju_kebijakan_privasi INTEGER,

          is_profile_complete INTEGER DEFAULT 0,

          created_at TEXT,
          updated_at TEXT
        )
        ''');

        /// ================= TAARUF REQUEST =================
        await db.execute('''
        CREATE TABLE taaruf_requests(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          pengaju_id INTEGER,
          target_id INTEGER,
          status TEXT DEFAULT 'pending',
          created_at TEXT
        )
        ''');

        /// ================= CHAT TAARUF =================
        await db.execute('''
        CREATE TABLE taaruf_messages(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          taaruf_id INTEGER,
          sender_id INTEGER,
          message TEXT,
          created_at TEXT
        )
        ''');
      },
    );
  }

  /// ================= REGISTER USER =================
  static Future<int> registerUser(UserModel user) async {
    final database = await db();
    return await database.insert('user', user.toMap());
  }

  /// ================= LOGIN USER =================
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

  /// CHECK EMAIL
  static Future<bool> isEmailExists(String email) async {
    final database = await db();

    final result = await database.query(
      'user',
      where: 'email = ?',
      whereArgs: [email],
    );

    return result.isNotEmpty;
  }

  /// ================= CREATE PROFILE =================
  static Future<int> createProfile(Map<String, dynamic> profile) async {
    final database = await db();
    return await database.insert('user_profiles', profile);
  }

  /// ================= GET PROFILE =================
  static Future<Map<String, dynamic>?> getProfileByUserId(int userId) async {
    final database = await db();

    final result = await database.query(
      'user_profiles',
      where: 'user_id = ?',
      whereArgs: [userId],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first;
    }

    return null;
  }

  /// ================= UPDATE PROFILE =================
  static Future<int> updateProfile(int id, Map<String, dynamic> data) async {
    final database = await db();

    return await database.update(
      'user_profiles',
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<bool> hasProfile(int userId) async {
    final database = await db();

    final result = await database.query(
      'user_profiles',
      where: 'user_id = ? AND is_profile_complete = 1',
      whereArgs: [userId],
    );

    return result.isNotEmpty;
  }

  /// ================= TAARUF REQUEST =================
  static Future<int> createTaarufRequest({
    required int pengajuId,
    required int targetId,
  }) async {
    final database = await db();

    return await database.insert('taaruf_requests', {
      'pengaju_id': pengajuId,
      'target_id': targetId,
      'status': 'pending',
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  /// ================= GET TAARUF =================
  static Future<List<Map<String, dynamic>>> getTaarufRequests(
    int userId,
  ) async {
    final database = await db();

    return await database.query(
      'taaruf_requests',
      where: 'target_id = ? OR pengaju_id = ?',
      whereArgs: [userId, userId],
    );
  }
}
