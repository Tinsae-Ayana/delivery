part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  ProfileState({name, phoneNumber, photo, status, errorMessage})
      : name = name ?? '',
        phoneNumber = phoneNumber ?? const PhoneNUmber.dirty(''),
        status = status ?? FormzStatus.invalid,
        errorMessage = errorMessage ?? '',
        photo = photo ?? File('null');

  final String name;
  final PhoneNUmber phoneNumber;
  final File photo;
  final FormzStatus status;
  final String errorMessage;
  @override
  List<Object> get props => [name, phoneNumber, status, photo];

  ProfileState copyWith({name, phoneNumber, photo, status, errorMessage}) {
    return ProfileState(
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        photo: photo ?? this.photo,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
