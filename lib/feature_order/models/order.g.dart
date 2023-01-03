// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as String,
      totalPrice: json['totalPrice'],
      products: json['products'].map<Product>((e) {
        return Product.fromJson(e);
      }).toList(),
      user: User.fromJson(json['user']),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'products': instance.products.map((e) {
        e.toJson();
      }).toList(),
      'user': instance.user.toJson(),
      'totalPrice': instance.totalPrice,
      'id': instance.id
    };
