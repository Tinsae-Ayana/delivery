part of 'otp_bloc.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}

class OtpScreenSubmitEvent extends OtpEvent {
  const OtpScreenSubmitEvent({required this.context});
  final BuildContext context;
}

class OtpCodeChangeEvent extends OtpEvent {
  const OtpCodeChangeEvent({required this.otpCode});
  final OtpCode otpCode;
  @override
  List<Object> get props => [otpCode];
}

class ErrorMessageChangeEvent extends OtpEvent {
  const ErrorMessageChangeEvent({required this.errorMessage});
  final String errorMessage;
  @override
  List<Object> get props => [errorMessage];
}

class OtpStatusChangeEvent extends OtpEvent {
  const OtpStatusChangeEvent({required this.status});
  final FormzStatus status;
  @override
  List<Object> get props => [status];
}

class ResendButtonEvent extends OtpEvent {}
