import '../entities/chat_message.dart';
import '../repositories/chat_repository.dart';

class SearchGif {
  final ChatRepository repository;

  SearchGif(this.repository);

  Future<List<ChatMessage>> call(
    String query,
  ) async {
    return await repository.searchGif(query);
  }
}