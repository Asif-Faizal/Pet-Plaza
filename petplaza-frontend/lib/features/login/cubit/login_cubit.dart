import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class LoginTextFieldState extends Equatable {
  final bool isEmail;
  final String selectedCountryCode;
  final String emailOrPhone;
  final String password;
  final bool isValid;
  final String? errorMessage;

  const LoginTextFieldState({
    this.isEmail = true,
    this.selectedCountryCode = '+1',
    this.emailOrPhone = '',
    this.password = '',
    this.isValid = false,
    this.errorMessage,
  });

  LoginTextFieldState copyWith({
    bool? isEmail,
    String? selectedCountryCode,
    String? emailOrPhone,
    String? password,
    bool? isValid,
    String? errorMessage,
  }) {
    return LoginTextFieldState(
      isEmail: isEmail ?? this.isEmail,
      selectedCountryCode: selectedCountryCode ?? this.selectedCountryCode,
      emailOrPhone: emailOrPhone ?? this.emailOrPhone,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isEmail, selectedCountryCode, emailOrPhone, password, isValid, errorMessage];
}

class LoginCubit extends Cubit<LoginTextFieldState> {
  LoginCubit() : super(const LoginTextFieldState());

  void toggleInputType() {
    emit(state.copyWith(
      isEmail: !state.isEmail,
      emailOrPhone: '',
      isValid: false,
      errorMessage: null,
    ));
  }

  void updateCountryCode(String code) {
    emit(state.copyWith(selectedCountryCode: code));
    _validateInput(state.emailOrPhone);
  }

  void updateEmailOrPhone(String value) {
    emit(state.copyWith(emailOrPhone: value));
    _validateInput(value);
  }

  void updatePassword(String value) {
    emit(state.copyWith(password: value));
  }

  void _validateInput(String value) {
    if (state.isEmail) {
      _validateEmail(value);
    } else {
      _validatePhoneNumber(value);
    }
  }

  void _validateEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    
    if (email.isEmpty) {
      emit(state.copyWith(
        isValid: false,
        errorMessage: 'Email is required',
      ));
    } else if (!emailRegex.hasMatch(email)) {
      emit(state.copyWith(
        isValid: false,
        errorMessage: 'Please enter a valid email address',
      ));
    } else {
      emit(state.copyWith(
        isValid: true,
        errorMessage: null,
      ));
    }
  }

  void _validatePhoneNumber(String phone) {
    final phoneRegex = RegExp(r'^\d{10}$');
    
    if (phone.isEmpty) {
      emit(state.copyWith(
        isValid: false,
        errorMessage: 'Phone number is required',
      ));
    } else if (!phoneRegex.hasMatch(phone)) {
      emit(state.copyWith(
        isValid: false,
        errorMessage: 'Please enter a valid 10-digit phone number',
      ));
    } else {
      emit(state.copyWith(
        isValid: true,
        errorMessage: null,
      ));
    }
  }
} 