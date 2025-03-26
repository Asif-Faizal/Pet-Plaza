import 'package:dartz/dartz.dart';

import '../domain/register_user_entity.dart';
import '../domain/register_user_repo.dart';
import 'register_user_datasource.dart';
import 'register_user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Exception, User>> registerUser(RegisterRequestModel request) async {
    try {
      final result = await remoteDataSource.registerUser(request);
      return Right(result);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}