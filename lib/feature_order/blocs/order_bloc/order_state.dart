part of 'order_bloc.dart';

class OrderState extends Equatable {
  const OrderState({required this.orders});

  final List<Order> orders;

  @override
  List<Object> get props => [orders];
}
