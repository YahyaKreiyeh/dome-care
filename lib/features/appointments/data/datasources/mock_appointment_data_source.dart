import 'dart:math';

import 'package:dome_care/core/constants/enums.dart';
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

AppointmentStatus _randomStatus() {
  const statuses = [
    AppointmentStatus.confirmed,
    AppointmentStatus.pending,
    AppointmentStatus.canceled,
    AppointmentStatus.rejected,
  ];
  return statuses[_rnd.nextInt(statuses.length)];
}

String _randomMobile() =>
    '+963 9${_rnd.nextInt(9)}${_rnd.nextInt(9)} '
    '${_rnd.nextInt(900) + 100} ${_rnd.nextInt(900) + 100}';

String _randomTelephone() => '011 ${_rnd.nextInt(9000000) + 1000000}';

String _randomFee() {
  const fees = [15000, 20000, 25000, 30000, 35000, 40000, 45000];
  final v = fees[_rnd.nextInt(fees.length)];
  final s = v.toString().replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (m) => '${m[1]},',
  );
  return '$s SYR';
}

const _defaultLocation = 'Al-Baramkeh, Damascus, Syria';
const _defaultReason =
    'Why you want to cancel the Appointment? '
    'Why you want to cancel the Appointment? '
    'Why you want to cancel the Appointment? '
    'Why you want to cancel the Appointment?';

final Map<DateTime, List<AppointmentEntity>> mockEvents = {
  DateTime(2025, 8, 23): [
    AppointmentEntity(
      date: DateTime(2025, 8, 23),
      time: "10:00 AM",
      image: _randomAvatar(),
      name: "Dr. Benjamin Li",
      specialization: "Psychiatrist",
      status: AppointmentStatus.canceled,
      location: _defaultLocation,
      phoneNumber: '+963 999 999 999',
      telephone: '011 214578512',
      fee: '40,000 SYR',
      cancelReason: _defaultReason,
    ),
    AppointmentEntity(
      date: DateTime(2025, 8, 23),
      time: "02:30 PM",
      image: _randomAvatar(),
      name: "Dr. Jane Smith",
      specialization: "Dermatologist",
      status: _randomStatus(),
      location: _defaultLocation,
      phoneNumber: _randomMobile(),
      telephone: _randomTelephone(),
      fee: _randomFee(),
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
      location: _defaultLocation,
      phoneNumber: _randomMobile(),
      telephone: _randomTelephone(),
      fee: _randomFee(),
    ),
    AppointmentEntity(
      date: DateTime(2025, 8, 4),
      time: "01:00 PM",
      image: _randomAvatar(),
      name: "Dr. Emily Brown",
      specialization: "Neurologist",
      status: _randomStatus(),
      location: _defaultLocation,
      phoneNumber: _randomMobile(),
      telephone: _randomTelephone(),
      fee: _randomFee(),
    ),
    AppointmentEntity(
      date: DateTime(2025, 8, 4),
      time: "03:45 PM",
      image: _randomAvatar(),
      name: "Dr. David Wilson",
      specialization: "Orthopedic",
      status: _randomStatus(),
      location: _defaultLocation,
      phoneNumber: _randomMobile(),
      telephone: _randomTelephone(),
      fee: _randomFee(),
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
      location: _defaultLocation,
      phoneNumber: _randomMobile(),
      telephone: _randomTelephone(),
      fee: _randomFee(),
      cancelReason: (i % 7 == 0) ? _defaultReason : null,
    ),
  ),
};
