import 'package:dartz/dartz.dart';

import 'user_adoption_request_entity.dart';

abstract class UserAdoptionRequestRepository {
  Future<Either<String, List<UserAdoptionRequestEntity>>> getUserAdoptionRequests(String token);
} 