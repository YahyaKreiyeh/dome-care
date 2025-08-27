import 'package:intl/intl.dart';

class AppFormatter {
  AppFormatter._();

  static String formatPrice(num value) {
    return NumberFormat("#,###").format(value);
  }
}
