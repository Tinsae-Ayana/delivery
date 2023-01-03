part of 'otp_bloc.dart';

class OtpState extends Equatable {
  const OtpState(
      {this.otpCode = const OtpCode.pure(''),
      this.errorMessage = '',
      this.status = FormzStatus.invalid});
  final OtpCode otpCode;
  final String errorMessage;
  final FormzStatus status;

  OtpState compyWith({otpCode, errorMessage, status}) {
    return OtpState(
        errorMessage: errorMessage ?? this.errorMessage,
        otpCode: otpCode ?? this.otpCode,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [otpCode, errorMessage, status];
}
