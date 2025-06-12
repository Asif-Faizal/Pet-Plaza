import 'package:dartz/dartz.dart';

import 'pet_items_entity.dart';

abstract class PetItemRepository {
  Future<Either<String, List<PetItem>>> getPetItems();
}