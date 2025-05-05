import 'package:dartz/dartz.dart';

import '../../data/adoption_request/adoption_request_model.dart';
import '../adoption_request/adoption_request_entity.dart';

abstract class PetAdoptionRepository {
  Future<Either<String, AdoptionRequestEntity>> submitAdoptionRequest(AdoptionRequestModel request, String token);
}
