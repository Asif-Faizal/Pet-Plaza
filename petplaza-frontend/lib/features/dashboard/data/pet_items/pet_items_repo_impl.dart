import 'package:dartz/dartz.dart';

import '../../domain/pet_items/pet_items_entity.dart';
import '../../domain/pet_items/pet_items_repo.dart';
import 'pet_item_datasource.dart';

class PetItemRepositoryImpl implements PetItemRepository {
  final PetItemRemoteDataSource remoteDataSource;

  PetItemRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, List<PetItem>>> getPetItems() async {
    try {
      final items = await remoteDataSource.fetchPetItems();
      return Right(items);
    } catch (e) {
      return Left('Failed to load items: $e');
    }
  }
}