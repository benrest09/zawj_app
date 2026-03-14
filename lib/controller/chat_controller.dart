// File: lib/controller/chat_controller.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zawj_app/models/chatgroup_model.dart';

class ChatController {
  // Simpan chat group ke SharedPreferences
  Future<void> saveChatGroups(List<ChatGroupModel> chats) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> chatStrings = chats.map((chat) {
      return chat.toMap().toString();
    }).toList();
    await prefs.setStringList('chat_groups', chatStrings);
  }

  // Ambil semua chat group
  Future<List<ChatGroupModel>> getChatGroups() async {
    final prefs = await SharedPreferences.getInstance();
    final chatStrings = prefs.getStringList('chat_groups') ?? [];

    return chatStrings.map((str) {
      // Parse string kembali ke Map (simplified)
      return ChatGroupModel(
        id: '1',
        participantName: 'Fatimah Az-Zahra',
        mediatorName: 'Ustadz Ahmad Fauzi',
        lastMessage: 'Menurut saya, suami adalah pemimpin...',
        timestamp: '10:18',
        status: 'aktif',
        unreadCount: 2,
        participantAvatar: 'akhwat',
      );
    }).toList();
  }

  // Hapus chat yang sudah selesai
  Future<bool> deleteChat(String chatId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<ChatGroupModel> chats = await getChatGroups();

      // Hapus chat berdasarkan ID
      chats.removeWhere((chat) => chat.id == chatId);

      // Simpan ulang
      await saveChatGroups(chats);

      return true;
    } catch (e) {
      return false;
    }
  }

  // Update status chat
  Future<bool> updateChatStatus(String chatId, String status) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<ChatGroupModel> chats = await getChatGroups();

      // Update status
      final index = chats.indexWhere((chat) => chat.id == chatId);
      if (index != -1) {
        // Chat tidak bisa diubah langsung, jadi buat baru
        chats[index] = ChatGroupModel(
          id: chats[index].id,
          participantName: chats[index].participantName,
          mediatorName: chats[index].mediatorName,
          lastMessage: chats[index].lastMessage,
          timestamp: chats[index].timestamp,
          status: status,
          unreadCount: 0,
          participantAvatar: chats[index].participantAvatar,
        );

        await saveChatGroups(chats);
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  // Tambah chat baru (dummy data)
  Future<void> addDummyChats() async {
    final dummyChats = [
      ChatGroupModel(
        id: '1',
        participantName: 'Fatimah Az-Zahra',
        mediatorName: 'Ustadz Ahmad Fauzi',
        lastMessage: 'Menurut saya, suami adalah pemimpin...',
        timestamp: '10:18',
        status: 'aktif',
        unreadCount: 2,
        participantAvatar: 'akhwat',
      ),
      ChatGroupModel(
        id: '2',
        participantName: 'Aminah Salsabila',
        mediatorName: 'Ustadz Muhammad Rizki',
        lastMessage: 'Alhamdulillah proses taaruf telah s...',
        timestamp: 'Kemarin',
        status: 'selesai',
        unreadCount: 0,
        participantAvatar: 'akhwat',
      ),
    ];

    await saveChatGroups(dummyChats);
  }
}
