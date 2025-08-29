import 'package:dio/dio.dart';
import 'package:dome_care/core/models/result.dart';
import 'package:dome_care/core/networking/api_error_handler.dart';
import 'package:dome_care/features/login/data/data_sources/authentication_local_data_source.dart';
import 'package:dome_care/features/login/data/data_sources/authentication_remote_data_source.dart';
import 'package:dome_care/features/login/data/models/login_dto.dart';
import 'package:dome_care/features/login/domain/entites/user_entity.dart';
import 'package:dome_care/features/login/domain/repositories/authentication_repository.dart';
import 'package:dome_care/features/login/domain/usecases/login_usecase.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  final AuthenticationRemoteDataSource _remote;
  final AuthenticationLocalDataSource _local;
  AuthenticationRepositoryImplementation(this._remote, this._local);

  @override
  Future<Result<UserEntity>> login({required LoginParams params}) async {
    try {
      final LoginResponseDto dto = await _remote.login(
        username: params.userName,
        password: params.password,
      );
      final entity = dto.toDomain();
      await _local.saveTokens(
        accessToken: dto.accessToken,
        refreshToken: dto.refreshToken,
      );
      return Result.success(data: entity);
    } on DioException catch (error) {
      final apiError = ApiErrorHandler.handle(error);
      return Result.failure(
        error: error,
        errorMessage: apiError.getAllErrorMessages(),
      );
    } catch (error) {
      return Result.failure(
        error: Exception('Login failed: $error'),
        errorMessage: 'Unable to login. Please try again.',
      );
    }
  }
}
