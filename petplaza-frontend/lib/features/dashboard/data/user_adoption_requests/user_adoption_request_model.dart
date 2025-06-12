import 'package:petplaza/features/dashboard/domain/user_adoption_requests/user_adoption_request_entity.dart';

class AdoptionRequestPetModel extends AdoptionRequestPetEntity {
  const AdoptionRequestPetModel({
    required super.id,
    required super.name,
    required super.petType,
    required super.breed,
    required super.images,
    required super.status,
  });

  factory AdoptionRequestPetModel.fromJson(Map<String, dynamic> json) {
    return AdoptionRequestPetModel(
      id: json['_id'],
      name: json['name'],
      petType: json['petType'],
      breed: json['breed'],
      images: List<String>.from(json['images']),
      status: json['status'],
    );
  }
}

class AdoptionCentreModel extends AdoptionCentreEntity {
  const AdoptionCentreModel({
    required super.id,
    required super.name,
    required super.location,
    super.contactNumber,
    super.contactAddress,
    super.email,
  });

  factory AdoptionCentreModel.fromJson(Map<String, dynamic> json) {
    return AdoptionCentreModel(
      id: json['_id'],
      name: json['name'],
      location: json['location'],
      contactNumber: json['contactNumber'],
      contactAddress: json['contactAddress'],
      email: json['email'],
    );
  }
}

class UserAdoptionRequestModel extends UserAdoptionRequestEntity {
  const UserAdoptionRequestModel({
    required super.id,
    required super.note,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    required super.pet,
    required super.adoptionCentre,
  });

  factory UserAdoptionRequestModel.fromJson(Map<String, dynamic> json) {
    return UserAdoptionRequestModel(
      id: json['_id'],
      note: json['note'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      pet: AdoptionRequestPetModel.fromJson(json['pet']),
      adoptionCentre: json['adoptionCentre'] != null 
          ? AdoptionCentreModel.fromJson(json['adoptionCentre'])
          : null,
    );
  }
}
