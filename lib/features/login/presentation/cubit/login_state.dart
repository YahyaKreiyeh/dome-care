import 'package:dome_care/core/models/result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default(Result.empty()) Result status,
    @Default('') String phone,
    String? phoneError,
    @Default('') String password,
    String? passwordError,
    @Default(true) bool isPasswordObscured,
  }) = _LoginState;
}
