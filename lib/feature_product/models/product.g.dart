// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    productName: json['productName'] as String,
    price: (json['price'] as num).toDouble(),
    productImages: (json['productImages'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    id: json['id'] as String,
    catagory: $enumDecode(_$CatagoryEnumMap, json['catagory']),
    timeOfPost: json['timeOfPost'].toString(),
    size: int.parse(json['size'] ?? '40'),
    color: json['color'] as String?,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'productName': instance.productName,
      'price': instance.price,
      'productImages': instance.productImages,
      'color': instance.color,
      'size': instance.size,
      'id': instance.id,
      'timeOfPost': instance.timeOfPost,
      'catagory': _$CatagoryEnumMap[instance.catagory]!,
    };

const _$CatagoryEnumMap = {
  Catagory.cosmotics: 'cosmotics',
  Catagory.shoes: 'shoes',
  Catagory.other: 'other',
};
