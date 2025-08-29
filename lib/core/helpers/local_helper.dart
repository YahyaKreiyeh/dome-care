import 'dart:io';

class LocalHelper {
  LocalHelper._();

  static bool isArabic() => Platform.localeName.contains('ar');
}
