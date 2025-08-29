import 'package:dome_care/core/localization/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

bool validateSyrianLocalNumber(String digitsOnly) {
  final d = digitsOnly;
  if (d.isEmpty) return false;
  final normalized = d.startsWith('0') ? d.substring(1) : d;
  final isValid =
      normalized.length == 9 &&
      normalized.startsWith('9') &&
      int.tryParse(normalized) != null;
  return isValid;
}

String toSyrianE164(String localDigits) {
  final d = localDigits.startsWith('0')
      ? localDigits.substring(1)
      : localDigits;
  return '+963$d';
}

String? passwordValidationError(String value) {
  final v = value;
  if (v.isEmpty) return LocaleKeys.login_password_required.tr();
  if (v.contains(' ')) return LocaleKeys.login_password_no_spaces_allowed.tr();
  if (v.length < 8) return LocaleKeys.login_password_at_least_8_characters.tr();
  return null;
}
