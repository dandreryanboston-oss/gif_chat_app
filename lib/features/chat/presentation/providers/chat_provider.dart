import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import '../../domain/usecases/search_gif.dart';
import '../../data/datasource/giphy_remote_datasource.dart';
import '../../data/models/chat_message_model.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../domain/entities/chat_message.dart';

class ChatProvider extends ChangeNotifier {

  final List<ChatMessage> messages = [

    ChatMessageModel.botMessage(
      'Hey 👋 Ask me anything and I’ll reply naturally with a matching GIF.',
    ),
  ];

  bool isLoading = false;

  final translator = GoogleTranslator();

  final useCase = SearchGif(
    ChatRepositoryImpl(
      GiphyRemoteDataSource(),
    ),
  );

  /// SEND MESSAGE
  Future<void> sendMessage(
    String text,
  ) async {

    if (text.trim().isEmpty) return;

    /// USER MESSAGE
    messages.add(
      ChatMessageModel.userMessage(text),
    );

    isLoading = true;
    notifyListeners();

    try {

      /// BETTER GIF SEARCH KEYWORD
      final keyword =
          _extractKeyword(text);

      /// NATURAL BOT REPLY
      final botReply =
          await getBotResponse(text);

      /// SEARCH GIFS
      final gifs =
          await useCase(keyword);

      /// TAKE FIRST GIF
      final gif =
          gifs.isNotEmpty
              ? gifs.first
              : null;

      /// BOT MESSAGE
      messages.add(
        ChatMessage(
          text: botReply,
          gifUrl: gif?.gifUrl ?? '',
          isUser: false,
          time: DateTime.now(),
        ),
      );

    } catch (e) {

      messages.add(
        ChatMessageModel.botMessage(
          'Sorry 😢 I could not find a GIF.',
        ),
      );
    }

    isLoading = false;
    notifyListeners();
  }

  /// NATURAL AI RESPONSE
  Future<String> getBotResponse(
    String query,
  ) async {

    final lower =
        query.toLowerCase();

    String response;

    /// GREETINGS
    if (lower.contains('hello') ||
        lower.contains('hi') ||
        lower.contains('hey')) {

      response =
          'Hey 👋 Nice to chat with you!';

    }

    /// HUNGRY / FOOD
    else if (lower.contains('hungry') ||
        lower.contains('food') ||
        lower.contains('eat') ||
        lower.contains('dinner') ||
        lower.contains('lunch')) {

      response =
          'Food sounds amazing right now 🍔';

    }

    /// LOVE
    else if (lower.contains('love')) {

      response =
          'That’s actually really sweet ❤️';

    }

    /// SAD
    else if (lower.contains('sad') ||
        lower.contains('cry')) {

      response =
          'Aww 🥺 Hope this makes you feel better.';

    }

    /// ANGRY
    else if (lower.contains('angry') ||
        lower.contains('mad')) {

      response =
          'Okay okay 😅 let’s calm down a little.';

    }

    /// FUNNY
    else if (lower.contains('funny') ||
        lower.contains('lol')) {

      response =
          '😂 This one fits perfectly.';

    }

    /// DEFAULT
    else {

      response =
          'This GIF totally matches what you said 😄';
    }

    final translation =
        await translator.translate(
      response,
      to: query.contains(
        RegExp(r'[áéíóúñ]'),
      )
          ? 'es'
          : 'en',
    );

    return translation.text;
  }

  /// SMART GIF SEARCH
  String _extractKeyword(
    String text,
  ) {

    final lower =
        text.toLowerCase();

    /// FOOD
    if (lower.contains('hungry') ||
        lower.contains('food') ||
        lower.contains('eat') ||
        lower.contains('dinner')) {

      return 'hungry food meme';
    }

    /// LOVE
    if (lower.contains('love')) {

      return 'cute love';
    }

    /// SAD
    if (lower.contains('sad') ||
        lower.contains('cry')) {

      return 'sad reaction';
    }

    /// ANGRY
    if (lower.contains('angry') ||
        lower.contains('mad')) {

      return 'angry meme';
    }

    /// HELLO
    if (lower.contains('hello') ||
        lower.contains('hi') ||
        lower.contains('hey')) {

      return 'hello reaction';
    }

    /// FUNNY
    if (lower.contains('funny') ||
        lower.contains('lol')) {

      return 'funny meme';
    }

    /// DEFAULT
    return '$text meme';
  }
}