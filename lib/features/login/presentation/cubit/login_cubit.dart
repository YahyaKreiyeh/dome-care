import 'package:dome_care/core/localization/locale_keys.g.dart';
import 'package:dome_care/core/mixins/cubit_mixin.dart';
import 'package:dome_care/core/models/result.dart';
import 'package:dome_care/core/utilities/validators.dart';
import 'package:dome_care/features/login/domain/usecases/login_usecase.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> with SafeEmitter<LoginState> {
  final LoginUseCase _loginUseCase;
  LoginCubit(this._loginUseCase) : super(LoginState());

  Future<void> login() async {
    safeEmit(state.copyWith(status: const Result.loading()));
    final result = await _loginUseCase(
      LoginParams(userName: state.username, password: state.password),
    );
    safeEmit(state.copyWith(status: result));
  }

  void phoneChanged(String val) {
    final digits = val.replaceAll(RegExp(r'\D'), '');
    final error = validateSyrianLocalNumber(digits)
        ? null
        : 'Enter a valid number';
    safeEmit(state.copyWith(phone: digits, phoneError: error));
  }

  void usernameChanged(String val) {
    final trimmed = val.trim();
    final error = trimmed.isEmpty
        ? LocaleKeys.login_username_required.tr()
        : null;
    safeEmit(state.copyWith(username: val, usernameError: error));
  }

  void passwordChanged(String val) {
    final error = passwordValidationError(val);
    safeEmit(state.copyWith(password: val, passwordError: error));
  }

  void togglePasswordVisibility() {
    safeEmit(state.copyWith(isPasswordObscured: !state.isPasswordObscured));
  }
}
