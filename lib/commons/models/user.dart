import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sura_online_shopping_admin/commons/models/phone_number.dart';

part 'user.g.dart';

enum UserType { admin, normal }

@JsonSerializable()
class User extends Equatable {
  final String name;
  final PhoneNUmber phoneNumber;
  late final String? photo;
  final String id;
  final UserType type;
  // ignore: prefer_const_constructors_in_immutables
  User(
      {required this.name,
      required this.phoneNumber,
      required this.id,
      required this.type,
      this.photo});
  static final empty = User(
      id: '',
      photo: '',
      name: '',
      phoneNumber: const PhoneNUmber.dirty(''),
      type: UserType.normal);

  bool isEmpty() => this == empty;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [name, phoneNumber, photo, id, type];
}
