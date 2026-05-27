import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/chat_message_model.dart';

class GiphyRemoteDataSource {

  final String apiKey =
      'QlTfv4HGzRJwEtcIJj3PaV8JeIQrt0sk';

  Future<List<ChatMessageModel>>
      searchGif(
    String query,
  ) async {

    final url = Uri.parse(
      'https://api.giphy.com/v1/gifs/search'
      '?api_key=$apiKey'
      '&q=$query'
      '&limit=10'
      '&rating=g'
      '&lang=en',
    );

    final response =
        await http.get(url);

    if (response.statusCode == 200) {

      final data =
          jsonDecode(response.body);

      final gifs =
          List<Map<String, dynamic>>.from(
        data['data'],
      );

      return gifs.map((gif) {

        /// BETTER SMALLER GIF SIZE
        final gifUrl =
            gif['images']['fixed_height']
                    ['url'] ??
                '';

        return ChatMessageModel(
          text: '',
          gifUrl: gifUrl,
          isUser: false,
          time: DateTime.now(),
        );

      }).toList();

    } else {

      throw Exception(
        'Failed to load GIFs',
      );
    }
  }
}