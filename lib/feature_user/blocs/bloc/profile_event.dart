part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class NameChangeEvent extends ProfileEvent {
  const NameChangeEvent({required this.name});
  final String name;
  @override
  List<Object> get props => [name];
}

class PhoneNumberChangeEvent extends ProfileEvent {
  const PhoneNumberChangeEvent({required this.phoneNumber});
  final PhoneNUmber phoneNumber;
  @override
  List<Object> get props => [phoneNumber];
}

class PhotoChangeEvent extends ProfileEvent {
  const PhotoChangeEvent({required this.photo});
  final File photo;
  @override
  List<Object> get props => [photo];
}

class StatusChangeEvent extends ProfileEvent {
  const StatusChangeEvent({required this.status});
  final FormzStatus status;
  @override
  List<Object> get props => [status];
}

class ErrorMessageEvent extends ProfileEvent {
  const ErrorMessageEvent({required this.errorMessage});
  final String errorMessage;
  @override
  List<Object> get props => [errorMessage];
}

class SaveButtonEvent extends ProfileEvent {
  const SaveButtonEvent({required this.userId, required this.context});
  final String userId;
  final BuildContext context;
}
