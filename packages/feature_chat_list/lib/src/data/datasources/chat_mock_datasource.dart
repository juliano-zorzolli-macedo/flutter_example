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
        avatarUrl: 'https://rlv.zcache.com.br/adesivo_redondo_nome_da_liga_da_justica_e_logotipo_de_blindagem-r27ff34897b664b508cbc1485bbed7ae8_zg2qos_644.webp?rlvnet=1',
      ),
      const Conversation(
        id: '2',
        name: 'Kiko',
        lastMessage: 'Primeiro me diz se você quer',
        time: '09:04',
        unreadCount: 5,
        avatarUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSERLlvdL2uF6T3R64SlcfcArh3ps0Rw5X5ng&s',
      ),
      const Conversation(
        id: '3',
        name: 'Seu Madruga',
        lastMessage: 'Só não te dou outra porque...',
        time: '09:02',
        unreadCount: 3,
        avatarUrl: 'https://i0.wp.com/rafabarbosa.com/wp-content/uploads/2014/03/seu-madruga-e1401213118837.jpg?fit=300%2C168&ssl=1',
      ),
      const Conversation(
        id: '4',
        name: 'Chaves',
        lastMessage: 'Isso isso isso',
        time: '19/11',
        unreadCount: 0,
        avatarUrl: 'https://imagem.natelinha.uol.com.br/original/origem-do-chaves-no-sbt-e-revelada_52.jpeg',
      ),
      const Conversation(
        id: '5',
        name: 'Goku',
        lastMessage: 'A luta',
        time: '11/11',
        unreadCount: 0,
        avatarUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_Xfyf7Y_EBW3ScYgKRyGhxC_PyLjDQh24pg&s',
      ),
    ];
  }
}