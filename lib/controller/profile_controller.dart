import 'package:zawj_app/database/sqflite.dart';
import 'package:zawj_app/models/userprofile_model.dart';

class ProfileController {
  Future<Map<String, dynamic>> saveProfile(UserprofileModel profile) async {
    try {
      final existingProfile = await DBHelper.getProfileByUserId(profile.userId);

      if (existingProfile != null) {
        final profileId = existingProfile['id'];

        await DBHelper.updateProfile(profileId, profile.toMap());

        return {
          'success': true,
          'message': 'Profil berhasil diupdate',
          'id': profileId,
        };
      } else {
        final profileId = await DBHelper.createProfile(profile.toMap());

        return {
          'success': true,
          'message': 'Profil berhasil disimpan',
          'id': profileId,
        };
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getProfile(int userId) async {
    try {
      final profileMap = await DBHelper.getProfileByUserId(userId);

      if (profileMap != null) {
        return {'success': true, 'data': UserprofileModel.fromMap(profileMap)};
      }

      return {'success': false, 'message': 'Profil tidak ditemukan'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<bool> checkProfileComplete(int userId) async {
    return await DBHelper.hasProfile(userId);
  }
}
