import 'dart:convert';
import 'package:core_secure_storage/core_secure_storage.dart';
import '../../domain/entities/conversation.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_mock_datasource.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatMockDataSource dataSource;
  final CoreSecureStorage secureStorage;

  ChatRepositoryImpl(this.dataSource, this.secureStorage);

  @override
  Future<List<Conversation>> getConversations() async {
    final conversations = await dataSource.getConversations();

    try {
      final List<Map<String, dynamic>> jsonList = conversations.map((c) => {
        'id': c.id,
        'name': c.name,
        'lastMessage': c.lastMessage,
        'time': c.time,
        'unreadCount': c.unreadCount,
        'isMuted': c.isMuted,
        'avatarUrl': c.avatarUrl,
      }).toList();

      await secureStorage.saveChatList(jsonEncode(jsonList));

    } catch (e) {
      print("⚠️ Erro ao salvar cache nativo: $e");
    }
    return conversations;
  }

  @override
  Future<List<Message>> getChatHistory(String chatId, String lastMessage) async {
    return await dataSource.getChatHistory(chatId, lastMessage);
  }
}