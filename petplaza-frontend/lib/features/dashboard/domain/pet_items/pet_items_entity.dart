import 'package:equatable/equatable.dart';

class PetItem extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String petType;
  final String category;
  final List<String> imageUrls;
  final int stock;

  const PetItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.petType,
    required this.category,
    required this.imageUrls,
    required this.stock,
  });

  @override
  List<Object?> get props => [id, name, description, price, petType, category, imageUrls, stock];
}
