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

      /// SMARTER GIF KEYWORDS
      final keyword =
          getGifKeyword(text);

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

  /// SMART HUMAN-LIKE RESPONSES
  Future<String> getBotResponse(
    String query,
  ) async {

    final lower = query.toLowerCase();

    String response;

    /// GREETINGS
    if (lower.contains('hello') ||
        lower.contains('hi') ||
        lower.contains('hey')) {

      response =
          'Hey 👋 how are you?';
    }

    /// HOW ARE YOU
    else if (lower.contains('how are you')) {

      response =
          'I’m doing pretty good 😄';
    }

    /// WHERE QUESTIONS
    else if (lower.contains('where')) {

      if (lower.contains('dog')) {

        response =
            'Probably running around somewhere 🐶';

      } else if (lower.contains('dad')) {

        response =
            'Maybe he went to grab milk 😂';

      } else if (lower.contains('mom')) {

        response =
            'Probably busy doing mom things 😅';

      } else if (lower.contains('you going')) {

        response =
            'Not sure yet 😎 maybe somewhere fun.';

      } else {

        response =
            'Honestly I have no idea 😂';
      }
    }

    /// WHAT QUESTIONS
    else if (lower.contains('what')) {

      if (lower.contains('time')) {

        response =
            'Time goes way too fast 😭';

      } else if (lower.contains('dinner')) {

        response =
            'Hopefully something good 🍕';

      } else if (lower.contains('doing')) {

        response =
            'Just chilling here 😎';

      } else {

        response =
            'That’s a good question honestly 👀';
      }
    }

    /// ARE YOU QUESTIONS
    else if (lower.contains('are you')) {

      if (lower.contains('thirsty')) {

        response =
            'A little 😅 I could use a drink.';

      } else if (lower.contains('hungry')) {

        response =
            'Honestly yes 🍔';

      } else if (lower.contains('tired')) {

        response =
            'A tiny bit 😴';

      } else {

        response =
            'Maybe 😂';
      }
    }

    /// WHY QUESTIONS
    else if (lower.contains('why')) {

      response =
          'Honestly… that’s a mystery 😂';
    }

    /// LOVE
    else if (lower.contains('love')) {

      response =
          'That’s honestly sweet ❤️';
    }

    /// SAD
    else if (lower.contains('sad')) {

      response =
          'Hope this cheers you up 😢';
    }

    /// FUNNY
    else if (lower.contains('funny')) {

      response =
          'Okay this is hilarious 😂';
    }

    /// BYE
    else if (lower.contains('bye')) {

      response =
          'See you later 👋';
    }

    /// DEFAULT
    else {

      final replies = [

        'That’s actually interesting 😄',

        'I kinda like that.',

        'Not gonna lie… that’s funny 😂',

        'I totally get what you mean.',

        'That sounds fun 😎',

        'Honestly that’s a vibe.',

        'Hmm maybe 👀',

        'Could be honestly 😂',
      ];

      replies.shuffle();

      response = replies.first;
    }

    final translation =
        await translator.translate(
      response,
      to: query.contains(
            RegExp(r'[áéíóúñ¿]'),
          )
          ? 'es'
          : 'en',
    );

    return translation.text;
  }

  /// SMART GIF MATCHING
  String getGifKeyword(
    String text,
  ) {

    final lower = text.toLowerCase();

    /// QUESTIONS
    if (lower.contains('?')) {

      if (lower.contains('thirsty')) {
        return 'drinking meme';
      }

      if (lower.contains('dinner') ||
          lower.contains('food')) {
        return 'funny food reaction';
      }

      if (lower.contains('where')) {
        return 'confused reaction';
      }

      if (lower.contains('time')) {
        return 'waiting meme';
      }

      if (lower.contains('how')) {
        return 'happy reaction';
      }

      return 'funny reaction';
    }

    /// NORMAL TOPICS
    if (lower.contains('hello') ||
        lower.contains('hi')) {

      return 'hello reaction';
    }

    if (lower.contains('love')) {

      return 'cute love gif';
    }

    if (lower.contains('sad')) {

      return 'sad crying reaction';
    }

    if (lower.contains('funny')) {

      return 'funny meme';
    }

    if (lower.contains('angry')) {

      return 'angry reaction meme';
    }

    if (lower.contains('bye')) {

      return 'goodbye meme';
    }

    return 'reaction meme';
  }
}