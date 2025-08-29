import 'package:dome_care/core/models/result.dart';
import 'package:dome_care/core/usecases/usecase.dart';
import 'package:dome_care/features/login/domain/entites/user_entity.dart';
import 'package:dome_care/features/login/domain/repositories/authentication_repository.dart';

class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthenticationRepository _repo;
  const LoginUseCase(this._repo);

  @override
  Future<Result<UserEntity>> call(LoginParams params) {
    final username = params.userName.trim();
    return _repo.login(
      params: LoginParams(userName: username, password: params.password),
    );
  }
}

class LoginParams {
  final String userName;
  final String password;
  const LoginParams({required this.userName, required this.password});
}
