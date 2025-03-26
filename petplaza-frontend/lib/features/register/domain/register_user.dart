import 'package:dartz/dartz.dart';

import '../data/register_user_model.dart';
import 'register_user_entity.dart';
import 'register_user_repo.dart';

class RegisterUserUseCase {
  final UserRepository repository;

  RegisterUserUseCase({required this.repository});

  Future<Either<Exception, User>> call(RegisterRequestModel request) {
    return repository.registerUser(request);
  }
}