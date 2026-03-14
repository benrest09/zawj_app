import 'package:zawj_app/database/sqflite.dart';

class TaarufController {
  Future<bool> sendTaarufRequest({
    required int pengajuId,
    required int targetId,
  }) async {
    try {
      final database = await DBHelper.db();

      await database.insert('taaruf_requests', {
        'pengaju_id': pengajuId,
        'target_id': targetId,
        'status': 'pending',
        'created_at': DateTime.now().toIso8601String(),
      });

      return true;
    } catch (e) {
      print("Error send taaruf: $e");
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getTaarufRequests(int userId) async {
    final database = await DBHelper.db();
    return await database.query(
      'taaruf_requests',
      where: 'pengaju_id = ? OR target_id = ?',
      whereArgs: [userId, userId],
    );
  }

  Future<void> updateTaarufStatus({
    required int taarufId,
    required String status,
  }) async {
    final database = await DBHelper.db();
    await database.update(
      'taaruf_requests',
      {'status': status},
      where: 'id = ?',
      whereArgs: [taarufId],
    );
  }
}
