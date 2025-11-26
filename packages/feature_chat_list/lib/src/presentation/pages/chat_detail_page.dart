import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/chat_detail_cubit.dart';
import '../bloc/chat_detail_state.dart';

class ChatDetailPage extends StatelessWidget {
  final String chatId;
  final String chatName;
  final String imageUrl;

  const ChatDetailPage({
    super.key,
    required this.chatId,
    required this.chatName,
    required this.imageUrl
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<ChatDetailCubit>()..loadMessages(chatId),
      child: Scaffold(
        backgroundColor: AppColors.backgroundChat,
        appBar: AppBar(
          titleSpacing: 0,
          title: Row(
            children: [
              DSAvatar(size: 36, imageUrl: imageUrl),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  chatName,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
            IconButton(icon: const Icon(Icons.call), onPressed: () {}),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatDetailCubit, ChatDetailState>(
                builder: (context, state) {
                  if (state is ChatDetailLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.primary),
                    );
                  } else if (state is ChatDetailError) {
                    return Center(child: Text(state.message));
                  } else if (state is ChatDetailLoaded) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final msg = state.messages[index];
                        return DSMessageBubble(
                          text: msg.text,
                          time: msg.time,
                          isMe: msg.isMe,
                          isRead: msg.isRead,
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              color: Colors.white,
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add, color: AppColors.primary),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: "Mensagem",
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            filled: false,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: AppColors.primary),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}