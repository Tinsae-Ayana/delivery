import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sura_online_shopping_admin/feature_product/models/product.dart';
import 'package:sura_online_shopping_admin/repository/services.dart';

import '../../../commons/models/user.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({required this.services}) : super(const CartState()) {
    on<ProductAdded>(_onProductAddEvent);
    on<ProductDeleted>(_onProductDeleteEvent);
    on<OrderEvent>(_onOrderEvent);
  }

  final Services services;

  _onProductAddEvent(event, emit) {
    emit(CartState(
        orderedProduct: state.orderedProduct + [event.product],
        totalPrice: state.totalPrice + event.product.price));
  }

  _onProductDeleteEvent(event, emit) {
    debugPrint(state.orderedProduct.length.toString());
    state.orderedProduct.remove(event.product);
    debugPrint(state.orderedProduct.length.toString());
    emit(CartState(
        orderedProduct: state.orderedProduct,
        totalPrice: state.totalPrice - event.product.price));
  }

  _onOrderEvent(event, emit) {
    services.postOrders(json: {
      'user': event.userId.toJson(),
      'products': state.orderedProduct.map((e) => e.toJson()).toList(),
      'totalPrice': state.totalPrice
    });
  }
}
