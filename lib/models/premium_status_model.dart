class PremiumStatusModel {
  final bool isPremium;
  final DateTime? expiresAt;
  final String? planName;

  const PremiumStatusModel({
    this.isPremium = false,
    this.expiresAt,
    this.planName,
  });

  bool get isActive =>
      isPremium && (expiresAt == null || expiresAt!.isAfter(DateTime.now()));

  int? get daysRemaining =>
      expiresAt?.difference(DateTime.now()).inDays;

  PremiumStatusModel copyWith({
    bool? isPremium,
    DateTime? expiresAt,
    String? planName,
  }) {
    return PremiumStatusModel(
      isPremium: isPremium ?? this.isPremium,
      expiresAt: expiresAt ?? this.expiresAt,
      planName: planName ?? this.planName,
    );
  }

  Map<String, dynamic> toJson() => {
        'isPremium': isPremium,
        'expiresAt': expiresAt?.toIso8601String(),
        'planName': planName,
      };

  factory PremiumStatusModel.fromJson(Map<String, dynamic> json) =>
      PremiumStatusModel(
        isPremium: json['isPremium'] as bool? ?? false,
        expiresAt: json['expiresAt'] != null
            ? DateTime.parse(json['expiresAt'] as String)
            : null,
        planName: json['planName'] as String?,
      );
}
