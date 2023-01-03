import 'package:formz/formz.dart';

enum OtpCodeError { invalidCode }

class OtpCode extends FormzInput<String, OtpCodeError> {
  const OtpCode.dirty(super.value) : super.dirty();
  const OtpCode.pure(super.value) : super.pure();
  static final RegExp _otpRegExp = RegExp(
    r'^[0-9]{6}$',
  );

  @override
  OtpCodeError? validator(String value) {
    return _otpRegExp.hasMatch(value) ? null : OtpCodeError.invalidCode;
  }
}
