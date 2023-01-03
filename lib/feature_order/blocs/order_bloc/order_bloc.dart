import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sura_online_shopping_admin/feature_order/models/order.dart';
import 'package:sura_online_shopping_admin/repository/services.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({required this.services}) : super(const OrderState(orders: [])) {
    on<OrderDeletedEvent>(_onOrderDelete);
    on<LoadOrders>(_onLoad);
    on<ChangeOrderEvent>(_onChange);
  }
  final Services services;
  late final StreamSubscription streamSubscription;

  _onOrderDelete(event, emit) {
    state.orders.remove(event.order);
    services.deleteOrders(id: event.order.id);
    emit(OrderState(orders: state.orders));
  }

  _onLoad(event, emit) {
    streamSubscription = services.retrieveAllOrders().listen((event) {
      add(ChangeOrderEvent(orders: event));
    });
  }

  _onChange(event, emit) {
    emit(OrderState(orders: event.orders));
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
