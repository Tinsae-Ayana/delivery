import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:sura_online_shopping_admin/repository/services.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.services}) : super(const PostState()) {
    on<ProductNameChangeEvent>(_onProductNameChangeEvent);
    on<PriceChangeEvent>(_onPriceChangeEvent);
    on<ColorChangeEvent>(_onColorChangeEvent);
    on<IdChangeEvent>(_onIdChangeEvent);
    on<SizeChangeEvent>(_onSizeChangeEvent);
    on<CatagoryChangeEvent>(_onCatagoryNameChangeEvent);
    on<MessageChangeEvent>(_onMessageChangeEvent);
    on<ImageFileChangeEvent>(_onImageFileChangeEvent);
    on<PostToFirebaseEvent>(_onPostToFirebaseEvent);
  }
  final Services services;

  _onProductNameChangeEvent(event, emit) {
    debugPrint(event.productName);
    emit(state.copyWith(productName: event.productName));
  }

  _onPriceChangeEvent(event, emit) {
    debugPrint(event.price.toString());
    emit(state.copyWith(price: event.price));
  }

  _onColorChangeEvent(event, emit) {
    debugPrint(event.color);
    emit(state.copyWith(color: event.color));
  }

  _onIdChangeEvent(event, emit) {
    emit(state.copyWith(id: event.id));
  }

  _onSizeChangeEvent(event, emit) {
    debugPrint(event.size);
    emit(state.copyWith(size: event.size));
  }

  _onCatagoryNameChangeEvent(event, emit) {
    emit(state.copyWith(catagory: event.catagory));
  }

  _onMessageChangeEvent(event, emit) {
    emit(state.copyWith(message: event.message));
  }

  _onImageFileChangeEvent(event, emit) {
    emit(state.copyWith(imageFiles: event.imageFiles));
  }

  _onPostToFirebaseEvent(event, emit) async {
    if (state.catagory != '' &&
        state.imageFiles != [] &&
        state.productName != '' &&
        state.price != 0.0) {
      final productImages =
          await services.postProductPhoto(file: state.imageFiles);
      final timeOfpost = DateTime.now();
      services.postProduct(json: {
        'productName': state.productName,
        'price': state.price,
        'productImages': productImages,
        'size': state.size,
        'color': state.color,
        'timeOfPost': timeOfpost.toString(),
        'catagory': state.catagory
      });
    } else {
      add(const MessageChangeEvent(
          message: 'please Fill all the necessary field'));
    }
  }
}
