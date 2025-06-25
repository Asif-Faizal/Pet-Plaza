import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/order_history/order_history_entity.dart';
import '../../domain/order_history/order_history_repo.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  final OrderHistoryRepository orderHistoryRepository;

  OrderHistoryBloc({required this.orderHistoryRepository}) : super(OrderHistoryInitial()) {
    on<GetOrderHistory>(_onGetOrderHistory);
    on<RefreshOrderHistory>(_onRefreshOrderHistory);
  }

  Future<void> _onGetOrderHistory(
    GetOrderHistory event,
    Emitter<OrderHistoryState> emit,
  ) async {
    emit(OrderHistoryLoading());
    
    final result = await orderHistoryRepository.getOrderHistory(
      token: event.token,
    );

    result.fold(
      (error) => emit(OrderHistoryError(error)),
      (orderHistory) => emit(OrderHistoryLoaded(orderHistory)),
    );
  }

  Future<void> _onRefreshOrderHistory(
    RefreshOrderHistory event,
    Emitter<OrderHistoryState> emit,
  ) async {
    final result = await orderHistoryRepository.getOrderHistory(
      token: event.token,
    );

    result.fold(
      (error) => emit(OrderHistoryError(error)),
      (orderHistory) => emit(OrderHistoryLoaded(orderHistory)),
    );
  }
} 