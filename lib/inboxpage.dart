import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zawj_app/constant/app_color.dart';
import 'package:zawj_app/controller/inbox_controller.dart';
import 'package:zawj_app/models/taaruf_request_model.dart';
import 'package:zawj_app/groupchat.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  final InboxController _controller = InboxController();
  List<TaarufRequestModel> _requests = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  Future<void> _loadRequests() async {
    setState(() {
      _isLoading = true;
    });

    final requests = await _controller.getTaarufRequests();

    setState(() {
      _requests = requests;
      _isLoading = false;
    });
  }

  Future<void> _handleResponse(
    TaarufRequestModel request,
    String status,
  ) async {
    final success = await _controller.updateRequestStatus(
      requestId: request.id,
      status: status,
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            status == 'diterima' ? 'Ajuan diterima' : 'Ajuan ditolak',
          ),
          backgroundColor: status == 'diterima' ? Colors.green : Colors.red,
        ),
      );

      if (status == 'diterima') {
        final prefs = await SharedPreferences.getInstance();
        final chatRooms = prefs.getStringList('chat_rooms') ?? [];

        final chatRoomData = {
          'id': request.senderId,
          'name': request.senderName,
          'gender': 'Ikhwan',
          'lastMessage': request.message,
          'timestamp': DateTime.now().toIso8601String(),
        };

        chatRooms.add(json.encode(chatRoomData));
        await prefs.setStringList('chat_rooms', chatRooms);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GroupChatPage(
              participantName: request.senderName,
              mediatorName: 'Ustadz Pendamping',
              targetId: request.senderId,
              participantGender: 'Ikhwan',
            ),
          ),
        );
      } else {
        _loadRequests();
      }
    }
  }

  Future<void> _deleteRequest(TaarufRequestModel request) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Ajuan'),
        content: const Text('Apakah Anda yakin ingin menghapus ajuan ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final success = await _controller.deleteRequest(request.id);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ajuan berhasil dihapus'),
            backgroundColor: Colors.green,
          ),
        );
        _loadRequests();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Inbox Ajuan Taaruf',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _requests.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.mail_outline, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada ajuan taaruf',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: _loadRequests,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _requests.length,
                itemBuilder: (context, index) {
                  final request = _requests[index];
                  return _buildRequestCard(request);
                },
              ),
            ),
    );
  }

  Widget _buildRequestCard(TaarufRequestModel request) {
    final isPending = request.status == 'pending';
    final isAccepted = request.status == 'diterima';
    final isRejected = request.status == 'ditolak';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showDetailDialog(request),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF9A9E), Color(0xFFFECFEF)],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              request.senderName,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isPending
                                  ? Colors.orange[50]
                                  : isAccepted
                                  ? Colors.green[50]
                                  : Colors.red[50],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              isPending
                                  ? 'Pending'
                                  : isAccepted
                                  ? 'Diterima'
                                  : 'Ditolak',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: isPending
                                    ? Colors.orange[700]
                                    : isAccepted
                                    ? Colors.green[700]
                                    : Colors.red[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        request.message,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        request.timestamp,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDetailDialog(TaarufRequestModel request) {
    final isPending = request.status == 'pending';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(request.senderName),
        content: Text(request.message),
        actions: [
          if (isPending)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _handleResponse(request, 'ditolak');
              },
              child: const Text('Tolak'),
            ),
          if (isPending)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _handleResponse(request, 'diterima');
              },
              child: const Text('Terima'),
            ),
          if (!isPending)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteRequest(request);
              },
              child: const Text('Hapus'),
            ),
        ],
      ),
    );
  }
}
