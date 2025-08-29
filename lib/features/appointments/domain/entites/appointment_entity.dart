import 'package:dome_care/core/constants/enums.dart';

class AppointmentEntity {
  final DateTime date;
  final String time;
  final String image;
  final String name;
  final String specialization;
  final AppointmentStatus status;
  final String? location;
  final String? phoneNumber;
  final String? telephone;
  final String? fee;
  final String? cancelReason;

  AppointmentEntity({
    required this.date,
    required this.time,
    required this.image,
    required this.name,
    required this.specialization,
    required this.status,
    this.location,
    this.phoneNumber,
    this.telephone,
    this.fee,
    this.cancelReason,
  });
}
