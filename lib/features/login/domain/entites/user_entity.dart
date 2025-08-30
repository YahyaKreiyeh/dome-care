import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

/// Immutable user domain model derived from the Figma auth/profile flows.
/// Contains only fields the current UI needs. Tokens are included because
/// several screens trigger authenticated requests directly after login.
@freezed
abstract class UserEntity with _$UserEntity {
  /// Creates a [UserEntity].
  ///
  /// All fields are required by current business rules and UI contracts.
  const factory UserEntity({
    /// Short-lived bearer token used in API requests.
    required String accessToken,

    /// Token used to refresh [accessToken].
    required String refreshToken,

    /// Backend user identifier.
    required int id,

    /// Public handle used in some screens.
    required String username,

    /// Login/contact email.
    required String email,

    /// First name for profile and greetings.
    required String firstName,

    /// Last name for profile and greetings.
    required String lastName,

    /// User gender as provided by backend (may become an enum later).
    required String gender,

    /// URL to profile image.
    required String image,
  }) = _UserEntity;

  /// Builds a [UserEntity] from JSON as returned by the backend.
  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}
