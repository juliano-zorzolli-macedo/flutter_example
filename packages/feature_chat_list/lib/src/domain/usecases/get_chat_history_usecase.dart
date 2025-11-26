import '../entities/message.dart';
import '../repositories/chat_repository.dart';

class GetChatHistoryUseCase {
  final ChatRepository repository;

  GetChatHistoryUseCase(this.repository);

  Future<List<Message>> call(String chatId, String lastMessage) async {
    return await repository.getChatHistory(chatId, lastMessage);
  }
}
