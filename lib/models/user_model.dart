/// User type categories in VeggieMama
enum UserType {
  pregnant,   // nosečnica
  postpartum, // mamica po porodu
  babyMom,    // mamica z dojenčkom
}

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final UserType userType;
  final DateTime? dueDate;
  final DateTime? birthDate;
  final int? babyAgeInMonths;
  final int dailyWaterGoal;
  final String preferredLanguage;
  final bool isPremium;
  final DateTime? premiumUntil;
  final String? avatarPath;
  final bool onboardingCompleted;

  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userType,
    this.dueDate,
    this.birthDate,
    this.babyAgeInMonths,
    this.dailyWaterGoal = 2000,
    this.preferredLanguage = 'sl',
    this.isPremium = false,
    this.premiumUntil,
    this.avatarPath,
    this.onboardingCompleted = false,
  });

  String get fullName => '$firstName $lastName';

  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    UserType? userType,
    DateTime? dueDate,
    DateTime? birthDate,
    int? babyAgeInMonths,
    int? dailyWaterGoal,
    String? preferredLanguage,
    bool? isPremium,
    DateTime? premiumUntil,
    String? avatarPath,
    bool? onboardingCompleted,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userType: userType ?? this.userType,
      dueDate: dueDate ?? this.dueDate,
      birthDate: birthDate ?? this.birthDate,
      babyAgeInMonths: babyAgeInMonths ?? this.babyAgeInMonths,
      dailyWaterGoal: dailyWaterGoal ?? this.dailyWaterGoal,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      isPremium: isPremium ?? this.isPremium,
      premiumUntil: premiumUntil ?? this.premiumUntil,
      avatarPath: avatarPath ?? this.avatarPath,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'userType': userType.name,
        'dueDate': dueDate?.toIso8601String(),
        'birthDate': birthDate?.toIso8601String(),
        'babyAgeInMonths': babyAgeInMonths,
        'dailyWaterGoal': dailyWaterGoal,
        'preferredLanguage': preferredLanguage,
        'isPremium': isPremium,
        'premiumUntil': premiumUntil?.toIso8601String(),
        'avatarPath': avatarPath,
        'onboardingCompleted': onboardingCompleted,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        userType: UserType.values.byName(json['userType'] as String),
        dueDate: json['dueDate'] != null
            ? DateTime.parse(json['dueDate'] as String)
            : null,
        birthDate: json['birthDate'] != null
            ? DateTime.parse(json['birthDate'] as String)
            : null,
        babyAgeInMonths: json['babyAgeInMonths'] as int?,
        dailyWaterGoal: json['dailyWaterGoal'] as int? ?? 2000,
        preferredLanguage: json['preferredLanguage'] as String? ?? 'sl',
        isPremium: json['isPremium'] as bool? ?? false,
        premiumUntil: json['premiumUntil'] != null
            ? DateTime.parse(json['premiumUntil'] as String)
            : null,
        avatarPath: json['avatarPath'] as String?,
        onboardingCompleted: json['onboardingCompleted'] as bool? ?? false,
      );
}
