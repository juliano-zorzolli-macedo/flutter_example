import '../../domain/entities/conversation.dart';

class ChatMockDataSource {
  Future<List<Conversation>> getConversations() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      const Conversation(
        id: '1',
        name: 'Liga da Justiça',
        lastMessage: 'Chaves: reagiu 🥰 para "📷 Foto"',
        time: '15:19',
        unreadCount: 15,
        isMuted: true,
        avatarUrl: 'https://ui-avatars.com/api/?name=PP+Phiz&background=random',
      ),
      const Conversation(
        id: '2',
        name: 'Kiko',
        lastMessage: 'Primeiro me diz se você quer',
        time: '09:04',
        unreadCount: 5,
        avatarUrl: 'https://ui-avatars.com/api/?name=Phiz+Ai&background=ff9800&color=fff',
      ),
      const Conversation(
        id: '3',
        name: 'Seu Madruga',
        lastMessage: 'Só não te dou outra porque...',
        time: '09:02',
        unreadCount: 3,
        avatarUrl: 'https://ui-avatars.com/api/?name=Phiz+General&background=000&color=fff',
      ),
      const Conversation(
        id: '4',
        name: 'Chaves',
        lastMessage: 'Isso isso isso',
        time: '19/11',
        unreadCount: 0,
        avatarUrl: 'https://ui-avatars.com/api/?name=Pontini&background=ffeb3b&color=000',
      ),
      const Conversation(
        id: '5',
        name: 'Goku',
        lastMessage: 'A luta',
        time: '11/11',
        unreadCount: 0,
        avatarUrl: 'https://ui-avatars.com/api/?name=Robson+Alves&background=333&color=fff',
      ),
    ];
  }
}