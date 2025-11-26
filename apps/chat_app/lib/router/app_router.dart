import 'package:go_router/go_router.dart';
import 'package:feature_chat_list/feature_chat_list.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ChatListPage(),
      routes: [
        GoRoute(
          path: 'chat/:id',
          builder: (context, state) {
            final id = state.pathParameters['id'] ?? '';
            final extra = state.extra as Map<String, dynamic>?;
            final name = extra?['name'] ?? 'Conversa';
            final imageUrl = extra?['imageUrl'] ?? '';
            final lastMessage = extra?['lastMessage'] ?? '';
            return ChatDetailPage(
              chatId: id,
              chatName: name,
              imageUrl: imageUrl,
              lastMessage: lastMessage
            );
          },
        ),
      ],
    ),
  ],
);