import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

enum Catagory { cosmotics, shoes, other }

@JsonSerializable()
class Product {
  final String productName;
  final double price;
  final List<String> productImages;
  final String? color;
  final int? size;
  final String id;
  final String timeOfPost;
  final Catagory catagory;
  const Product(
      {required this.productName,
      required this.price,
      required this.productImages,
      required this.id,
      required this.catagory,
      required this.timeOfPost,
      this.size,
      this.color});
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
