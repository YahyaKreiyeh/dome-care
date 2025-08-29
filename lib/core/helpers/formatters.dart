import 'package:intl/intl.dart';

class AppFormatter {
  AppFormatter._();

  /// Format price with thousand separators
  static String formatPrice(num value) {
    return NumberFormat("#,###").format(value);
  }

  /// Format date like: 22 Dec 2025
  static String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  /// Format time like: 09:00 AM
  static String formatTime(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  /// Format both date and time like: 22 Dec 2025, 09:00 AM
  static String formatDateTime(DateTime date) {
    return DateFormat('dd MMM yyyy, hh:mm a').format(date);
  }

  /// Format day of week like: MON
  static String formatWeekday(DateTime date, {String? locale}) {
    return DateFormat('EEE', locale).format(date).toUpperCase();
  }
}
