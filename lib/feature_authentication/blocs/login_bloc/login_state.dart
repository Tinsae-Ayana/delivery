part of 'login_bloc.dart';

enum Phoneverfied { verfiedPhone, unverfiedPhone }

class LoginState extends Equatable {
  const LoginState(
      {this.phoneNumStatus = Phoneverfied.unverfiedPhone,
      this.name = '',
      this.errorMessage = '',
      this.phoneNUmber = const PhoneNUmber.dirty(''),
      this.status = FormzStatus.pure});

  final PhoneNUmber phoneNUmber;
  final String name;
  final FormzStatus status;
  final String errorMessage;
  final Phoneverfied phoneNumStatus;

  @override
  List<Object> get props =>
      [phoneNUmber, name, status, errorMessage, phoneNumStatus];

  LoginState copyWith(
      {name, status, phoneNumber, errorMessage, phoneNumStatus}) {
    return LoginState(
        phoneNumStatus: phoneNumStatus ?? this.phoneNumStatus,
        name: name ?? this.name,
        phoneNUmber: phoneNumber ?? phoneNUmber,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
