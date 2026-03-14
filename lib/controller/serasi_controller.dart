// File: lib/controller/serasi_controller.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zawj_app/models/serasi_model.dart';
import 'dart:convert';

class SerasiController {
  // Ambil semua profil serasi (dummy data)
  Future<List<SerasiModel>> getSerasiProfiles({
    required int currentUserId,
    required String gender,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final savedProfiles = prefs.getStringList('serasi_profiles');

    if (savedProfiles != null && savedProfiles.isNotEmpty) {
      return savedProfiles.map((str) {
        final map = json.decode(str) as Map<String, dynamic>;
        return SerasiModel.fromMap(map);
      }).toList();
    }

    // Dummy data berdasarkan gender user
    final dummyProfiles = gender == 'Ikhwan'
        ? [
            SerasiModel(
              id: '1',
              nama: 'Fatimah Az-Zahra',
              usia: 26,
              domisili: 'Jakarta',
              pendidikan: 'S1 Psikologi',
              pekerjaan: 'Psikolog Klinis',
              tentangSaya:
                  'Muslimah yang ingin membangun rumah tangga sakinah, mawaddah, warahmah. Mencari pasangan yang istiqomah.',
              jenisKelamin: 'Akhwat',
              fotoUrl: 'akhwat',
              isOnline: true,
            ),
            SerasiModel(
              id: '2',
              nama: 'Aminah Salsabila',
              usia: 24,
              domisili: 'Bandung',
              pendidikan: 'S1 Teknik Informatika',
              pekerjaan: 'Software Engineer',
              tentangSaya:
                  'Suka membaca dan traveling. Ingin menemukan pasangan yang bisa diajak tumbuh bersama.',
              jenisKelamin: 'Akhwat',
              fotoUrl: 'akhwat',
              isOnline: false,
            ),
          ]
        : [
            SerasiModel(
              id: '3',
              nama: 'Ahmad Fauzi',
              usia: 28,
              domisili: 'Surabaya',
              pendidikan: 'S1 Ekonomi',
              pekerjaan: 'Entrepreneur',
              tentangSaya:
                  'Pecinta kopi dan teknologi. Mencari pasangan yang shalihah.',
              jenisKelamin: 'Ikhwan',
              fotoUrl: 'ikhwan',
              isOnline: true,
            ),
          ];

    // Simpan dummy data
    final List<String> profileStrings = dummyProfiles.map((profile) {
      return json.encode(profile.toMap());
    }).toList();
    await prefs.setStringList('serasi_profiles', profileStrings);

    return dummyProfiles;
  }

  // Simpan ajuan taaruf
  Future<bool> submitTaarufRequest({
    required String senderId,
    required String senderName,
    required String targetId,
    required String message,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final requests = prefs.getStringList('taaruf_requests') ?? [];

      final newRequest = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'senderId': senderId,
        'senderName': senderName,
        'targetId': targetId,
        'message': message,
        'timestamp': DateTime.now().toString(),
        'status': 'pending',
        'isRead': false,
      };

      requests.add(json.encode(newRequest));
      await prefs.setStringList('taaruf_requests', requests);

      return true;
    } catch (e) {
      print('Error submitting taaruf: $e');
      return false;
    }
  }
}
