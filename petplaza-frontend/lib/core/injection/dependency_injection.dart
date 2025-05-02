import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../features/login/bloc/bloc/login_bloc.dart';
import '../../features/login/cubit/login_cubit.dart';
import '../../features/login/data/login_datasource.dart';
import '../../features/login/data/login_repo_impl.dart';
import '../../features/login/domain/login_repo.dart';
import '../../features/register/bloc/register_user/register_user_bloc.dart';
import '../../features/register/data/register_user_datasource.dart';
import '../../features/register/data/register_user_repo_impl.dart';
import '../../features/register/domain/register_user.dart';
import '../../features/register/domain/register_user_repo.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Data Sources
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(client: sl()),
  );

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => RegisterUserUseCase(repository: sl()));

  // BLoC
  sl.registerFactory(() => RegisterUserBloc(sl())); // Make sure it's here

  // External
  sl.registerLazySingleton(() => http.Client());

  // Cubit
  sl.registerFactory(() => LoginCubit());

  // BLoC
  sl.registerFactory(() => LoginBloc(loginRepository: sl()));
  sl.registerLazySingleton<LoginDataSource>(
    () => LoginDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(dataSource: sl()),
  );
}
