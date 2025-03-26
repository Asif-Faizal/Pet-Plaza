import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

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
}
