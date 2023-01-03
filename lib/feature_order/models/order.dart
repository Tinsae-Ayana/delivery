import 'package:json_annotation/json_annotation.dart';
import 'package:sura_online_shopping_admin/commons/models/user.dart';
import 'package:sura_online_shopping_admin/feature_product/models/product.dart';
part 'order.g.dart';

@JsonSerializable()
class Order {
  List<Product> products;
  double totalPrice;
  User user;
  String id;

  Order({
    required this.id,
    required this.totalPrice,
    required this.products,
    required this.user,
  });
  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
