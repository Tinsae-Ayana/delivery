part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OrderDeletedEvent extends OrderEvent {
  final Order order;
  const OrderDeletedEvent({required this.order});
  @override
  List<Object> get props => [order];
}

class LoadOrders extends OrderEvent {}

class ChangeOrderEvent extends OrderEvent {
  final List<Order> orders;
  const ChangeOrderEvent({required this.orders});
  @override
  List<Object> get props => [orders];
}
