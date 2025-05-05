import 'package:equatable/equatable.dart';

class AdoptionRequestEntity extends Equatable {
  final bool isSuccess;
  final String id;
  final String petId;
  final String userId;
  final String adoptionCentreId;
  final String note;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AdoptionRequestEntity({
    required this.isSuccess,
    required this.id,
    required this.petId,
    required this.userId,
    required this.adoptionCentreId,
    required this.note,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, petId, userId, adoptionCentreId, note, status, createdAt, updatedAt];
}
