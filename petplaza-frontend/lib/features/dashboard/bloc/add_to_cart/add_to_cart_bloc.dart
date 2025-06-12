import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/cart/add_to_cart_entity.dart';
import '../../domain/cart/cart_repo.dart';

part 'add_to_cart_event.dart';
part 'add_to_cart_state.dart';

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  final CartRepository repository;

  AddToCartBloc(this.repository) : super(CartInitial()) {
    on<AddToCart>((event, emit) async {
      emit(CartLoading());
      final result = await repository.addToCart(event.productId, event.quantity,event.token);
      result.fold(
        (error) => emit(CartError(error)),
        (cart) => emit(CartLoaded(cart)),
      );
    });
  }
}