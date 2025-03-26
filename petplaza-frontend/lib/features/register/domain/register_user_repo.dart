import 'package:dartz/dartz.dart';

import '../data/register_user_model.dart';
import 'register_user_entity.dart';

abstract class UserRepository {
  Future<Either<Exception, User>> registerUser(RegisterRequestModel request);
}