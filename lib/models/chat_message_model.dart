enum ChatRole { user, assistant }

class ChatMessage {
  final ChatRole role;
  final String content;
  final DateTime sentAt;

  const ChatMessage({
    required this.role,
    required this.content,
    required this.sentAt,
  });

  bool get isUser => role == ChatRole.user;

  Map<String, dynamic> toJson() => {
        'role': role.name,
        'content': content,
        'sentAt': sentAt.toIso8601String(),
      };

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        role: ChatRole.values.byName(json['role'] as String),
        content: json['content'] as String,
        sentAt: DateTime.parse(json['sentAt'] as String),
      );
}
