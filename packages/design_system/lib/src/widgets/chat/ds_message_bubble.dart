import 'package:design_system/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DSMessageBubble extends StatelessWidget {
  final String text;
  final String time;
  final bool isMe;
  final bool isRead;

  const DSMessageBubble({
    super.key,
    required this.text,
    required this.time,
    required this.isMe,
    this.isRead = false,
  });

  @override
  Widget build(BuildContext context) {
    final align = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final color = isMe ? AppColors.bubbleMe : AppColors.bubbleOther;
    const radius = Radius.circular(12);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: radius,
            topRight: radius,
            bottomLeft: isMe ? radius : Radius.zero,
            bottomRight: isMe ? Radius.zero : radius,
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 2, offset: const Offset(0, 1))
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 30, top: 8, bottom: 20),
              child: Text(text, style: const TextStyle(fontSize: 15)),
            ),
            Positioned(
              bottom: 4,
              right: 8,
              child: Row(
                children: [
                  Text(time, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                  if (isMe) ...[
                    const SizedBox(width: 4),
                    Icon(
                      Icons.done_all,
                      size: 14,
                      color: isRead ? Colors.blue : Colors.grey,
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}