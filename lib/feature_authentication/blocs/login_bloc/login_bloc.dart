import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:sura_online_shopping_admin/commons/models/phone_number.dart';
import 'package:sura_online_shopping_admin/repository/data_provider/firebase_authenticatin.dart';
import 'package:sura_online_shopping_admin/repository/services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({services})
      : _services = services,
        super(const LoginState()) {
    on<NameChangeEvent>(_onNameChange);
    on<ErrorMessageChangeEvent>(_onErrorMessageChange);
    on<StatusChangeEvent>(_onStatusChange);
    on<PhoneChangeEvent>(_onPhoneNumberChange);
    on<LoginButtonPressedEvent>(_loginButtonPressed);
    on<PhoneNumStatusEvent>(_onPhoneNumStatusChange);
  }

  final Services _services;
  _onErrorMessageChange(event, emit) {
    emit(state.copyWith(errorMessage: event.errorMessage));
  }

  _onPhoneNumStatusChange(event, emit) {
    emit(state.copyWith(phoneNumStatus: event.status));
  }

  _onNameChange(event, emit) {
    debugPrint('on name change event');
    // debugPrint(event.name);
    emit(state.copyWith(name: event.name));
    debugPrint(state.name);
  }

  _onStatusChange(event, emit) {
    emit(state.copyWith(status: event.status));
  }

  _loginButtonPressed(event, emit) async {
    if (state.status == FormzStatus.invalid) return;
    add(const StatusChangeEvent(status: FormzStatus.submissionInProgress));
    try {
      final message = await _services.verfiyPhoneNumber(
          phoneNumber: state.phoneNUmber.value);
      debugPrint(message);
      debugPrint(
          '=====================================================================================>');
      if (message == 'VerficationSucess') {
        add(const PhoneNumStatusEvent(status: Phoneverfied.verfiedPhone));
        add(const StatusChangeEvent(status: FormzStatus.submissionSuccess));
      } else {
        add(const PhoneNumStatusEvent(status: Phoneverfied.unverfiedPhone));
        add(const StatusChangeEvent(status: FormzStatus.submissionFailure));
      }
    } on SigninWithPhoneNumberFailure catch (e) {
      add(ErrorMessageChangeEvent(errorMessage: e.massage));
      add(const StatusChangeEvent(status: FormzStatus.submissionFailure));
    }
  }

  _onPhoneNumberChange(event, emit) {
    debugPrint('phone number change');
    debugPrint(event.phoneNUmber.toString());

    emit(state.copyWith(phoneNumber: event.phoneNUmber));
    add(StatusChangeEvent(status: Formz.validate([state.phoneNUmber])));
    debugPrint(Formz.validate([state.phoneNUmber]).toString());
  }
}
