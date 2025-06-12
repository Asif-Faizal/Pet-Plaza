
import '../../domain/pet_items/pet_items_entity.dart';

class PetItemModel extends PetItem {
  const PetItemModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.petType,
    required super.category,
    required super.imageUrls,
    required super.stock,
  });

  factory PetItemModel.fromJson(Map<String, dynamic> json) {
    return PetItemModel(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      petType: json['petType'],
      category: json['category'],
      imageUrls: List<String>.from(json['imageUrls']),
      stock: json['stock'],
    );
  }
}
