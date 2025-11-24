import 'package:equatable/equatable.dart';
import '../../domain/entities/conversation.dart';

sealed class ChatListState extends Equatable {
  const ChatListState();
  @override
  List<Object> get props => [];
}

class ChatListInitial extends ChatListState {}
class ChatListLoading extends ChatListState {}

class ChatListLoaded extends ChatListState {
  final List<Conversation> conversations;
  const ChatListLoaded(this.conversations);
  @override
  List<Object> get props => [conversations];
}

class ChatListError extends ChatListState {
  final String message;
  const ChatListError(this.message);
}