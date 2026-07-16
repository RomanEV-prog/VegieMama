class AchievementModel {
  final String id;
  final String title;
  final String description;
  final String icon;
  final int currentCount;
  final int requiredCount;
  final bool isUnlocked;
  final DateTime? unlockedAt;

  const AchievementModel({
    required this.id,
    required this.title,
    required this.description,
    this.icon = '🌿',
    this.currentCount = 0,
    required this.requiredCount,
    this.isUnlocked = false,
    this.unlockedAt,
  });

  double get progress =>
      requiredCount > 0 ? (currentCount / requiredCount).clamp(0.0, 1.0) : 0.0;

  AchievementModel copyWith({
    String? id,
    String? title,
    String? description,
    String? icon,
    int? currentCount,
    int? requiredCount,
    bool? isUnlocked,
    DateTime? unlockedAt,
  }) {
    return AchievementModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      currentCount: currentCount ?? this.currentCount,
      requiredCount: requiredCount ?? this.requiredCount,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'icon': icon,
        'currentCount': currentCount,
        'requiredCount': requiredCount,
        'isUnlocked': isUnlocked,
        'unlockedAt': unlockedAt?.toIso8601String(),
      };

  factory AchievementModel.fromJson(Map<String, dynamic> json) =>
      AchievementModel(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        icon: json['icon'] as String? ?? '🌿',
        currentCount: json['currentCount'] as int? ?? 0,
        requiredCount: json['requiredCount'] as int,
        isUnlocked: json['isUnlocked'] as bool? ?? false,
        unlockedAt: json['unlockedAt'] != null
            ? DateTime.parse(json['unlockedAt'] as String)
            : null,
      );
}
