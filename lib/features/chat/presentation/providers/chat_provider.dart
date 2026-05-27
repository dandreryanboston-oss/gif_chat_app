import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

import '../../data/datasource/giphy_remote_datasource.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/usecases/search_gif.dart';

class ChatProvider extends ChangeNotifier {

  final List<ChatMessage> messages = [

    ChatMessage(
      text: 'Hello! Search for any GIF you want.',
      gifUrl: '',
      isUser: false,
    ),
  ];

  bool isLoading = false;

  final translator = GoogleTranslator();

  final useCase = SearchGif(
    ChatRepositoryImpl(
      GiphyRemoteDataSource(),
    ),
  );

  Future<void> sendMessage(String text) async {

    if (text.trim().isEmpty) return;

    // USER MESSAGE
    messages.add(
      ChatMessage(
        text: text,
        gifUrl: '',
        isUser: true,
      ),
    );

    isLoading = true;
    notifyListeners();

    // BOT RESPONSE
    messages.add(
      ChatMessage(
        text: await getBotResponse(text),
        gifUrl: '',
        isUser: false,
      ),
    );

    try {

      final gifs = await useCase(text);

      messages.addAll(gifs);

    } catch (e) {

      messages.add(
        ChatMessage(
          text: 'Sorry, I could not find GIFs.',
          gifUrl: '',
          isUser: false,
        ),
      );
    }

    isLoading = false;
    notifyListeners();
  }

  Future<String> getBotResponse(String query) async {

    final response =
        'Here are the GIFs related to "$query"';

    final translation =
        await translator.translate(
      response,
      to: query.contains(RegExp(r'[áéíóúñ]'))
          ? 'es'
          : 'en',
    );

    return translation.text;
  }
}