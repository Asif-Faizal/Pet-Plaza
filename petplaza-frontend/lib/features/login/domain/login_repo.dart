import 'package:dartz/dartz.dart';
import 'package:petplaza/features/login/domain/login_entity.dart';

import '../../../core/error/failures.dart';
import '../data/login_request_model.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginEntity>> login(LoginRequestModel request);
}


