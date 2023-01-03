part of 'cart_bloc.dart';

class CartState extends Equatable {
  const CartState({this.orderedProduct = const [], this.totalPrice = 0});

  final List<Product> orderedProduct;
  final double totalPrice;

  @override
  List<Object> get props => [orderedProduct, totalPrice];
}
