class BabyProfileModel {
  final String id;
  final String name;
  final DateTime birthDate;
  final String? notes;

  const BabyProfileModel({
    required this.id,
    required this.name,
    required this.birthDate,
    this.notes,
  });

  BabyProfileModel copyWith({
    String? id,
    String? name,
    DateTime? birthDate,
    String? notes,
  }) {
    return BabyProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'birthDate': birthDate.toIso8601String(),
        'notes': notes,
      };

  factory BabyProfileModel.fromJson(Map<String, dynamic> json) =>
      BabyProfileModel(
        id: json['id'] as String,
        name: json['name'] as String,
        birthDate: DateTime.parse(json['birthDate'] as String),
        notes: json['notes'] as String?,
      );
}
