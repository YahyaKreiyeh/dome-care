import 'package:dio/dio.dart';
import 'package:dome_care/features/login/data/models/login_dto.dart';
import 'package:dome_care/features/login/data/services/authentication_service.dart';

abstract class AuthenticationRemoteDataSource {
  Future<LoginResponseDto> login({
    required String username,
    required String password,
  });
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final AuthenticationService _service;
  AuthenticationRemoteDataSourceImpl(this._service);

  @override
  Future<LoginResponseDto> login({
    required String username,
    required String password,
  }) async {
    try {
      // HACK: Remove hardcoded credentials once backend is ready
      // return await _service.login(
      //   LoginRequestDto(username: username, password: password),
      // );
      return await _service.login(
        LoginRequestDto(username: 'emilys', password: 'emilyspass'),
      );
    } on DioException {
      rethrow;
    }
  }
}
