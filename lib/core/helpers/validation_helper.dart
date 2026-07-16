/// Input validation helpers
class ValidationHelper {
  ValidationHelper._();

  static String? requiredField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'To polje je obvezno';
    }
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Prosim vnesi ime';
    }
    if (value.trim().length < 2) {
      return 'Ime mora imeti vsaj 2 znaka';
    }
    return null;
  }

  static String? waterAmount(String? value) {
    if (value == null || value.isEmpty) return null;
    final amount = int.tryParse(value);
    if (amount == null || amount < 0 || amount > 10000) {
      return 'Vnesi veljavno količino (0–10.000 ml)';
    }
    return null;
  }

  static String? sleepHours(String? value) {
    if (value == null || value.isEmpty) return null;
    final hours = double.tryParse(value);
    if (hours == null || hours < 0 || hours > 24) {
      return 'Vnesi veljavno število ur (0–24)';
    }
    return null;
  }
}
