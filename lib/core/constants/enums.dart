enum SnackbarType { success, error, warning }

enum AppointmentStatus { confirmed, pending, canceled, rejected }

extension AppointmentStatusX on AppointmentStatus {
  String get label {
    switch (this) {
      case AppointmentStatus.confirmed:
        return "Confirmed";
      case AppointmentStatus.pending:
        return "Pending";
      case AppointmentStatus.canceled:
        return "Canceled";
      case AppointmentStatus.rejected:
        return "Rejected";
    }
  }
}
