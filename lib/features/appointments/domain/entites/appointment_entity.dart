import 'package:dome_care/core/constants/enums.dart';
import 'package:dome_care/features/appointments/domain/entites/doctor_entity.dart';

class AppointmentEntity {
  final DateTime date;
  final String time;
  final AppointmentStatus status;
  final DoctorEntity doctor;
  final String fee;
  final String? cancelReason;

  AppointmentEntity({
    required this.date,
    required this.time,
    required this.status,
    required this.doctor,
    required this.fee,
    this.cancelReason,
  });
}
