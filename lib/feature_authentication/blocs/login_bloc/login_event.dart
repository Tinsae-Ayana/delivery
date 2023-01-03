part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class NameChangeEvent extends LoginEvent {
  const NameChangeEvent({required this.name});
  final String name;
  @override
  List<Object> get props => [name];
}

class ErrorMessageChangeEvent extends LoginEvent {
  const ErrorMessageChangeEvent({required this.errorMessage});
  final String errorMessage;
  @override
  List<Object> get props => [errorMessage];
}

class StatusChangeEvent extends LoginEvent {
  const StatusChangeEvent({required this.status});
  final FormzStatus status;
  @override
  List<Object> get props => [status];
}

class PhoneChangeEvent extends LoginEvent {
  const PhoneChangeEvent({required this.phoneNUmber});
  final PhoneNUmber phoneNUmber;
  @override
  List<Object> get props => [phoneNUmber];
}

class LoginButtonPressedEvent extends LoginEvent {
  const LoginButtonPressedEvent({required this.context});
  final BuildContext context;
  @override
  List<Object> get props => [context];
}

class PhoneNumStatusEvent extends LoginEvent {
  const PhoneNumStatusEvent({required this.status});
  final Phoneverfied status;
  @override
  List<Object> get props => [status];
}
