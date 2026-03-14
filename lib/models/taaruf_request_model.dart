// File: lib/models/taaruf_request_model.dart
class TaarufRequestModel {
  final String id;
  final String senderId;
  final String senderName;
  final String senderFoto;
  final String message;
  final String timestamp;
  final String status; // 'pending', 'diterima', 'ditolak'
  final bool isRead;

  TaarufRequestModel({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.senderFoto,
    required this.message,
    required this.timestamp,
    required this.status,
    required this.isRead,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'senderName': senderName,
      'senderFoto': senderFoto,
      'message': message,
      'timestamp': timestamp,
      'status': status,
      'isRead': isRead,
    };
  }

  factory TaarufRequestModel.fromMap(Map<String, dynamic> map) {
    return TaarufRequestModel(
      id: map['id'] ?? '',
      senderId: map['senderId'] ?? '',
      senderName: map['senderName'] ?? '',
      senderFoto: map['senderFoto'] ?? '',
      message: map['message'] ?? '',
      timestamp: map['timestamp'] ?? '',
      status: map['status'] ?? 'pending',
      isRead: map['isRead'] ?? false,
    );
  }
}
