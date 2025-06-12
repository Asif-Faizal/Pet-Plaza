import 'package:petplaza/features/dashboard/domain/pet/pet_entity.dart';

class PetResponseModel extends Pet {
  const PetResponseModel({
    required super.id,
    required super.name,
    required super.petType,
    required super.breed,
    required super.gender,
    required super.age,
    required super.ownerName,
    required super.contactNumber,
    required super.contactAddress,
    required super.behavior,
    required super.description,
    required super.imageUrls,
    required super.adoptionCentreName,
    required super.adoptionCentreLocation,
    required super.status,
  });

  factory PetResponseModel.fromJson(Map<String, dynamic> json) {
    final item = json;
    final adoptionCentre = item['adoptionCentre'] ?? {};

    return PetResponseModel(
      id: item['_id'] ?? '',
      name: item['name'] ?? '',
      petType: item['petType'] ?? '',
      breed: item['breed'] ?? '',
      gender: item['gender'] ?? '',
      age: item['age'] ?? 0,
      ownerName: item['ownerName'] ?? '',
      contactNumber: item['contactNumber'] ?? '',
      contactAddress: item['contactAddress'] ?? '',
      behavior: item['behavior'] ?? '',
      description: item['description'] ?? '',
      imageUrls: List<String>.from(item['imageUrls'] ?? []),
      adoptionCentreName: adoptionCentre['name'] ?? '',
      adoptionCentreLocation: adoptionCentre['location'] ?? '',
      status: item['status'] ?? '',
    );
  }

  static List<PetResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PetResponseModel.fromJson(json)).toList();
  }
}
