import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/order/order_entity.dart';
import '../../domain/order/order_repo.dart';

part 'place_order_event.dart';
part 'place_order_state.dart';

class PlaceOrderBloc extends Bloc<PlaceOrderEvent, PlaceOrderState> {
  final OrderRepository orderRepository;

  PlaceOrderBloc({required this.orderRepository}) : super(PlaceOrderInitial()) {
    on<PlaceOrder>(_onPlaceOrder);
  }

  Future<void> _onPlaceOrder(
    PlaceOrder event,
    Emitter<PlaceOrderState> emit,
  ) async {
    emit(PlaceOrderLoading());
    
    final result = await orderRepository.placeOrder(
      street: event.street,
      city: event.city,
      state: event.state,
      postalCode: event.postalCode,
      country: event.country,
      paymentMethod: event.paymentMethod,
      token: event.token,
    );

    result.fold(
      (error) => emit(PlaceOrderError(error)),
      (order) => emit(PlaceOrderSuccess(order)),
    );
  }
} 