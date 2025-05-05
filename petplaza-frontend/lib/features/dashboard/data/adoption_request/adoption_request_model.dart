import 'package:equatable/equatable.dart';

import '../../domain/adoption_request/adoption_request_entity.dart';

class AdoptionResponseModel extends AdoptionRequestEntity {

  const AdoptionResponseModel({
    required super.isSuccess,
    required super.id,
    required super.petId,
    required super.userId,
    required super.adoptionCentreId,
    required super.note,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
  });

  factory AdoptionResponseModel.fromJson(Map<String, dynamic> json) {
    return AdoptionResponseModel(
      isSuccess: json['success'],
      id: json['id'],
      petId: json['petId'],
      userId: json['userId'],
      adoptionCentreId: json['adoptionCentreId'],
      note: json['note'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  factory AdoptionResponseModel.fromJsonList(Map<String, dynamic> json) {
    return AdoptionResponseModel(
      isSuccess: json['success'],
      id: json['data']['_id'],
      petId: json['data']['pet'],
      userId: json['data']['user'],
      adoptionCentreId: json['data']['adoptionCentre'],
      note: json['data']['note'],
      status: json['data']['status'],
      createdAt: DateTime.parse(json['data']['createdAt']),
      updatedAt: DateTime.parse(json['data']['updatedAt']),
    );
  }
}

class AdoptionRequestModel extends Equatable{
  final String petId;
  final String note;

  const AdoptionRequestModel({
    required this.petId,
    required this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'petId': petId,
      'note': note,
    };
  }

  @override
  List<Object?> get props => [petId, note];
}
