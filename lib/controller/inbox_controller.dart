// File: lib/controller/inbox_controller.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zawj_app/models/taaruf_request_model.dart';
import 'dart:convert';

class InboxController {
  // Ambil semua ajuan taaruf
  Future<List<TaarufRequestModel>> getTaarufRequests() async {
    final prefs = await SharedPreferences.getInstance();
    final requests = prefs.getStringList('taaruf_requests') ?? [];

    return requests.map((str) {
      final map = json.decode(str) as Map<String, dynamic>;
      return TaarufRequestModel.fromMap(map);
    }).toList();
  }

  // Update status ajuan
  Future<bool> updateRequestStatus({
    required String requestId,
    required String status,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final requests = prefs.getStringList('taaruf_requests') ?? [];

      final updatedRequests = requests.map((str) {
        final map = json.decode(str) as Map<String, dynamic>;
        if (map['id'] == requestId) {
          map['status'] = status;
          map['isRead'] = true;
        }
        return json.encode(map);
      }).toList();

      await prefs.setStringList('taaruf_requests', updatedRequests);
      return true;
    } catch (e) {
      print('Error updating request: $e');
      return false;
    }
  }

  // Hapus ajuan
  Future<bool> deleteRequest(String requestId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final requests = prefs.getStringList('taaruf_requests') ?? [];

      final filteredRequests = requests.where((str) {
        final map = json.decode(str) as Map<String, dynamic>;
        return map['id'] != requestId;
      }).toList();

      await prefs.setStringList('taaruf_requests', filteredRequests);
      return true;
    } catch (e) {
      print('Error deleting request: $e');
      return false;
    }
  }
}
