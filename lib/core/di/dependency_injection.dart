import 'package:dio/dio.dart';
import 'package:dome_care/core/networking/dio_factory.dart';
import 'package:dome_care/features/login/data/data_sources/authentication_local_data_source.dart';
import 'package:dome_care/features/login/data/data_sources/authentication_remote_data_source.dart';
import 'package:dome_care/features/login/data/repositories/authentication_repository_implementation.dart';
import 'package:dome_care/features/login/data/services/authentication_service.dart';
import 'package:dome_care/features/login/domain/repositories/authentication_repository.dart';
import 'package:dome_care/features/login/domain/usecases/login_usecase.dart';
import 'package:dome_care/features/login/presentation/cubit/login_cubit.dart';
import 'package:dome_care/features/snackbar/bloc/snackbar_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  final dio = await DioFactory.getDio();
  getIt.registerSingleton<Dio>(dio);

  // Snackbar
  getIt.registerFactory<SnackbarBloc>(() => SnackbarBloc());

  // Login
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
  getIt.registerLazySingleton<LoginUseCase>(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImplementation(getIt(), getIt()),
  );
  getIt.registerLazySingleton<AuthenticationService>(
    () => AuthenticationService(getIt()),
  );
  getIt.registerLazySingleton<AuthenticationLocalDataSource>(
    () => AuthenticationLocalDataSourceImpl(),
  );
}
