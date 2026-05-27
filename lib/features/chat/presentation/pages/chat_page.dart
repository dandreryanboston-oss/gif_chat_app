import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/chat_provider.dart';
import '../widgets/chat_bubble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
  });

  @override
  State<ChatPage> createState() =>
      _ChatPageState();
}

class _ChatPageState
    extends State<ChatPage> {

  final TextEditingController
      controller =
      TextEditingController();

  final ScrollController
      scrollController =
      ScrollController();

  /// AUTO SCROLL
  void scrollToBottom() {

    Future.delayed(
      const Duration(
        milliseconds: 200,
      ),
      () {

        if (scrollController
            .hasClients) {

          scrollController.animateTo(
            scrollController
                .position
                .maxScrollExtent,

            duration:
                const Duration(
              milliseconds: 400,
            ),

            curve: Curves.easeOut,
          );
        }
      },
    );
  }

  /// SEND MESSAGE
  Future<void> sendMessage(
    ChatProvider provider,
  ) async {

    final text =
        controller.text.trim();

    if (text.isEmpty) return;

    controller.clear();

    await provider.sendMessage(
      text,
    );

    scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      resizeToAvoidBottomInset:
          true,

      backgroundColor:
          const Color(
        0xffECE5DD,
      ),

      /// APP BAR
      appBar: AppBar(

        elevation: 0,

        backgroundColor:
            const Color(
          0xff6C3BD0,
        ),

        titleSpacing: 0,

        title: Row(
          children: [

            const CircleAvatar(
              radius: 20,
              backgroundImage:
                  NetworkImage(
                'https://i.pravatar.cc/150?img=3',
              ),
            ),

            const SizedBox(
              width: 12,
            ),

            Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: const [

                Text(
                  'GIF Chat',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                SizedBox(
                  height: 2,
                ),

                Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      body: SafeArea(

        child:
            Consumer<ChatProvider>(
          builder: (
            context,
            provider,
            child,
          ) {

            WidgetsBinding.instance
                .addPostFrameCallback(
              (_) {
                scrollToBottom();
              },
            );

            return Column(
              children: [

                /// CHAT LIST
                Expanded(
                  child:
                      ListView.builder(
                    controller:
                        scrollController,

                    physics:
                        const BouncingScrollPhysics(),

                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),

                    itemCount:
                        provider
                            .messages
                            .length,

                    itemBuilder:
                        (
                      context,
                      index,
                    ) {

                      final message =
                          provider
                                  .messages[
                              index];

                      return Padding(
                        padding:
                            const EdgeInsets.only(
                          bottom: 10,
                        ),

                        child:
                            ChatBubble(
                          message:
                              message,
                        ),
                      );
                    },
                  ),
                ),

                /// TYPING INDICATOR
                if (provider
                    .isLoading)

                  const Padding(
                    padding:
                        EdgeInsets.only(
                      left: 14,
                      bottom: 10,
                    ),

                    child: Align(
                      alignment:
                          Alignment
                              .centerLeft,

                      child:
                          TypingAnimation(),
                    ),
                  ),

                /// INPUT AREA
                Container(

                  padding:
                      EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 10,
                    bottom:
                        MediaQuery.of(
                                  context,
                                )
                                .viewInsets
                                .bottom >
                            0
                        ? 10
                        : 18,
                  ),

                  decoration:
                      const BoxDecoration(
                    color:
                        Colors.white,

                    boxShadow: [

                      BoxShadow(
                        color:
                            Colors.black12,

                        blurRadius: 8,

                        offset:
                            Offset(
                          0,
                          -2,
                        ),
                      ),
                    ],
                  ),

                  child: Row(
                    children: [

                      /// TEXT INPUT
                      Expanded(
                        child:
                            Container(

                          padding:
                              const EdgeInsets.symmetric(
                            horizontal:
                                18,
                          ),

                          decoration:
                              BoxDecoration(
                            color:
                                Colors.grey
                                    .shade100,

                            borderRadius:
                                BorderRadius.circular(
                              30,
                            ),
                          ),

                          child:
                              TextField(
                            controller:
                                controller,

                            minLines:
                                1,

                            maxLines:
                                5,

                            textInputAction:
                                TextInputAction.send,

                            onSubmitted:
                                (_) =>
                                    sendMessage(
                              provider,
                            ),

                            decoration:
                                const InputDecoration(
                              border:
                                  InputBorder.none,

                              hintText:
                                  'Ask something...',
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      /// SEND BUTTON
                      GestureDetector(

                        onTap: () =>
                            sendMessage(
                          provider,
                        ),

                        child:
                            Container(
                          width: 54,
                          height: 54,

                          decoration:
                              const BoxDecoration(
                            color:
                                Color(
                              0xff6C3BD0,
                            ),

                            shape:
                                BoxShape
                                    .circle,
                          ),

                          child:
                              const Icon(
                            Icons.send_rounded,

                            color:
                                Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TypingAnimation
    extends StatelessWidget {

  const TypingAnimation({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    return Container(

      padding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),

      decoration:
          BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
          20,
        ),
      ),

      child: Row(
        mainAxisSize:
            MainAxisSize.min,

        children: const [

          SizedBox(
            width: 18,
            height: 18,

            child:
                CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),

          SizedBox(
            width: 12,
          ),

          Text(
            'Typing...',
            style: TextStyle(
              fontSize: 14,
              fontWeight:
                  FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}