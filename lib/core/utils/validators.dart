import '../constants/app_strings.dart';

/// Form validators returning `null` when valid, or an Arabic error message.
/// Signatures match `TextFormField.validator`.
abstract final class Validators {
  static final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\.[a-zA-Z]{2,}$",
  );
  static final RegExp _letterRegExp = RegExp(r'[a-zA-Z؀-ۿ]');
  static final RegExp _digitRegExp = RegExp(r'[0-9٠-٩]');

  static const int minPasswordLength = 8;
  static const int minNameLength = 3;

  static String? fullName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return AppStrings.fullNameRequired;
    if (name.length < minNameLength) return AppStrings.fullNameTooShort;
    return null;
  }

  static String? email(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return AppStrings.emailRequired;
    if (!_emailRegExp.hasMatch(email)) return AppStrings.emailInvalid;
    return null;
  }

  /// Light check for the login form: only requires a value.
  static String? loginPassword(String? value) {
    if (value == null || value.isEmpty) return AppStrings.passwordRequired;
    return null;
  }

  /// Strength check for registration.
  static String? password(String? value) {
    final password = value ?? '';
    if (password.isEmpty) return AppStrings.passwordRequired;
    if (password.length < minPasswordLength) return AppStrings.passwordTooShort;
    if (!_letterRegExp.hasMatch(password)) {
      return AppStrings.passwordNeedsLetter;
    }
    if (!_digitRegExp.hasMatch(password)) return AppStrings.passwordNeedsDigit;
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) {
      return AppStrings.confirmPasswordRequired;
    }
    if (value != original) return AppStrings.passwordsDoNotMatch;
    return null;
  }
}
