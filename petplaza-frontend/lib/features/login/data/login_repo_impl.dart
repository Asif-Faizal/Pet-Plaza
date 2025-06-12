import 'package:dartz/dartz.dart';
import 'package:petplaza/features/login/data/login_datasource.dart';
import 'package:petplaza/features/login/data/login_request_model.dart';
import 'package:petplaza/features/login/domain/login_entity.dart';

import '../../../core/error/failures.dart';
import '../domain/login_repo.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource dataSource;

  LoginRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, LoginEntity>> login(LoginRequestModel request) async {
    try {
      final response = await dataSource.login(request);
      return Right(response);
    } catch (e) {
      return Left(LoginFailure());
    }
  }
}
