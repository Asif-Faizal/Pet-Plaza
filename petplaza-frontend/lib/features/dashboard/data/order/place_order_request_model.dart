class PlaceOrderRequestModel {
  final ShippingAddressRequestModel shippingAddress;
  final String paymentMethod;

  PlaceOrderRequestModel({
    required this.shippingAddress,
    required this.paymentMethod,
  });

  Map<String, dynamic> toJson() {
    return {
      'shippingAddress': shippingAddress.toJson(),
      'paymentMethod': paymentMethod,
    };
  }
}

class ShippingAddressRequestModel {
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  ShippingAddressRequestModel({
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
    };
  }
} 