import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/login_request_model.dart';
import '../../domain/login_entity.dart';
import '../../domain/login_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  LoginBloc({required this.loginRepository}) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      final result = await loginRepository.login(LoginRequestModel(identifier: event.identifier, passcode: event.passcode));
      result.fold((failure) {
        emit(LoginFailure(message: failure.toString()));
      }, (loginEntity) {
        emit(LoginSuccess(loginEntity: loginEntity));
      });
    });
  }
}
