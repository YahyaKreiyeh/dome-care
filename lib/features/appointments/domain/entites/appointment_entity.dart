class AppointmentEntity {
  final DateTime date;
  final String time;
  final String image;
  final String name;
  final String specialization;
  final String status;

  AppointmentEntity({
    required this.date,
    required this.time,
    required this.image,
    required this.name,
    required this.specialization,
    required this.status,
  });
}
