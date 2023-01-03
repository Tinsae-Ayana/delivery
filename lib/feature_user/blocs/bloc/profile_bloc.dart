import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:sura_online_shopping_admin/app/bloc/app_bloc.dart';
import 'package:sura_online_shopping_admin/commons/models/phone_number.dart';
import 'package:sura_online_shopping_admin/commons/models/user.dart';
import 'package:sura_online_shopping_admin/repository/services.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.services}) : super(ProfileState()) {
    on<NameChangeEvent>(_onNameChange);
    on<StatusChangeEvent>(_onStatusChange);
    on<PhotoChangeEvent>(_onPhotoChange);
    on<PhoneNumberChangeEvent>(_onPhoneNumberChange);
    on<ErrorMessageEvent>(_onErrorMessage);
    on<SaveButtonEvent>(_onSaveButtonEvent);
  }

  final Services services;

  _onStatusChange(event, emit) {
    emit(state.copyWith(status: event.status));
  }

  _onErrorMessage(event, emit) {
    emit(state.copyWith(errorMessage: event.errorMessage));
  }

  _onNameChange(event, emit) {
    if (event.name != '' &&
        Formz.validate([state.phoneNumber]) == FormzStatus.valid) {
      emit(state.copyWith(name: event.name));
      add(const StatusChangeEvent(status: FormzStatus.valid));
    } else {
      emit(state.copyWith(name: event.name));
    }
  }

  _onPhotoChange(event, emit) {
    debugPrint('inside the photo event');
    emit(state.copyWith(photo: event.photo));
  }

  _onPhoneNumberChange(event, emit) {
    if (Formz.validate([event.phoneNumber]) == FormzStatus.valid &&
        state.name != '') {
      emit(state.copyWith(phoneNumber: event.phoneNumber));
      add(const StatusChangeEvent(status: FormzStatus.valid));
    } else {
      emit(state.copyWith(phoneNumber: event.phoneNumber));
    }
  }

  _onSaveButtonEvent(event, emit) async {
    debugPrint(state.photo.toString());
    if (state.status == FormzStatus.valid && state.photo.path != 'null') {
      final photoId = await services.postUserPhoto(file: state.photo);

      services.writeUsertoFirebase(id: event.userId, json: {
        'name': state.name,
        'phoneNumber': state.phoneNumber.value,
        'photo': photoId,
        'id': event.userId
      });
      BlocProvider.of<AppBloc>(event.context).add(UserChangeEvent(
          user: User(
              type: BlocProvider.of<AppBloc>(event.context).state.user.type,
              id: event.userId,
              phoneNumber: state.phoneNumber,
              photo: photoId,
              name: state.name)));
    } else {
      debugPrint('inside else');
      add(const ErrorMessageEvent(errorMessage: 'Invalid Inputs!'));
    }
  }
}
