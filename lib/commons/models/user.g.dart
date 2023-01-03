part of 'user.dart';

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      phoneNumber: PhoneNUmber.dirty(json['phoneNumber']),
      type: json['type'] == 'normal' ? UserType.normal : UserType.admin,
      id: json['id'] as String,
      photo: json['photo'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'phoneNumber': instance.phoneNumber.value,
      'photo': instance.photo,
      'id': instance.id,
      'type': instance.type == UserType.normal ? 'normal' : 'admin'
    };
