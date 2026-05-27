import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasource/giphy_remote_datasource.dart';

class ChatRepositoryImpl implements ChatRepository {

  final GiphyRemoteDataSource remoteDataSource;

  ChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ChatMessage>> searchGif(String query) async {
    return await remoteDataSource.searchGif(query);
  }
}