import '../../domain/entities/chat_message.dart';

class ChatMessageModel extends ChatMessage {
  ChatMessageModel({
    required super.text,
    required super.gifUrl,
    required super.isUser,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      text: json['title'] ?? '',
      gifUrl: json['images']['original']['url'],
      isUser: false,
    );
  }
}