import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sura_online_shopping_admin/commons/models/user.dart';

import 'package:sura_online_shopping_admin/repository/services.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required this.services})
      : super(AppState(
            user: User.empty,
            intConStatus: false,
            themeMode: ThemeMode.light)) {
    on<UserChangeEvent>(_userChangedEvent);
    on<IntConStatusChangeEvent>(_intConStatusChangeEvent);
    on<ThemeModeChangeEvent>(_onThemeChange);
    on<LogOutEvent>(_onLogOutEvent);

    services.isConnectionAvailable().listen((connectionStatus) {
      add(IntConStatusChangeEvent(isConnectedToInternet: connectionStatus));
    });
  }

  final Services services;

  _userChangedEvent(event, emit) {
    debugPrint(event.user.name);
    debugPrint(event.user.phoneNumber.toString());
    emit(state.copyWith(user: event.user));
  }

  _intConStatusChangeEvent(event, emit) {
    emit(state.copyWith(intConStatus: event.isConnectedToInternet));
  }

  _onThemeChange(event, emit) {
    emit(state.copyWith(themeMode: event.themeMode));
  }

  _onLogOutEvent(event, emit) {
    services.logOut();
  }
}
