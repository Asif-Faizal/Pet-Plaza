import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/register_user_model.dart';
import '../../domain/register_user.dart';
import '../../domain/register_user_entity.dart';

part 'register_user_event.dart';
part 'register_user_state.dart';

class RegisterUserBloc extends Bloc<RegisterUserEvent, RegisterUserState> {
  final RegisterUserUseCase useCase;
  RegisterUserBloc(this.useCase) : super(RegisterUserInitial()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(RegisterUserLoading());
      final result = await useCase(event.request);
      result.fold(
        (failure) => emit(RegisterUserFailure(failure.toString())),
        (user) => emit(RegisterUserSuccess(user)),
      );
    });
  }
}
