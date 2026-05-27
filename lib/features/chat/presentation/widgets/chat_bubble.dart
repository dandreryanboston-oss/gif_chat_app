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

    final hasGif =
        message.gifUrl.isNotEmpty;

    return Padding(
      padding:
          const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),

      child: Align(
        alignment:
            isUser
                ? Alignment.centerRight
                : Alignment.centerLeft,

        child: Column(
          crossAxisAlignment:
              isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,

          children: [
            /// MESSAGE CONTAINER
            Container(
              constraints:
                  BoxConstraints(
                maxWidth:
                    MediaQuery.of(
                          context,
                        ).size.width *
                        0.75,
              ),

              decoration:
                  BoxDecoration(
                color:
                    isUser
                        ? const Color(
                          0xff6C3BD0,
                        )
                        : Colors.white,

                borderRadius:
                    BorderRadius.only(
                  topLeft:
                      const Radius.circular(
                    22,
                  ),
                  topRight:
                      const Radius.circular(
                    22,
                  ),
                  bottomLeft:
                      Radius.circular(
                    isUser ? 22 : 6,
                  ),
                  bottomRight:
                      Radius.circular(
                    isUser ? 6 : 22,
                  ),
                ),

                boxShadow: [
                  BoxShadow(
                    color:
                        Colors.black.withOpacity(
                      0.06,
                    ),
                    blurRadius: 6,
                    offset:
                        const Offset(0, 2),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [
                  /// TEXT
                  if (message
                      .text
                      .trim()
                      .isNotEmpty)
                    Padding(
                      padding:
                          EdgeInsets.only(
                        left: 14,
                        right: 14,
                        top: 12,
                        bottom:
                            hasGif
                                ? 8
                                : 12,
                      ),

                      child: Text(
                        message.text,

                        style: TextStyle(
                          fontSize: 15,
                          height: 1.4,

                          color:
                              isUser
                                  ? Colors
                                      .white
                                  : Colors
                                      .black87,
                        ),
                      ),
                    ),

                  /// GIF IMAGE
                  if (hasGif)
                    ClipRRect(
                      borderRadius:
                          BorderRadius.only(
                        bottomLeft:
                            Radius.circular(
                          isUser
                              ? 18
                              : 6,
                        ),
                        bottomRight:
                            Radius.circular(
                          isUser
                              ? 6
                              : 18,
                        ),
                      ),

                      child: SizedBox(
                        height: 220,

                        child: Image.network(
                          message.gifUrl,

                          fit: BoxFit.contain,

                          loadingBuilder: (
                            context,
                            child,
                            loadingProgress,
                          ) {
                            if (loadingProgress ==
                                null) {
                              return child;
                            }

                            return Container(
                              height: 220,
                              alignment:
                                  Alignment
                                      .center,

                              child:
                                  const CircularProgressIndicator(),
                            );
                          },

                          errorBuilder: (
                            context,
                            error,
                            stackTrace,
                          ) {
                            return Container(
                              height: 220,
                              alignment:
                                  Alignment
                                      .center,

                              child: const Icon(
                                Icons
                                    .broken_image,
                                size: 40,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),

            /// TIME
            Padding(
              padding:
                  const EdgeInsets.only(
                top: 4,
                left: 8,
                right: 8,
              ),

              child: Text(
                _formatTime(),

                style: TextStyle(
                  fontSize: 11,
                  color:
                      Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime() {
    final now = DateTime.now();

    final hour =
        now.hour > 12
            ? now.hour - 12
            : now.hour;

    final minute =
        now.minute
            .toString()
            .padLeft(2, '0');

    final period =
        now.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }
}