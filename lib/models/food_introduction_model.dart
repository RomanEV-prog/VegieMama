/// One food in the introduction guide, plus the user's own progress
/// (introduced / reaction / notes).
class FoodIntroductionModel {
  final String foodId;
  final String name;
  final String emoji;
  final String category; // npr. 'zelenjava', 'sadje', 'žita', 'stročnice'
  final int recommendedFromMonth;

  /// Gentle plant-focused note (priprava, hranila, previdnost).
  final String note;

  final bool introduced;
  final DateTime? introducedAt;
  final String? reaction; // 'ok' | 'ni marala' | 'reakcija'
  final String? notes;

  const FoodIntroductionModel({
    required this.foodId,
    required this.name,
    this.emoji = '🥄',
    required this.category,
    required this.recommendedFromMonth,
    this.note = '',
    this.introduced = false,
    this.introducedAt,
    this.reaction,
    this.notes,
  });

  FoodIntroductionModel copyWith({
    String? foodId,
    String? name,
    String? emoji,
    String? category,
    int? recommendedFromMonth,
    String? note,
    bool? introduced,
    DateTime? introducedAt,
    String? reaction,
    String? notes,
  }) {
    return FoodIntroductionModel(
      foodId: foodId ?? this.foodId,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      category: category ?? this.category,
      recommendedFromMonth: recommendedFromMonth ?? this.recommendedFromMonth,
      note: note ?? this.note,
      introduced: introduced ?? this.introduced,
      introducedAt: introducedAt ?? this.introducedAt,
      reaction: reaction ?? this.reaction,
      notes: notes ?? this.notes,
    );
  }

  /// Only the user's progress is persisted; the catalogue itself is code.
  Map<String, dynamic> progressToJson() => {
        'foodId': foodId,
        'introduced': introduced,
        'introducedAt': introducedAt?.toIso8601String(),
        'reaction': reaction,
        'notes': notes,
      };

  FoodIntroductionModel withProgressFromJson(Map<String, dynamic> json) =>
      copyWith(
        introduced: json['introduced'] as bool? ?? false,
        introducedAt: json['introducedAt'] != null
            ? DateTime.parse(json['introducedAt'] as String)
            : null,
        reaction: json['reaction'] as String?,
        notes: json['notes'] as String?,
      );
}
