import 'package:dartz/dartz.dart';

import 'pet_entity.dart';

abstract class PetRepository {
  Future<Either<String, List<Pet>>> getFilteredPets({required String petType, required String status});
}