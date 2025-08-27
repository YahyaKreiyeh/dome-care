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
  if (v.isEmpty) return 'Password is required';
  if (v.contains(' ')) return 'No spaces allowed';
  if (v.length < 8) return 'At least 8 characters';
  final hasUpper = RegExp(r'[A-Z]').hasMatch(v);
  final hasLower = RegExp(r'[a-z]').hasMatch(v);
  final hasDigit = RegExp(r'\d').hasMatch(v);
  if (!(hasUpper && hasLower && hasDigit)) {
    return 'Use upper, lower & a number';
  }
  return null;
}
