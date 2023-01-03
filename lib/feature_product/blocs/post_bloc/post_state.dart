part of 'post_bloc.dart';

class PostState extends Equatable {
  const PostState({
    this.productName = '',
    this.price = 0.0,
    this.color = '',
    this.size,
    this.catagory = 'other',
    this.message = '',
    this.imageFiles = const [],
  });
  final String productName;
  final double price;
  final String color;
  final int? size;
  final String catagory;
  final String message;
  final List<File> imageFiles;

  PostState copyWith(
      {productName, price, color, id, size, catagory, message, imageFiles}) {
    return PostState(
        productName: productName ?? this.productName,
        price: price ?? this.price,
        color: color ?? this.color,
        size: size ?? this.size,
        catagory: catagory ?? this.catagory,
        message: message ?? this.message,
        imageFiles: imageFiles ?? this.imageFiles);
  }

  @override
  List<Object> get props =>
      [productName, price, color, catagory, message, imageFiles];
}
