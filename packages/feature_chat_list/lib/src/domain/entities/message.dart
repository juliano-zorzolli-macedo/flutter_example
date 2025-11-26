import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final String text;
  final String time;
  final bool isMe;
  final bool isRead;

  const Message({
    required this.id,
    required this.text,
    required this.time,
    required this.isMe,
    this.isRead = false,
  });

  @override
  List<Object?> get props => [id, text, time, isMe, isRead];
}