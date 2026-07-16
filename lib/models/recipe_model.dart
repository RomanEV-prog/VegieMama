class RecipeModel {
  final String id;
  final String title;
  final String description;
  final String emoji;
  final List<String> tags;
  final bool isFavorite;
  final bool isRecent;
  final List<String> suitableFor; // npr. 'nosečnost', 'dojenje', 'malček'
  final List<String> nutrientsHighlights; // npr. 'železo', 'B12'
  final List<String> ingredients;
  final List<String> steps;

  /// For child-suitable recipes: earliest recommended age in months.
  final int? suitableFromMonth;
  final String? imageUrl;
  final int prepTimeMinutes;

  const RecipeModel({
    required this.id,
    required this.title,
    this.description = '',
    this.emoji = '🥗',
    this.tags = const [],
    this.isFavorite = false,
    this.isRecent = false,
    this.suitableFor = const [],
    this.nutrientsHighlights = const [],
    this.ingredients = const [],
    this.steps = const [],
    this.suitableFromMonth,
    this.imageUrl,
    this.prepTimeMinutes = 30,
  });

  bool get isForChild => suitableFromMonth != null;

  RecipeModel copyWith({
    String? id,
    String? title,
    String? description,
    String? emoji,
    List<String>? tags,
    bool? isFavorite,
    bool? isRecent,
    List<String>? suitableFor,
    List<String>? nutrientsHighlights,
    List<String>? ingredients,
    List<String>? steps,
    int? suitableFromMonth,
    String? imageUrl,
    int? prepTimeMinutes,
  }) {
    return RecipeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      emoji: emoji ?? this.emoji,
      tags: tags ?? this.tags,
      isFavorite: isFavorite ?? this.isFavorite,
      isRecent: isRecent ?? this.isRecent,
      suitableFor: suitableFor ?? this.suitableFor,
      nutrientsHighlights: nutrientsHighlights ?? this.nutrientsHighlights,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      suitableFromMonth: suitableFromMonth ?? this.suitableFromMonth,
      imageUrl: imageUrl ?? this.imageUrl,
      prepTimeMinutes: prepTimeMinutes ?? this.prepTimeMinutes,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'emoji': emoji,
        'tags': tags,
        'isFavorite': isFavorite,
        'isRecent': isRecent,
        'suitableFor': suitableFor,
        'nutrientsHighlights': nutrientsHighlights,
        'ingredients': ingredients,
        'steps': steps,
        'suitableFromMonth': suitableFromMonth,
        'imageUrl': imageUrl,
        'prepTimeMinutes': prepTimeMinutes,
      };

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String? ?? '',
        emoji: json['emoji'] as String? ?? '🥗',
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
        ingredients: (json['ingredients'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        steps: (json['steps'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        suitableFromMonth: json['suitableFromMonth'] as int?,
        imageUrl: json['imageUrl'] as String?,
        prepTimeMinutes: json['prepTimeMinutes'] as int? ?? 30,
      );
}
