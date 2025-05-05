import 'package:dartz/dartz.dart';

import '../../domain/pet/pet_entity.dart';
import '../../domain/pet/pet_repo.dart';
import 'pet_datasource.dart';
import 'pet_request_model.dart';

class PetRepositoryImpl implements PetRepository {
  final PetRemoteDatasource remoteDatasource;

  PetRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<String, List<Pet>>> getFilteredPets({required String petType, required String status}) async {
    try {
      final request = PetRequestModel(petType: petType, status: status);
      final response = await remoteDatasource.getFilteredPets(request);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}