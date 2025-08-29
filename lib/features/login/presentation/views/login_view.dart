import 'package:dome_care/core/constants/constants.dart';
import 'package:dome_care/core/constants/enums.dart';
import 'package:dome_care/core/helpers/spacing.dart';
import 'package:dome_care/core/models/country.dart';
import 'package:dome_care/core/models/result.dart';
import 'package:dome_care/core/routing/routes.dart';
import 'package:dome_care/core/routing/routes_extension.dart';
import 'package:dome_care/core/style/assets/assets.gen.dart';
import 'package:dome_care/core/themes/app_colors.dart';
import 'package:dome_care/core/themes/text_styles.dart';
import 'package:dome_care/core/widgets/buttons/primary_button.dart';
import 'package:dome_care/core/widgets/text_fields/custom_text_field.dart';
import 'package:dome_care/features/login/presentation/cubit/login_cubit.dart';
import 'package:dome_care/features/login/presentation/cubit/login_state.dart';
import 'package:dome_care/features/snackbar/bloc/snackbar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteScaffoldBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Header(),
              _LoginForm(),
              _LoginButton(),
              _CreateAccount(),
              _LoginBlocListener(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VerticalSpace(24),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'New to DomeCare? ',
                style: TextStyles.primaryText40016,
              ),
              TextSpan(
                text: 'Create Account',
                style: TextStyles.primary70016.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.appPrimaryText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final phone = context.select((LoginCubit c) => c.state.phone);
    final phoneError = context.select((LoginCubit c) => c.state.phoneError);
    final password = context.select((LoginCubit c) => c.state.password);
    final passwordError = context.select(
      (LoginCubit c) => c.state.passwordError,
    );
    final isLoading = context.select(
      (LoginCubit c) => c.state.status.isLoading,
    );

    final canSubmit =
        phone.isNotEmpty &&
        password.isNotEmpty &&
        phoneError == null &&
        passwordError == null &&
        !isLoading;

    return Column(
      children: [
        VerticalSpace(108),
        PrimaryButton(
          text: 'Log In',
          textStyle: TextStyles.white70016,
          loading: isLoading,
          onPressed: canSubmit
              ? () => context.read<LoginCubit>().login()
              : null,
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Assets.images.loginHeader.image(),
        VerticalSpace(13),
        _Welcome(),
        VerticalSpace(24),
      ],
    );
  }
}

class _Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Welcome back to DomeCare 👋',
      style: TextStyles.primaryText70018,
    );
  }
}

class _LoginBlocListener extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        state.status.when(
          success: (_) {
            context.read<SnackbarBloc>().add(
              AddSnackbarEvent(
                message: 'Login successful',
                type: SnackbarType.success,
              ),
            );
            context.pushReplacementNamed(Routes.myAppointments);
          },
          failure: (_, _, errorMessage) {
            context.read<SnackbarBloc>().add(
              AddSnackbarEvent(
                message: errorMessage ?? 'Login failed',
                type: SnackbarType.error,
              ),
            );
          },
          loading: () {},
          empty: () {},
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _PhoneNumberInput(),
        VerticalSpace(16),
        _PasswordInput(),
        VerticalSpace(16),
        _ForgotPassword(),
      ],
    );
  }
}

class _ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Forgot password?",
      style: TextStyles.primaryText70013.copyWith(
        decoration: TextDecoration.underline,
      ),
      textAlign: TextAlign.end,
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  const _PhoneNumberInput();

  @override
  Widget build(BuildContext context) {
    final error = context.select((LoginCubit c) => c.state.phoneError);
    return CustomTextField(
      keyboardType: TextInputType.phone,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: context.read<LoginCubit>().phoneChanged,
      hintText: 'Mobile Number',
      maxLength: 10,
      errorText: error,
      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      prefixIcon: InkWell(
        onTap: () => _showCountryPicker(context),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 4),
                child: Text('+963', style: TextStyles.primaryText40015),
              ),
              const Icon(Icons.keyboard_arrow_down),
              const HorizontalSpace(16),
            ],
          ),
        ),
      ),
    );
  }

  Future<Country?> _showCountryPicker(BuildContext context) async {
    const all = [Country(name: 'Syria', flag: '🇸🇾')];
    final controller = TextEditingController();
    var filtered = List<Country>.from(all);

    return showModalBottomSheet<Country>(
      context: context,
      useSafeArea: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            void filter(String q) {
              final query = q.toLowerCase();
              setSheetState(() {
                filtered = all
                    .where((c) => c.name.toLowerCase().contains(query))
                    .toList();
              });
            }

            return Column(
              children: [
                VerticalSpace(24),
                _SearchField(controller: controller, onChanged: filter),
                _List(items: filtered, onSelect: (c) => ctx.pop()),
              ],
            );
          },
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    final isObscured = context.select(
      (LoginCubit c) => c.state.isPasswordObscured,
    );
    final error = context.select((LoginCubit c) => c.state.passwordError);

    final phone = context.select((LoginCubit c) => c.state.phone);
    final phoneError = context.select((LoginCubit c) => c.state.phoneError);
    final password = context.select((LoginCubit c) => c.state.password);
    final passwordError = context.select(
      (LoginCubit c) => c.state.passwordError,
    );
    final isLoading = context.select(
      (LoginCubit c) => c.state.status.isLoading,
    );

    final canSubmit =
        phone.isNotEmpty &&
        password.isNotEmpty &&
        phoneError == null &&
        passwordError == null &&
        !isLoading;

    return CustomTextField(
      hintText: 'Password',
      obscureText: isObscured,
      errorText: error,
      onChanged: context.read<LoginCubit>().passwordChanged,
      textInputAction: TextInputAction.done,
      onEditingComplete: () {
        if (canSubmit) {
          context.read<LoginCubit>().login();
        } else {
          FocusScope.of(context).unfocus();
        }
      },
      suffixIcon: Padding(
        padding: const EdgeInsetsDirectional.only(end: 12),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => context.read<LoginCubit>().togglePasswordVisibility(),
          child: Icon(
            isObscured
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: AppColors.inputBorderGrey,
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),

      child: CustomTextField(
        controller: controller,
        onChanged: onChanged,
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search),
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List({required this.items, required this.onSelect});

  final List<Country> items;
  final ValueChanged<Country> onSelect;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(horizontalPadding),
        itemCount: items.length,
        itemBuilder: (_, i) {
          final c = items[i];
          return ListTile(
            onTap: () => onSelect(c),
            leading: Text(c.flag, style: const TextStyle(fontSize: 30)),
            title: Text(c.name),
          );
        },
        separatorBuilder: (_, _) =>
            const Divider(height: 1, color: AppColors.inputBorderGrey),
      ),
    );
  }
}
