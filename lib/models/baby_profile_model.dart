/// Development stage of the child, derived from age.
enum BabyStage {
  newborn, // 0–5 mesecev: mleko je vse, kar potrebuje
  introducing, // 6–11 mesecev: uvajanje goste hrane
  toddler, // 12–36 mesecev: malček, družinska prehrana
}

class BabyProfileModel {
  final String id;
  final String name;
  final DateTime birthDate;
  final List<String> allergies;
  final String? notes;

  const BabyProfileModel({
    required this.id,
    required this.name,
    required this.birthDate,
    this.allergies = const [],
    this.notes,
  });

  int get ageInMonths {
    final now = DateTime.now();
    int months =
        (now.year - birthDate.year) * 12 + now.month - birthDate.month;
    if (now.day < birthDate.day) months--;
    return months.clamp(0, 999);
  }

  BabyStage get stage {
    final months = ageInMonths;
    if (months < 6) return BabyStage.newborn;
    if (months < 12) return BabyStage.introducing;
    return BabyStage.toddler;
  }

  BabyProfileModel copyWith({
    String? id,
    String? name,
    DateTime? birthDate,
    List<String>? allergies,
    String? notes,
  }) {
    return BabyProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      allergies: allergies ?? this.allergies,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'birthDate': birthDate.toIso8601String(),
        'allergies': allergies,
        'notes': notes,
      };

  factory BabyProfileModel.fromJson(Map<String, dynamic> json) =>
      BabyProfileModel(
        id: json['id'] as String,
        name: json['name'] as String,
        birthDate: DateTime.parse(json['birthDate'] as String),
        allergies: (json['allergies'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        notes: json['notes'] as String?,
      );
}
