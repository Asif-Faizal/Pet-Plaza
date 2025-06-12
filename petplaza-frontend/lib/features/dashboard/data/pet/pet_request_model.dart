class PetRequestModel {
  final String petType;
  final String status;

  PetRequestModel({required this.petType, required this.status});

  Map<String, String> toQueryParams() {
    return {
      'petType': petType,
      'status': status,
    };
  }
}
