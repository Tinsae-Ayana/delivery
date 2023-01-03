part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class ProductNameChangeEvent extends PostEvent {
  const ProductNameChangeEvent({required this.productName});
  final String productName;
}

class PriceChangeEvent extends PostEvent {
  const PriceChangeEvent({required this.price});
  final double price;
}

class ColorChangeEvent extends PostEvent {
  const ColorChangeEvent({required this.color});
  final String color;
}

class IdChangeEvent extends PostEvent {
  const IdChangeEvent({required this.id});
  final int id;
}

class SizeChangeEvent extends PostEvent {
  const SizeChangeEvent({required this.size});
  final int size;
}

class CatagoryChangeEvent extends PostEvent {
  const CatagoryChangeEvent({required this.catagory});
  final String catagory;
}

class MessageChangeEvent extends PostEvent {
  const MessageChangeEvent({required this.message});
  final String message;
}

class ImageFileChangeEvent extends PostEvent {
  const ImageFileChangeEvent({required this.imageFiles});
  final List<File> imageFiles;
}

class PostToFirebaseEvent extends PostEvent {}
