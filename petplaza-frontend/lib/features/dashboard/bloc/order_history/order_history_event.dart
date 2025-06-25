part of 'order_history_bloc.dart';

abstract class OrderHistoryEvent extends Equatable {
  const OrderHistoryEvent();

  @override
  List<Object> get props => [];
}

class GetOrderHistory extends OrderHistoryEvent {
  final String token;

  const GetOrderHistory({required this.token});

  @override
  List<Object> get props => [token];
}

class RefreshOrderHistory extends OrderHistoryEvent {
  final String token;

  const RefreshOrderHistory({required this.token});

  @override
  List<Object> get props => [token];
} 