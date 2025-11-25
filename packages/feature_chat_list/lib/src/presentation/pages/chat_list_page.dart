import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../presentation/bloc/chat_list_cubit.dart';
import '../bloc/chat_list_state.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<ChatListCubit>()..loadConversations(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
              'ChatApp',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)
          ),
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.add_circle_outline)),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Text('Buscar', style: TextStyle(color: Colors.grey[600]))
                  ],
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<ChatListCubit, ChatListState>(
                builder: (context, state) {
                  if (state is ChatListLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ChatListError) {
                    return Center(child: Text(state.message));
                  } else if (state is ChatListLoaded) {
                    return ListView.separated(
                      itemCount: state.conversations.length,
                      separatorBuilder: (_, __) => const Divider(height: 1, indent: 70),
                      itemBuilder: (context, index) {
                        final item = state.conversations[index];
                        return DSChatTile(
                          name: item.name,
                          lastMessage: item.lastMessage,
                          time: item.time,
                          avatarUrl: item.avatarUrl,
                          unreadCount: item.unreadCount,
                          isMuted: item.isMuted,
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}