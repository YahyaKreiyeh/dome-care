import 'package:intl/intl.dart';

class AppFormatter {
  AppFormatter._();

  /// Wrap a run so digits render left-to-right without changing widget alignment.
  static String forceLtr(String s) => '\u2066$s\u2069';
  static String _toEnDigits(String s) {
    const ar = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    const fa = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    var out = s
        .replaceAll('\u200F', '') // RLM
        .replaceAll('\u200E', ''); // LRM
    for (var i = 0; i < 10; i++) {
      out = out.replaceAll(ar[i], '$i').replaceAll(fa[i], '$i');
    }
    return out;
  }

  /// Price with ASCII digits (always). Uses English grouping format.
  static String formatPrice(num value, {String? locale}) {
    return NumberFormat.decimalPattern('en').format(value);
  }

  /// Date like: "07 Mar 2024"
  /// - Day ("07") and year ("2024") are ASCII digits.
  /// - Month ("Mar") is localized to [locale] (short month name).
  /// Date like:
  /// - EN locale: "07 Mar 2024"
  /// - AR locale: "23 أغسطس 2025"
  static String formatDate(DateTime date, {String? locale}) {
    final day = DateFormat('dd', 'en').format(date);
    final year = DateFormat('yyyy', 'en').format(date);

    final lang = locale?.split('-').first.toLowerCase();
    if (lang == 'ar') {
      final monthName = DateFormat('MMMM', 'ar').format(date);
      return forceLtr('$day $monthName $year');
    } else {
      final monthName = DateFormat('MMM', locale ?? 'en').format(date);
      return forceLtr('$day $monthName $year');
    }
  }

  /// Weekday short like "Mon" (localized), digits (if any) remain ASCII.
  static String formatWeekday(
    DateTime date, {
    String? locale,
    bool upper = false,
  }) {
    final s = DateFormat('E', locale).format(date);
    final r = _toEnDigits(s);
    return upper ? r.toUpperCase() : r;
  }

  /// Time like: "09:00 AM"
  /// - "09:00" is ASCII digits (English).
  /// - AM/PM marker is localized to [locale] only.
  /// If the locale does not use AM/PM, the marker may be empty.
  static String formatTime(DateTime date, {String? locale}) {
    final timeEn = DateFormat('hh:mm', 'en').format(date); // ASCII
    var period = (locale == null)
        ? DateFormat('a').format(date)
        : DateFormat('a', locale).format(date);
    if (period.trim().isEmpty) {
      period = DateFormat('a', 'en').format(date);
    }
    final out = '$timeEn $period'.trim();
    return forceLtr(_toEnDigits(out));
  }

  /// "07 Mar 2024, 09:00 AM"
  /// - Date has localized month, ASCII digits.
  /// - Time has ASCII digits with localized AM/PM.
  static String formatDateTime(DateTime date, {String? locale}) {
    return '${formatDate(date, locale: locale)}, ${formatTime(date, locale: locale)}';
  }

  /// "March 2024" / localized month + ASCII year.
  static String formatMonthYear(DateTime date, {String? locale}) {
    final month = DateFormat('MMMM', locale).format(date);
    final year = DateFormat('yyyy', 'en').format(date);
    final out = '$month $year';
    return forceLtr(_toEnDigits(out));
  }

  /// Parse EN time strings (e.g., "02:30 PM") and output with ASCII digits
  /// and localized AM/PM only (no localized digits).
  // Replace the whole method with this implementation
  static String formatTimeFromEnglish(String raw, {required String toLocale}) {
    String s = raw.trim().replaceAll('\u200F', '').replaceAll('\u200E', '');
    s = _toEnDigits(s);

    s = s
        .replaceAll(RegExp(r'\s*(?:ص|صباح(?:ًا|ا)?)\b'), ' AM')
        .replaceAll(RegExp(r'\s*(?:م|مساء(?:ً)?)\b'), ' PM');

    DateTime parsed;
    try {
      if (RegExp(r'\bAM\b|\bPM\b').hasMatch(s)) {
        parsed = DateFormat('hh:mm a', 'en').parse(s);
      } else if (RegExp(r'^\d{1,2}:\d{2}$').hasMatch(s)) {
        try {
          parsed = DateFormat('HH:mm', 'en').parse(s);
        } catch (_) {
          parsed = DateFormat('hh:mm', 'en').parse(s);
        }
      } else {
        parsed = DateFormat('hh:mm a', 'ar').parse(raw);
      }
    } catch (_) {
      parsed = DateTime(0, 1, 1, 0, 0);
    }

    final timeEn = DateFormat('hh:mm', 'en').format(parsed);
    var period = DateFormat('a', toLocale).format(parsed);
    if (period.trim().isEmpty) {
      period = DateFormat('a', 'en').format(parsed);
    }
    final out = '$timeEn $period'.trim();
    return forceLtr(_toEnDigits(out));
  }
}
