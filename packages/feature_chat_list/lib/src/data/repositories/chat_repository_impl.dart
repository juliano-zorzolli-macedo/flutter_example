import '../../domain/entities/conversation.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_mock_datasource.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatMockDataSource dataSource;

  ChatRepositoryImpl(this.dataSource);

  @override
  Future<List<Conversation>> getConversations() async {
    return await dataSource.getConversations();
  }
}