import 'package:dome_care/core/models/result.dart';
import 'package:dome_care/features/login/domain/entites/user_entity.dart';
import 'package:dome_care/features/login/domain/usecases/login_usecase.dart';

abstract class AuthenticationRepository {
  Future<Result<UserEntity>> login({required LoginParams params});
}
