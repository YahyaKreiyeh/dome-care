import 'package:dome_care/core/constants/constants.dart';
import 'package:dome_care/core/helpers/shared_pref_helper.dart';

abstract class AuthenticationLocalDataSource {
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  });

  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> clearTokens();
}

class AuthenticationLocalDataSourceImpl
    implements AuthenticationLocalDataSource {
  AuthenticationLocalDataSourceImpl();

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      await SharedPrefHelper.setSecuredString(
        SharedPrefKeys.userToken,
        accessToken,
      );
      await SharedPrefHelper.setSecuredString(
        SharedPrefKeys.refreshToken,
        refreshToken,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> getAccessToken() async {
    try {
      final v = await SharedPrefHelper.getSecuredString(
        SharedPrefKeys.userToken,
      );
      return (v.isEmpty) ? null : v;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      final v = await SharedPrefHelper.getSecuredString(
        SharedPrefKeys.refreshToken,
      );
      return (v.isEmpty) ? null : v;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearTokens() async {
    try {
      await SharedPrefHelper.deleteSecured(SharedPrefKeys.userToken);
      await SharedPrefHelper.deleteSecured(SharedPrefKeys.refreshToken);
    } catch (e) {
      rethrow;
    }
  }
}
