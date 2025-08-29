import 'package:easy_localization/easy_localization.dart';

enum SnackbarType { success, error, warning }

enum AppointmentStatus { confirmed, pending, canceled, rejected }

extension AppointmentStatusX on AppointmentStatus {
  String get label {
    switch (this) {
      case AppointmentStatus.confirmed:
        return 'status_confirmed'.tr();
      case AppointmentStatus.pending:
        return 'status_pending'.tr();
      case AppointmentStatus.canceled:
        return 'status_canceled'.tr();
      case AppointmentStatus.rejected:
        return 'status_rejected'.tr();
    }
  }
}
