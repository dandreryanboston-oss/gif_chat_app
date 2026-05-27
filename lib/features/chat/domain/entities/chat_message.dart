class ChatMessage {
  final String text;

  final String gifUrl;

  final bool isUser;

  /// MESSAGE TIME
  final DateTime? time;

  /// OPTIONAL FUTURE FEATURES
  final bool isRead;
  final bool isDelivered;

  ChatMessage({
    required this.text,
    required this.gifUrl,
    required this.isUser,

    this.time,

    this.isRead = false,
    this.isDelivered = true,
  });

  /// CHECK IF MESSAGE HAS GIF
  bool get hasGif =>
      gifUrl.trim().isNotEmpty;

  /// CHECK IF MESSAGE HAS TEXT
  bool get hasText =>
      text.trim().isNotEmpty;
}