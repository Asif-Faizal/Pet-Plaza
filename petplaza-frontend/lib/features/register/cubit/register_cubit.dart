import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class RegisterTextFieldState extends Equatable {
  final String name;
  final String phoneNumber;
  final String email;
  final String location;
  final String managerName;
  final String address;
  final String selectedCountryCode;
  final bool isNameValid;
  final bool isPhoneValid;
  final bool isEmailValid;
  final bool isLocationValid;
  final bool isManagerNameValid;
  final bool isAddressValid;
  final String? nameError;
  final String? phoneError;
  final String? emailError;
  final String? locationError;
  final String? managerNameError;
  final String? addressError;
  final bool isIndividual;

  const RegisterTextFieldState({
    this.name = '',
    this.phoneNumber = '',
    this.email = '',
    this.location = '',
    this.managerName = '',
    this.address = '',
    this.selectedCountryCode = '+1',
    this.isNameValid = false,
    this.isPhoneValid = false,
    this.isEmailValid = false,
    this.isLocationValid = false,
    this.isManagerNameValid = false,
    this.isAddressValid = false,
    this.nameError,
    this.phoneError,
    this.emailError,
    this.locationError,
    this.managerNameError,
    this.addressError,
    this.isIndividual = true,
  });

  bool get isFormValid {
    if (isIndividual) {
      return isNameValid && isPhoneValid && isEmailValid && isLocationValid;
    } else {
      return isNameValid && 
             isPhoneValid && 
             isEmailValid && 
             isLocationValid && 
             isManagerNameValid && 
             isAddressValid;
    }
  }

  RegisterTextFieldState copyWith({
    String? name,
    String? phoneNumber,
    String? email,
    String? location,
    String? managerName,
    String? address,
    String? selectedCountryCode,
    bool? isNameValid,
    bool? isPhoneValid,
    bool? isEmailValid,
    bool? isLocationValid,
    bool? isManagerNameValid,
    bool? isAddressValid,
    String? nameError,
    String? phoneError,
    String? emailError,
    String? locationError,
    String? managerNameError,
    String? addressError,
    bool? isIndividual,
  }) {
    return RegisterTextFieldState(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      location: location ?? this.location,
      managerName: managerName ?? this.managerName,
      address: address ?? this.address,
      selectedCountryCode: selectedCountryCode ?? this.selectedCountryCode,
      isNameValid: isNameValid ?? this.isNameValid,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isLocationValid: isLocationValid ?? this.isLocationValid,
      isManagerNameValid: isManagerNameValid ?? this.isManagerNameValid,
      isAddressValid: isAddressValid ?? this.isAddressValid,
      nameError: nameError,
      phoneError: phoneError,
      emailError: emailError,
      locationError: locationError,
      managerNameError: managerNameError,
      addressError: addressError,
      isIndividual: isIndividual ?? this.isIndividual,
    );
  }

  @override
  List<Object?> get props => [
        name,
        phoneNumber,
        email,
        location,
        managerName,
        address,
        selectedCountryCode,
        isNameValid,
        isPhoneValid,
        isEmailValid,
        isLocationValid,
        isManagerNameValid,
        isAddressValid,
        nameError,
        phoneError,
        emailError,
        locationError,
        managerNameError,
        addressError,
        isIndividual,
      ];
}

class RegisterCubit extends Cubit<RegisterTextFieldState> {
  RegisterCubit({bool isIndividual = true}) : super(RegisterTextFieldState(isIndividual: isIndividual));

  void updateName(String value) {
    emit(state.copyWith(name: value));
    _validateName(value);
  }

  void updatePhoneNumber(String value) {
    emit(state.copyWith(phoneNumber: value));
    _validatePhoneNumber(value);
  }

  void updateEmail(String value) {
    emit(state.copyWith(email: value));
    _validateEmail(value);
  }

  void updateLocation(String value) {
    emit(state.copyWith(location: value));
    _validateLocation(value);
  }

  void updateCountryCode(String code) {
    emit(state.copyWith(selectedCountryCode: code));
    _validatePhoneNumber(state.phoneNumber);
  }

  void updateManagerName(String value) {
    if (!state.isIndividual) {
      emit(state.copyWith(managerName: value));
      _validateManagerName(value);
    }
  }

  void updateAddress(String value) {
    if (!state.isIndividual) {
      emit(state.copyWith(address: value));
      _validateAddress(value);
    }
  }

  void _validateName(String name) {
    if (name.isEmpty) {
      emit(state.copyWith(
        isNameValid: false,
        nameError: 'Name is required',
      ));
    } else if (name.length < 2) {
      emit(state.copyWith(
        isNameValid: false,
        nameError: 'Name must be at least 2 characters',
      ));
    } else {
      emit(state.copyWith(
        isNameValid: true,
        nameError: null,
      ));
    }
  }

  void _validatePhoneNumber(String phone) {
    final phoneRegex = RegExp(r'^\d{10}$');
    
    if (phone.isEmpty) {
      emit(state.copyWith(
        isPhoneValid: false,
        phoneError: 'Phone number is required',
      ));
    } else if (!phoneRegex.hasMatch(phone)) {
      emit(state.copyWith(
        isPhoneValid: false,
        phoneError: 'Please enter a valid 10-digit phone number',
      ));
    } else {
      emit(state.copyWith(
        isPhoneValid: true,
        phoneError: null,
      ));
    }
  }

  void _validateEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    
    if (email.isEmpty) {
      emit(state.copyWith(
        isEmailValid: false,
        emailError: 'Email is required',
      ));
    } else if (!emailRegex.hasMatch(email)) {
      emit(state.copyWith(
        isEmailValid: false,
        emailError: 'Please enter a valid email address',
      ));
    } else {
      emit(state.copyWith(
        isEmailValid: true,
        emailError: null,
      ));
    }
  }

  void _validateLocation(String location) {
    if (location.isEmpty) {
      emit(state.copyWith(
        isLocationValid: false,
        locationError: 'Location is required',
      ));
    } else {
      emit(state.copyWith(
        isLocationValid: true,
        locationError: null,
      ));
    }
  }

  void _validateManagerName(String managerName) {
    if (!state.isIndividual) {
      if (managerName.isEmpty) {
        emit(state.copyWith(
          isManagerNameValid: false,
          managerNameError: 'Manager name is required',
        ));
      } else {
        emit(state.copyWith(
          isManagerNameValid: true,
          managerNameError: null,
        ));
      }
    }
  }

  void _validateAddress(String address) {
    if (!state.isIndividual) {
      if (address.isEmpty) {
        emit(state.copyWith(
          isAddressValid: false,
          addressError: 'Address is required',
        ));
      } else {
        emit(state.copyWith(
          isAddressValid: true,
          addressError: null,
        ));
      }
    }
  }
} 