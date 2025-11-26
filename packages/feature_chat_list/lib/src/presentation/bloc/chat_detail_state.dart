import 'package:equatable/equatable.dart';
import '../../domain/entities/message.dart';

sealed class ChatDetailState extends Equatable {
  const ChatDetailState();
  @override
  List<Object> get props => [];
}

class ChatDetailInitial extends ChatDetailState {}

class ChatDetailLoading extends ChatDetailState {}

class ChatDetailLoaded extends ChatDetailState {
  final List<Message> messages;
  const ChatDetailLoaded(this.messages);
  @override
  List<Object> get props => [messages];
}

class ChatDetailError extends ChatDetailState {
  final String message;
  const ChatDetailError(this.message);
}