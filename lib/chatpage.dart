// File: lib/chatpage.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zawj_app/constant/app_color.dart';
import 'package:zawj_app/groupchat.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Map<String, dynamic>> chatRooms = [];

  @override
  void initState() {
    super.initState();
    loadChats();
  }

  // Fungsi untuk memuat semua room chat yang tersimpan
  Future<void> loadChats() async {
    final prefs = await SharedPreferences.getInstance();
    final chats = prefs.getStringList('chat_rooms') ?? [];

    setState(() {
      chatRooms = chats
          .map((e) => json.decode(e) as Map<String, dynamic>)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Tambahkan event listener untuk refresh saat kembali dari chat
    return WillPopScope(
      onWillPop: () async {
        loadChats(); // Refresh list saat back
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Find My Zawj',
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColor.pinkmuda,
                ),
              ),
              Text(
                'Pesan',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        body: chatRooms.isEmpty ? _emptyChat() : _chatList(),
      ),
    );
  }

  Widget _emptyChat() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF9A9E), Color(0xFFFECFEF)],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.chat_bubble_outline,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Belum ada percakapan',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Terima ajuan taaruf untuk memulai percakapan',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chatList() {
    return ListView.builder(
      itemCount: chatRooms.length,
      itemBuilder: (context, index) {
        final chat = chatRooms[index];
        // Cek gender untuk avatar yang benar
        final isFemale =
            chat["gender"] == "Akhwat" || chat["gender"] == "akhwat";

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: isFemale ? Colors.pink[100] : Colors.blue[100],
              backgroundImage: AssetImage(
                isFemale
                    ? "assets/images/akhwat.jpg"
                    : "assets/images/ikhwan.jpg",
              ),
            ),
            title: Text(
              chat["name"],
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              chat["lastMessage"] ?? "Belum ada pesan",
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Text(
              "now",
              style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => GroupChatPage(
                    participantName: chat["name"],
                    mediatorName: "Ustadz Pendamping",
                    targetId: chat["id"],
                    participantGender: chat["gender"],
                  ),
                ),
              ).then((_) => loadChats()); // Refresh saat kembali
            },
          ),
        );
      },
    );
  }
}
