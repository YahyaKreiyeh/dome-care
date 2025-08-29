import 'dart:math';

import 'package:dome_care/core/style/assets/assets.gen.dart';
import 'package:dome_care/features/appointments/domain/entites/appointment_entity.dart';

final _rnd = Random();

String _randomAvatar() {
  final i = _rnd.nextInt(3) + 1;
  switch (i) {
    case 1:
      return Assets.images.avatar1.path;
    case 2:
      return Assets.images.avatar2.path;
    case 3:
    default:
      return Assets.images.avatar3.path;
  }
}

String _randomStatus() {
  const statuses = ['Confirmed', 'Pending', 'Rejected'];
  return statuses[_rnd.nextInt(statuses.length)];
}

final Map<DateTime, List<AppointmentEntity>> mockEvents = {
  DateTime(2025, 8, 23): [
    AppointmentEntity(
      date: DateTime(2025, 8, 23),
      time: "10:00 AM",
      image: _randomAvatar(),
      name: "Dr. John Doe",
      specialization: "Cardiologist",
      status: _randomStatus(),
    ),
    AppointmentEntity(
      date: DateTime(2025, 8, 23),
      time: "02:30 PM",
      image: _randomAvatar(),
      name: "Dr. Jane Smith",
      specialization: "Dermatologist",
      status: _randomStatus(),
    ),
  ],
  DateTime(2025, 8, 4): [
    AppointmentEntity(
      date: DateTime(2025, 8, 4),
      time: "09:00 AM",
      image: _randomAvatar(),
      name: "Dr. Albert Lee",
      specialization: "Dentist",
      status: _randomStatus(),
    ),
    AppointmentEntity(
      date: DateTime(2025, 8, 4),
      time: "01:00 PM",
      image: _randomAvatar(),
      name: "Dr. Emily Brown",
      specialization: "Neurologist",
      status: _randomStatus(),
    ),
    AppointmentEntity(
      date: DateTime(2025, 8, 4),
      time: "03:45 PM",
      image: _randomAvatar(),
      name: "Dr. David Wilson",
      specialization: "Orthopedic",
      status: _randomStatus(),
    ),
  ],
  DateTime(2025, 8, 7): List.generate(
    30,
    (i) => AppointmentEntity(
      date: DateTime(2025, 8, 7),
      time: "${9 + (i % 8)}:00 AM",
      image: _randomAvatar(),
      name: "Doctor ${i + 1}",
      specialization: "Specialization ${(i % 5) + 1}",
      status: _randomStatus(),
    ),
  ),
};
