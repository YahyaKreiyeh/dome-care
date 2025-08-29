import 'dart:math';

import 'package:dome_care/core/constants/enums.dart';
import 'package:dome_care/core/style/assets/assets.gen.dart';
import 'package:dome_care/features/appointments/domain/entites/appointment_entity.dart';
import 'package:dome_care/features/appointments/domain/entites/doctor_entity.dart';

final _rndAr = Random();

AppointmentStatus _randomStatusAr() {
  const statuses = [
    AppointmentStatus.confirmed,
    AppointmentStatus.pending,
    AppointmentStatus.canceled,
    AppointmentStatus.rejected,
  ];
  return statuses[_rndAr.nextInt(statuses.length)];
}

String _randomMobileAr() =>
    '+963 9${_rndAr.nextInt(9)}${_rndAr.nextInt(9)} '
    '${_rndAr.nextInt(900) + 100} ${_rndAr.nextInt(900) + 100}';

String _randomTelephoneAr() => '011 ${_rndAr.nextInt(9000000) + 1000000}';

String _randomFeeAr() {
  const fees = [15000, 20000, 25000, 30000, 35000, 40000, 45000];
  final v = fees[_rndAr.nextInt(fees.length)];
  final s = v.toString().replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (m) => '${m[1]},',
  );
  return '$s ل.س';
}

String _arTime(String hhmmAmPm) {
  return hhmmAmPm.replaceAll('AM', 'ص').replaceAll('PM', 'م');
}

const _defaultLocationAr = 'البرامكة، دمشق، سوريا';
const _defaultReasonAr =
    'لماذا تريد إلغاء الموعد؟ '
    'لماذا تريد إلغاء الموعد؟ '
    'لماذا تريد إلغاء الموعد؟ '
    'لماذا تريد إلغاء الموعد؟';

final List<DoctorEntity> mockDoctorsAr = [
  DoctorEntity(
    image: Assets.images.avatar1.path,
    name: 'د. بنيامين لي',
    specialization: 'طبيب نفسي',
    location: _defaultLocationAr,
    phoneNumber: '+963 999 999 999',
    telephone: '011 214578512',
  ),
  DoctorEntity(
    image: Assets.images.avatar2.path,
    name: 'د. جين سميث',
    specialization: 'طبيب جلدية',
    location: _defaultLocationAr,
    phoneNumber: _randomMobileAr(),
    telephone: _randomTelephoneAr(),
  ),
  DoctorEntity(
    image: Assets.images.avatar3.path,
    name: 'د. ألبرت لي',
    specialization: 'طبيب أسنان',
    location: _defaultLocationAr,
    phoneNumber: _randomMobileAr(),
    telephone: _randomTelephoneAr(),
  ),
  DoctorEntity(
    image: Assets.images.avatar1.path,
    name: 'د. إيملي براون',
    specialization: 'طبيب أعصاب',
    location: _defaultLocationAr,
    phoneNumber: _randomMobileAr(),
    telephone: _randomTelephoneAr(),
  ),
  DoctorEntity(
    image: Assets.images.avatar3.path,
    name: 'د. ديفيد ويلسون',
    specialization: 'طبيب عظام',
    location: _defaultLocationAr,
    phoneNumber: _randomMobileAr(),
    telephone: _randomTelephoneAr(),
  ),
];

DoctorEntity _randomDoctorAr() =>
    mockDoctorsAr[_rndAr.nextInt(mockDoctorsAr.length)];

final Map<DateTime, List<AppointmentEntity>> mockEventsAr = {
  DateTime(2025, 8, 23): [
    AppointmentEntity(
      date: DateTime(2025, 8, 23),
      time: _arTime("10:00 AM"),
      status: AppointmentStatus.canceled,
      doctor: mockDoctorsAr[0],
      fee: '40,000 ل.س',
      cancelReason: _defaultReasonAr,
    ),
    AppointmentEntity(
      date: DateTime(2025, 8, 23),
      time: _arTime("02:30 PM"),
      status: _randomStatusAr(),
      doctor: mockDoctorsAr[1],
      fee: _randomFeeAr(),
    ),
  ],

  DateTime(2025, 8, 4): [
    AppointmentEntity(
      date: DateTime(2025, 8, 4),
      time: _arTime("09:00 AM"),
      status: _randomStatusAr(),
      doctor: mockDoctorsAr[2],
      fee: _randomFeeAr(),
    ),
    AppointmentEntity(
      date: DateTime(2025, 8, 4),
      time: _arTime("01:00 PM"),
      status: _randomStatusAr(),
      doctor: mockDoctorsAr[3],
      fee: _randomFeeAr(),
    ),
    AppointmentEntity(
      date: DateTime(2025, 8, 4),
      time: _arTime("03:45 PM"),
      status: _randomStatusAr(),
      doctor: mockDoctorsAr[4],
      fee: _randomFeeAr(),
    ),
  ],

  DateTime(2025, 8, 7): List.generate(
    30,
    (i) => AppointmentEntity(
      date: DateTime(2025, 8, 7),
      time: _arTime("${9 + (i % 8)}:00 AM"),
      status: _randomStatusAr(),
      doctor: _randomDoctorAr(),
      fee: _randomFeeAr(),
      cancelReason: (i % 7 == 0) ? _defaultReasonAr : null,
    ),
  ),
};
