import 'package:dome_care/features/appointments/domain/entites/appointment_entity.dart';

final Map<DateTime, List<AppointmentEntity>> mockEvents = {
  DateTime(2025, 8, 23): [
    AppointmentEntity(
      date: DateTime(2025, 8, 23),
      time: "10:00 AM",
      image: "assets/images/doc1.png",
      name: "Dr. John Doe",
      specialization: "Cardiologist",
      status: "Confirmed",
    ),
    AppointmentEntity(
      date: DateTime(2025, 8, 23),
      time: "02:30 PM",
      image: "assets/images/doc2.png",
      name: "Dr. Jane Smith",
      specialization: "Dermatologist",
      status: "Pending",
    ),
  ],
  DateTime(2025, 8, 4): [
    AppointmentEntity(
      date: DateTime(2025, 8, 4),
      time: "09:00 AM",
      image: "assets/images/doc3.png",
      name: "Dr. Albert Lee",
      specialization: "Dentist",
      status: "Cancelled",
    ),
    AppointmentEntity(
      date: DateTime(2025, 8, 4),
      time: "01:00 PM",
      image: "assets/images/doc4.png",
      name: "Dr. Emily Brown",
      specialization: "Neurologist",
      status: "Confirmed",
    ),
    AppointmentEntity(
      date: DateTime(2025, 8, 4),
      time: "03:45 PM",
      image: "assets/images/doc5.png",
      name: "Dr. David Wilson",
      specialization: "Orthopedic",
      status: "Confirmed",
    ),
  ],
  DateTime(2025, 8, 7): List.generate(
    30,
    (i) => AppointmentEntity(
      date: DateTime(2025, 8, 7),
      time: "${9 + (i % 8)}:00 AM",
      image: "assets/images/doc${(i % 5) + 1}.png",
      name: "Doctor ${i + 1}",
      specialization: "Specialization ${(i % 5) + 1}",
      status: i.isEven ? "Confirmed" : "Pending",
    ),
  ),
};
