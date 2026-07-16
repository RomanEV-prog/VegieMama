class AIAssistantModel {
  final String id;
  final String name;
  final String role;
  final String avatarAsset;
  final String introText;
  final String? lastConversationPreview;

  const AIAssistantModel({
    required this.id,
    required this.name,
    required this.role,
    required this.avatarAsset,
    required this.introText,
    this.lastConversationPreview,
  });

  AIAssistantModel copyWith({
    String? id,
    String? name,
    String? role,
    String? avatarAsset,
    String? introText,
    String? lastConversationPreview,
  }) {
    return AIAssistantModel(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      avatarAsset: avatarAsset ?? this.avatarAsset,
      introText: introText ?? this.introText,
      lastConversationPreview:
          lastConversationPreview ?? this.lastConversationPreview,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'role': role,
        'avatarAsset': avatarAsset,
        'introText': introText,
        'lastConversationPreview': lastConversationPreview,
      };

  factory AIAssistantModel.fromJson(Map<String, dynamic> json) =>
      AIAssistantModel(
        id: json['id'] as String,
        name: json['name'] as String,
        role: json['role'] as String,
        avatarAsset: json['avatarAsset'] as String,
        introText: json['introText'] as String,
        lastConversationPreview: json['lastConversationPreview'] as String?,
      );
}
