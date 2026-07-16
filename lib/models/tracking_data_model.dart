class TrackingDataModel {
  final DateTime date;
  final int waterIntake;
  final int waterGoal;
  final double sleepHours;
  final double sleepGoal;
  final int moodRating; // 1-5
  final int mealsLogged;
  final List<String> vitamins;
  final int breastfeedingSessions;
  final String? notes;

  const TrackingDataModel({
    required this.date,
    this.waterIntake = 0,
    this.waterGoal = 2000,
    this.sleepHours = 0,
    this.sleepGoal = 8,
    this.moodRating = 3,
    this.mealsLogged = 0,
    this.vitamins = const [],
    this.breastfeedingSessions = 0,
    this.notes,
  });

  double get waterProgress =>
      waterGoal > 0 ? (waterIntake / waterGoal).clamp(0.0, 1.0) : 0.0;

  double get sleepProgress =>
      sleepGoal > 0 ? (sleepHours / sleepGoal).clamp(0.0, 1.0) : 0.0;

  TrackingDataModel copyWith({
    DateTime? date,
    int? waterIntake,
    int? waterGoal,
    double? sleepHours,
    double? sleepGoal,
    int? moodRating,
    int? mealsLogged,
    List<String>? vitamins,
    int? breastfeedingSessions,
    String? notes,
  }) {
    return TrackingDataModel(
      date: date ?? this.date,
      waterIntake: waterIntake ?? this.waterIntake,
      waterGoal: waterGoal ?? this.waterGoal,
      sleepHours: sleepHours ?? this.sleepHours,
      sleepGoal: sleepGoal ?? this.sleepGoal,
      moodRating: moodRating ?? this.moodRating,
      mealsLogged: mealsLogged ?? this.mealsLogged,
      vitamins: vitamins ?? this.vitamins,
      breastfeedingSessions:
          breastfeedingSessions ?? this.breastfeedingSessions,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'waterIntake': waterIntake,
        'waterGoal': waterGoal,
        'sleepHours': sleepHours,
        'sleepGoal': sleepGoal,
        'moodRating': moodRating,
        'mealsLogged': mealsLogged,
        'vitamins': vitamins,
        'breastfeedingSessions': breastfeedingSessions,
        'notes': notes,
      };

  factory TrackingDataModel.fromJson(Map<String, dynamic> json) =>
      TrackingDataModel(
        date: DateTime.parse(json['date'] as String),
        waterIntake: json['waterIntake'] as int? ?? 0,
        waterGoal: json['waterGoal'] as int? ?? 2000,
        sleepHours: (json['sleepHours'] as num?)?.toDouble() ?? 0,
        sleepGoal: (json['sleepGoal'] as num?)?.toDouble() ?? 8,
        moodRating: json['moodRating'] as int? ?? 3,
        mealsLogged: json['mealsLogged'] as int? ?? 0,
        vitamins: (json['vitamins'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        breastfeedingSessions: json['breastfeedingSessions'] as int? ?? 0,
        notes: json['notes'] as String?,
      );
}
