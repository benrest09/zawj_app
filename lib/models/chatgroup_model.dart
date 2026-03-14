import 'dart:convert';

class ChatGroupModel {
  final String id;
  final String participantName;
  final String mediatorName;
  final String lastMessage;
  final String timestamp;
  final String status;
  final int unreadCount;
  final String participantAvatar;

  ChatGroupModel({
    required this.id,
    required this.participantName,
    required this.mediatorName,
    required this.lastMessage,
    required this.timestamp,
    required this.status,
    required this.unreadCount,
    required this.participantAvatar,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'participantName': participantName,
      'mediatorName': mediatorName,
      'lastMessage': lastMessage,
      'timestamp': timestamp,
      'status': status,
      'unreadCount': unreadCount,
      'participantAvatar': participantAvatar,
    };
  }

  factory ChatGroupModel.fromMap(Map<String, dynamic> map) {
    return ChatGroupModel(
      id: map['id'] ?? '',
      participantName: map['participantName'] ?? '',
      mediatorName: map['mediatorName'] ?? '',
      lastMessage: map['lastMessage'] ?? '',
      timestamp: map['timestamp'] ?? '',
      status: map['status'] ?? 'aktif',
      unreadCount: map['unreadCount'] ?? 0,
      participantAvatar: map['participantAvatar'] ?? 'ikhwan',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatGroupModel.fromJson(String source) =>
      ChatGroupModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
