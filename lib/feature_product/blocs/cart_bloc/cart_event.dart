part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class ProductAdded extends CartEvent {
  const ProductAdded({required this.product});
  final Product product;
  @override
  List<Object> get props => [product];
}

class ProductDeleted extends CartEvent {
  const ProductDeleted({required this.product});
  final Product product;
  @override
  List<Object> get props => [product];
}

class OrderEvent extends CartEvent {
  const OrderEvent({required this.userId});
  final User userId;
  @override
  List<Object> get props => [userId];
}
