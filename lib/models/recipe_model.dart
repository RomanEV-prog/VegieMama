class RecipeModel {
  final String id;
  final String title;
  final List<String> tags;
  final bool isFavorite;
  final bool isRecent;
  final List<String> suitableFor; // e.g., 'pregnancy', 'breastfeeding', 'baby'
  final List<String> nutrientsHighlights; // e.g., 'iron', 'B12', 'protein'
  final String? imageUrl;
  final int prepTimeMinutes;

  const RecipeModel({
    required this.id,
    required this.title,
    this.tags = const [],
    this.isFavorite = false,
    this.isRecent = false,
    this.suitableFor = const [],
    this.nutrientsHighlights = const [],
    this.imageUrl,
    this.prepTimeMinutes = 30,
  });

  RecipeModel copyWith({
    String? id,
    String? title,
    List<String>? tags,
    bool? isFavorite,
    bool? isRecent,
    List<String>? suitableFor,
    List<String>? nutrientsHighlights,
    String? imageUrl,
    int? prepTimeMinutes,
  }) {
    return RecipeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      tags: tags ?? this.tags,
      isFavorite: isFavorite ?? this.isFavorite,
      isRecent: isRecent ?? this.isRecent,
      suitableFor: suitableFor ?? this.suitableFor,
      nutrientsHighlights: nutrientsHighlights ?? this.nutrientsHighlights,
      imageUrl: imageUrl ?? this.imageUrl,
      prepTimeMinutes: prepTimeMinutes ?? this.prepTimeMinutes,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'tags': tags,
        'isFavorite': isFavorite,
        'isRecent': isRecent,
        'suitableFor': suitableFor,
        'nutrientsHighlights': nutrientsHighlights,
        'imageUrl': imageUrl,
        'prepTimeMinutes': prepTimeMinutes,
      };

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        id: json['id'] as String,
        title: json['title'] as String,
        tags: (json['tags'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        isFavorite: json['isFavorite'] as bool? ?? false,
        isRecent: json['isRecent'] as bool? ?? false,
        suitableFor: (json['suitableFor'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        nutrientsHighlights: (json['nutrientsHighlights'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        imageUrl: json['imageUrl'] as String?,
        prepTimeMinutes: json['prepTimeMinutes'] as int? ?? 30,
      );
}
