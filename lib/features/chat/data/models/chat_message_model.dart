import '../../domain/entities/chat_message.dart';

class ChatMessageModel
    extends ChatMessage {

  ChatMessageModel({
    required super.text,
    required super.gifUrl,
    required super.isUser,
    required super.time,
  });

  /// FROM GIPHY JSON
  factory ChatMessageModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return ChatMessageModel(
      text: '',
      gifUrl:
          json['images']['fixed_height']
                  ['url'] ??
              '',
      isUser: false,
      time: DateTime.now(),
    );
  }

  /// USER MESSAGE
  factory ChatMessageModel.userMessage(
    String text,
  ) {

    return ChatMessageModel(
      text: text,
      gifUrl: '',
      isUser: true,
      time: DateTime.now(),
    );
  }

  /// BOT MESSAGE
  factory ChatMessageModel.botMessage(
    String text,
  ) {

    return ChatMessageModel(
      text: text,
      gifUrl: '',
      isUser: false,
      time: DateTime.now(),
    );
  }
}