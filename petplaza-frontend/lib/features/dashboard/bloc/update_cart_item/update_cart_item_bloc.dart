import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/cart/add_to_cart_entity.dart';
import '../../domain/cart/cart_repo.dart';

part 'update_cart_item_event.dart';
part 'update_cart_item_state.dart';

class UpdateCartItemBloc extends Bloc<UpdateCartItemEvent, UpdateCartItemState> {
  final CartRepository repository;

  UpdateCartItemBloc(this.repository) : super(UpdateCartItemInitial()) {
    on<UpdateCartItem>((event, emit) async {
      emit(UpdateCartItemLoading());
      final result = await repository.updateCartItem(
        event.productId,
        event.quantity,
        event.token,
      );
      result.fold(
        (error) => emit(UpdateCartItemError(error)),
        (cart) => emit(UpdateCartItemSuccess(cart)),
      );
    });
  }
} 