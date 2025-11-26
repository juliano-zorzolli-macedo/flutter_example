import '../entities/conversation.dart';
import '../entities/message.dart';

abstract class ChatRepository {
  Future<List<Conversation>> getConversations();
  Future<List<Message>> getChatHistory(String chatId, String lastMessage);
}