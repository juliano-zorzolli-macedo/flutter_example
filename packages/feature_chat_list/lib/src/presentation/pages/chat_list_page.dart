import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/bloc/chat_list_cubit.dart';
import '../bloc/chat_list_state.dart';
import '../l10n/chat_l10n.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Acessa as strings injetadas via contexto
    final l10n = ChatL10n.of(context);

    return BlocProvider(
      create: (_) => GetIt.I<ChatListCubit>()..loadConversations(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(l10n.appTitle),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_circle_outline, color: AppColors.primary),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: DSSearchBar(
                hintText: l10n.actionSearch,
                readOnly: true,
                onTap: () {
                  // Futura navegação para busca
                  print("Clicou na busca");
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<ChatListCubit, ChatListState>(
                builder: (context, state) {
                  if (state is ChatListLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.primary),
                    );
                  } else if (state is ChatListError) {
                    return Center(
                      child: Text(state.message ?? l10n.errorGeneric),
                    );
                  } else if (state is ChatListLoaded) {
                    return ListView.separated(
                      itemCount: state.conversations.length,
                      separatorBuilder: (_, __) => const Divider(
                        height: 1,
                        indent: 70,
                        color: AppColors.surfaceNeutral,
                      ),
                      itemBuilder: (context, index) {
                        final item = state.conversations[index];
                        return InkWell(
                          onTap: () {
                            context.go(
                              '/chat/${item.id}',
                              extra: {'name': item.name, 'imageUrl': item.avatarUrl},
                            );
                          },
                          child: DSChatTile(
                            name: item.name,
                            lastMessage: item.lastMessage,
                            time: item.time,
                            avatarUrl: item.avatarUrl,
                            unreadCount: item.unreadCount,
                            isMuted: item.isMuted,
                          ),
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