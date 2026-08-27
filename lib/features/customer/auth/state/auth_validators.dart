import '../../../../core/constants/app_strings.dart';

/// Pure mock-form validation — there is no backend to authenticate against,
/// so these only check basic shape/format before "logging in" locally.
class AuthValidators {
  AuthValidators._();

  static final RegExp _emailPattern = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) return AppStrings.errorNameRequired;
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return AppStrings.errorEmailRequired;
    if (!_emailPattern.hasMatch(value.trim())) return AppStrings.errorEmailInvalid;
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) return AppStrings.errorPhoneRequired;
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return AppStrings.errorPasswordRequired;
    if (value.length < 6) return AppStrings.errorPasswordShort;
    return null;
  }

  static String? Function(String?) confirmPassword(TextEditingValueGetter passwordGetter) {
    return (value) {
      if (value == null || value.isEmpty) return AppStrings.errorConfirmPasswordRequired;
      if (value != passwordGetter()) return AppStrings.errorPasswordMismatch;
      return null;
    };
  }
}

typedef TextEditingValueGetter = String Function();
