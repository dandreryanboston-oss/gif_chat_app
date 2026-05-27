import '../entities/chat_message.dart';

abstract class ChatRepository {

  /// SEARCH GIFS
  Future<List<ChatMessage>> searchGif(
    String query,
  );
}