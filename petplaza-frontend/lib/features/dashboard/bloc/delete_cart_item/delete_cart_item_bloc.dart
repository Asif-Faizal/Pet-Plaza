import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/cart/add_to_cart_entity.dart';
import '../../domain/cart/cart_repo.dart';

part 'delete_cart_item_event.dart';
part 'delete_cart_item_state.dart';

class DeleteCartItemBloc extends Bloc<DeleteCartItemEvent, DeleteCartItemState> {
  final CartRepository repository;

  DeleteCartItemBloc(this.repository) : super(DeleteCartItemInitial()) {
    on<DeleteCartItem>((event, emit) async {
      emit(DeleteCartItemLoading());
      final result = await repository.deleteCartItem(event.productId, event.token);
      result.fold(
        (error) => emit(DeleteCartItemError(error)),
        (cart) => emit(DeleteCartItemSuccess(cart)),
      );
    });
  }
} 