import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zawj_app/constant/app_color.dart';
import 'package:zawj_app/main_screen.dart';

class GroupChatPage extends StatefulWidget {
  final String participantName;
  final String mediatorName;
  final String targetId;
  final String participantGender;

  const GroupChatPage({
    super.key,
    required this.participantName,
    required this.mediatorName,
    required this.targetId,
    required this.participantGender,
  });

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  final TextEditingController _messageController = TextEditingController();

  final List<Map<String, String>> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  // ================= LOAD CHAT =================
  Future<void> _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();

    final saved = prefs.getStringList('chat_${widget.targetId}') ?? [];

    if (saved.isNotEmpty) {
      setState(() {
        _messages.clear();
        _messages.addAll(
          saved.map((e) => Map<String, String>.from(json.decode(e))),
        );
      });
    } else {
      _addWelcomeMessage();
    }
  }

  // ================= SAVE CHAT =================
  Future<void> _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();

    final encoded = _messages.map((e) => json.encode(e)).toList();

    await prefs.setStringList('chat_${widget.targetId}', encoded);
  }

  // ================= WELCOME MESSAGE =================
  void _addWelcomeMessage() async {
    _messages.add({
      'sender': 'system',
      'message':
          'Selamat datang di grup taaruf dengan ${widget.participantName}. Ustadz ${widget.mediatorName} akan memandu proses ini.',
      'time': DateTime.now().toString(),
    });

    await _saveMessages();
    setState(() {});
  }

  // ================= SEND MESSAGE =================
  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'sender': 'me',
        'message': _messageController.text.trim(),
        'time': DateTime.now().toString(),
      });
    });

    _messageController.clear();

    await _saveMessages();

    // simulasi balasan
    Future.delayed(const Duration(seconds: 2), () async {
      if (mounted) {
        setState(() {
          _messages.add({
            'sender': 'them',
            'message': "Wa'alaikumsalam, terima kasih atas pesannya.",
            'time': DateTime.now().toString(),
          });
        });

        await _saveMessages();
      }
    });
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen()),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const MainScreen()),
                (route) => false,
              );
            },
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.participantName,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                'Dipandu oleh ${widget.mediatorName}',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: AppColor.pinktua,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return _buildMessageBubble(msg);
                },
              ),
            ),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  // ================= MESSAGE BUBBLE =================
  Widget _buildMessageBubble(Map<String, String> msg) {
    final isMe = msg['sender'] == 'me';
    final isSystem = msg['sender'] == 'system';

    if (isSystem) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColor.pinkmuda.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              msg['message']!,
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(
                widget.participantGender == "ikhwan"
                    ? "assets/images/ikhwan.jpg"
                    : "assets/images/akhwat.jpg",
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isMe ? AppColor.pinktua : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: isMe ? const Radius.circular(16) : Radius.zero,
                  bottomRight: isMe ? Radius.zero : const Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                msg['message']!,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: isMe ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= INPUT =================
  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Tulis pesan...',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[400],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              maxLines: null,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: AppColor.pinktua,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white, size: 20),
              onPressed: _sendMessage,
              padding: const EdgeInsets.all(10),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
