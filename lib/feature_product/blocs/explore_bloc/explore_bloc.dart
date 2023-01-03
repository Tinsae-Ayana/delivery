import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:sura_online_shopping_admin/feature_product/models/product.dart';

import 'package:sura_online_shopping_admin/repository/services.dart';
part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc({required this.services}) : super(const ExploreState()) {
    on<ProductChangeEvent>(_onProductChangeEvent);
    on<NewArrivalsChangeEvent>(_onNewArrivalChangeEvent);
    on<CatagoryChangeEvent>(_onCatagoryChangeEvent);
    on<EditProdcutEvent>(_onEditProductEvent);
    on<DeleteProductEvent>(_onDeleteProductEvent);
    add(const CatagoryChangeEvent(catagory: 0));

    newArrivalStream = services.retrieveNewArrival().listen((event) {
      add(NewArrivalsChangeEvent(newArrivals: event));
    });
  }
  Services services;
  StreamSubscription? subscription;
  StreamSubscription? newArrivalStream;

  _onProductChangeEvent(event, emit) {
    emit(state.copyWith(product: event.product));
  }

  _onNewArrivalChangeEvent(event, emit) {
    emit(state.copyWith(newArrivals: event.newArrivals));
  }

  _onDeleteProductEvent(event, emit) {
    services.deleteProduct(id: event.productId);
  }

  _onEditProductEvent(event, emit) {
    services.updateProduct(id: event.productId, data: event.data);
  }

  _onCatagoryChangeEvent(event, emit) {
    switch (event.catagory) {
      case 0:
        if (subscription != null) {
          subscription!.cancel().then((_) {
            subscription = services.retrieveAllProduct().listen((event) {
              add(ProductChangeEvent(product: event));
            });
          });
        } else {
          subscription = services.retrieveAllProduct().listen((event) {
            add(ProductChangeEvent(product: event));
          });
        }

        break;
      case 1:
        if (subscription != null) {
          subscription!.cancel().then((_) {
            subscription = services
                .retrieveProductByCatagory(catagoryName: 'shoes')
                .listen((event) {
              add(ProductChangeEvent(product: event));
            });
          });
        } else {
          subscription = services
              .retrieveProductByCatagory(catagoryName: 'shoes')
              .listen((event) {
            add(ProductChangeEvent(product: event));
          });
        }
        break;
      case 2:
        if (subscription != null) {
          subscription!.cancel().then((_) {
            subscription = services
                .retrieveProductByCatagory(catagoryName: 'cosmotics')
                .listen((event) {
              add(ProductChangeEvent(product: event));
            });
          });
        } else {
          subscription = services
              .retrieveProductByCatagory(catagoryName: 'cosmotics')
              .listen((event) {
            add(ProductChangeEvent(product: event));
          });
        }
        break;
      case 3:
        if (subscription != null) {
          subscription!.cancel().then((_) {
            subscription = services
                .retrieveProductByCatagory(catagoryName: 'other')
                .listen((event) {
              add(ProductChangeEvent(product: event));
            });
          });
        } else {
          subscription = services
              .retrieveProductByCatagory(catagoryName: 'other')
              .listen((event) {
            add(ProductChangeEvent(product: event));
          });
        }
        break;
    }
  }

  @override
  Future<void> close() {
    newArrivalStream!.cancel();
    subscription!.cancel();
    return super.close();
  }
}
