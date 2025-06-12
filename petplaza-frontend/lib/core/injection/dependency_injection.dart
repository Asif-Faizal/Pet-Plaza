import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:petplaza/features/dashboard/bloc/get_cart_items/get_cart_items_bloc.dart';
import 'package:petplaza/features/dashboard/domain/user_adoption_requests/user_adoption_request_repo.dart' show UserAdoptionRequestRepository;

import '../../features/dashboard/bloc/add_to_cart/add_to_cart_bloc.dart';
import '../../features/dashboard/bloc/adoption_request/adoption_requests_bloc.dart';
import '../../features/dashboard/bloc/pet/pet_bloc.dart';
import '../../features/dashboard/bloc/pet_items/pet_items_bloc.dart';
import '../../features/dashboard/bloc/update_cart_item/update_cart_item_bloc.dart';
import '../../features/dashboard/bloc/user_adoption_requests/user_adoption_requests_bloc.dart';
import '../../features/dashboard/data/adoption_request/adoption_request_datasource.dart';
import '../../features/dashboard/data/adoption_request/adoption_request_repo_impl.dart';
import '../../features/dashboard/data/cart/cart_datasource.dart';
import '../../features/dashboard/data/cart/cart_to_repo_impl.dart';
import '../../features/dashboard/data/pet/pet_datasource.dart';
import '../../features/dashboard/data/pet/pet_repo_impl.dart';
import '../../features/dashboard/data/pet_items/pet_item_datasource.dart';
import '../../features/dashboard/data/pet_items/pet_items_repo_impl.dart';
import '../../features/dashboard/data/user_adoption_requests/user_adoption_request_datasource.dart';
import '../../features/dashboard/data/user_adoption_requests/user_adoption_request_repo_impl.dart';
import '../../features/dashboard/domain/adoption_request/adoption_request_repo.dart';
import '../../features/dashboard/domain/cart/cart_repo.dart';
import '../../features/dashboard/domain/pet/pet_repo.dart';
import '../../features/dashboard/domain/pet_items/pet_items_repo.dart';
import '../../features/login/bloc/bloc/login_bloc.dart';
import '../../features/login/cubit/login_cubit.dart';
import '../../features/login/data/login_datasource.dart';
import '../../features/login/data/login_repo_impl.dart';
import '../../features/login/domain/login_repo.dart';
import '../../features/register/bloc/register_user/register_user_bloc.dart';
import '../../features/register/cubit/register_cubit.dart';
import '../../features/register/data/register_user_datasource.dart';
import '../../features/register/data/register_user_repo_impl.dart';
import '../../features/register/domain/register_user.dart';
import '../../features/register/domain/register_user_repo.dart';
import '../../features/dashboard/bloc/delete_cart_item/delete_cart_item_bloc.dart';

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
  sl.registerFactory(() => RegisterCubit());

  // BLoC
  sl.registerFactory(() => LoginBloc(loginRepository: sl()));
  sl.registerLazySingleton<LoginDataSource>(
    () => LoginDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(dataSource: sl()),
  );

  // Pet Repository
  sl.registerLazySingleton<PetRepository>(
    () => PetRepositoryImpl(remoteDatasource: sl()),
  );

  // Pet Bloc
  sl.registerFactory(() => PetBloc(petRepository: sl()));

  // Pet Remote Datasource
  sl.registerLazySingleton<PetRemoteDatasource>(
    () => PetRemoteDatasourceImpl(client: sl()),
  );

  // Pet Adoption Remote Datasource
  sl.registerLazySingleton<PetAdoptionRemoteDataSource>(
    () => PetAdoptionRemoteDataSourceImpl(client: sl()),
  );

  // Pet Adoption Repository
  sl.registerLazySingleton<PetAdoptionRepository>(
    () => PetAdoptionRepositoryImpl(remoteDataSource: sl()),
  );

  // Pet Adoption Bloc
  sl.registerFactory(() => AdoptionRequestsBloc(petAdoptionRepository: sl()));

  // User Adoption Request Remote Datasource
  sl.registerLazySingleton<UserAdoptionRequestRemoteDataSource>(
    () => UserAdoptionRequestRemoteDataSourceImpl(client: sl()),
  );

  // User Adoption Request Repository
  sl.registerLazySingleton<UserAdoptionRequestRepository>(
    () => UserAdoptionRequestRepositoryImpl(remoteDataSource: sl()),
  );

  // User Adoption Request Bloc
  sl.registerFactory(() => UserAdoptionRequestsBloc(userAdoptionRequestRepository: sl()));


  sl.registerFactory(() => PetItemBloc(sl()));

  // Repository
  sl.registerLazySingleton<PetItemRepository>(() => PetItemRepositoryImpl(sl()));

  // Data Source
  sl.registerLazySingleton<PetItemRemoteDataSource>(() => PetItemRemoteDataSourceImpl(sl()));



  sl.registerLazySingleton<CartRemoteDataSource>(
      () => CartRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(sl()));
  sl.registerFactory(() => AddToCartBloc(sl()));
  sl.registerFactory(()=> GetCartItemsBloc(sl()));

  // Bloc
  sl.registerFactory(
    () => DeleteCartItemBloc(sl()),
  );
  sl.registerFactory(() => UpdateCartItemBloc(sl()));
}
