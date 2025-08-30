/// Minimal doctor information required by cards, lists, and headers in the UI.
/// Entities remain UI-agnostic but reflect the current Figma needs.
class DoctorEntity {
  /// local path to doctor avatar/banner.
  final String image;

  /// Display name.
  final String name;

  /// Medical specialty label (e.g., "Cardiologist").
  final String specialization;

  /// Clinic/hospital location as shown in the card.
  final String location;

  /// Mobile contact number.
  final String phoneNumber;

  /// Landline contact number.
  final String telephone;

  /// Creates a [DoctorEntity]. All fields are currently required to match UI.
  const DoctorEntity({
    required this.image,
    required this.name,
    required this.specialization,
    required this.location,
    required this.phoneNumber,
    required this.telephone,
  });
}
