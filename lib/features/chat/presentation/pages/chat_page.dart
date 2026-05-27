import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/chat_provider.dart';
import '../widgets/chat_bubble.dart';

class ChatPage extends StatefulWidget {

  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final TextEditingController controller =
      TextEditingController();

  final ScrollController scrollController =
      ScrollController();

  void scrollToBottom() {

    Future.delayed(
      const Duration(milliseconds: 300),
      () {

        if (scrollController.hasClients) {

          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('GIF Chat'),
      ),

      body: Consumer<ChatProvider>(
        builder: (context, provider, child) {

          WidgetsBinding.instance
              .addPostFrameCallback((_) {
            scrollToBottom();
          });

          return Column(
            children: [

              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: provider.messages.length,
                  itemBuilder: (context, index) {

                    final message =
                        provider.messages[index];

                    return ChatBubble(
                      message: message,
                    );
                  },
                ),
              ),

              if (provider.isLoading)
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: TypingAnimation(),
                ),

              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [

                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration:
                            const InputDecoration(
                          hintText:
                              'Search GIFs...',
                          border:
                              OutlineInputBorder(),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    IconButton(
                      onPressed: () async {

                        await provider.sendMessage(
                          controller.text,
                        );

                        controller.clear();
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class TypingAnimation extends StatelessWidget {

  const TypingAnimation({super.key});

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment:
          MainAxisAlignment.start,
      children: const [

        SizedBox(width: 20),

        Text(
          'Typing...',
          style: TextStyle(fontSize: 16),
        ),

        SizedBox(width: 10),

        SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ],
    );
  }
}