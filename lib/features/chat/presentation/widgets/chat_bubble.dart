import 'package:flutter/material.dart';

import '../../domain/entities/chat_message.dart';

class ChatBubble extends StatelessWidget {

  final ChatMessage message;

  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {

    final isUser = message.isUser;

    return Align(
      alignment:
          isUser
              ? Alignment.centerRight
              : Alignment.centerLeft,

      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 300,
        ),

        margin: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),

        padding: const EdgeInsets.all(14),

        decoration: BoxDecoration(

          color: isUser
              ? Colors.deepPurple
              : Colors.grey.shade900,

          borderRadius:
              BorderRadius.circular(20),
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(
              message.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),

            if (message.gifUrl.isNotEmpty) ...[

              const SizedBox(height: 12),

              ClipRRect(
                borderRadius:
                    BorderRadius.circular(15),

                child: Image.network(
                  message.gifUrl,
                  width: 250,
                  fit: BoxFit.cover,
                  loadingBuilder:
                      (context, child, loadingProgress) {

                    if (loadingProgress == null) {
                      return child;
                    }

                    return const Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}