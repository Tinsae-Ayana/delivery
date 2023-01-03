import 'package:formz/formz.dart';

enum PhoneNumberValidationError { invalidPhoneNumber }

class PhoneNUmber extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNUmber.dirty(value) : super.dirty(value);

  static final RegExp _phoneNumberRegExp = RegExp(
    r'^\+[0-9]{12}$',
  );

  @override
  PhoneNumberValidationError? validator(String value) {
    return _phoneNumberRegExp.hasMatch(value)
        ? null
        : PhoneNumberValidationError.invalidPhoneNumber;
  }
}
