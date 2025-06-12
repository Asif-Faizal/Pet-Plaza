import 'package:dartz/dartz.dart';

import '../../domain/adoption_request/adoption_request_entity.dart';
import '../../domain/adoption_request/adoption_request_repo.dart';
import 'adoption_request_datasource.dart';
import 'adoption_request_model.dart';

class PetAdoptionRepositoryImpl implements PetAdoptionRepository {
  final PetAdoptionRemoteDataSource remoteDataSource;

  PetAdoptionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, AdoptionRequestEntity>> submitAdoptionRequest(AdoptionRequestModel request, String token) async {
    try {
      final response = await remoteDataSource.submitAdoptionRequest(request, token);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
