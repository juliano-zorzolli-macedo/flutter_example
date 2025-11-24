import 'package:equatable/equatable.dart';

class Conversation extends Equatable {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final String? avatarUrl;
  final int unreadCount;
  final bool isMuted;

  const Conversation({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.avatarUrl,
    this.unreadCount = 0,
    this.isMuted = false,
  });

  @override
  List<Object?> get props => [id, name, lastMessage, time, unreadCount, isMuted];
}