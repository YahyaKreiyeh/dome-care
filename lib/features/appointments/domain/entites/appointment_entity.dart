import 'package:dome_care/core/constants/enums.dart';
import 'package:dome_care/features/appointments/domain/entites/doctor_entity.dart';

/// Appointment model tailored to the scheduling and details screens.
/// Keeps a nested [DoctorEntity] for direct rendering in cards/headers.
class AppointmentEntity {
  /// Calendar date of the appointment.
  final DateTime date;

  /// Human-readable time slot (formatted for UI).
  final String time;

  /// Current status (e.g., booked, cancelled, completed).
  final AppointmentStatus status;

  /// The associated doctor shown in the appointment card.
  final DoctorEntity doctor;

  /// Display fee with currency (string to preserve formatting).
  final String fee;

  /// Optional cancel reason when [status] is cancelled.
  final String? cancelReason;

  /// Creates an [AppointmentEntity]. All non-nullable fields are required
  /// per current business rules and UI contracts.
  AppointmentEntity({
    required this.date,
    required this.time,
    required this.status,
    required this.doctor,
    required this.fee,
    this.cancelReason,
  });
}
