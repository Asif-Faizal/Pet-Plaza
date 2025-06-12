import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/cart/cart_repo.dart';
import '../../domain/cart/get_cart_entity.dart';

part 'get_cart_items_event.dart';
part 'get_cart_items_state.dart';

class GetCartItemsBloc extends Bloc<GetCartItemsEvent, GetCartItemsState> {
  final CartRepository repository;
  GetCartItemsBloc(this.repository) : super(CartInitial()) {
    on<GetCartItems>((event, emit) async{
      emit(CartLoading());
      final result = await repository.getCartItems(event.token);
      result.fold(
        (error) => emit(CartError(error)),
        (cart) => emit(CartLoaded(cart)),
      );
    });
  }
}
