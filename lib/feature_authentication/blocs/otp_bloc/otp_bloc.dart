import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:sura_online_shopping_admin/app/bloc/app_bloc.dart';
import 'package:sura_online_shopping_admin/commons/adim_home/screen/home.dart';
import 'package:sura_online_shopping_admin/commons/models/phone_number.dart';
import 'package:sura_online_shopping_admin/commons/models/user.dart';
import 'package:sura_online_shopping_admin/feature_authentication/model/otp.dart';
import 'package:sura_online_shopping_admin/repository/services.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc(
      {required this.services,
      required this.username,
      required this.phoneNUmber})
      : super(const OtpState(
            errorMessage: '',
            status: FormzStatus.invalid,
            otpCode: OtpCode.pure(''))) {
    on<OtpCodeChangeEvent>(_onOtpChange);
    on<ErrorMessageChangeEvent>(_onErrorMessageChange);
    on<OtpStatusChangeEvent>(_onStatusChange);
    on<OtpScreenSubmitEvent>(_onOtpSubmit);
    on<ResendButtonEvent>(_onResendButtonEvent);
  }
  final Services services;
  final PhoneNUmber phoneNUmber;
  final String username;

  _onOtpSubmit(event, emit) {
    if (state.status == FormzStatus.invalid) return;

    try {
      debugPrint(
          '=============================================================================>');
      debugPrint('inside submit function');
      emit(state.compyWith(status: FormzStatus.submissionInProgress));
      services.signInwithCredential(sms: state.otpCode.value);

      debugPrint(username);
      final phone = phoneNUmber;
      final id = services.loggedInUser()!;
      const type = UserType.normal;
      final user = User(id: id, name: username, phoneNumber: phone, type: type);
      services.writeUsertoFirebase(json: user.toJson(), id: id);
      debugPrint(
          '=============================================================================>');
      debugPrint(user.toString());
      BlocProvider.of<AppBloc>(event.context, listen: false)
          .add(UserChangeEvent(user: user));

      Navigator.pushReplacement(event.context,
          MaterialPageRoute(builder: ((context) => const Home())));
    } catch (e) {
      add(const OtpStatusChangeEvent(status: FormzStatus.submissionFailure));
    }
  }

  _onResendButtonEvent(event, emit) {
    try {
      services.verfiyPhoneNumber(phoneNumber: phoneNUmber.value);
    } catch (e) {
      add(const OtpStatusChangeEvent(status: FormzStatus.submissionFailure));
    }
  }

  _onErrorMessageChange(event, emit) {
    emit(state.compyWith(errorMessage: event.errorMessage));
  }

  _onStatusChange(event, emit) {
    emit(state.compyWith(status: event.status));
    switch (event.status) {
      case FormzStatus.submissionFailure:
        add(const ErrorMessageChangeEvent(errorMessage: 'Submission Failure'));
        break;
      case FormzStatus.invalid:
        add(const ErrorMessageChangeEvent(errorMessage: 'Invalid'));
    }
  }

  _onOtpChange(event, emit) {
    emit(state.compyWith(otpCode: event.otpCode));
    add(OtpStatusChangeEvent(status: Formz.validate([state.otpCode])));
    debugPrint(state.status.toString());
  }
}
