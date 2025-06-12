import 'package:dartz/dartz.dart';

import '../../domain/user_adoption_requests/user_adoption_request_entity.dart';
import '../../domain/user_adoption_requests/user_adoption_request_repo.dart';
import 'user_adoption_request_datasource.dart';

class UserAdoptionRequestRepositoryImpl implements UserAdoptionRequestRepository {
  final UserAdoptionRequestRemoteDataSource remoteDataSource;

  UserAdoptionRequestRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, List<UserAdoptionRequestEntity>>> getUserAdoptionRequests(String token) async {
    try {
      final requests = await remoteDataSource.getUserAdoptionRequests(token);
      return Right(requests);
    } catch (e) {
      return Left(e.toString());
    }
  }
} 