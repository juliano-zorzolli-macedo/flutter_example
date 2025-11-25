import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class ChatDetailPage extends StatelessWidget {
  final String chatId;
  final String chatName;

  const ChatDetailPage({
    super.key,
    required this.chatId,
    required this.chatName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundChat, // Fundo bege
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            const DSAvatar(size: 36, imageUrl: null), // Placeholder
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
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                // Mensagens Mockadas
                DSMessageBubble(
                  text: "Olá! Tudo bem?",
                  time: "09:00",
                  isMe: false,
                ),
                DSMessageBubble(
                  text: "Tudo ótimo, e com você?",
                  time: "09:02",
                  isMe: true,
                  isRead: true,
                ),
                DSMessageBubble(
                  text: "Os dados da lista anterior foram salvos no KeyStore do Android! 🔐",
                  time: "09:05",
                  isMe: true,
                  isRead: false,
                ),
              ],
            ),
          ),
          // Input Area
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
    );
  }
}